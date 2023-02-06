#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

# This is meant to be executed with arch-chroot /mnt
# and it has to be copied inside /mnt first
# example, after copying it to /mnt/root 
# arch-chroot /mnt /root/06_user.sh

useradd -m bettini

usermod -aG wheel,sys,rfkill bettini

sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

echo -ne "
IMPORTANT: remember to set the password in the end!
"

chown bettini:bettini /media/bettini/common
