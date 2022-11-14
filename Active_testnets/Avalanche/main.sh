#!/bin/bash
cd /root/
wget $BINARY
archive=`ls` && tar -xf $archive
echo $BINARY $archive
rm $archive
sleep 2
cp `ls`/avalanchego /usr/bin/avax && cp `ls`/plugins /usr/bin/

mkdir -p ./.avalanchego/configs/chains/P/
sleep 2
cat > ./.avalanchego/configs/chains/P/config.json <<EOF
{
  "state-sync-enabled": true
}
EOF
sleep 2
avax
