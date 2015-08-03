#!/bin/sh

# Set $PUPPET_VERSION inside Packer's template. Valid options are:
#   'provisionerless' -- build a image without Puppet
#   'x.y.z'           -- build a image with version x.y.z of Puppet
#   'latest'          -- build a image with the latest version of Puppet

os_ver="$(rpm -q --qf "%{VERSION}" $(rpm -q --whatprovides redhat-release))"

if [ x$PUPPET_VERSION != x'provisionerless' ]; then
  rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-${os_ver}.noarch.rpm
  if [ x$PUPPET_VERSION == x'latest' ]; then
    yum -y install puppet
  else
    yum -y install puppet-$PUPPET_VERSION
  fi
  rm -f /etc/yum.repos.d/puppetlabs.repo
  rpm -e puppetlabs-release
else
  echo "Building a image without Puppet"
fi
