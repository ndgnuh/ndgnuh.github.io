#!/bin/sh

rm public/* -rf
hugo
git add .
git commit -vm "$(date)"
git push origin gh-pages
cd public
git add .
git commit -vm "$(date)"
git push origin master
cd ..
