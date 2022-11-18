#!/bin/bash
apt-get install software-properties-common -y
add-apt-repository -y ppa:ethereum/ethereum
apt-get update
apt-get install ethereum -y
apt-get upgrade geth -y
runsvdir -P /etc/service

