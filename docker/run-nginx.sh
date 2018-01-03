#!/bin/bash -x

source ./nginxvars.sh

# nginxlocalconf=/tmp/nginx/conf

cp ./nginx.conf ${nginxlocalconf}/

docker run --name nginx -v ${nginxlocalconf}:/etc/nginx:ro -P -d nginx
