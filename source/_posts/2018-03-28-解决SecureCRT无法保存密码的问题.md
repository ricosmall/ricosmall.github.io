---
title: 解决SecureCRT无法保存密码的问题
date: 2018-03-28 23:08:45
tags:
- SecureCRT
categories:
- 笔记
---

## 问题

在 SecureCRT 上登录同一台机器，每次都要输入密码，非常繁琐。登录的时候「保存密码」的选项又是勾上的，就是不起作用，怎么办呢？

![login-settings](http://o9o8lcfa3.bkt.clouddn.com/securecrt-connect.png)

## 方法

打开 secureCRT => Preferences，左侧选择 General，去掉右侧面板中 Use Keychain 选项，如下图：

![securecrt-settings](http://o9o8lcfa3.bkt.clouddn.com/securecrt-settings.png)

然后登录的时候确保「保存密码」 选项选中的情况下，成功登录一次之后，密码就会保存下来了。
