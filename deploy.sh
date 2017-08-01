#!/usr/bin/env bash

cd themes/next
git pull
cd ../../
hexo clean
hexo deploy --generate

rm -rf themes/next
git add .
git commit -m '更新文章'
git push origin hexo
