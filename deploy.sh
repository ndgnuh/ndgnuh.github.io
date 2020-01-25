#!/bin/sh

for f in public/*; do
    rm "public/$f"
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
