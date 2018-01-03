#!/bin/bash -x

# execute this script from the directory containing this script, please

readonly scriptarg="$1"
readonly currentdir=$(pwd)

readonly localport=2718
readonly hugoport=1414

readonly bindiface=0.0.0.0
readonly siteidentifier='robotrobot.io'
#readonly siteidentifier=localhost
readonly baseurl=http://${siteidentifier}

# work dir for new builds from github
readonly workdir=$(mktemp -d /tmp/${siteidentifier}-XXXXXXX)
readonly localsrcdir=${workdir}/${siteidentifier}
readonly themedir=${localsrcdir}/themes
readonly localport=3141

# temp dirs to skip git
readonly cachedsitedir=/tmp/${siteidentifier}
if [ ! -d ${cachedsitedir} ]; then mkdir ${cachedsitedir} ; fi

echo "INFO: Created work directory: ${workdir}"
cd ${workdir}

if [ "${scriptarg}" == "--cache" ];
then
   echo "INFO: Syncing last github pull from cache at: ${cachedsitedir}"
   rsync -avh ${cachedsitedir} .
else
   echo "INFO: Pulling down from github and caching to: ${cachedsitedir}"
   cd ${workdir} ;
   git clone https://github.com/jasonnerothin/${siteidentifier}.git ;
   cd ${themedir} ;
   git clone https://github.com/MarcusVirg/forty ;
   cd ${currentdir} ;
   rsync -avh ${localsrcdir} /tmp ;
fi

echo "Running ${siteidentifier} from ${localsrcdir} at ${bindiface}:${hugoport}..."
sudo docker run \
    -d --rm -v ${localsrcdir}:/src \
    -p ${localport}:${hugoport} -u hugo \
    jguyomard/hugo-builder \
    hugo server -w --bind=${bindiface} --baseURL ${baseurl} --port ${hugoport}