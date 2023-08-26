#!/bin/env bash

PS3="Quieres instalar PARU como AUR Helper?: "
	select PARUH in "Si" "No"
		do
			if [ $PARUH ]; then
				break
			fi
		done
if [ "${PARUH}" == "Si" ]; then

		echo -e "\t\e[33mInstalando PARU\e[0m"
			sleep 2
				echo "cd && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si --noconfirm && cd" | $CHROOT su "$USR"
			clear
	fi

if [ "${PARUH}" == "Si" ]; then

		#logo "zramswap"
		#	sleep 2
		#		echo "cd && paru -S zramswap stacer --skipreview --noconfirm --removemake" | $CHROOT su "$USR"
		#	clear
		#logo "spotify spotify-adblock mpv popcorn-time"
		#	sleep 2
		#		echo "cd && yay -S spotify spotify-adblock-git mpv-git popcorntime-bin --noconfirm --removemake --cleanafter" | $CHROOT su "$USR"
		#	clear
		#logo "Whatsapp & Telegram"
		#	sleep 2
		#		echo "cd && yay -S whatsapp-nativefier telegram-desktop-bin --noconfirm --removemake --cleanafter" | $CHROOT su "$USR"
		#	clear
		echo -e "\t\e[33mIconos, fuentes & stacer\e[0m"
			sleep 2
				echo "cd && paru -S nerd-fonts-ubuntu-mono --noconfirm --removemake --cleanafter" | $CHROOT su "$USR"
			clear
		fi

#          Reversión de privilegios sin contraseña

	sed -i 's/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /mnt/etc/sudoers

# Confirmación de reinicio
	while true; do
			read -rp " Quieres reiniciar ahora? [s/N]: " sn
		case $sn in
			[Ss]* ) umount -R >/dev/null 2>&1;reboot;;
			[Nn]* ) exit;;
			* ) printf "Error: solo escribe 's' o 'n'\n\n";;
		esac
	done