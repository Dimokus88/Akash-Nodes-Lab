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
git clone $GITHUB_REPOSITORY && cd $GIT_FOLDER
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

PEER="994c9398e55947b2f1f45f33fbdbffcbcad655db@okp4-testnet.nodejumper.io:29656,9d53d896fe92947f8955356191ec0d8c48ce5c98@143.198.179.16:26656,4a46d3ebb46d154c2e9a80f902de331564e12ecb@49.12.216.13:60756,614bbd8582094dd40655ebf74feac81fd0eab530@95.216.252.32:26656,bf6655b16b995a5ebc9bac48411f89d6b832d252@116.202.21.210:26656,94ae99b5efbbcfc26b70122c2d79f82588c14762@109.107.191.202:26656,e4d902d1b7c2c21c1a015352f7477a91c31e26c3@128.199.159.202:36656,a5f66d43453252bb51e35025fcf697f337ee0a3b@88.198.34.226:10096,5f27f3b5c813cb79902759d4ab1308b7fa28e05d@195.2.92.172:26656,ada4e7531515ac292e02d67c2780beb6a2e518e3@62.113.113.65:26656,aff7c6f4a4d2081fe7bab2d7165b585df51cbb3e@94.103.81.202:26656,5ce331c27ba867e11f56b933a51ae67289debfa2@23.88.10.3:26656,884f2ac01e37b97e58deb06a52638b96d64dc9ea@45.85.250.65:26656,0795566d7dae3e72b94bfffe91a9389846e16170@91.196.164.212:26656,53f3e3abee5be9aef0de9adc663c94ae62c911df@135.181.158.205:26656,ba1ad28ac74455335b745f38a90f26b08cad3d47@161.35.162.77:26656,d447c0160314b801ced8252829a00a27bfb5242f@193.33.194.153:26656,0ace47c9e9037ef34e26bfaa6c1d24b791499771@46.101.43.11:26656,579f664e68cd95b9be97426563ca2b79b63f9cf0@212.23.222.93:36656,6fb047e647333b3efe9e536d1825f52b571a6cf4@107.155.91.166:29656,8c1fed645d89306b0df5343743e902b292111d40@62.113.117.151:26656,81e6ecb1a1aa4ffba826b82ae287b169e7fff701@4.227.188.54:26656,e90452c94bce24a2e5c80d3fcaf8e10194414d50@185.188.249.179:26656,02855dcad19516b59ab8d495f0f8bc8a931c5a3d@195.2.74.35:26656"

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
apt install lz4 -y
cp $HOME/okp4d/data/priv_validator_state.json $HOME/okp4d/priv_validator_state.json.backup
okp4d tendermint unsafe-reset-all --home $HOME/okp4d --keep-addr-book
rm -rf $HOME/okp4d/data 
rm -rf $HOME/okp4d/wasm
SNAP_NAME=$(curl -s https://snapshots2-testnet.nodejumper.io/okp4-testnet/ | egrep -o ">okp4-nemeton.*\.tar.lz4" | tr -d ">")
curl https://snapshots2-testnet.nodejumper.io/okp4-testnet/${SNAP_NAME} | lz4 -dc - | tar -xf - -C $HOME/okp4d
mv $HOME/okp4d/priv_validator_state.json.backup $HOME/okp4d/data/priv_validator_state.json
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
