---
title: nginx反向代理的Express如何拿到真实客户端IP
date: 2017-10-27 18:56:17
tags:
- nginx
- Express
- IP
categories:
- 教程
---

最近碰到一个苦恼的问题，Express 的后端打印客户端的真实 IP 地址，结果打印出来的全部是`127.0.0.1`。如果你也碰到了这个问题，那么恭喜你，我接下来就告诉你怎么解决。

<!-- more -->

正常来说，引起这个问题的原因就是服务器做了 nginx 反向代理。所有客户端的请求都先打到 nginx 服务器，然后 nginx 服务器再去请求 node 服务器，如果 nginx 和 node 服务器部署在同一台机上面，那么 node 能拿到的 IP 地址其实就是本机地址，也就是`127.0.0.1`。

找到引起问题的根源，就可以对症下药了。

### 修改 nginx 配置

配置修改如下：

```
server {
    listen       80;
    server_name  website.com;

    location / {
        proxy_set_header  Host $host;
        proxy_set_header  X-Real-IP $remote_addr;
        proxy_set_header  X-Forwarded-Proto https;
        proxy_set_header  X-Forwarded-For $remote_addr;
        proxy_set_header  X-Forwarded-Host $remote_addr;
        proxy_pass    http://127.0.0.1:3000/;

    }
}
```

### 修改 Express 配置

修改 `app.js` 文件，增加一行代码：

```javascript
app.set('trust proxy', 'loopback');
```

### 获取客户端真实 IP 地址

在代码中使用`req.ip`就可以获取到用户的真实 IP 地址了。
