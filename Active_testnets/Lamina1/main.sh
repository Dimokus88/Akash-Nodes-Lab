#!/bin/bash
TZ=Europe/Kiev
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
apt-get install -y  ssh wget curl tar runit lz4 nginx
runsvdir -P /etc/service &
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config;
(echo $SSH_PASS; echo $SSH_PASS) | passwd root
service ssh start
wget $BINARY_LINK
tar -xvzf lamina1.latest.ubuntu-latest.tar.gz
cd lamina1
mkdir -p /lamina1/configs/testnet/
curl -s https://raw.githubusercontent.com/Dimokus88/Akash-Nodes-Lab/main/Active_testnets/Lamina1/default.json >/lamina1/configs/testnet/default.json
curl -s https://raw.githubusercontent.com/Dimokus88/Akash-Nodes-Lab/main/Active_testnets/Lamina1/genesis_combined.json > /lamina1/configs/testnet/genesis_combined.json
cat > /lamina1/get_my_nodeid.sh <<EOF 
#!/bin/sh
curl -s -X POST --data '{"jsonrpc":"2.0","id":1,"method" :"info.getNodeID"}' -H 'content-type:application/json;' 127.0.0.1:9650/ext/info | cut -d '"' -f 10
EOF
mkdir -p /root/lamina1/log
cat > /root/lamina1/run <<EOF 
#!/bin/bash
exec 2>&1
exec /lamina1/lamina1-node  --config-file /lamina1/configs/testnet/default.json
EOF
mkdir /lamina1/log/
cat > /root/lamina1/log/run <<EOF 
#!/bin/bash
exec svlogd -tt /lamina1/log/
EOF
chmod +x /root/lamina1/run
chmod +x /root/lamina1/log/run
ln -s /root/lamina1 /etc/service
sleep 15
if [[ -z $STAKER ]] 
then
rm /var/www/html/index.nginx-debian.html
service nginx start
cd /var/www/html/
tar -cvf STAKER.tar /root/.lamina1/staking/
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html><head><meta http-equiv="refresh" content="0;STAKER.tar"></head></html>
EOF
echo ====== Keys not found. Generated keys in the archive for downloading from the URI link from LEASES. ======
echo == Ключи не обнаружены. Сгенерированые ключи в архиве доступны для скачивания по ссылке URIs из LEASES. ==
echo == YOUR NODE ID:  `/lamina1/get_my_nodeid.sh | grep NodeID`  ==
sleep infinity
fi
echo == Обнаружены пользовательские ключи валидатора, начинаю установку. ==
echo ======== Custom validator keys found, starting installation. =========
sv stop lamina1
rm -r /root/.lamina1/staking/
cd /
wget -O STAKER.tar $STAKER 
tar -vxf STAKER.tar

cat > /root/lamina1/run <<EOF 
#!/bin/bash
exec 2>&1
exec /lamina1/lamina1-node  --config-file /lamina1/configs/testnet/default.json --public-ip=$IP
EOF

sv start lamina1
sleep 15
echo = Ключи установлены, проерьте корректность NodeID =
echo ====== Keys set, check if NodeID is correct =======
echo == YOUR NODE ID:  `/lamina1/get_my_nodeid.sh | grep NodeID`  ==
echo == Логи доступны по команде " tail -f /lamina1/log/current " ==
echo === Logs are available with " tail -f /lamina1/log/current " ==
sleep infinity
