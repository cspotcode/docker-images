#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

set -x
export HOME="$CONTAINER_HOME"

sudo ls -al /var/run/docker.sock
sudo ls -al "$HOME"
id

sudo docker login docker.pkg.github.com --username cspotcode --password-stdin <<< "$GITHUB_TOKEN"

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
