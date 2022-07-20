#!/usr/bin/env bash

set -x #echo on

echo -ne "
Enabling swap on ${SWAP_PARTITION}
"

swapon ${SWAP_PARTITION}

echo -ne "
BTRFS subvolumes on ${ROOT_PARTITION}
"

mount ${ROOT_PARTITION} /mnt

btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@cache
btrfs su cr /mnt/@log
umount /mnt

echo -ne "
Mounting all partitions
"

mount -o subvol=/@,defaults,noatime,compress=zstd ${ROOT_PARTITION} /mnt
mount -o subvol=/@home,defaults,noatime,compress=zstd -m ${ROOT_PARTITION} /mnt/home
mount -o subvol=/@cache,defaults,noatime,compress=zstd -m ${ROOT_PARTITION} /mnt/var/cache
mount -o subvol=/@log,defaults,noatime,compress=zstd -m ${ROOT_PARTITION} /mnt/var/log

mount -o defaults,noatime -m ${EFI_PARTITION} /mnt/boot/efi

mount -o defaults,noatime -m ${DATA_PARTITION} /mnt/media/bettini/common
