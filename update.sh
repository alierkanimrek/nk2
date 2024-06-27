#!/bin/bash
rm -rf /home/admin/nk2
git clone https://github.com/alierkanimrek/nk2.git
systemctl stop nk2
cp nk2/* /opt/nk2 -r
chown admin:admin /opt/nk2 -R
systemctl start nk2
sleep 3
systemctl status nk2