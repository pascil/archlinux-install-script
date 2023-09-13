#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

# This is meant to be executed with arch-chroot /mnt
# and it has to be copied inside /mnt first
# example, after copying it to /mnt/root 
# arch-chroot /mnt /root/05_configuration.sh

grub_resume_boot_option() {
	grub_swap_part=$(find /dev/disk/ | grep "$(awk '$3=="swap" {print $1; exit}' /etc/fstab | cut -d= -f 2)")
    echo "resume=$grub_swap_part"
}

pacman -S --noconfirm --needed grub efibootmgr base-devel linux-lts-headers networkmanager network-manager-applet

sed -i 's/MODULES=(.*)/MODULES=(crc32c-intel btrfs)/' /etc/mkinitcpio.conf

sed -i 's/HOOKS=(.*)/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck resume)/' /etc/mkinitcpio.conf

mkinitcpio -P

sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 mem_sleep_default=deep"/' /etc/default/grub

sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT/ s~\"$~ $(grub_resume_boot_option)\"~g" /etc/default/grub

# "--removable" seemed to be required with Tianocore (KVM), to reuse the same machine and image
# in different host OSes.
# The option installs the EFI executable to the "fallback" path (e.g. EFI/boot/bootx64.efi)
# to avoid having to register the executable to the UEFI firmware (NVRAM).
# The scropt archinstall uses this option as well
grub-install --target=x86_64-efi --efi-directory=/boot/efi --removable --recheck

grub-install --target=x86_64-efi --bootloader-id=Arch --efi-directory=/boot/efi

grub-mkconfig -o /boot/grub/grub.cfg
