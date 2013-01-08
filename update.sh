#!/usr/bin/env bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

while read repo; do
	prefix=`echo $repo|awk '{print $1}'`
	url=`echo $repo|awk '{print $2}'`
	
	if [[ -d ${DIR}/${prefix} ]]; then
		echo "Prefix ${prefix} exists."
		echo "Perorming update...."
		git --git-dir=${DIR}/.git --work-tree=${DIR} subtree pull   --prefix=${prefix} ${url} master
	fi;

done < ${DIR}/repolist

