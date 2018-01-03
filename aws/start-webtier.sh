#!/bin/bash -x

cd /tmp
curl https://raw.githubusercontent.com/jasonnerothin/robotrobot.io/master/docker/run-hugo.sh -o run-hugo.sh -s
chmod +x run-hugo.sh
./run-hugo.sh
#./run-hugo.sh --cache 2719
