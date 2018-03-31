#!/usr/bin/env bash

# 更新next主题
# 检测next主题是否存在，不存在则pull下来
if [ ! -d 'themes/next' ]; then
    git clone https://github.com/ricosmall/hexo-theme-next.git --depth=1 ./themes/next
fi

echo '准备更新next主题'
cd themes/next
git pull
cd ../../
echo '更新next主题成功！'

# 清除之前生成的代码
echo '准备清除缓存'
hexo clean
echo '清除缓存成功！'

# 生成
echo '准备生成新的资源'
hexo generate
echo '生成新的资源成功！'

# 部署（包含部署到Coding）
echo '准备部署新的资源'
hexo deploy
echo '部署新的资源成功！'

# push到github
echo '更新GitHub源码'
git add .
git commit -m '更新文章'
git push origin hexo
echo '更新成功！'
