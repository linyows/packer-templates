#!/bin/bash -eux

# disable IPv6
echo "NETWORKING_IPV6=no" >> /etc/sysconfig/network
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6

# disable zeroconf
echo "NOZEROCONF=yes" >> /etc/sysconfig/network
