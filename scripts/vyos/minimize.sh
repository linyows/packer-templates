#!/bin/sh -ex

# Zero out the free space to reduce final image size
sudo dd if=/dev/zero of=/EMPTY bs=1M || :
sudo rm -f /EMPTY
