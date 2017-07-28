---
title: JavaScript、CSS、HTTP知识相关的面试题
date: 2017-03-03 21:29:10
tags:
- JavaScript
- CSS
categories:
- 面试
---

一上来就是前端技术人员的面试，让我感觉压力好大，有点紧张。

<!-- more -->

问题：

- Array有哪些方法？
- 如何封装简单模块？
- CSS如何实现一份设计稿完美兼容各种移动端？
- CSS如何做三列布局？
- CSS如何实现元素垂直水平居中？
- HTTP请求的头部信息包括哪些东西？
- HTTP请求的状态码有哪些，分别代表什么意思？
- Node.js有哪些核心插件或模块？
- 拿到一份设计稿，如何开始开发工作？
- 有没有写过一些可复用的组件？
- 从前端的角度考虑安全性，该如何有效预防？

面试时确实有一部分原因是紧张，有一部分原因是基础确实不够扎实。

现在就来慢慢研究这些问题。

---

### Array有哪些方法？

| 方法名称 | 描述 |
| -------- | ------------ |
| `concat` | 连接2个或更多数组，并返回结果 |
| `every` | 对数组每一项运行给定函数，如果该函数每一项都返回true，则返回true |
| `filter` | 对数组每一项运行给定函数，返回该函数会返回true的项组成的数组 |
| `forEach` | 对数组每一项运行给定函数。这个函数没有返回值 |
| `join` | 将所有的数组元素连成一个字符串 |
| `indexOf` | 返回第一个与给定参数相等的数组元素的索引，没有找到则放回-1 |
| `lastIndexOf` | 返回在数组中搜索到的与给定参数相等的元素的索引里的最大值 |
| `map` | 对数组的每一项运行给定函数，返回每次函数的调用结果组成的数组 |
| `reverse` | 颠倒数组中元素的顺序，原先第一个元素现在变成最后一个，同样原先的最后一个元素变成了现在的第一个元素 |
| `slice` | 传入索引值，将数组里对应索引范围内的元素作为新数组返回 |
| `some` | 对数组的每一项运行给定函数，如果任一项返回true，则返回true |
| `sort` | 按照字母顺序对数组排序，支持传入指定排序方法的函数作为参数 |
| `toString` | 将数组作为字符串返回 |
| `valueOf` | 和toString类似，将数组作为字符串返回 |
| `push` | 将传入的参数作为数组的最后一项添加到数组中，并返回新数组的长度 |
| `pop` | 取出数组的最后一项并作为返回值 |
| `shift` | 取出数组的第一项并作为返回值 |
| `unshift` | 将传入的参数作为数组的第一项添加到数组中，并返回新数组的长度 |

这是我能想到和找到的所有方法了，如果看官发现更多，请提醒我，谢谢！


### 如何封装简单模块？

我采用的是宽放大模式，就是一个立即执行函数表达式：

```javascript
(function (window, module, undefined) {
    module.sayHello = function () {
        console.log('Hello');
    };

    ...

})(window, window.module || (window.module = {}));
```

### CSS如何实现一份设计稿完美兼容各种移动端？

采用rem方式，并且采用js动态识别屏幕的宽度动态生成viewport的meta标签。


### CSS如何做三列布局？


### CSS如何实现元素水平垂直居中？

- 方法一：

HTML部分如下：

```html
<div class="wrapper">  
    <div class="content">Content here</div>
</div>
```

CSS部分如下：

```css
.wrapper {
    float: left;
    height: 50%;
    margin-bottom: -120px;
}

.content {
    clear: both;
    height: 240px;
    position: relative;
}
```

- 方法二：


### HTTP请求的头部信息包括哪些东西？

最基本的信息如下表：

- 请求头部信息：

| 字段名 | 描述 | 举例
| ----- | ----- | ----- |
| `Host` | 服务器域名 | `Host: www.baidu.com` |
| `Accept` | 可接受的媒体类型 | `Accept: * / *` |
| `Accept-Encoding` | 可接受的编码类型 | `Accept-Encoding: gzip, deflate, sdch` |
| `Accept-Language` | 可接受的语言 | `Accept-Language: en-US, en; q=0.8` |
| `User-Agent` | 用户代理 | `User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36` |
| `Content-type` | 发送内容类型 | `Content-type: text/plain` |
| `Content-length` | 发送内容长度 | `Content-length: 327` |
| `Connection` | 客户端连接的类型 | `Connection: keep-alive` |
| `Referer` | 当前文档的URL | `Referer: http://www.baidu.com/12345` |

- 响应头部信息：

| 字段名 | 描述 | 举例
| ----- | ----- | ----- |
| `Access-Control-Allow-Origin` | 可跨域访问源 | `Access-Control-Allow-Origin: *` |
| `Cache-Control` | 可缓存性 | `Cache-Control: no-cache` |
| `Content-length` | 响应内容长度 | `Content-length: 35` |
| `Content-type` | 响应内容类型 | `Content-type: image/gif` |
| `Date` | 响应时间 | `Date: Mon, 06 Mar 2017 15:34:16 GMT`|
| `Status` | 响应状态码 | `Status: 200` |


### HTTP请求的状态码有哪些？分别代表什么意思？

状态码分类：

| 整体范围 | 已定义范围 | 分类 |
| ----- | ----- | ----- |
| 100 ～ 199 | 100 ～ 101 | 信息提示 |
| 200 ～ 299 | 200 ～ 206 | 成功提示 |
| 300 ～ 399 | 300 ～ 307 | 重定向 |
| 400 ～ 499 | 400 ～ 417 | 客户端错误 |
| 500 ～ 599 | 500 ～ 505 | 服务器错误 |

状态码解释：

| 状态码 | 解释 |
| ----- | ----- |
| `100` | Continue（继续） 初始的请求已经接受，客户应当继续发送请求的其余部分。（HTTP 1.1新） |
| `101` | Switching Protocols（切换协议） 请求者已要求服务器切换协议，服务器已确认并准备进行切换。（HTTP 1.1新） |
| `200` | OK（成功） 一切正常，对GET和POST请求的应答文档跟在后面。 |
| `201` | Created（已创建）服务器已经创建了文档，Location头给出了它的URL。 |
| `202` | Accepted（已接受）服务器已接受了请求，但尚未对其进行处理。 |
| `203` | Non-Authoritative Information（非授权信息）文档已经正常地返回，但一些应答头可能不正确，可能来自另一来源 。（HTTP 1.1新）。 |
| `204` | No Content（无内容）未返回任何内容，浏览器应该继续显示原来的文档。 |
| `205` | Reset Content（重置内容）没有新的内容，但浏览器应该重置它所显示的内容。用来强制浏览器清除表单输入内容（HTTP 1.1新）。 |
| `206` | Partial Content（部分内容）服务器成功处理了部分 GET 请求。（HTTP 1.1新） |
| `300` | Multiple Choices（多种选择）客户请求的文档可以在多个位置找到，这些位置已经在返回的文档内列出。如果服务器要提出优先选择，则应该在Location应答头指明。 |
| `301` | Moved Permanently（永久移动）请求的网页已被永久移动到新位置。服务器返回此响应（作为对 GET 或 HEAD 请求的响应）时，会自动将请求者转到新位置。 |
| `302` | Found（临时移动）类似于301，但新的URL应该被视为临时性的替代，而不是永久性的。注意，在HTTP1.0中对应的状态信息是“Moved Temporatily”，出现该状态代码时，浏览器能够自动访问新的URL，因此它是一个很有用的状态代码。注意这个状态代码有时候可以和301替换使用。例如，如果浏览器错误地请求http://host/~user（缺少了后面的斜杠），有的服务器返回301，有的则返回302。严格地说，我们只能假定只有当原来的请求是GET时浏览器才会自动重定向。请参见307。 |
| `303` | See Other（查看其他位置）类似于301/302，不同之处在于，如果原来的请求是POST，Location头指定的重定向目标文档应该通过GET提取（HTTP 1.1新）。 |
| `304` | Not Modified（未修改）自从上次请求后，请求的网页未被修改过。原来缓冲的文档还可以继续使用，不会返回网页内容。 |
| `305` | Use Proxy（使用代理）只能使用代理访问请求的网页。如果服务器返回此响应，那么，服务器还会指明请求者应当使用的代理。（HTTP 1.1新） |
| `307` | Temporary Redirect（临时重定向）和 302（Found）相同。许多浏览器会错误地响应302应答进行重定向，即使原来的请求是POST，即使它实际上只能在POST请求的应答是303时才能重定向。由于这个原因，HTTP 1.1新增了307，以便更加清除地区分几个状态代码：当出现303应答时，浏览器可以跟随重定向的GET和POST请求；如果是307应答，则浏览器只能跟随对GET请求的重定向。（HTTP 1.1新） |
| `400` | Bad Request（错误请求）请求出现语法错误。 |
| `401` | Unauthorized（未授权）客户试图未经授权访问受密码保护的页面。应答中会包含一个WWW-Authenticate头，浏览器据此显示用户名字/密码对话框，然后在填写合适的Authorization头后再次发出请求。 |
| `403` | Forbidden（已禁止） 资源不可用。服务器理解客户的请求，但拒绝处理它。通常由于服务器上文件或目录的权限设置导致。 |
| `404` | Not Found（未找到）无法找到指定位置的资源。 |
| `405` | Method Not Allowed（方法禁用）请求方法（GET、POST、HEAD、DELETE、PUT、TRACE等）禁用。（HTTP 1.1新） |
| `406` | Not Acceptable（不接受）指定的资源已经找到，但它的MIME类型和客户在Accpet头中所指定的不兼容（HTTP 1.1新） |
| `407` | Proxy Authentication Required（需要代理授权）类似于401，表示客户必须先经过代理服务器的授权。（HTTP 1.1新） |
| `408` | Request Time-out（请求超时）服务器等候请求时超时。（HTTP 1.1新） |
| `409` | Conflict（冲突）通常和PUT请求有关。由于请求和资源的当前状态相冲突，因此请求不能成功。（HTTP 1.1新） |
| `410` | Gone（已删除）如果请求的资源已被永久删除，那么，服务器会返回此响应。该代码与 404（未找到）代码类似，但在资源以前有但现在已经不复存在的情况下，有时会替代 404 代码出现。如果资源已被永久删除，那么，您应当使用 301 代码指定该资源的新位置。（HTTP 1.1新） |
| `411` | Length Required（需要有效长度）不会接受包含无效内容长度标头字段的请求。（HTTP 1.1新） |
| `412` | Precondition Failed（未满足前提条件）服务器未满足请求者在请求中设置的其中一个前提条件。（HTTP 1.1新） |
| `413` | Request Entity Too Large（请求实体过大）请求实体过大，已超出服务器的处理能力。如果服务器认为自己能够稍后再处理该请求，则应该提供一个Retry-After头。（HTTP 1.1新） |
| `414` | Request-URI Too Large（请求的 URI 过长）请求的 URI（通常为网址）过长，服务器无法进行处理。 |
| `415` | Unsupported Media Type（不支持的媒体类型）请求的格式不受请求页面的支持。 |
| `416` | Requested range not satisfiable（请求范围不符合要求）服务器不能满足客户在请求中指定的Range头。（HTTP 1.1新） |
| `417` | Expectation Failed（未满足期望值）服务器未满足”期望”请求标头字段的要求。 |
| `500` | Internal Server Error（服务器内部错误）服务器遇到错误，无法完成请求。 |
| `501` | Not Implemented（尚未实施） 服务器不具备完成请求的功能。例如，当服务器无法识别请求方法时，服务器可能会返回此代码。 |
| `502` | Bad Gateway（错误网关）服务器作为网关或者代理时，为了完成请求访问下一个服务器，但该服务器返回了非法的应答。 |
| `503` | Service Unavailable（服务不可用）服务器由于维护或者负载过重未能应答。通常，这只是一种暂时的状态。 |
| `504` | Gateway Time-out（网关超时） 由作为代理或网关的服务器使用，表示不能及时地从远程服务器获得应答。（HTTP 1.1新） |
| `505` | HTTP Version not supported（HTTP 版本不受支持）不支持请求中所使用的 HTTP 协议版本。 |


### Node.js有哪些核心插件或模块？

Node.js核心模块如下表：

| 模块名称 | 描述 |
| ----- | ----- |
| http | 提供http服务器功能 |
| url | 用于解析url |
| fs | 文件IO系统 |
| querystring | 解析url的查询字符串 |
| util | 提供实用工具 |
| path | 处理文件路径 |
| crypto | 提供加密解密功能 |
| child_process | 新建子进程 |

为了提高运行速度，上面这些核心模块在安装时都会被编译成二进制文件。


### 拿到一份设计稿，如何开始开发工作？

先分析布局，划分框架，然后规划结构，编写代码。

如果是协同开发，那就要建立代码规范：
- 合理地使用标签
- 准确使用CSS
- 良好的注释
- 清晰的代码结构

除此之外，为了提高效率，降低出错率，应该实现前端工程化。


### 有没有写过一些可复用的组件？


### 从前端的角度考虑安全性，该如何有效预防？
