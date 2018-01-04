#!/bin/bash -x

source 01-localhost.sh
#source 02-production.sh

readonly nginx_port=80

readonly host_nginx_dir=/tmp/nginx/
readonly host_nginx_conf=${host_nginx_dir}${conf_file}
readonly host_nginx_log_files=${host_nginx_dir}logs

if [ ! -d ${host_nginx_log_files} ];
then
    mkdir -pf ${host_nginx_log_files} ;
fi

cp -f ./${conf_file} ${host_nginx_conf} ;

#docker run start -d --rm -v ${host_nginx_dir}:/etc/nginx/:ro -p ${upstream_port}:${downstream_port} -t nginx:latest

docker run -it -p ${upstream_port}:${nginx_port} \
   -v ${host_nginx_conf}:/etc/nginx/nginx.conf:ro \
   -v ${host_nginx_log_files}:/etc/nginx/logs \
   -d b7d42a127980 \
   nginx-debug -g 'daemon off;' ;

#sleep 1 ;
#exit 0 ;