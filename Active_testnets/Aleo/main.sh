#!/bin/bash
cd /
runsvdir -P /etc/service &
apt update
git clone https://github.com/AleoHQ/snarkOS.git --depth 1 && cd snarkOS
apt-get install build-essential curl clang gcc libssl-dev llvm make pkg-config tmux xz-utils tmate -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && source $HOME/.cargo/env
cargo install --path .
if [[ -z "$PRIVAT_CODE" ]]
then
echo == Account not found! ==
echo === Generate new account! ==
echo === Save privat key! ===
snarkos account new
echo === NEXT ===
echo ++ 1. Encode the private key with base64. ++
echo ++ 2. Uncomment the line with the 'PRIVAT_CODE' variable by removing the '#' symbol. ++
echo ++ 3. Paste the value to the PRIVAT_CODE variable after the '=' sign. ++
echo For example: 
echo ++++++++++++++++++
echo    env:
echo      - 'PRIVAT_CODE=QVByaXZhdGVLZXkxemtwNzN5jd1dTg4TFlCS2gyTlM2QkJ2eEY2bVc'
echo ++++++++++++++++++
sleep infinity
fi
#=====client======
mkdir -p /root/client/log
cat > /root/client/run <<EOF 
#!/bin/bash
exec 2>&1
exec $(which snarkos) start --nodisplay --client `echo $PRIVAT_CODE | base64 -d`
EOF
cat > /root/client/log/run <<EOF 
#!/bin/bash
mkdir /var/log/client
exec svlogd -tt /var/log/client
EOF
chmod +x /root/client/run
chmod +x /root/client/log/run
ln -s /root/client /etc/service
#=================
echo == Client is running ==
echo == LOG: tail -f /var/log/client/current ==
sleep 5
echo === Instal prover...===
sleep 1m
#=====prover======
mkdir /root/prover && mkdir /root/prover/log
cat > /root/prover/run <<EOF 
#!/bin/bash
exec 2>&1
exec $(which snarkos) start --nodisplay --prover `echo $PRIVAT_CODE | base64 -d`
EOF
cat > /root/prover/log/run <<EOF 
#!/bin/bash
mkdir /var/log/prover
exec svlogd -tt /var/log/prover
EOF
chmod +x /root/prover/run
chmod +x /root/prover/log/run
ln -s /root/prover /etc/service
#=================
echo == Prover is running ==
echo == LOG: tail -f /var/log/prover/current ==
tmate -F
sleep infinity
