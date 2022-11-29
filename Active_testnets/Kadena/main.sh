#!/bin/bash
if [[ -n $IP ]]
then
runsvdir -P /etc/service &
sleep 5
mkdir -p /root/kadena/log
cat > /root/kadena/run <<EOF 
#!/bin/bash
exec 2>&1
exec /chainweb/chainweb-node --p2p-hostname $IP
EOF
cat > /root/kadena/log/run <<EOF 
#!/bin/bash
mkdir /var/log/kadena
exec svlogd -tt /var/log/kadena
EOF
chmod +x /root/kadena/run
chmod +x /root/kadena/log/run

ln -s /root/kadena /etc/service
sleep 2
ln -s /var/log/kadena/current /log
sleep 1
tail -f /log
sleep infinity
else
echo
echo IP address not found!
echo Specify in the UPDATE tab the IP address given by the provider and specified in the lease tab and update the deployment!
echo Example:
echo ==================================
echo services:
echo ---node:
echo -----image: kadena/chainweb-node
echo ------env:
echo ------ - "IP=123.123.123.123"
echo ==================================echo
echo
echo IP адрес не найден!
echo Укажите во вкладке UPDATE выданный провайдером IP адрес указанный во вкладке lease и обновите деплоймент!
echo Пример:
echo ==================================
echo services:               
echo ---node:
echo -----image: kadena/chainweb-node
echo ------env:
echo ------ - "IP=123.123.123.123"
echo ==================================
sleep infinity
fi
