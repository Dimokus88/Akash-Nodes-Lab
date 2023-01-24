#!/bin/bash
TZ=Europe/Kiev
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
apt-get install -y  ssh wget curl tar runit
runsvdir -P /etc/service &
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config;
(echo $SSH_PASS; echo $SSH_PASS) | passwd root
service ssh start
wget $BINARY_LINK
tar -xvzf lamina1.latest.ubuntu-latest.tar.gz
cd lamina1
curl https://lamina1.github.io/lamina1/config.testnet.tar | tar xf -

mkdir -p /root/lamina1/log
cat > /root/lamina1/run <<EOF 
#!/bin/bash
exec 2>&1
exec cd /lamina1/
exec ./lamina1-node  --config-file ./configs/testnet/default.json
EOF
mkdir /lamina1/log/
cat > /root/lamina1/log/run <<EOF 
#!/bin/bash
exec svlogd -tt /lamina1/log/
EOF
chmod +x /root/lamina1/run
chmod +x /root/lamina1/log/run
ln -s /root/lamina1 /etc/service


sleep infinity
