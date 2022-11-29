#!/bin/bash
if [[ -n $IP ]]
then
runsvdir -P /etc/service &
apt-get update && apt-get upgrade -y
apt install runit -y

sleep infinity
else
echo ip адрес не найден!
echo Укажите во вкладке UPDATE выданный провайдером IP адрес (вкладка lease) и обновите деплоймент!
echo Пример:
echo ==================================
echo =  ...                           =
echo = services:                      =
echo =  node:                         =
echo =    image: kadena/chainweb-node =
echo =    env:                        =
echo =      - "IP=123.123.123.123     =
echo =  ...                           =
echo ==================================
sleep infinity
fi
