#!/bin/sh


# if auth secret not found just exit
if [ -z $GITHUB_AUTH_SECRET ]; then
    echo "credential not found"
    exit -1
fi

echo "Fetching the sauce..."
git clone --recursive https://github.com/ndgnuh/ndgnuh.github.io -b gh-pages blog
cd blog

echo "Building the website with hugo-${HUGO_VERSION}..."
hugo

if [ $? != 0 ]; then
    echo "Build failed"
    exit -2
fi

echo "Doing sketchy stuff..."
touch ~/.git-credentials
chmod 0600 ~/.git-credentials
echo $GITHUB_AUTH_SECRET > ~/.git-credentials

git config credential.helper store
git config user.email "ndgnuh-blog-bot@users.noreply.github.com"
git config user.name "ndgnuh-blog-bot"

# push stuff on master
echo "Deploying to github..."
cd public/
git add .
git commit -m "Rebuild site at $(date "+%Y-%m-%d %H:%M")"
git push --force origin HEAD:master
