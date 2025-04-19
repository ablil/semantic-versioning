# Semantic Versioning GitHub Action

This GitHub Action automatically parses your Git history using Conventional Commits and computes the next semantic version based on commit messages — no manual versioning required.

## Features
- Scans your Git commit history from the latest version tag (or first commit if none exists)
- Applies semantic versioning rules:
    - fix: bumps patch
    - feat: bumps minor

    - fix!: bump major
    - feat!: bump major
- Optionally, you can set a custom starting version
- Outputs the new version you shuuld bump to, along with the next potential major, minor, and patch versions

## Inputs

| Name      | Description                          |
|-----------|--------------------------------------|
| `initial` | read Git history starting from this version |

## Outputs

| Name      | Description                          |
|-----------|--------------------------------------|
| `version` | The latest semantic version tag.     |
| `major`   | The next major version (`vX+1.0.0`). |
| `minor`   | The next minor version (`vX.Y+1.0`). |
| `patch`   | The next patch version (`vX.Y.Z+1`). |
| `bumpto`  | The next version you should bump to, based on your git commit history |

## Example Usage

### Workflow File: `.github/workflows/semantic-versioning.yml`

```yaml
name: Generate Semantic Versions

on:
  push:
    branches:
      - main

jobs:
  semantic-versioning:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Generate Semantic Versions
        id: semver
        uses: ablil/semantic-versionning@main

      - name: Print Versions
        run: |
          echo "Latest version: ${{ steps.semantic-versioning.outputs.version }}"
          echo "Next major version: ${{ steps.semver.outputs.major }}"
          echo "Next minor version: ${{ steps.semver.outputs.minor }}"
          echo "Next patch version: ${{ steps.semver.outputs.patch }}"
```
