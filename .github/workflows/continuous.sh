#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

set -x

sudo ls -al /var/run/docker.sock
sudo ls -al "$HOME"
id

for dir in $(ls images) ; do
    pushd images/$dir
    img=docker.pkg.github.com/cspotcode/docker-images/$dir:latest
    docker login docker.pkg.github.com --username cspotcode --password-stdin <<< "$GITHUB_TOKEN"
    docker build -t "$img" .
    docker push "$img"
done