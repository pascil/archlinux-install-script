#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

# to avoid failures of the shape
# signature from "..." is invalid
# File ... is corrupted (invalid or corrupted package (PGP signature))
pacman -S --noconfirm archlinux-keyring reflector

echo -ne "
Setting mirrors
"

reflector \
	--country Germany \
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

pacstrap /mnt base base-devel linux-zen linux-zen-headers linux-firmware nano neovim ${CPU}-ucode btrfs-progs ntp wpa_supplicant \
	dialog networkmanager network-manager-applet crony avahi cups zram-generator reflector bluez blueman bluez-utils p7zip unrar \
	tar htop hyfetch git exfat-utils dosfstools efibootmgr acpi acpid pipewire pipewire-pulse pipewire-alsa mlocate

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
