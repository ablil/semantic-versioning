#!/bin/bash
# description: get latest tag from Git history



echo "Fetching all tags from Git history ..."
git fetch origin main --tags > /dev/null 2>&1

latest_tag=$(git tag --list --sort=-v:refname "v*.*.*" | head -n 1)
if [[ -n $latest_tag ]]; then
    echo "Found latest tag $latest_tag"
    echo "current=${latest_tag#v}" >> $GITHUB_OUTPUT
else
    echo "NO Github tag found"
fi
