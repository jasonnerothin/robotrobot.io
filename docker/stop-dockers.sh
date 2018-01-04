#!/bin/bash

docker ps | grep -v CON | awk '{ print $1 }' | xargs docker stop
#sudo docker ps | grep -v CON | awk '{ print $1 }' | xargs sudo docker stop

docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm
sleep 1
exit 0
