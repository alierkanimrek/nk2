#!/bin/bash
user=$(ls /opt/nk2 -l | grep nk2 | cut -f 3 -d " ")
echo "Updating for user '$user'"
read -p "is it ok?"
read -p "Ready for downloading..."
rm -rf nk2
git clone https://github.com/alierkanimrek/nk2.git
read -p "Ready for stop service and update..."
systemctl stop nk2
cp nk2/* /opt/nk2 -r
chown $user:$user /opt/nk2 -R
systemctl start nk2
sleep 3
systemctl status nk2