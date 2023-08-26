#!/bin/env bash

#          Refreshing Mirrors

echo -e "\t\e[33mRefrescando mirros en la nueva Instalacion\e[0m"

	$CHROOT reflector --verbose --latest 5 --country 'United States' --age 6 --sort rate --save /etc/pacman.d/mirrorlist >/dev/null 2>&1
	$CHROOT pacman -Syy
	confir
    sleep 4
clear
echo ""

#		Instalando gnome y servicios
echo -e "\t\e[33mInstalando gnome y gdm\e[0m"
# 		Instala GNOME, GDM y NetworkManager
		$CHROOT pacman -S gnome gdm pipewire pipewire-pulse firefox neovim gimp gparted dosfstools usbutils net-tools lha lrzip lzip p7zip lbzip2 arj lzop cpio unrar unzip zip unarj xdg-utils --noconfirm

        $CHROOT systemctl enable gdm.service

sleep 3
clear
