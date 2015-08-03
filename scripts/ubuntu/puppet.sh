#!/bin/bash -eux

# Set $PUPPET_VERSION inside Packer's template. Valid options are:
#   'provisionerless' -- build a image without Puppet
#   'x.y.z'           -- build a image with version x.y.z of Puppet
#   'latest'          -- build a image with the latest version of Puppet

if [ x$PUPPET_VERSION != x'provisionerless' ]; then
  codename="$(lsb_release -c | cut -f2)"
  wget https://apt.puppetlabs.com/puppetlabs-release-${codename}.deb
  dpkg -i puppetlabs-release-${codename}.deb
  rm -f puppetlabs-release-${codename}.deb
  sed -i 's/^# deb/deb/g' /etc/apt/sources.list.d/puppetlabs.list
  apt-get update
  regular_ver="$(apt-cache show puppet | grep Version | grep $PUPPET_VERSION | awk '{print $2}')"

  if [ x$PUPPET_VERSION == x'latest' ]; then
    apt-get -y install puppet
  else
    # see https://tickets.puppetlabs.com/browse/CPR-92
    apt-get -y install puppet-common=$regular_ver
    apt-get -y install puppet=$regular_ver
  fi
  dpkg --list | awk '{ print $2 }' | grep puppetlabs-release | xargs apt-get -y purge
else
  echo "Building a image without Puppet"
fi
