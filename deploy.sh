#!/bin/sh

for f in public/*; do
    rm "$f" -rf
done
hugo
git add .
git commit -vm "$(date)"
git push origin gh-pages
cd public/
git add .
git commit -vm "$(date)"
git push origin master
cd ..
