#!/bin/bash
set -e

# if we have "--link some-docker:docker" and not DOCKER_HOST, let's set DOCKER_HOST automatically
if [ -z "$DOCKER_HOST" -a "$DOCKER_PORT_2375_TCP" ]; then
	export DOCKER_HOST='tcp://docker:2375'
fi

# proxy configuration
if [ -n "$http_proxy" ]; then
    envcli config set http-proxy $http_proxy
fi
if [ -n "$https_proxy" ]; then
    envcli config set https-proxy $https_proxy
fi

# detect ci
if [ -n "$CI" ]; then
    # set defaults
    envcli config set global-configuration-path /etc
    envcli config set cache-path /cache
    # change to ci project directory
    # - gitlab
    if [ -n "$CI_PROJECT_DIR" ]; then
        cd $CI_PROJECT_DIR
    fi
    # - travis
    if [ -n "$TRAVIS_BUILD_DIR" ]; then
        cd $TRAVIS_BUILD_DIR
    fi
    # install aliases
    envcli install-aliases
fi

exec "$@"
