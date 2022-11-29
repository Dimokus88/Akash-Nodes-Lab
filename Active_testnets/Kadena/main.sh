#!/bin/bash
if [ ! -s /root/ipaddress ]
then
echo ip адрес не найден!
sleep infinity
else
#runsvdir -P /etc/service &
#apt-get update && apt-get upgrade -y
#apt install runit -y
echo =========== ip адрес найден =============
sleep infinity
fi
