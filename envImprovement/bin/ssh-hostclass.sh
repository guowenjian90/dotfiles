#!/bin/zsh
# fpath=(/home/wenjian/.zshrc $fpath)
# autoload sshmulti
HOSTS=`expand-hostclass --recurse --hosts-only $1`
script_path=`dirname $0`
HOSTS=${HOSTS:=$*}
# sshmulti $HOSTS
sh $script_path/ssh-multi.sh $HOSTS

