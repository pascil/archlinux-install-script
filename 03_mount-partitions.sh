#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

echo -ne "
BTRFS subvolumes on ${ROOT_PARTITION}
"

mount ${ROOT_PARTITION} /mnt

btrfs su cr /mnt/@
btrfs su cr /mnt/@root
btrfs su cr /mnt/@srv
btrfs su cr /mnt/@cache
btrfs su cr /mnt/@log
btrfs su cr /mnt/@tmp
umount /mnt

echo -ne "
Mounting all partitions
"
mount -o subvol=/@,defaults,nodiscard,noatime,compress=zstd ${ROOT_PARTITION} /mnt
mount -o defaults,noatime -m ${BOOT_PARTITION} /mnt/boot
mount -o defaults,noatime -m ${EFI_PARTITION} /mnt/boot/efi
mount -o defaults,nodiscard,noatime,compress=zstd -m ${HOME_PARTITION} /mnt/home
mount -o subvol=/@root,defaults,nodiscard,noatime,compress=zstd -m ${ROOT_PARTITION} /mnt/root
mount -o subvol=/@srv,defaults,nodiscard,noatime,compress=zstd -m ${ROOT_PARTITION} /mnt/srv
mount -o subvol=/@cache,defaults,nodiscard,noatime,compress=zstd -m ${ROOT_PARTITION} /mnt/var/cache
mount -o subvol=/@log,defaults,nodiscard,noatime,compress=zstd -m ${ROOT_PARTITION} /mnt/var/log
mount -o subvol=/@tmp,defaults,nodiscard,noatime,compress=zstd -m ${ROOT_PARTITION} /mnt/var/tmp

echo -ne "
Enabling swapfile
"
btrfs filesystem mkswapfile --size 4g --uuid clear /mnt/swapfile
swapon --discard --priority 1 /mnt/swapfile