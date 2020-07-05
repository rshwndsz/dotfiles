#! /usr/bin/env zsh

CWD=${PWD}
cd /Users/Russel/Notes/ObsidianVault
# Check for changes
# https://stackoverflow.com/a/5143914
if ! git diff-index --quiet HEAD --; then
    DATETIME=`date +"%Y-%m-%d %T"`
    git add .
    git commit -m "Update vault -- ${DATETIME}"
    git push origin master
else
    echo "No changes in ObsidianVault. Nothing done."
fi
cd ${PWD}

