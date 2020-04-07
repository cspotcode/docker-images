#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

set -x

# Use our own home directory, not the one that Github Actions tries to give us
export HOME="$CONTAINER_HOME"

# Using sudo for all docker stuff, because we need root to read/write the docker socket

# Login to Github Packages
sudo docker login docker.pkg.github.com --username cspotcode --password-stdin <<< "$GITHUB_TOKEN"

# Perform a test push of a small image to Github Actions to verify permission
sudo docker pull alpine
sudo docker tag alpine docker.pkg.github.com/cspotcode/docker-images/alpine-test-push:latest
sudo docker push docker.pkg.github.com/cspotcode/docker-images/alpine-test-push:latest

# Build and push a single image
build_push() {
    local dir
    dir="$1"
    pushd "images/$dir"
    # skip over windows docker images
    if [[ ! -f is-windows ]] ; then
        img="docker.pkg.github.com/cspotcode/docker-images/$dir:latest"
        img2="docker.pkg.github.com/cspotcode/docker-images/$dir:$GITHUB_REF"
        DOCKER_BUILDKIT=1 sudo --preserve-env=DOCKER_BUILDKIT \
            docker build \
                --cache-from="$img2" \
                --build-arg BUILDKIT_INLINE_CACHE=1 \
                -t "$img" \
                -t "$img2" \
                .
        sudo docker push "$img"
        sudo docker push "$img2"
    fi
    popd
}

# Listed explicitly so we can control the ordering
build_push node-ci
build_push build-node-from-source
