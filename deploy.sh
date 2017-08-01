#!/usr/bin/env bash

git clone https://github.com/ricosmall/hexo-theme-next.git --depth=1 themes/next
hexo clean
hexo deploy --generate

rm -rf themes/next
git add .
git commit -m '更新文章'
git push origin hexo
