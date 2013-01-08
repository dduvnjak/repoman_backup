#!/usr/bin/env bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

while read repo; do
	prefix=`echo $repo|awk '{print $1}'`
	url=`echo $repo|awk '{print $2}'`
	if [[ -d ${DIR}/${prefix} ]]; then
		echo "Prefix ${prefix} exists"
	fi;
done < ${DIR}/repolist

