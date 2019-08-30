#!/bin/bash

image_build() {
    if [ "$USE_BUILDAH" == "true" ]; then
        buildah bud $@
    else
        docker build $@
    fi
}

image_push() {
    if [ "$USE_BUILDAH" == "true" ]; then
        buildah push --tls-verify=false $@
    else
        docker push $@
    fi
}

registry_login() {
    local username=$1
    local password=$2
    local registry=$3
    if [ "$USE_BUILDAH" == "true" ]; then
        echo "$password" | buildah login -u "$username" --password-stdin $registry
    else
        echo "$password" | docker login -u "$username" --password-stdin $registry
    fi
}
