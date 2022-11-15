#!/bin/bash
echo 'export YOUR_WALLET_ADDRESS='${YOUR_WALLET_ADDRESS} >> /root/.bashrc
cd /
wget -O /anaconda.sh "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
chmod +x ./anaconda.sh
(echo -e \n ; echo yes ; echo -e \n ; echo yes; echo yes) | ./anaconda.sh
rm ./anaconda.sh
PATH=$PATH:/n/bin
source ~/.bashrc
conda create --name exorde-env python=3.9 -y
conda activate exorde-env
pip install --upgrade pip
git clone https://github.com/exorde-labs/ExordeModuleCLI.git
cd ExordeModuleCLI
pip install -r requirements.txt

mkdir -p /root/Exorde/log    
cat > /root/Exorde/run <<EOF 
#!/bin/bash
exec 2>&1
exec python Launcher.py -m $YOUR_WALLET_ADDRESS -l 2
EOF
chmod +x /root/Exorde/run
LOG=/var/log/Exorde
cat > /root/Exorde/log/run <<EOF 
#!/bin/bash
mkdir $LOG
exec svlogd -tt $LOG
EOF
chmod +x /root/Exorde/log/run
ln -s /root/Exorde /etc/service
ln -s /var/log/Exorde/current /LOG
sleep 10
tail -f /LOG
