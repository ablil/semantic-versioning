#!/bin/bash
# descritption: given a semantic version, return all next versions (major, minor and patch )

version=${$1#v}
IFS='.' read -r major minor patch <<< $version

next_patch="v$major.$minor.$((patch + 1))"
next_minor="v$major.$((minor + 1)).0"
next_major="v$((major + 1)).0.0"

echo "patch=$next_patch" >> $GITHUB_OUTPUT
echo "minor=$next_minor" >> $GITHUB_OUTPUT
echo "major=$next_major" >> $GITHUB_OUTPUT
echo "version=$latest_tag" >> $GITHUB_OUTPUT
echo "bumpto=$bump_to" >> $GITHUB_OUTPUT
