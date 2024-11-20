#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

# to avoid failures of the shape
# signature from "..." is invalid
# File ... is corrupted (invalid or corrupted package (PGP signature))
pacman -S --noconfirm archlinux-keyring

echo -ne "
Setting mirrors
"

reflector \
	--country Italy,Germany \
	--age 12 \
	--protocol https \
	--fastest 5 \
	--latest 20 \
	--sort rate \
	--save /etc/pacman.d/mirrorlist

echo -ne "
Updating package metadata
"

pacman -Syy

echo -ne "
pacstrap
"

pacstrap /mnt base linux linux-headers linux-lts-headers linux-firmware nano vim intel-ucode btrfs-progs sof-firmware alsa-firmware

echo -ne "
Generating fstab
"

genfstab -U /mnt >>/mnt/etc/fstab

# remove subvolid to avoid problems with restoring snapper snapshots
sed -i 's/subvolid=.*,//' /mnt/etc/fstab

# ensure nodiscard is in fstab (though we used that in mount, it is not preserved)
sed -i 's/noatime,compress/noatime,nodiscard,compress/' /mnt/etc/fstab

echo -ne "
Showing fstab
"

cat /mnt/etc/fstab
