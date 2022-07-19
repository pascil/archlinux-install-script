#!/usr/bin/env bash

set -x #echo on

echo -ne "
Check variables
"

if [[ -z ${EFI_PARTITION+y} ]]; then
    echo "EFI_PARTITION is not defined"
    exit 1
else
    echo "EFI_PARTITION  ${EFI_PARTITION}"
fi

if [[ -z ${SWAP_PARTITION+y} ]]; then
    echo "SWAP_PARTITION is not defined"
    exit 1
else
    echo "SWAP_PARTITION ${SWAP_PARTITION}"
fi

if [[ -z ${ROOT_PARTITION+y} ]]; then
    echo "ROOT_PARTITION is not defined"
    exit 1
else
    echo "ROOT_PARTITION ${ROOT_PARTITION}"
fi

if [[ -z ${DATA_PARTITION+y} ]]; then
    echo "DATA_PARTITION is not defined"
    exit 1
else
    echo "DATA_PARTITION ${DATA_PARTITION}"
fi

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
