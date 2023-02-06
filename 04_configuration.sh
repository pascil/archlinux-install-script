#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

# This is meant to be executed with arch-chroot /mnt
# and it has to be copied inside /mnt first
# example, after copying it to /mnt/root 
# arch-chroot /mnt /root/04_configuration.sh

ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
hwclock --systohc

echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
echo it_IT.UTF-8 UTF-8 >> /etc/locale.gen

locale-gen

cat >> /etc/locale.conf << EOF
LANG=en_US.UTF-8
LC_ADDRESS=it_IT.UTF-8
LC_IDENTIFICATION=it_IT.UTF-8
LC_MEASUREMENT=it_IT.UTF-8
LC_MONETARY=it_IT.UTF-8
LC_NAME=it_IT.UTF-8
LC_NUMERIC=it_IT.UTF-8
LC_PAPER=it_IT.UTF-8
LC_TELEPHONE=it_IT.UTF-8
LC_TIME=it_IT.UTF-8
EOF

echo KEYMAP=it >> /etc/vconsole.conf

echo ${INST_HOSTNAME} >> /etc/hostname

cat >> /etc/hosts << EOF
127.0.0.1	localhost
::1		localhost
127.0.1.1	myhostname.localdomain	${INST_HOSTNAME}
EOF
