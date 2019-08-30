#!/bin/bash
set -e

# setup environment
. $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/env.sh

. $script_dir/docker.sh

# directory to store assets for test or release
release_dir=$script_dir/release
mkdir -p $release_dir

# expose an extension point for running before main 'release' processing
if [ -f $script_dir/ext/pre_release.sh ]
then
    . $script_dir/ext/pre_release.sh $base_dir
fi

# iterate over each asset
for asset in $assets_dir/*
do
    if [[ $asset != *-local.yaml ]]
    then
        echo "Releasing: $asset"
        mv $asset $release_dir
    fi
done

# login to dockerhub/docker registry login if not running in kubernetes
if [ -z "$KUBERNETES_SERVICE_HOST" ]; then
    registry_login "$DOCKER_PASSWORD" "$DOCKER_USERNAME" "$DOCKER_REGISTRY"
fi

if [ -f $build_dir/image_list ]
then
    while read line
    do
        if [ "$line" != "" ]
        then
            echo "Pushing image $line"
            image_push $line
        fi
    done < $build_dir/image_list
else
    # iterate over each stack
    for repo_stack in $STACKS_LIST
    do
        stack_id=`echo ${repo_stack/*\//}`
        echo "Releasing stack images for: $stack_id"
        image_push $DOCKERHUB_ORG/$stack_id
    done

    echo "Releasing stack index"
    image_push $DOCKERHUB_ORG/$INDEX_IMAGE
    image push $DOCKERHUB_ORG/$INDEX_IMAGE:$INDEX_VERSION
fi

# expose an extension point for running after main 'release' processing
if [ -f $script_dir/ext/post_release.sh ]
then
    . $script_dir/ext/post_release.sh $base_dir
fi
