#!/bin/sh

rm public/posts -rf
rm public/vi -rf
rm public/en -rf
hugo
git add .
git commit -vm "$(date)"
git push origin gh-pages
cd public/
git add .
git commit -vm "$(date)"
git push origin master
cd ..
