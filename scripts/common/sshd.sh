#!/bin/bash -eux

# speed up SSH login by avoiding DNS lookup
echo "UseDNS no" >> /etc/ssh/sshd_config
echo "GSSAPIAuthentication no" >> /etc/ssh/sshd_config
