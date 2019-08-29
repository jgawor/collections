#!/bin/bash
set -e

if [ -z $BUILD_ALL ]
then
    export RELEASE_NAME="$stack_id-v$stack_version"
else
    if [ -z $TRAVIS_TAG ]; then
        if [ -f $base_dir/VERSION ]; then
            export RELEASE_NAME="$(cat $base_dir/VERSION)"
        else
            export RELEASE_NAME="$BUILD_ALL"
        fi
    else
        export RELEASE_NAME=$TRAVIS_TAG
    fi
fi

# Unset the INDEX_LIST variable that wopuld have been set by the Apposdy build
unset INDEX_LIST

# Setup the environment variable needed to build Kabanero Collections
export BUILD_ALL=true
export REPO_LIST=incubator
export EXCLUDED_STACKS=incubator/swift
export CODEWIND_INDEX=false
export INDEX_IMAGE=kabanero-index
