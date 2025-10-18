#!/bin/bash
# Generate sanitized Docker tag from branch name
# Usage: get-docker-tag.sh <branch_name>

set -e

BRANCH_NAME="${1:-main}"

# Sanitize branch name: lowercase, replace / with -, remove invalid chars
TAG=$(echo "$BRANCH_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9._-]/-/g')

# Use 'latest' for main branch, sanitized branch name otherwise
if [ "$BRANCH_NAME" = "main" ]; then
  echo "latest"
else
  echo "$TAG"
fi
