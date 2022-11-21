#!/bin/bash
cp /usr/lib/go-1.18/bin/go /usr/bin/
git clone https://github.com/ledgerwatch/erigon.git
cd erigon; git checkout stable
make
PATH=$PATH:/erigon/build/bin
mkdir /root/erigon && mkdir /root/erigon/log
cat > /root/erigon/run <<EOF 
#!/bin/bash
exec 2>&1
exec erigon --chain=goerli --datadir="/home/erigon/datadir/" --authrpc.jwtsecret="/home/erigon/jwtsecret" --ws --private.api.addr="localhost:9090" --snapshots=true --externalcl --http.api=engine,eth,net --prune.r.before=4367322 --prune htc --http.vhosts "*" --http.port 8545 --http.addr 0.0.0.0 --http.corsdomain "*"
EOF
cat > /root/erigon/log/run <<EOF 
#!/bin/bash
mkdir /var/log/erigon
exec svlogd -tt /var/log/erigon
EOF
chmod +x /root/erigon/run
chmod +x /root/erigon/log/run
ln -s /root/erigon /etc/service
sleep 5
tail -f /var/log/erigon/current

sleep infinity
