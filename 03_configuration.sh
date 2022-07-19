#!/usr/bin/env bash

set -x #echo on

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
hwclock --systohc

echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
echo it_IT.UTF-8 UTF-8 >> /etc/locale.gen

locale-gen

echo LANG=en_US.UTF-8 >> /etc/locale.conf

echo KEYMAP=it >> /etc/vconsole.conf

echo ${INST_HOSTNAME} >> /etc/hostname

cat >> /etc/hosts << EOF
127.0.0.1	localhost
::1		localhost
127.0.1.1	myhostname.localdomain	${INST_HOSTNAME}
EOF
