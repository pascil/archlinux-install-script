#!/usr/bin/env bash

set -x #echo on

pacman -S --noconfirm archlinux-keyring

echo -ne "
Setting mirrors
"

reflector \
	--country Italy,Germany \
	--age 12 \
	--protocol https \
	--latest 5 \
	--sort rate \
	--save /etc/pacman.d/mirrorlist

echo -ne "
Updating package metadata
"

pacman -Syy

echo -ne "
pacstrap
"

pacstrap /mnt base linux-lts linux-firmware nano vim intel-ucode btrfs-progs

echo -ne "
Generating fstab
"

genfstab -U /mnt >> /mnt/etc/fstab

echo -ne "
Showing fstab
"

cat /mnt/etc/fstab
