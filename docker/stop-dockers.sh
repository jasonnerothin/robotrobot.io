#!/bin/bash -x

sudo docker ps | grep -v CON | awk '{ print $1 }' | xargs sudo docker stop
