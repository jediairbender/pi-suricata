#!/bin/bash

sudo apt-get install python3-pip libnss3-dev liblz4-dev libnspr4-dev libcap-ng-dev git -y

sudo apt install libpcre3 libpcre3-dbg libpcre3-dev build-essential libpcap-dev libyaml-0-2 libyaml-dev pkg-config zlib1g zlib1g-dev make libmagic-dev libjansson-dev rustc cargo python-yaml python3-yaml liblua5.1-dev -y

#Download Suricata source
wget https://www.openinfosecfoundation.org/download/suricata-6.0.4.tar.gz

#Compile Suricata source
cd suricata-6.0.4/
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --enable-nfqueue --
enable-lua
make
sudo make install
cd suricata-update/
sudo python3 setup.py build
sudo python3 setup.py install
cd ..
sudo make install-full
cd ..


wget https://github.com/jediairbender/pi-suricata/blob/c9bafbe3dfb5bc4714a521d94c7840f78768171b/suricata.service

mv suricata.service /etc/systemd/system/

##Enable the service
sudo systemctl enable suricata.service

##Update Suricata
sudo suricata-update
sudo suricata-update update-sources 
sudo suricata-update check-versions
