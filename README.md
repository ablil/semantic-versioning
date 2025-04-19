# Semantic Versioning GitHub Action

This GitHub Action picks up the latest semantic versioning tag (`vX.Y.Z`) from your Git repository, parses it, and calculates the next **major**, **minor**, and **patch** versions. It’s useful for projects following semantic versioning practices to automate version management.

## Features
- Fetches the latest semantic version tag (`vX.Y.Z`) from the main branch.
- Computes the next **major**, **minor**, and **patch** versions.
- Handles repositories with no tags by initializing to `v0.0.0`.

## Inputs

No input is required

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
