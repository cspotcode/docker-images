#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

set -x

for dir in $(ls images) ; do
    pushd images/$dir
    img=docker.pkg.github.com/cspotcode/docker-images/$dir:latest
    docker login docker.pkg.github.com --username cspotcode
    docker build -t "$img" .
    docker push "$img"
done