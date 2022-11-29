#!/bin/bash
if [ -e /root/ipaddress ]
then
#runsvdir -P /etc/service &
#apt-get update && apt-get upgrade -y
#apt install runit -y
echo =========== ip адрес найден =============
sleep infinity
else

echo ip адрес не найден!
sleep infinity
fi
