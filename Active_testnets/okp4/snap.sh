#!/bin/bash
source ~/.bashrc
sv stop okp4d
sleep 2
sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1false|" /root/okp4d/config/config.toml
apt install lz4 -y
sleep 2
cp /root/okp4d/data/priv_validator_state.json /root/okp4d/priv_validator_state.json.backup
cp /root/okp4d/data/priv_validator_key.json /root/okp4d/priv_validator_key.json.backup
sleep 2
okp4d tendermint unsafe-reset-all --home /root/okp4d --keep-addr-book
sleep 2
rm -rf /root/okp4d/data 
rm -rf /root/okp4d/wasm

SNAP_NAME=$(curl -s https://snapshots2-testnet.nodejumper.io/okp4-testnet/ | egrep -o ">okp4-nemeton.*\.tar.lz4" | tr -d ">")
echo ===============================================
echo == Ожидайте скачивания снепшота до 2х часов. ==
echo ===============================================
echo = Expect the snapshot download up to 2 hours. =
echo ===============================================
curl https://snapshots2-testnet.nodejumper.io/okp4-testnet/${SNAP_NAME} | lz4 -dc - | tar -xf - -C /root/okp4d
mv /root/okp4d/priv_validator_state.json.backup /root/okp4d/data/priv_validator_state.json
mv /root/okp4d/priv_validator_key.json.backup /root/okp4d/data/priv_validator_key.json
echo =======================
echo == Снепшот загружен! ==
echo =======================
echo =Snapshot is uploaded!=
echo =======================
sv start okp4d
