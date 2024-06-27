#!/bin/bash
apt-get update
apt install git apt-transport-https gpg
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg  --dearmor -o /usr/share/keyrings/dart.gpg
echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' \
  | tee /etc/apt/sources.list.d/dart_stable.list
apt-get update && apt-get install dart
rm -rf nk2
git clone https://github.com/alierkanimrek/nk2.git
mkdir /opt/nk2
cp nk2/* /opt/nk2 -r
chown admin:admin /opt/nk2 -R
mkdir /etc/nk2
cp nk2/bin/config.json.template /etc/nk2/config.json
cp -v nk2/nk2.service /lib/systemd/system/nk2.service
systemctl daemon-reload
su - admin -c "cd /opt/nk2; dart pub get"
nano /etc/nk2/config.json
systemctl enable nk2
systemctl start nk2
sleep 3
systemctl status nk2



