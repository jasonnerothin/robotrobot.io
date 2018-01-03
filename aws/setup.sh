#!/usr/bin/env bash

sudo apt-get update

# install docker CE
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install docker-ce=17.12.0~ce-0~ubuntu

# setup nginx

source ../docker/nginxvars.sh

sudo mkdir -p ${nginxlocalconf}