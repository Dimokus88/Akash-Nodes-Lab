#!/bin/bash
cd /root/
wget $BINARY
archive=`ls` && tar -xf $archive
echo $BINARY $archive
rm $archive
sleep 2
cp `ls`/avalanchego /usr/bin/avax && cp -r `ls`/plugins /usr/bin/

mkdir -p ./.avalanchego/configs/chains/C/
sleep 2
cat > ./.avalanchego/configs/chains/C/config.json <<EOF
{
  "state-sync-enabled": true
}
EOF
sleep 2
avax --network-id $NETWORK
