#!/usr/bin/env bash

set -x #echo on

set -eo pipefail

echo -ne "
Enabling services
"
systemctl enable ntpd
systemctl enable NetworkManager
systemctl enable cups
systemctl enable bluetooth
systemctl enable acpid

echo -ne "
Enabling zram
"
cat >> /etc/systemd/zram-generator.conf << EOF
[zram0]
zram-size = min(ram * 0.75)
compression-algorithm = zstd
EOF

swapon --discard --priority 100 /dev/zram0
systemctl enable systemd-zram-setup@zram0.service

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
Installing Desktop Environment
"
pacman -S --noconfirm kde dolphin konsole kate discover sddm

systemctl enable sddm

echo -ne "
Installing AUR helper
"
cd /home/${USER}
su -- ${USER}

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S --noconfirm preload

sudo systemctl enable preload

exit

cd /root

echo -ne "
Installing Apps
"
pacman -S --noconfirm timeshift ufw tailscale

systemctl enable ufw
systemctl enable tailscaled

echo -ne "
Installing Flatpak
"
pacman -S --noconfirm xdg-desktop-portal xdg-desktop-portal-kde flatpak flatpak-kcm

cd /home/${USER}
su -- ${USER}

yay -S --noconfirm flatseal

exit 

cd /root

flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo   
flatpak install flathub org.mozilla.firefox
flatpak install flathub io.github.ungoogled_software.ungoogled_chromium
flatpak install flathub org.torproject.torbrowser-launcher
flatpak install flathub org.libreoffice.LibreOffice
flatpak install flathub dev.vencord.Vesktop
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.valvesoftware.SteamLink
flatpak install flathub io.github.hmlendea.geforcenow-electron
flatpak install flathub io.github.unknownskl.greenlight
flatpak install flathub com.heroicgameslauncher.hgl
flatpak install flathub com.github.Matoking.protontricks
flatpak install flathub io.freetubeapp.FreeTube
flatpak install flathub io.github.mhogomchungu.media-downloader
flatpak install flathub org.mozilla.Thunderbird
flatpak install flathub com.ulduzsoft.Birdtray
flatpak install flathub com.bitwarden.desktop
flatpak install flathub it.mijorus.gearlever
flatpak install flathub com.vscodium.codium
flatpak install flathub io.github.shiftey.Desktop
flatpak install flathub com.github.wwmm.easyeffects
flatpak install flathub com.github.iwalton3.jellyfin-media-player
flatpak install flathub io.mpv.Mpv
flatpak install flathub io.github.jeffshee.Hidamari
flatpak install flathub com.nextcloud.desktopclient.nextcloud
flatpak install flathub org.zotero.Zotero
flatpak install flathub com.tutanota.Tutanota
flatpak install flathub chat.simplex.simplex
flatpak install flathub org.texstudio.TeXstudio