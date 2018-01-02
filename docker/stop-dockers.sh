#!/usr/bin/env bash

docker ps | grep -v CON | awk '{ print $1 }' | xargs docker stop
