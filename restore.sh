#!/usr/bin/env bash

# Get script directory
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Git subtree prefix is the first argument
prefix=${1}

# function for printing usage instructions
function usage {
  echo -e "usage: restore.sh repo_prefix\n"
}

# check number of arguments, print usage if number is wrong
if [[ $# -eq 0 ]] || [[ $# -gt 1 ]]; then
        echo "ERROR: Invalid number of arguments";
        usage
        exit -1;
fi;

# get the git url based on prefix
url=`grep ${prefix} ${DIR}/repolist | awk '{print $2}'`

# check if prefix/url exists
if [[ ${url} == "" ]]; then
  echo "Repo ${prefix} not found!"
  exit -1
fi;

# extract ssh connection from git url
ssh_conn=`echo ${url} | cut -d":" -f 1`
# extract repo location on the git server
repo_location=`echo ${url} | cut -d":" -f 2`

# perform a complete clean of the repo dir on the git server
ssh ${ssh_conn} "rm -rf ${repo_location}/* && git --git-dir=${repo_location} init --bare"

# split the original repo from the subtree
git --git-dir=${DIR}/.git --work-tree=${DIR} subtree split --prefix=${prefix} --annotate="(${prefix})" -b ${prefix}

# push the splitted repo to the original location
git push -f ${url} ${prefix}:master

# delete the temporary created branch for splitting
git branch -d ${prefix}
