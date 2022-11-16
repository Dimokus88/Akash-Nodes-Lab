#!/bin/bash
# By Dimokus (https://t.me/Dimokus)
runsvdir -P /etc/service &
cp /usr/lib/go-1.18/bin/go /usr/bin/
# ++++++++++++ Установка удаленного доступа ++++++++++++++
echo 'export MY_ROOT_PASSWORD='${MY_ROOT_PASSWORD} >> /root/.bashrc
apt -y install tmate
mkdir /root/tmate && mkdir /root/tmate/log
cat > /root/tmate/run <<EOF 
#!/bin/bash
exec 2>&1
exec tmate -F
EOF
cat > /root/tmate/log/run <<EOF 
#!/bin/bash
mkdir /var/log/tmate
exec svlogd -tt /var/log/tmate
EOF
chmod +x /root/tmate/run
chmod +x /root/tmate/log/run
ln -s /root/tmate /etc/service

if [[ -n $MY_ROOT_PASSWORD ]]
then
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
  (echo ${MY_ROOT_PASSWORD}; echo ${MY_ROOT_PASSWORD}) | passwd root && service ssh restart
else
  apt install -y goxkcdpwgen 
  MY_ROOT_PASSWORD=$(goxkcdpwgen -n 1)
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
  (echo ${MY_ROOT_PASSWORD}; echo ${MY_ROOT_PASSWORD}) | passwd root && service ssh restart
  echo ============= SSH PASS: $MY_ROOT_PASSWORD ==============
  sleep 10
fi
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# ---------------- переменные ----------------------
GIT_FOLDER=`basename $GITHUB_REPOSITORY | sed "s/.git//"`
if [[ -n $SNAP_RPC ]]
then 
CHAIN=`curl -s "$SNAP_RPC"/status | jq -r .result.node_info.network`
  if [[ -z "$BINARY_VERSION" ]]
  then
    BINARY_VERSION=`curl -s "$SNAP_RPC"/abci_info | jq -r .result.response.version`
  fi
fi

echo $CHAIN
echo $GENESIS
sleep 10
echo 'export MONIKER='${MONIKER} >> /root/.bashrc
echo 'export BINARY_VERSION='${BINARY_VERSION} >> /root/.bashrc
echo 'export CHAIN='${CHAIN} >> /root/.bashrc
echo 'export SNAP_RPC='${SNAP_RPC} >> /root/.bashrc
echo 'export TOKEN='${TOKEN} >> /root/.bashrc
echo 'export GENESIS='${GENESIS} >> /root/.bashrc
source /root/.bashrc
# --------------------------------------------------
INSTALL (){
#-----------КОМПИЛЯЦИЯ БИНАРНОГО ФАЙЛА------------
git clone $GITHUB_REPOSITORY && cd  `find /$GIT_FOLDER -name Makefile | sed "s/Makefile//"`
sleep 5
git checkout $BINARY_VERSION
make build
make install
BINARY=`ls /root/go/bin`
if [[ -z $BINARY ]]
then
BINARY=`ls /root/$GIT_FOLDER/build/`
fi
echo $BINARY
echo 'export BINARY='${BINARY} >> /root/.bashrc
cp /root/$GIT_FOLDER/build/$BINARY /usr/bin/$BINARY
cp /root/go/bin/$BINARY /usr/bin/$BINARY
$BINARY version
#-------------------------------------------------
#=======ИНИЦИАЛИЗАЦИЯ БИНАРНОГО ФАЙЛА================
echo =INIT=
$BINARY init "$MONIKER" --chain-id $CHAIN --home /root/$BINARY
sleep 5
$BINARY config chain-id $CHAIN
$BINARY config keyring-backend os
#====================================================
#===========ДОБАВЛЕНИЕ GENESIS.JSON===============
if [[ -n ${SNAP_RPC} ]]
then 
	rm /root/$BINARY/config/genesis.json
	curl -s "$SNAP_RPC"/genesis | jq .result.genesis >> /root/$BINARY/config/genesis.json
	DENOM=`curl -s "$SNAP_RPC"/genesis | grep denom -m 1 | tr -d \"\, | sed "s/denom://" | tr -d \ `
	echo 'export DENOM='${DENOM} >> /root/.bashrc
fi
if [[ -n ${GENESIS} ]]
then
	wget -O $HOME/$BINARY/config/genesis.json $GENESIS
	DENOM=`cat $HOME/$BINARY/config/genesis.json | grep denom -m 1 | tr -d \"\, | sed "s/denom://" | tr -d \ `
	echo 'export DENOM='${DENOM} >> /root/.bashrc
fi
echo $DENOM
sleep 5
#=================================================


#-----ВНОСИМ ИЗМЕНЕНИЯ В CONFIG.TOML , APP.TOML.-----------

if [[ -n ${SNAP_RPC} ]] && [[  -z "$PEER" ]]
then
  n_peers=`curl -s $SNAP_RPC/net_info? | jq -r .result.n_peers`
  let n_peers="$n_peers"-1
  RPC="$SNAP_RPC"
  echo -n "$RPC," >> /root/RPC.txt
  p=0
  count=0
  echo "Search peers..."
  while [[ "$p" -le  "$n_peers" ]] && [[ "$count" -le 9 ]]
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
			count="$count"+1
   	fi
	p="$p"+1
done
echo "Search peers is complete!"
PEER=`cat /root/PEER.txt | sed 's/,$//'`
fi
echo $PEER
echo $SEED
sleep 5
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025$DENOM\"/;" /root/$BINARY/config/app.toml
sleep 1
sed -i.bak -e "s/^double_sign_check_height *=.*/double_sign_check_height = 15/;" /root/$BINARY/config/config.toml
sed -i.bak -e "s/^seeds *=.*/seeds = \"$SEED\"/;" /root/$BINARY/config/config.toml
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$PEER\"/;" /root/$BINARY/config/config.toml
sed -i.bak -e "s_"tcp://127.0.0.1:26657"_"tcp://0.0.0.0:26657"_;" /root/$BINARY/config/config.toml
pruning="custom" && \
pruning_keep_recent="1000" && \
pruning_interval="10" && \
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" /root/$BINARY/config/app.toml && \
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" /root/$BINARY/config/app.toml && \
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" /root/$BINARY/config/app.toml
snapshot_interval="2000" && \
sed -i.bak -e "s/^snapshot-interval *=.*/snapshot-interval = \"$snapshot_interval\"/" /root/$BINARY/config/app.toml
#-----------------------------------------------------------
# ====================RPC======================
if [[ -n ${SNAP_RPC} ]]
then
	RPC=`echo $SNAP_RPC,$SNAP_RPC,$RPC`
	echo $RPC
	LATEST_HEIGHT=`curl -s $SNAP_RPC/block | jq -r .result.block.header.height`; \
	BLOCK_HEIGHT=$((LATEST_HEIGHT - 2000)); \
	BLOCK_HEIGHT=`echo $BLOCK_HEIGHT | sed "s/...$/000/"`; \
	TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)
	echo $LATEST_HEIGHT $BLOCK_HEIGHT $TRUST_HASH
	sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
	s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$RPC\"| ; \
	s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
	s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"|" /root/$BINARY/config/config.toml
fi
#================================================
wget -O /tmp/priv_validator_key.json ${LINK_KEY}
file=/tmp/priv_validator_key.json
if  [[ -f "$file" ]]
then
	      sleep 2
	      cd /
	      rm /root/$BINARY/config/priv_validator_key.json
	      echo ==========priv_validator_key found==========
	      echo ========Обнаружен priv_validator_key========
	      cp /tmp/priv_validator_key.json /root/$BINARY/config/
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
	echo "========  priv_validator_key не найден! Укажите ссылку напрямое скачивание  ======="
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
# +++++++++++ Защита от двойной подписи ++++++++++++
if [[ -n ${SNAP_RPC} ]]
then
  HEX=`cat /root/$BINARY/config/priv_validator_key.json | jq -r .address`
  COUNT=15
  CHECKING_BLOCK=`curl -s $SNAP_RPC/abci_info? | jq -r .result.response.last_block_height`
  while [[ $COUNT -gt 0 ]]
  do
    CHEKER=`curl -s $SNAP_RPC/commit?height=$CHECKING_BLOCK | grep $HEX`
    if [[ -n $CHEKER  ]]
    then
    	echo ++ Защита от двойной подписи!++
    	echo ++ ВНИМАНИЕ! ОБНАРУЖЕНА ПОДПИСЬ В ВАЛИДАТОРА НА БЛОКЕ № $CHECKING_BLOCK ! ЗАПУСК НОДЫ ОСТАНОВЛЕН! ++
    	echo ++ Double signature protection!++
    	echo ++ WARNING! VALIDATOR SIGNATURE DETECTED ON BLOCK № $CHECKING_BLOCK ! NODE LAUNCH HAS BEEN STOPPED! ++
    	sleep infinity
    fi
    let COUNT=$COUNT-1
    let CHECKING_BLOCK=$CHECKING_BLOCK-1
    sleep 1
  done
fi
# ++++++++++++++++++++++++++++++++++++++++++++++++++
#===========ЗАПУСК НОДЫ============
echo =Run node...=
cd /
mkdir /root/$BINARY/log
    
cat > /root/$BINARY/run <<EOF 
#!/bin/bash
exec 2>&1
exec $BINARY start --home /root/$BINARY
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
#======================================================== КОНЕЦ БЛОКА ФУНКЦИЙ ====================================================

INSTALL
sleep 5
RUN
sleep 30
catching_up=`curl -s localhost:26657/status | jq -r .result.sync_info.catching_up`
count=0
while [[ $catching_up == true ]]
do
  echo == Нода не синхронизирована, ожидайте.. ==
  echo == Node out of sync, please wait.. ==
  sleep 2m
  catching_up=`curl -s localhost:26657/status | jq -r .result.sync_info.catching_up`
  LB=`curl -s localhost:26657/status | jq -r .result.sync_info.latest_block_height`
  echo $catching_up
  echo $LB
done

# -----------------------------------------------------------
for ((;;))
  do    
    tail -50 /var/log/$BINARY/current | grep -iv peer
    sleep 10m
  done
fi
