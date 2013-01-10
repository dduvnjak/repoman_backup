#!/usr/bin/env bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
prefix=${1}

function usage {
  echo -e "usage: restore.sh repo_prefix\n"
}

# check number of arguments
if [[ $# -eq 0 ]] || [[ $# -gt 1 ]]; then
        echo "ERROR: Invalid number of arguments";
        usage
        exit -1;
fi;

url=`grep ${prefix} ${DIR}/repolist | awk '{print $2}'`

if [[ ${url} == "" ]]; then
  echo "Repo ${prefix} not found!"
  exit -1
fi;

git --git-dir=${DIR}/.git --work-tree=${DIR} subtree split --prefix=${prefix} --annotate="(${prefix})" -b ${prefix}

git push ${url} ${prefix}:master

git branch -d ${prefix}
