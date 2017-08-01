---
title: 使用Travis实现hexo博客的自动化部署
date: 2017-08-01 11:40:25
tags:
- hexo
- Travis-CI
categories:
- 教程
---

一直想写一篇文章，记录一下从搭建博客到实现用[Travis-CI](https://www.travis-ci.org)自动化部署博客的过程。憋到现在才写，拖了很久。

<!-- more -->

如何使用hexo搭建博客就不赘述了，请打开hexo的[官网](https://hexo.io)参考文档，很容易的。

## 第一次小跨越：实现博客同时部署到[Coding](https://coding.net)和[Github](https://github.com)

由于github在国内访问速度比较慢，比较合适的做法是：把博客静态资源在GitHub上面部署一份，同时在Coding(和GitHub原理一模一样)上也部署一份。如果没有自己的域名，这个时候就可以通过`yourusername.github.io`或者`yourusername.coding.me`访问到相同的博客页面。

### 原始方法

一开始，我没有多想，按照原始的方法部署博客。过程就像下面这样：

```bash
# 1. 新建一篇文章
hexo new post '文章标题'

# 2. 编写文章内容
vim 文章标题.md

# 3. 生成静态博客代码
hexo generate

# 4. 部署博客代码到Github
hexo deploy

# 5. 复制生成的博客代码到另一个Coding项目
cp -r public ../blog-in-coding

# 6. 部署博客代码到Coding
git add .
git commit -m 'create a new post'
git push origin master
```

每次这样显得特别原始，特别麻烦。一个程序员习惯这种机械的流程是没有好下场的。问题总结下来其实就是：是否可以同时将一份博客代码同时部署到两个远程仓库？这个问题我之前专门写了一篇文章做了介绍。[传送门](/2017/03/03/将代码同时push到两个不同的远程仓库/)

这个问题得以解决，新的博客部署流程就变成了这样：

```bash
# 1. 新建一篇文章
hexo new post '文章标题'

# 2. 编写文章内容
vim 文章标题.md

# 3. 生成静态博客代码
hexo generate

# 4. 部署博客代码到GitHub和Coding
hexo deploy
```

已经省去了两个大的步骤。更进一步的做法就是把上面的3和4结合成一个命令：`hexo deploy --generate`。至此，基本上已经优化到一个不错的水平了。

## 第二次大跨越：使用[Travis-CI](https://www.travis-ci.org)实现[Hexo](https://hexo.io)博客的自动化部署
