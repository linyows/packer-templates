#!/bin/bash -ex

WRAPPER=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper

$WRAPPER begin
if [ "$vyatta_repo_dev" == 'true' ]; then
  $WRAPPER set system package repository daisy url 'http://packages.vyatta.com/vyatta-dev/daisy/unstable'
  $WRAPPER set system package repository daisy distribution 'daisy'
  $WRAPPER set system package repository daisy components 'main'
fi

if [ $vyatta_repo_4people == 'true' ]; then
  $WRAPPER set system package repository vyatta4people url 'http://packages.vyatta4people.org/debian'
  $WRAPPER set system package repository vyatta4people distribution 'experimental'
  $WRAPPER set system package repository vyatta4people components 'main'
fi

if [ $vyatta_repo_debian == 'true' ]; then
  $WRAPPER set system package repository squeeze url 'http://mirrors.kernel.org/debian'
  $WRAPPER set system package repository squeeze distribution 'squeeze'
  $WRAPPER set system package repository squeeze components 'main contrib non-free'
fi

$WRAPPER commit
$WRAPPER save
$WRAPPER end

sudo aptitude -y update
