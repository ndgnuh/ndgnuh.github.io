#!/bin/sh


# if auth secret not found just exit
if [ -z $GITHUB_AUTH_SECRET ]; then
    echo "credential not found"
    exit -1
fi

echo "Fetching the sauce..."
git clone --recursive https://github.com/ndgnuh/ndgnuh.github.io -b gh-pages blog
cd blog

echo "Fetching the website..."
git clone https://github.com/ndgnuh/ndgnuh.github.io -b master public

echo "Building the website with hugo-${HUGO_VERSION}..."
hugo --destination ../public

if [ $? != 0 ]; then
    echo "Build failed"
    exit -2
fi

echo "Doing sketchy stuff..."
touch ~/.git-credentials
chmod 0600 ~/.git-credentials
echo $GITHUB_AUTH_SECRET > ~/.git-credentials

echo "Deploying to github..."
cd public
git config credential.helper store
git config user.email "ndgnuh-blog-bot@users.noreply.github.com"
git config user.name "ndgnuh-blog-bot"
git add .
git commit -m "Rebuild site at $(date "+%Y-%m-%d %H:%M")"
git push origin HEAD:master
