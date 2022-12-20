#!/bin/bash
apt install runit -y
runsvdir -P /etc/service &
wget https://bitcoin.org/bin/bitcoin-core-22.0/bitcoin-22.0-x86_64-linux-gnu.tar.gz
tar xvf bitcoin-22.0-x86_64-linux-gnu.tar.gz
install -m 0755 -o root -g root -t /usr/local/bin bitcoin-22.0/bin/*
mkdir -p /root/bitcoin/log
cat > /root/bitcoin/run <<EOF 
#!/bin/bash
exec 2>&1
exec bitcoind -rpcport=8333
EOF
cat > /root/bitcoin/log/run <<EOF 
#!/bin/bash
mkdir /var/log/bitcoin
exec svlogd -tt /var/log/bitcoin
EOF
chmod +x /root/bitcoin/run
chmod +x /root/bitcoin/log/run
ln -s /root/bitcoin /etc/service
sleep 5
tail -f /var/log/bitcoin/current
