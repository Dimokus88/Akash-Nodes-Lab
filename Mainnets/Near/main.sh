#!/bin/bash
apt install sudo nano clang make tmate wget tar ssh runit -y
apt install -y git binutils-dev libcurl4-openssl-dev zlib1g-dev libdw-dev libiberty-dev cmake gcc g++ python protobuf-compiler libssl-dev pkg-config llvm awscli
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
(echo $PASS; echo $PASS) | passwd root
service ssh start
runsvdir -P /etc/service &
curl "https://sh.rustup.rs" -sSf | sh -s -- -y
source $HOME/.cargo/env
rustup update stable
source $HOME/.cargo/env
echo == Клонирую и устанавливаю nearcore ===
sleep 10
git clone https://github.com/near/nearcore && cd nearcore
git fetch origin --tags
git checkout $VERSION_NEARCORE -b mynode
make neard
echo == сборка завершена ==
sleep 10
if [[ $CHAIN == localnet ]]
then
echo == Выбран localnet ==
sleep 10
cargo build --package neard --features nightly_protocol,nightly_protocol_features --release
./target/release/neard --home ~/.near init --chain-id localnet
./target/release/neard --home ~/.near run
sleep infinity
fi
./target/release/neard --home ~/.near init --chain-id $CHAIN --download-genesis --download-config --boot-nodes $BOOT_NODES
rm ~/.near/config.json
wget -O ~/.near/config.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/$CHAIN/config.json
echo == Синхронизация заголовков ==
sleep 10
aws s3 --no-sign-request cp s3://near-protocol-public/backups/$CHAIN/rpc/latest .
LATEST=$(cat latest)
aws s3 --no-sign-request cp --no-sign-request --recursive s3://near-protocol-public/backups/$CHAIN/rpc/$LATEST ~/.near/data
echo == запуск near ==
sleep 10
./target/release/neard --home ~/.near run
