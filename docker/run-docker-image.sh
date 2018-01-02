#!/usr/bin/env bash -x

# execute this script from the directory containing this script, please

readonly scriptarg="$1"
readonly currentdir=$(pwd)

readonly bindport=2718
#readonly bindport="$2"

if [ -z "${bindport}" ];
then
   echo "ERROR: Need a bindport." ;
   exit 0
fi

readonly bindiface=0.0.0.0
readonly siteidentifier='robotrobot.io'

# work dir for new builds from github
readonly workdir=$(mktemp -d /tmp/robotrobot.io-XXXXXXX)
readonly robotrobotdir=${workdir}/${siteidentifier}
readonly themedir=${robotrobotdir}/themes

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
   rsync -avh ${robotrobotdir} /tmp ;
fi

echo "Running ${siteidentifier} from ${robotrobotdir} at ${bindiface}:${bindport}..."
#docker run --rm -it -v ${robotrobotdir}:/src -p ${bindport}:1313 -u hugo jguyomard/hugo-builder hugo server -w --bind=${bindiface}
docker run --rm -v ${robotrobotdir}:/src -p ${bindport}:1313 -u hugo jguyomard/hugo-builder hugo server -w --bind=${bindiface}