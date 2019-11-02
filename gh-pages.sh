#!/bin/sh

usage(){
        
    echo "#######################"
    echo "#  NOT YET USABLE!!!  #"
    echo "#######################"
    echo "USAGE:\t./gh-pages.sh <option>"
    echo ""
    echo "OPTIONS:"
    echo "\tdeploy\t\tdeploy master branch on github"
    echo "\tcommit\t\tcommit master branch"
    exit 1
}

[ -z $1 ] && usage;
