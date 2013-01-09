#!/usr/bin/env bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
prefix=${1}

if [[ ! `grep ${prefix} ${DIR}/repolist` ]]; then
  echo "Repo ${prefix} not found!"
  exit 1
fi;

#git --git-dir=${DIR}/.git --work-tree=${DIR} subtree split --prefix=${prefix} --annotate="(${prefix})" -b ${prefix}
