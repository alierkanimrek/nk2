#!/bin/bash
user=$(ls /opt/nk2 -l | grep nk2 | cut -f 3 -d " ")
echo "Updating for user '$user'"
read -p "is it ok?" x
read -p "Ready for downloading..." x
rm -rf nk2
git clone https://github.com/alierkanimrek/nk2.git
read -p "Ready for stop service and update..." x
systemctl stop nk2
cp nk2/* /opt/nk2 -r
chown $user:$user /opt/nk2 -R
systemctl start nk2
sleep 3
systemctl status nk2