#          Timezone, Lang & Keyboard
echo -e "\t\e[33m-------------------------------\e[0m"
echo -e "\t\e[33mConfigurando Timezone y Locales\e[0m"
echo -e "\t\e[33m-------------------------------\e[0m"
sleep 3

# Buscar todas las zonas horarias disponibles
TIMEZONES=$(find /usr/share/zoneinfo/ -type f | cut -d/ -f5- | sort)

# Convertir las zonas horarias en un array
TIMEZONES=($TIMEZONES)

# Función para generar un menú whiptail
function whiptail_menu() {
    local title=$1
    local prompt=$2
    local options=("${!3}")
    local default_option=$4

    # Generar la lista de opciones para whiptail
    local whiptail_options=()
    for i in "${!options[@]}"; do
        whiptail_options+=("$i" "${options[$i]}")
    done

    # Mostrar el menú whiptail
    local selection=$(whiptail --title "$title" --menu "$prompt" 16 60 8 "${whiptail_options[@]}" 3>&1 1>&2 2>&3)

    # Devolver la opción seleccionada
    echo "${options[$selection]}"
}

# Buscar todos los idiomas disponibles y descomentar las líneas que contengan #
LANGUAGES=$(sed -n 's/^# \([^ ]*\)/\1/p' /etc/locale.gen | sort)

# Convertir los idiomas en un array
LANGUAGES=($LANGUAGES)

# Función para generar un menú whiptail
function whiptail_menu() {
    local title=$1
    local prompt=$2
    local options=("${!3}")
    local default_option=$4

    # Generar la lista de opciones para whiptail
    local whiptail_options=()
    for i in "${!options[@]}"; do
        whiptail_options+=("$i" "${options[$i]}")
    done

    # Mostrar el menú whiptail
    local selection=$(whiptail --title "$title" --menu "$prompt" 16 60 8 "${whiptail_options[@]}" 3>&1 1>&2 2>&3)

    # Devolver la opción seleccionada
    echo "${options[$selection]}"
}
# Solicitar al usuario que seleccione un idioma
lang=$(whiptail_menu "Idioma" "Selecciona tu idioma:" LANGUAGES[@])
# Descomentar la línea seleccionada en /etc/locale.gen
sed -i "s/^# $lang/$lang/" /etc/locale.gen


# Buscar todas las configuraciones de teclado disponibles
KEYMAPS=$(find /usr/share/kbd/keymaps/**/*.map.gz -type f | cut -d "/" -f 6 | cut -d "." -f 1 | sort)

# Convertir las configuraciones de teclado en un array
KEYMAPS=($KEYMAPS)

# Solicitar al usuario que seleccione una zona horaria
timezone=$(whiptail_menu "Zona horaria" "Selecciona tu zona horaria:" TIMEZONES[@] "America/Argentina/Buenos_Aires")
# Solicitar al usuario que seleccione un idioma
lang=$(whiptail_menu "Idioma" "Selecciona tu idioma:" LANGUAGES[@] "en_US.UTF-8")
keymap=$(whiptail_menu "Configuración de teclado" "Selecciona tu configuración de teclado:" KEYMAPS[@] "us")

$CHROOT ln -sf /usr/share/zoneinfo/${timezone} /etc/localtime
$CHROOT hwclock --systohc
echo
echo "${lang} UTF-8" >>/mnt/etc/locale.gen
$CHROOT locale-gen
echo "LANG=${lang}" >>/mnt/etc/locale.conf
echo "KEYMAP=${keymap}" >>/mnt/etc/vconsole.conf
export LANG=${lang}