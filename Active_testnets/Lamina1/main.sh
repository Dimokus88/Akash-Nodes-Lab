#!/bin/bash
TZ=Europe/Kiev
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
apt-get install -y  ssh wget curl tar
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config;
(echo $SSH_PASS; echo $SSH_PASS) | passwd root
service ssh start
wget $BINARY_LINK
tar -xvzf lamina1.latest.ubuntu-latest.tar.gz
cd lamina1
curl https://lamina1.github.io/lamina1/config.testnet.tar | tar xf -
./lamina1-node  --config-file configs/testnet/default.json
sleep infinity
