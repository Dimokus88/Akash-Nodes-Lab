#!/bin/bash
ip_address=/root/ipaddress
if [[ -n $ip_address ]]
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
