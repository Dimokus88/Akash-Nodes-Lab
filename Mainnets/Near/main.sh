#!/bin/bash
apt update && apt upgrade -y
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
git clone https://github.com/near/nearcore && cd nearcore
git fetch origin --tags
git checkout tags/$VERSION_NEARCORE -b mynode
make neard
./target/release/neard --home ~/.near init --chain-id $CHAIN --download-genesis --download-config
