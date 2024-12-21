#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

# This is meant to be executed with arch-chroot /mnt
# and it has to be copied inside /mnt first
# example, after copying it to /mnt/root 
# arch-chroot /mnt /root/04_configuration.sh

ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
hwclock --systohc

echo en_US.UTF-8 UTF-8 >> /etc/locale.gen # mandatory
echo ${LOCALE} UTF-8 >> /etc/locale.gen

locale-gen

cat >> /etc/locale.conf << EOF
LANG=${LOCALE}
LC_ADDRESS=${LOCALE}
LC_IDENTIFICATION=${LOCALE}
LC_MEASUREMENT=${LOCALE}
LC_MONETARY=${LOCALE}
LC_NAME=${LOCALE}
LC_NUMERIC=${LOCALE}
LC_PAPER=${LOCALE}
LC_TELEPHONE=${LOCALE}
LC_TIME=${LOCALE}
EOF

echo KEYMAP=${KEYMAP} >> /etc/vconsole.conf

echo ${INST_HOSTNAME} >> /etc/hostname

cat >> /etc/hosts << EOF
127.0.0.1	localhost
::1		localhost
127.0.1.1	${INST_HOSTNAME}.localdomain	${INST_HOSTNAME}
EOF
