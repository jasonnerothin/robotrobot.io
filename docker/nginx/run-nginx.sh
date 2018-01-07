#!/bin/bash -x

# execute this script from the directory containing this script, please

source ./01-localhost.sh
#readonly conf_file=nginx.conf
#source 02-pcoroduction.sh

readonly nginx_port=80

readonly host_nginx_dir=/tmp/nginx/
readonly host_nginx_conf=${host_nginx_dir}${conf_file}
readonly host_nginx_log_files=${host_nginx_dir}logs

if [ ! -d ${host_nginx_log_files} ];
then
    mkdir -pf ${host_nginx_log_files} ;
fi

cp -f ./${conf_file} ${host_nginx_conf} ;

set -x
docker run --network=tonowhere -it -p 80:80 -p 1414:1414 --name nginx \
   -v ${host_nginx_conf}:/etc/nginx/nginx.conf:ro \
   -d nginx-debug \
   nginx-debug -g 'daemon off;' ;
set +x

sleep 1 ;
exit 0 ;
