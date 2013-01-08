#!/usr/bin/env bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
git --git-dir=${DIR}/.git --work-tree=${DIR} pull

while read repo; do
	
	prefix=`echo $repo|awk '{print $1}'`
	url=`echo $repo|awk '{print $2}'`
	
	if [[ -d ${DIR}/${prefix} ]]; then
		echo "Prefix ${prefix} exists."
		echo "Perorming update...."
		echo ""
		git --git-dir=${DIR}/.git --work-tree=${DIR} subtree pull --prefix=${prefix} ${url} master
	else
		echo "Prefix ${prefix} doesn't exist."
		echo "Adding the repo..."
		echo ""
		git --git-dir=${DIR}/.git --work-tree=${DIR} subtree add --prefix=${prefix} ${url} master
	fi;

done < ${DIR}/repolist

git --git-dir=${DIR}/.git --work-tree=${DIR} push

