#!/bin/bash
# Part 2/2
# Author Jonathan Sanfilippo - 18 Jul 2023
# Another installation method programmed through a custom script 
# prepared for File System Bios 
# architalialinux@gmail.com


# settings script 2

localhost="pcarch" # nome machina - hostname
user="jose"    # nome utente [solo minuscolo] -- username [only lowercase]
realname="jose" # nome reale [minuscolo/maiuscolo] - real name [uppercase/lowercase]
rootpw="123" # password per root -- root password
userpw="123" # password per utente -- user password
localegen="es_AR.UTF-8 UTF-8" # locale encoding
localeconf="LANG=es_AR.UTF-8"  # lingua locale -- local language
km="es" # lingua della tastiera -- keyboard layout
localtime="America/Argentina/Buenos_Aires" # localtime
groups="wheel" # aggiungi gruppi all'utente - add groups for user
Ntools="wpa_supplicant wireless_tools netctl net-tools iw networkmanager" # set network tools
Audio="alsa-utils pipewire-pulse" # Audio packages
Utils="mtools dosfstools exfatprogs fuse" # tools 
PKGS="firewalld gum jq tmux acpi cronie git reflector bluez bluez-utils" #general packages
DE="xorg gnome-shell nautilus gnome-console gvfs gnome-control-center xdg-user-dirs-gtk  gnome-text-editor gnome-keyring gnome-system-monitor" #GNOME [Minimal installation]
DM="gdm" # Display Manager
Service="gdm NetworkManager firewalld bluetooth cronie reflector" # Service



# end setting ----------------------------------------------





ln -sf /usr/share/zoneinfo/$localtime /etc/localtime 
hwclock --systohc
echo "$localegen" > /etc/locale.gen
locale-gen
echo "$localeconf" >> /etc/locale.conf
echo "KEYMAP=$km" >> /etc/vconsole.conf  
echo "$localhost" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts 
echo "::1       localhost" >> /etc/hosts
echo root:$rootpw | chpasswd
useradd -m $user
echo $user:$userpw | chpasswd
usermod -aG $groups $user
usermod -c "$realname" $user
echo "$user ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/$user



#Grub Bios version

pacman -S grub --noconfirm
grub-install --target=i386-pc /dev/sda 
grub-mkconfig -o /boot/grub/grub.cfg




pacman -S $Ntools $Utils $Audio $PKGS $DE $DM --noconfirm

git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si --noconfirm cd ..
paru -S gnome-tweaks --skipreview --noconfirm --removemake
paru -S extension-manager --skipreview --noconfirm --removemake
paru -S papirus-icon-theme --skipreview --noconfirm --removemake

git clone https://github.com/ArchItalia/core-gtk-theme.git && cd core-gtk-theme && makepkg -si --noconfirm && cd ..
git clone https://github.com/ArchItalia/core-gnome-backgrounds.git && cd core-gnome-backgrounds && makepkg -si --noconfirm && cd ..
git clone https://github.com/ArchItalia/architalia-fonts.git && cd architalia-fonts && makepkg -si --noconfirm && cd

systemctl enable $Service

rm -rf paru
rm -r /home/2-parte.sh #clear








