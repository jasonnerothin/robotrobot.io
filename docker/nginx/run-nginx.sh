#!/bin/bash -x

#readonly conffile=nginx.production.conf
readonly conffile=nginx.localhost.conf

readonly localnginxdir=/tmp/nginx/

if [ ! -d ${localnginxdir} ];
then
    mkdir -p ${localnginxdir} ;
fi

readonly localnginxconf=${localnginxdir}${conffile}
if [ ! -f ${localnginxconf} ];
then
    cp -f ./${conffile} ${localnginxdir}/nginx.conf ;
fi

sudo docker run -d --rm -v ${localnginxdir}:/etc/nginx/:ro -p 8090:80 -t nginx:latest