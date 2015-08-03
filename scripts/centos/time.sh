#!/bin/bash -eux

os_ver="$(rpm -q --qf "%{VERSION}" $(rpm -q --whatprovides redhat-release))"

case $os_ver in
  '7')
     yum -q -y install chrony
     echo "OPTIONS=-4" > /etc/sysconfig/chronyd
     sed -i "s/0.centos.pool.ntp.org/ntp.nict.jp/" /etc/chrony.conf
     sed -i "s/1.centos.pool.ntp.org/ntp1.jst.mfeed.ad.jp/" /etc/chrony.conf
     sed -i "s/2.centos.pool.ntp.org/ntp2.jst.mfeed.ad.jp/" /etc/chrony.conf
     sed -i "s/3.centos.pool.ntp.org/ntp3.jst.mfeed.ad.jp/" /etc/chrony.conf
     systemctl start chronyd
     ;;

  '6')
     yum -q -y install ntp
     sed -i "s/server 0.centos.pool.ntp.org iburst/server -4 ntp.nict.jp iburst/g" /etc/ntp.conf
     sed -i "s/server 1.centos.pool.ntp.org iburst/server -4 ntp1.jst.mfeed.ad.jp iburst/g" /etc/ntp.conf
     sed -i "s/server 2.centos.pool.ntp.org iburst/server -4 ntp2.jst.mfeed.ad.jp iburst/g" /etc/ntp.conf
     sed -i "s/server 3.centos.pool.ntp.org iburst/server -4 ntp3.jst.mfeed.ad.jp iburst/g" /etc/ntp.conf
     service ntpd start
     ;;
esac
