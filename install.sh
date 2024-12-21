#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

export EFI_PARTITION=/dev/sdb1
export BOOT_PARTITION=/dev/sdb2
export ROOT_PARTITION=/dev/sdb3
export HOME_PARTITION=/dev/sda1
export INST_HOSTNAME=archlinux
export USER=pl
export LOCALE=de_DE.UTF-8
export KEYMAP=de-latin1-nodeadkeys
export CPU=intel
export TIMEZONE=Europe/Berlin

echo -ne "
Starting...
"
( ./01_check.sh )|& tee 01_check.log
( ./02_create-partitions.sh )|& tee 02_create-partitions.log
( ./03_mount-partitions.sh )|& tee 03_mount-partitions.log
( ./04_pacstrap.sh )|& tee 04_pacstrap.log
( ./05_prepare-for-arch-chroot.sh )|& tee 05_prepare-for-arch-chroot.log
( arch-chroot /mnt /root/06_configuration.sh )|& tee 06_configuration.log
( arch-chroot /mnt /root/07_bootloader.sh )|& tee 07_bootloader.log
( arch-chroot /mnt /root/08_user.sh )|& tee 08_user.log
( arch-chroot /mnt /root/09_post_install.sh )|& tee 09_post_install.log
mkdir -p /mnt/home/${USER}/install-logs
cp -v *.log /mnt/home/${USER}/install-logs/
chown -R 1000:1000 /mnt/home/${USER}/install-logs/

echo -ne "
...Finished!
"
