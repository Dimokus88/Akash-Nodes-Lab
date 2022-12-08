#!/bin/bash
apt update && apt upgrade -y
apt install sudo nano clang make tmate-y
runsvdir -P /etc/service &
curl "https://sh.rustup.rs" -sSf | sh -s -- -y
source $HOME/.cargo/env
rustup update stable
source $HOME/.cargo/env
git clone https://github.com/near/nearcore && cd nearcore
git fetch origin --tags
git checkout tags/$VERSION_NEARCORE -b mynode
make release
./target/release/neard --home ~/.near init --chain-id $CHAIN --download-genesis --download-config
