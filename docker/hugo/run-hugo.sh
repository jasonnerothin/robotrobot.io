#!/bin/bash

readonly script_arg="$1"
readonly current_dir=$(pwd)

readonly hugo_port=1414

readonly bind_iface=0.0.0.0
readonly dev_site_identifier=localhost
readonly github_url=https://github.com/jasonnerothin/robotrobot.io.git
readonly github_theme_url=https://github.com/MarcusVirg/forty

readonly site_identifier=${dev_site_identifier}
readonly base_url=http://${site_identifier}

# work dir for new builds from github
readonly work_dir=$(mktemp -d /tmp/${site_identifier}-XXXXXXX)
readonly local_srcdir=${work_dir}
readonly theme_dir=${local_srcdir}/themes

# temp dirs to skip git
readonly cached_site_dir=/tmp/${site_identifier} ;
if [ ! -d ${cached_site_dir} ]; then mkdir -p ${cached_site_dir} ; fi

echo "INFO: Created work directory: ${work_dir}" ;

if [ "${script_arg}" != "--github" ];
then
   echo "INFO: Attempting a read from ${cached_site_dir}" ;
#   rsync -avh ${cached_site_dir}/* ${work_dir} ;
else
   echo "INFO: Pulling down from github and caching to: ${cached_site_dir}" ;
   git clone ${github_url} ${local_srcdir} ;
   cd ${local_srcdir}/themes ;
   git clone ${github_theme_url} ;
   rsync -avh ${local_srcdir}/* ${cached_site_dir} ;
fi
rm -rf ${cached_site_dir}/.git* ${cached_site_dir}/aws ${cached_site_dir}/docker \
   ${cached_site_dir}/themes/.git* ${cached_site_dir}/themes/.git ${cached_site_dir}/themes/exampleSite ;

echo "Running ${site_identifier} from ${local_srcdir} at localhost:${hugo_port} on interface ${bind_iface}..." ;
set -x
docker run --network=tonowhere \
    --rm -v ${cached_site_dir}:/src \
    -u hugo --name hugo \
    -d jguyomard/hugo-builder \
    hugo server -w --bind=${bind_iface} --baseURL http://${site_identifier} --port ${hugo_port} ;
set +x

sleep 1 ;
cd ${current_dir} ;
exit 0 ;
