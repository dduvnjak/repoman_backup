#!/usr/bin/env bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
prefix=${1}

function usage {
  echo "usage: restore.sh repo_prefix"
}

# check number of arguments
if [[ $# -eq 0 ]] && [[ $# -gt 1 ]]; then
        err_msg="ERROR: Invalid number of arguments \n";
        usage
        exit -1;
fi;

if [[ ! `grep ${prefix} ${DIR}/repolist` ]]; then
  echo "Repo ${prefix} not found!"
  exit 1
fi;

#git --git-dir=${DIR}/.git --work-tree=${DIR} subtree split --prefix=${prefix} --annotate="(${prefix})" -b ${prefix}
