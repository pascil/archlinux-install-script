#!/usr/bin/env bash

set -x #echo on

# This is meant to be executed with arch-chroot /mnt
# and it has to be copied inside /mnt first
# example, after copying it to /mnt/root 
# arch-chroot /mnt /root/05_configuration.sh

grub_resume_boot_option() {
	grub_swap_part=$(find /dev/disk/ | grep "$(awk '$3=="swap" {print $1; exit}' /etc/fstab | cut -d= -f 2)")
    echo "resume=$grub_swap_part"
}


pacman -S --noconfirm --needed grub grub-btrfs efibootmgr base-devel linux-lts-headers networkmanager network-manager-applet

sed -i 's/MODULES=(.*)/MODULES=(crc32c-intel btrfs)/' /mnt/etc/mkinitcpio.conf

sed -i 's/HOOKS=(.*)/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck resume)/' /etc/mkinitcpio.conf

mkinitcpio -P

sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 mem_sleep_default=deep $(grub_resume_boot_option)"/' /etc/default/grub

grub-install --target=x86_64-efi --bootloader-id=Arch --efi-directory=/boot/efi

grub-mkconfig -o /boot/grub/grub.cfg