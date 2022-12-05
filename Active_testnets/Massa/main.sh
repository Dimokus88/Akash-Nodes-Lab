#!/bin/bash
source $HOME/.bashrc
TZ=Europe/Kiev
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
apt-get update
apt-get upgrade -y
apt-get install -y sudo nano wget tar zip unzip jq goxkcdpwgen ssh build-essential git make dpkg gcc nvme-cli pkg-config libssl-dev libleveldb-dev clang bsdmainutils ncdu libleveldb-dev 
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
(echo ${my_root_password}; echo ${my_root_password}) | passwd root
service ssh restart
sleep 5
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb
sudo dpkg -i ./libssl1.1_1.1.0g-2ubuntu4_amd64.deb
sudo apt-get install -y nano runit
runsvdir -P /etc/service &
source $HOME/.bashrc
discord=1
error="Error: check if your node is running: error trying to connect: tcp connect error: Connection refused (os error 111)"
echo 'export my_root_password='${my_root_password} >> $HOME/.bashrc
echo 'export my_discord_id='${my_discord_id} >> $HOME/.bashrc
echo 'export my_wallet_privkey='${my_wallet_privkey} >> $HOME/.bashrc
echo 'export my_wallet_addr='${my_wallet_addr} >> $HOME/.bashrc
echo 'export MASSA_LINK='${MASSA_LINK} >> $HOME/.bashrc
echo 'export pass='${pass} >> $HOME/.bashrc
echo 'export client='${client} >> $HOME/.bashrc
echo 'export node='${node} >> $HOME/.bashrc
source $HOME/.bashrc
echo ==========================================================
sleep 5
wget -O ./massa.tar.gz ${MASSA_LINK}
tar -xvf massa.tar.gz

node=/massa/massa-node/massa-node
client=/massa/massa-client/massa-client

cd /massa/massa-node/
chmod +x massa-node
cd /massa/massa-client/
chmod +x massa-client
IP=$(wget -qO- eth0.me)
cat > /massa/massa-node/config/config.toml <<EOF 
[network]
routable_ip = "$IP"
EOF
cat /massa/massa-node/config/config.toml
sleep 5

cd /
mkdir /massa/massa-node/log

cat > /massa/massa-node/run <<EOF 
#!/bin/bash
exec 2>&1
exec ./massa-node -p $pass
EOF

chmod +x /massa/massa-node/run 
LOG=/root/log

cat > /massa/massa-node/log/run <<EOF 
#!/bin/bash
mkdir $LOG
exec svlogd -tt $LOG
EOF

chmod +x /massa/massa-node/log/run
ln -s /massa/massa-node /etc/service
cd /massa/massa-client/
status=`./massa-client get_status -p $pass`

while [[ $status == $error ]]
do
echo ==== Нода не подключена, ожидайте.. =====
echo ===== Node is not connected, wait.. =====
echo $status
sleep 2m
status=`./massa-client get_status -p $pass`
done

chmod +x massa-client
./massa-client wallet_add_secret_keys $my_wallet_privkey -p $pass
sleep 10
./massa-client wallet_info -p $pass
sleep 10
for ((;;))
do	
		./massa-client node_add_staking_secret_keys $my_wallet_privkey -p $pass
		
		synh=`./massa-client get_status -p $pass | grep "Version" | awk '{ print $2 }'`  
		my_wallet_addr=`./massa-client wallet_info -p $pass | grep "Address" | awk '{ print $2 }'`
		
		if [[ $discord == 1 ]]
		then
			discord=`./massa-client node_testnet_rewards_program_ownership_proof $my_wallet_addr $my_discord_id -p $pass`
		fi
		echo =================================Send to MassaBot==========================================
		echo $discord
		echo ============================================================================================
		echo === Your Public Key $my_wallet_addr Ваш публичный адрес ===
		echo ============================================================================================
		balance=$(./massa-client wallet_info -p $pass | grep "Balance:" | awk '{ print $2 }'|sed "s/final=//;s/,//")
		int_balance=${balance%%.*}
		date		
		
		if [[ "$int_balance" -gt "99" ]] ; then
			echo "More than 99. Баланс токенов более 99. "
			resp=$(./massa-client buy_rolls $my_wallet_addr $(($int_balance/100)) 0 -p $pass)
			echo $resp
		elif [[ "$int_balance" -lt "100" ]] ; then
			echo "Less than 100. Баланс токенов менее 100."
		fi
     
	sleep 5m       
done
