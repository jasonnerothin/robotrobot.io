#!/usr/bin/env bash

sudo docker ps | grep -v CON | awk '{ print $1 }' | xargs docker stop
