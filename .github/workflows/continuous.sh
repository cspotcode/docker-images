#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

set -x
export HOME="$CONTAINER_HOME"

sudo ls -al /var/run/docker.sock
sudo ls -al "$HOME"
id

sudo docker login docker.pkg.github.com --username "$GITHUB_ACTOR" --password-stdin <<< "$GITHUB_TOKEN"
sudo docker pull alpine
sudo docker tag alpine docker.pkg.github.com/cspotcode/docker-images/alpine-test-push:latest
sudo docker push docker.pkg.github.com/cspotcode/docker-images/alpine-test-push:latest

for dir in $(ls images) ; do
    pushd images/$dir
    # skip over windows docker images
    if [[ ! -f is-windows ]] ; then
        img=docker.pkg.github.com/cspotcode/docker-images/$dir:latest
        sudo docker build -t "$img" .
        sudo docker push "$img"
    fi
    popd images/$dir
done
