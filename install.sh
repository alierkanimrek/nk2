#!/bin/bash
echo "There are users into system"
users
echo "Installation for user '$1'"
read -p "is it ok?" x
echo "Did you change username in service script"
cat nk2/nk2.service
read -p "Ready for apt installations..." x
apt-get update
apt install git apt-transport-https gpg
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg  --dearmor -o /usr/share/keyrings/dart.gpg
echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' \
  | tee /etc/apt/sources.list.d/dart_stable.list
apt-get update && apt-get install dart
read -p "Ready for download..." x
rm -rf nk2
git clone https://github.com/alierkanimrek/nk2.git
read -p "Ready for install to /opt/nk2" x
mkdir /opt/nk2
cp nk2/* /opt/nk2 -r
chown $1:$1 /opt/nk2 -R
read -p "Ready for get dart packages..." x
su - $1 -c "cd /opt/nk2; dart pub get"
read -p "Ready for configuration..." x
mkdir /etc/nk2
cp nk2/bin/config.json.template /etc/nk2/config.json
nano /etc/nk2/config.json
read -p "Ready for service installation..." x
cp -v nk2/nk2.service /lib/systemd/system/nk2.service
systemctl daemon-reload
systemctl enable nk2
systemctl start nk2
sleep 3
systemctl status nk2
echo "wget -c https://raw.githubusercontent.com/alierkanimrek/nk2/main/update.sh">downupdate.sh
echo "bash update.sh">>downupdate.sh
chmod +x downupdate.sh
ls -l
read -p "just run downupdate.sh for updating" x



