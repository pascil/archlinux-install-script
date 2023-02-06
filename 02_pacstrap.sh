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

pacstrap /mnt base linux-lts linux-firmware nano vim intel-ucode btrfs-progs sof-firmware alsa-firmware

echo -ne "
Generating fstab
"

genfstab -U /mnt >> /mnt/etc/fstab

echo -ne "
Showing fstab
"

cat /mnt/etc/fstab
