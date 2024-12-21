#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

# This is meant to be executed with arch-chroot /mnt
# and it has to be copied inside /mnt first
# example, after copying it to /mnt/root 
# arch-chroot /mnt /root/08_user.sh

useradd -m ${USER}
usermod -aG wheel,audio,video,sys,rfkill,input ${USER}

sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

echo -ne "
Set Password for root
"
passwd

echo -ne "
Set Password for ${USER}
"
passwd ${USER}
