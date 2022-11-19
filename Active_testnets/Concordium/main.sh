#!/bin/bash
TZ=Europe/Kiev
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
apt-get update
apt-get upgrade -y
apt install ssh runit tmate -y
runsvdir -P /etc/service &
sleep 2
#------------Служба concordium-node----------
mkdir $CONCORDIUM_NODE_DATA_DIR
mkdir $CONCORDIUM_NODE_CONFIG_DIR
mkdir -p /root/concordium-node/log
cat > /root/concordium-node/run <<EOF 
#!/bin/bash
exec 2>&1
exec /concordium-node --config-dir $CONCORDIUM_NODE_CONFIG_DIR --data-dir $CONCORDIUM_NODE_DATA_DIR --genesis-data-file $CONCORDIUM_NODE_CONSENSUS_GENESIS_DATA_FILE --bootstrap-node=$CONCORDIUM_NODE_CONNECTION_BOOTSTRAP_NODES
EOF
mkdir /var/log/concordium-node
cat > /root/concordium-node/log/run <<EOF 
#!/bin/bash
exec svlogd -tt /var/log/concordium-node
EOF
chmod +x /root/concordium-node/run
chmod +x /root/concordium-node/log/run
ln -s /root/concordium-node /etc/service
sleep 1
№-------------------------------------------
#=============Служба node-collector===============
mkdir -p /root/node-collector/log
cat > /root/node-collector/run <<EOF 
#!/bin/bash
exec 2>&1
exec /node-collector
EOF
mkdir /var/log/node-collector
cat > /root/node-collector/log/run <<EOF 
#!/bin/bash
exec svlogd -tt /var/log/node-collector
EOF
chmod +x /root/node-collector/run
chmod +x /root/node-collector/log/run
ln -s /root/node-collector /etc/service
sleep 2
#=================================================
ln -s /var/log/node-collector/current /log_collector
ln -s /var/log/concordium-node/current /log_node

# пускаем в лог Cloudmos трансляцию логов concordium-node
tail -f log_node
