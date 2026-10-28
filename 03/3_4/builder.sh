#!/usr/bin/env bash
# script generated using copilot

set -eu

if [ "$#" -ne 2 ]; then
  echo "Usage: ./builder.sh <github-repo> <dockerhub-repo>" >&2
  exit 1
fi

GITHUB_REPO="$1"
DOCKERHUB_REPO="$2"

# Prefer Docker Hub credentials from the environment, while accepting the
# common variable spellings used in CI and local setups.
DOCKER_USERNAME="${DOCKERHUB_USERNAME:-${DOCKER_USER:-${DOCKER_USERNAME:-}}}"
DOCKER_PASSWORD="${DOCKERHUB_PASSWORD:-${DOCKER_PASSWORD:-${DOCKER_PWD:-}}}"

if [ -n "$DOCKER_USERNAME" ] && [ -n "$DOCKER_PASSWORD" ]; then
  if ! printf '%s\n' "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin >/dev/null 2>&1; then
    docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD" >/dev/null 2>&1 || true
  fi
fi

REPO_DIR="$(basename "$GITHUB_REPO" .git)"

if [ -d "$REPO_DIR" ]; then
  rm -rf "$REPO_DIR"
fi

git clone "https://github.com/$GITHUB_REPO" "$REPO_DIR"

(
  cd "$REPO_DIR"
  docker build -t "$DOCKERHUB_REPO" .
  docker push "$DOCKERHUB_REPO"
)

