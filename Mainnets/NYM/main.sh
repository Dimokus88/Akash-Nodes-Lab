#!/bin/bash
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
(echo $MY_ROOT_PASSWORD; echo $MY_ROOT_PASSWORD) | passwd root
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
PATH=$PATH:/nym/target/release
echo 'export PATH='$PATH:/nym/target/release >> /root/.bashrc
source /root/.bashrc


if [[ -z $KEYS ]]
then
service nginx start
nym-mixnode init --id "$MONIKER" --host $(curl ifconfig.me) --wallet-address $NYM_ADDRESS > /root/init
tar -cvf /var/www/html/nym_backup.tar /root/.nym/mixnodes/'$MONIKER'
cat > /var/www/html/index.html <<EOF
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>NYM on Akash Network</title>
 </head>
 <body>
`cat /root/init`
<a href="./nym_backup.tar">nym_backup</a>
 </body>
</html>
EOF
echo ==================================================================================
echo ========= Go to Uri link (in LEASE tab) and save all key and nym_backup! =========
echo ==================================================================================
echo == Encode nym_backup.tar to BASE64, and add to enveriment KEY (in deploy file). ==
echo For example:
echo     env:
echo      - "KEY=DQpjYXQgPiAvdmFyL3d3dy9odG1sL2luw0L3N0cmljdC5kdGQiP...................Q+DQogIDxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0idGV4dC9odG1s"
echo ==================================================================================
sleep infinity
else
sleep infinity
fi
