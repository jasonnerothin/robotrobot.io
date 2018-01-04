#!/bin/bash -x

readonly networkname=tonowhere
docker network create --driver=bridge \
--subnet=192.168.127.0/24 \
--gateway=192.168.127.1 \
--ip-range=192.168.127.128/25 \
${networkname} ;
