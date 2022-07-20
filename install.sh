#!/usr/bin/env bash

set -x #echo on

echo -ne "
Starting...
"

( ./00_check.sh )|& tee 00_check.log
( ./01_mount-partitions.sh )|& tee 01_mount-partitions.log
( ./02_pacstrap.sh )|& tee 02_pacstrap.log
( ./03_prepare-for-arch-chroot.sh )|& tee 03_prepare-for-arch-chroot.log
( arch-chroot /mnt /root/04_configuration.sh )|& tee 04_configuration.log
( arch-chroot /mnt /root/05_bootloader.sh )|& tee 05_bootloader.log
( arch-chroot /mnt /root/06_user.sh )|& tee 06_user.log
mkdir -p /mnt/home/bettini/install-logs
cp -v *.log /mnt/home/bettini/install-logs/

echo -ne "
...Finished!
"