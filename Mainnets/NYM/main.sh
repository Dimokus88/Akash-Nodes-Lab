#!/bin/bash
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
(echo $MY_ROOT_PASSWORD; echo $MY_ROOT_PASSWORD) | passwd root
echo 'export MONIKER='${MONIKER} >> /root/.bashrc
service ssh start
apt update -y
apt install pkg-config build-essential libssl-dev curl jq git nginx -y
rm /var/www/html/index.nginx-debian.html
curl "https://sh.rustup.rs" -sSf | sh -s -- -y
source $HOME/.cargo/env
rustup update
git clone https://github.com/nymtech/nym.git
cd nym
git reset --hard
git pull
git checkout release/$VERSION
cargo build --release
sleep 2
cp -r /nym/target/release/. /usr/local/bin/

if [[ -n $KEYS ]]
then
sleep infinity
else
service nginx start
sleep 2
nym-mixnode init --id "$MONIKER" --host $(curl ifconfig.me) --wallet-address $NYM_ADDRESS > /root/init
sleep 2
tar -cvf /var/www/html/nym_backup.tar /root/.nym/mixnodes/"$MONIKER"/
sleep 2
cat > /var/www/html/index.html <<EOF
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
 <head>
  <meta http-equiv="refresh" content="5;./nym_backup.tar">
  <title>NYM on Akash Network</title>
 </head>
 <body>
 </body>
</html>
EOF
sleep 2
echo =================================================================================
echo ============= Go to Uri link \(LEASE tab\) and download nym_backup! =============
echo =================================================================================
echo ==================== Saved mixnet identity and sphinx keypairs ==================
cat /root/init
echo =================================================================================
echo == Encode nym_backup.tar to BASE64, and add to enveriment KEY \(deploy file\). ==
echo For example:
echo     env:
echo      - "KEY=DQpjYXQgPiAvdmFyL3d3dy9odG1sL2luw0L3N0cmljdC5kdGQiP...................Q+DQogIDxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0idGV4dC9odG1s"
echo ==================================================================================
sleep infinity
fi
