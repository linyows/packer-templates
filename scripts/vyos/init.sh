#!/bin/bash -ex

# remove vyos user in /etc/passwd (ghost is there)

# remove extra ttys
sudo sed -i -e 's,^.*:/sbin/getty\s\+.*\s\+tty[2-6],#\0,' /etc/inittab

# Tweak sshd to prevent DNS resolution (speed up logins)
sudo sed -i 's/UseDNS yes/UseDNS no/' /etc/ssh/sshd_config

# Install NFS client
sudo apt-get -y install nfs-common

# Remove 5s grub timeout to speed up booting
cat <<EOF | sudo tee /etc/default/grub
GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
EOF

sudo update-grub
