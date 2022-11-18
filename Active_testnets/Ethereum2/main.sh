#!/bin/bash
apt-get install software-properties-common -y
add-apt-repository -y ppa:ethereum/ethereum
apt-get update
apt-get install ethereum -y
apt-get upgrade geth -y
runsvdir -P /etc/service
mkdir $CONCORDIUM_NODE_DATA_DIR
mkdir $CONCORDIUM_NODE_CONFIG_DIR
mkdir -p /root/concordium-node/log
cat > /root/concordium-node/run <<EOF 
#!/bin/bash
exec 2>&1
exec /concordium-node --config-dir $CONCORDIUM_NODE_CONFIG_DIR --data-dir $CONCORDIUM_NODE_DATA_DIR --genesis-data-file $CONCORDIUM_NODE_CONSENSUS_GENESIS_DATA_FILE --bootstrap-node=$CONCORDIUM_NODE_CONNECTION_BOOTSTRAP_NODES
EOF
cat > /root/concordium-node/log/run <<EOF 
#!/bin/bash
mkdir /var/log/concordium-node
exec svlogd -tt /var/log/concordium-node
EOF
chmod +x /root/concordium-node/run
chmod +x /root/concordium-node/log/run
ln -s /root/concordium-node /etc/service
