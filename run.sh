#!/bin/bash

set -e
starting_version=$1

echo "fetching all tags ..."
git fetch origin main --tags > /dev/null 2>&1

latest_tag=$(git tag --list --sort=-v:refname "v*.*.*" | head -n 1)
if [[ -z "$latest_tag" ]]; then
  echo "No semantic versioning tags found. Starting with v$starting_version"
  latest_tag="v$starting_version"
fi

version=${latest_tag#v}
IFS='.' read -r major minor patch <<< $version

next_patch="v$major.$minor.$((patch + 1))"
next_minor="v$major.$((minor + 1)).0"
next_major="v$((major + 1)).0.0"

echo "patch=$next_patch" >> $GITHUB_OUTPUT
echo "minor=$next_minor" >> $GITHUB_OUTPUT
echo "major=$next_major" >> $GITHUB_OUTPUT
echo "version=$latest_tag" >> $GITHUB_OUTPUT

echo "done"
