#!/bin/bash
wget $BINARY
archive=`ls` && tar -xf $archive
rm $archive
cp `ls`/avalanchego /usr/bin/avax && cp `ls`/plugins /usr/bin/

mkdir -p ./.avalanchego/configs/chains/P/
cat > ./.avalanchego/configs/chains/P/config.json <<EOF
{
  "state-sync-enabled": true
}
EOF
