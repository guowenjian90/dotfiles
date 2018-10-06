#!/bin/zsh
# fpath=(/home/wenjian/.zshrc $fpath)
# autoload sshmulti
HOSTS=`getApolloEnvironmentHosts -e $1 -s $2 --show N`
script_path=`dirname $0`
HOSTS=${HOSTS:=$*}
echo $HOSTS
# sshmulti $HOSTS
sh $script_path/ssh-multi.sh $HOSTS

