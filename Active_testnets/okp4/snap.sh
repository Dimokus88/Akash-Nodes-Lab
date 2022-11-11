#!/bin/bash
source ~/.bashrc
sv stop $BINARY
sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1false|" /root/$BINARY/config/config.toml
apt install lz4 -y
cp $HOME/okp4d/data/priv_validator_state.json $HOME/okp4d/priv_validator_state.json.backup
okp4d tendermint unsafe-reset-all --home $HOME/okp4d --keep-addr-book

rm -rf $HOME/okp4d/data 
rm -rf $HOME/okp4d/wasm

SNAP_NAME=$(curl -s https://snapshots2-testnet.nodejumper.io/okp4-testnet/ | egrep -o ">okp4-nemeton.*\.tar.lz4" | tr -d ">")
echo ===============================================
echo == Ожидайте скачивания снепшота до 2х часов. ==
echo ===============================================
echo = Expect the snapshot download up to 2 hours. =
echo ===============================================
curl https://snapshots2-testnet.nodejumper.io/okp4-testnet/${SNAP_NAME} | lz4 -dc - | tar -xf - -C $HOME/okp4d
mv $HOME/okp4d/priv_validator_state.json.backup $HOME/okp4d/data/priv_validator_state.json
echo =======================
echo == Снепшот загружен! ==
echo =======================
echo =Snapshot is uploaded!=
echo =======================
sv start $BINARY
