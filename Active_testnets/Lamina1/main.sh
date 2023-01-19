#!/bin/bash
TZ=Europe/Kiev
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
apt install -y ssh runit tar wget nano golang
wget $BINARY_LINK
tar -xvzf lamina1.latest.ubuntu-latest.tar.gz
cd lamina1
