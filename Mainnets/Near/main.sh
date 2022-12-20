#!/bin/bash
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
cp ./target/release/neard /usr/bin/
sleep 10
if [[ $CHAIN == localnet ]]
then
echo == Выбран localnet ==
sleep 10
cargo build --package neard --features nightly_protocol,nightly_protocol_features --release
neard init --chain-id localnet
neard run
sleep infinity
fi
neard init --chain-id $CHAIN --download-genesis --download-config --boot-nodes $BOOT_NODES
echo == Синхронизация заголовков ==
sleep 10
aws s3 --no-sign-request cp s3://near-protocol-public/backups/$CHAIN/rpc/latest .
LATEST=$(cat latest)
aws s3 --no-sign-request cp --no-sign-request --recursive s3://near-protocol-public/backups/$CHAIN/rpc/$LATEST ~/.near/data
echo == запуск near ==
sleep 10

mkdir -p /root/nearcore/log
cat > /root/nearcore/run <<EOF 
#!/bin/bash
exec 2>&1
exec neard run
EOF
cat > /root/nearcore/log/run <<EOF 
#!/bin/bash
mkdir /var/log/nearcore
exec svlogd -tt /var/log/nearcore
EOF
chmod +x /root/nearcore/run
chmod +x /root/nearcore/log/run
ln -s /root/nearcore /etc/service
