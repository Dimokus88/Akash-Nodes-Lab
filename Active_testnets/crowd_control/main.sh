#!/bin/bash
# By Dimokus (https://t.me/Dimokus)

if [[ -n $MY_ROOT_PASSWORD ]]
then
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
(echo ${MY_ROOT_PASSWORD}; echo ${MY_ROOT_PASSWORD}) | passwd root && service ssh restart
else
apt install -y goxkcdpwgen 
MY_ROOT_PASSWORD=$(goxkcdpwgen -n 1)
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
(echo ${MY_ROOT_PASSWORD}; echo ${MY_ROOT_PASSWORD}) | passwd root && service ssh restart
echo ===========================
echo SSH PASS: $MY_ROOT_PASSWORD
echo ===========================
sleep 20
fi
sleep 5
runsvdir -P /etc/service &
if [[ -n $SNAP_RPC ]]
then 
CHAIN=`curl -s "$SNAP_RPC"/status | jq -r .result.node_info.network`
WORK_FOLDER=`curl -s "$SNAP_RPC"/abci_info | jq -r .result.response.data`
WORK_FOLDER=`echo $WORK_FOLDER | sed "s/$WORK_FOLDER/.$WORK_FOLDER/"`
fi
SHIFT=1000
GIT_FOLDER=`basename $GITHUB_REPOSITORY | sed "s/.git//"`
echo $CHAIN
echo $WORK_FOLDER
echo $GENESIS
sleep 10
echo 'export MONIKER='${MONIKER} >> /root/.bashrc
echo 'export CHAT_ID='${CHAT_ID} >> /root/.bashrc
echo 'export CHAIN='${CHAIN} >> /root/.bashrc
echo 'export SNAP_RPC='${SNAP_RPC} >> /root/.bashrc
echo 'export TOKEN='${TOKEN} >> /root/.bashrc
echo 'export GENESIS='${GENESIS} >> /root/.bashrc
source /root/.bashrc
#======================================================== НАЧАЛО БЛОКА ФУНКЦИЙ ==================================================
#-------------------------- Установка GO и кмопиляция бинарного файла -----------------------
INSTALL (){
#-----------КОМПИЛЯЦИЯ БИНАРНОГО ФАЙЛА------------
echo  "Downloading Binary..."
wget https://github.com/DecentralCardGame/Cardchain/releases/download/v0.81/Cardchain_latest_linux_amd64.tar.gz
tar xzf Cardchain_latest_linux_amd64.tar.gz
chmod 775 Cardchaind
BINARY=Cardchaind
echo 'export BINARY='${BINARY} >> /root/.bashrc
sudo mv Cardchaind /usr/local/bin/
sudo rm Cardchain_latest_linux_amd64.tar.gz
$BINARY version
#-------------------------------------------------

#=======ИНИЦИАЛИЗАЦИЯ БИНАРНОГО ФАЙЛА================
echo =INIT=
rm /root/$WORK_FOLDER/config/genesis.json
$BINARY init "$MONIKER" --chain-id $CHAIN --home /root/$WORK_FOLDER
sleep 5
$BINARY config chain-id $CHAIN
$BINARY config keyring-backend os
#====================================================

#===========ДОБАВЛЕНИЕ GENESIS.JSON===============
wget -O $HOME/$WORK_FOLDER/config/genesis.json https://raw.githubusercontent.com/DecentralCardGame/Testnet/main/genesis.json
DENOM=`cat $HOME/$WORK_FOLDER/config/genesis.json | grep denom -m 1 | tr -d \"\, | sed "s/denom://" | tr -d \ `
echo 'export DENOM='${DENOM} >> /root/.bashrc
#=================================================

#-----ВНОСИМ ИЗМЕНЕНИЯ В CONFIG.TOML , APP.TOML.-----------

if [[ -n $SNAP_RPC ]]
then
n_peers=`curl -s $SNAP_RPC/net_info? | jq -r .result.n_peers`
let n_peers="$n_peers"-1
RPC="$SNAP_RPC"
echo -n "$RPC," >> /root/RPC.txt
p=0
count=0
echo "Search peers..."
while [[ "$p" -le  "$n_peers" ]] && [[ "$count" -le  14 ]]
do
	PEER=`curl -s  $SNAP_RPC/net_info? | jq -r .result.peers["$p"].node_info.listen_addr`
        if [[ ! "$PEER" =~ "tcp" ]] 
        then
			id=`curl -s  $SNAP_RPC/net_info? | jq -r .result.peers["$p"].node_info.id`
            		echo -n "$id@$PEER," >> /root/PEER.txt
			echo $id@$PEER
			rm /root/addr.tmp
			echo $PEER | sed 's/:/ /g' > /root/addr.tmp
			ADDRESS=(`cat /root/addr.tmp`)
			ADDRESS=`echo ${ADDRESS[0]}`
			PORT=(`cat /root/addr.tmp`)
			PORT=`echo ${PORT[1]}`
			let PORT=$PORT+1
			RPC=`echo $ADDRESS:$PORT`
			let count="$count"+1
			if [[ `curl -s http://$RPC/abci_info? --connect-timeout 5 | jq -r .result.response.last_block_height` -gt 0 ]]
			then
				echo "$RPC"
				echo -n "$RPC," >> /root/RPC.txt
				RPC=0
			fi
			RPC=0
   	     fi
	p="$p"+1
	done
echo "Search peers is complete!"
PEER=`cat /root/PEER.txt | sed 's/,$//'`
RPC=`cat /root/RPC.txt | sed 's/,$//'`
else
	if [[ -n $link_peer ]]
	then
		PEER=`curl -s $link_peer`
	fi

	if [[ -n $link_seed ]]
	then
		SEED=`curl -s $link_seed`
	fi
fi
echo $PEER
echo $SEED
sleep 5
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025$DENOM\"/;" /root/$WORK_FOLDER/config/app.toml
sleep 1
sed -i.bak -e "s/^seeds *=.*/seeds = \"$SEED\"/;" /root/$WORK_FOLDER/config/config.toml
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$PEER\"/;" /root/$WORK_FOLDER/config/config.toml
sed -i.bak -e "s_"tcp://127.0.0.1:26657"_"tcp://0.0.0.0:26657"_;" /root/$WORK_FOLDER/config/config.toml
pruning="custom" && \
pruning_keep_recent="5" && \
pruning_keep_every="1000" && \
pruning_interval="50" && \
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" /root/$WORK_FOLDER/config/app.toml && \
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" /root/$WORK_FOLDER/config/app.toml && \
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" /root/$WORK_FOLDER/config/app.toml && \
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" /root/$WORK_FOLDER/config/app.toml
snapshot_interval="1000" && \
sed -i.bak -e "s/^snapshot-interval *=.*/snapshot-interval = \"$snapshot_interval\"/" /root/$WORK_FOLDER/config/app.toml
#-----------------------------------------------------------

#|||||||||||||||||||||||||||||||||||ФУНКЦИЯ Backup||||||||||||||||||||||||||||||||||||||||||||||||||||||
# ====================RPC======================
if [[ -n $SNAP_RPC ]]
then
	RPC=`echo $SNAP_RPC,$RPC`
	echo $RPC
	LATEST_HEIGHT=`curl -s $SNAP_RPC/block | jq -r .result.block.header.height`; \
	BLOCK_HEIGHT=$((LATEST_HEIGHT - $SHIFT)); \
	TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)
	echo $LATEST_HEIGHT $BLOCK_HEIGHT $TRUST_HASH
	sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
	s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$RPC\"| ; \
	s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
	s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"|" /root/$WORK_FOLDER/config/config.toml
	echo RPC
fi
#================================================
# |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
wget -O /tmp/priv_validator_key.json ${LINK_KEY}
file=/tmp/priv_validator_key.json
if  [[ -f "$file" ]]
then
	      sleep 2
	      cd /
	      rm /root/$WORK_FOLDER/config/priv_validator_key.json
	      echo ==========priv_validator_key found==========
	      echo ========Обнаружен priv_validator_key========
	      cp /tmp/priv_validator_key.json /root/$WORK_FOLDER/config/
	      echo ========Validate the priv_validator_key.json file=========
	      echo ==========Сверьте файл priv_validator_key.json============
	      cat /tmp/priv_validator_key.json
	      sleep 10
    else     	
    	echo "==================================================================================="
	echo "======== priv_validator_key not found! Specify direct download link ==============="
	echo "===== of the validator key file in the LINK_KEY variable in your deploy.yml ======="
	echo "===== If you don't have a key file, use the instructions at the link below ======="
	echo "== https://github.com/Dimokus88/guides/blob/main/Cosmos%20SDK/valkey/README.md ===="
	echo "==================================================================================="
	echo "========  priv_validator_key ненайден! Укажите ссылку напрямое скачивание  ========"
	echo "========  файла ключа валидатора в переменной LINK_KEY в вашем deploy.yml  ========"
	echo "=====  Если у вас нет файла ключа, воспользуйтесь инструкцией по ссылке ниже ====="
	echo "== https://github.com/Dimokus88/guides/blob/main/Cosmos%20SDK/valkey/README.md ===="
	echo "==================================================================================="
	echo "============= The node is running with the generated validator key! ==============="
	echo "==================================================================================="
	echo "================= Нода запущена с сгенерированным ключом валидатора! =============="
	echo "==================================================================================="
	RUN
	sleep infinity 	
    fi
}

RUN (){
#===========ЗАПУСК НОДЫ============
echo =Run node...=
cd /
mkdir /root/$BINARY
mkdir /root/$BINARY/log
    
cat > /root/$BINARY/run <<EOF 
#!/bin/bash
exec 2>&1
exec $BINARY start
EOF
chmod +x /root/$BINARY/run
LOG=/var/log/$BINARY

cat > /root/$BINARY/log/run <<EOF 
#!/bin/bash
mkdir $LOG
exec svlogd -tt $LOG
EOF
chmod +x /root/$BINARY/log/run
ln -s /root/$BINARY /etc/service
ln -s /var/log/$BINARY/current /LOG
}
#--------------------------------------------------------------------------------------------
#======================================================== КОНЕЦ БЛОКА ФУНКЦИЙ ====================================================
INSTALL
sleep 15
RUN
sleep 30
catching_up=`curl -s localhost:26657/status | jq -r .result.sync_info.catching_up`
while [[ $catching_up == true ]]
do
echo == Нода не синхронизирована ==
sleep 2m
catching_up=`curl -s localhost:26657/status | jq -r .result.sync_info.catching_up`
echo $catching_up
done
#=====Включение алерт бота =====

if [[ -n $TOKEN ]]
then
cd /root/
git clone https://github.com/Dimokus88/bot.git 
cd bot
echo $SNAP_RPC > /root/bot/RPC.txt
chmod -R o+rx /root/bot/
/root/bot/run_bot.sh $BINARY $TOKEN
fi
#==============================
sleep 1m
# -----------------------------------------------------------
for ((;;))
  do    
    tail -100 /var/log/$BINARY/current | grep -iv peer
    sleep 10m
  done
fi
