#!/usr/bin/env bash

# 更新next主题
echo '准备更新next主题\n===================='
cd themes/next
git pull
cd ../../
echo '更新next主题成功！'

# 清除之前生成的代码
echo '准备清除缓存\n===================='
hexo clean
echo '清除缓存成功！'

# 生成
echo '准备生成新的资源\n===================='
hexo generate
echo '生成新的资源成功！'

# 部署（包含部署到Coding）
echo '准备部署新的资源\n===================='
hexo deploy
echo '部署新的资源成功！'

# push到github
echo '更新GitHub源码\n===================='
git add .
git commit -m '更新文章'
git push origin hexo
echo '更新成功！'
