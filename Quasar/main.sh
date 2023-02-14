#!/bin/bash
wget -O /usr/bin/quasarnoded https://github.com/quasar-finance/binary-release/raw/main/v0.0.2-alpha-11/quasarnoded-linux-amd64
quasarnoded init $MONIKER --chain-id $CHAIN
wget -O /root/.quasarnode/genesis.json https://raw.githubusercontent.com/quasar-finance/questnet/main/v04/definitive-genesis.json
sed -i.bak -e "s/^seeds *=.*/seeds = \"$SEED\"/;" /root/.quasarnode/config/config.toml
sed -i.bak -e "s_"tcp://127.0.0.1:26657"_"tcp://0.0.0.0:26657"_;" /root/.quasarnode/config/config.toml
quasarnoded start
