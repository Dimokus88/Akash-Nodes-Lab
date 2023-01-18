#!/bin/bash
apt-get install -y  wget tar ssh runit
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && (echo $PASS_SSH; echo $PASS_SSH) | passwd root
service ssh start
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





sleep infinity
