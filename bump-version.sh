#!/bin/bash
# description: get semantic version based on git commit history
# ref: https://www.conventionalcommits.org/en/v1.0.0/

ref=$1 # oldest git ref to start from (eg latest release tag)
starting_version=$2 # starting semantic version

major=0
minor=0
patch=0

if [[ -n "$starting_version" ]]; then
    IFS='.' read -r major minor patch <<< "$starting_version"
fi

while read -r line; do
    if [[ "$line" =~ ^fix.*$ ]]; then
       patch=$((patch + 1))
    fi

    if [[ "$line" =~ ^feat.*$ ]]; then
       minor=$((minor + 1))
       patch=0
    fi

    if [[ "$line" =~ ^feat!.*$ ]] || [[ "$line" =~ ^fix!.*$ ]]; then
        major=$((major + 1))
        minor=0
        patch=0
    fi
done < <(IFS= git log $ref..HEAD --pretty=format:"%s" --reverse)

echo $major.$minor.$patch
