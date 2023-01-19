#!/bin/bash
apt-get install -y  wget tar ssh runit lz4 nginx
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && (echo $PASS_SSH; echo $PASS_SSH) | passwd root
service ssh start
service nginx start
runsvdir -P /etc/service &
wget $LINK_BINARY
tar xvf `basename $LINK_BINARY`
rm `basename $LINK_BINARY`
install -m 0755 -o root -g root -t /usr/local/bin `ls | grep bitcoin`/bin/*
mkdir /root/.bitcoin

if [[ -n $SNAPSHOT ]]
then
curl $SNAPSHOT | lz4 -dc - | tar -xf - -C /root/.bitcoin
fi
mkdir -p /root/bitcoin/log

cat > /root/bitcoin/run <<EOF 
#!/bin/bash
exec 2>&1
exec bitcoind -port=8333 -prune=$PRUNE
EOF
cat > /root/bitcoin/log/run <<EOF 
#!/bin/bash
mkdir /var/log/bitcoin
exec svlogd -tt /var/log/bitcoin
EOF
chmod +x /root/bitcoin/run
chmod +x /root/bitcoin/log/run
ln -s /root/bitcoin /etc/service
ln -s /var/log/bitcoin/current /LOG

cat > /root/bitcoin/snapshot.sh <<EOF 
#!/bin/bash
for ((;;))
do
cd /var/www/html/
tar -cvf bitcoin_data.lz4 -I lz4 ./blocks ./chainstate
DATE=date
echo Archive \$DATE create!
sleep 6h
done
EOF
chmod +x /root/bitcoin/snapshot.sh
mkdir -p /root/bitcoin/snapshot/log/
cat > /root/bitcoin/snapshot/run <<EOF 
#!/bin/bash
exec 2>&1
exec /root/bitcoin/snapshot.sh
EOF
cat > /root/bitcoin/snapshot/log/run <<EOF 
#!/bin/bash
mkdir /var/log/snapshot/
exec svlogd -tt /var/log/snapshot/
EOF
chmod +x /root/bitcoin/snapshot/run
chmod +x /root/bitcoin/snapshot/log/run
ln -s /root/bitcoinsnapshot/ /etc/service
ln -s /var/log/snapshot/current /SNAP_LOG


echo ======== Просмотр логов ноды tail -f /LOG ========
echo = Просмотр логов службы бекапа tail -f /SNAP_LOG =
echo ========== View node logs tail -f /LOG ===========
echo === View backup service logs tail -f /SNAP_LOG ===
sleep infinity
