#!/bin/bash -eux

apt-get -y install chrony
sed -i "s/0.centos.pool.ntp.org/ntp.nict.jp/" /etc/chrony/chrony.conf
sed -i "s/1.centos.pool.ntp.org/ntp1.jst.mfeed.ad.jp/" /etc/chrony/chrony.conf
sed -i "s/2.centos.pool.ntp.org/ntp2.jst.mfeed.ad.jp/" /etc/chrony/chrony.conf
sed -i "s/3.centos.pool.ntp.org/ntp3.jst.mfeed.ad.jp/" /etc/chrony/chrony.conf
service chrony start
