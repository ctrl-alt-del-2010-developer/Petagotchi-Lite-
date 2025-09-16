RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
RESET='\e[0m'

# Paket yöneticisi ve kurulum komutu tespiti
detect_pkg_manager() {
    if [ "$(uname)" = "Darwin" ]; then
        PKG_MANAGER="brew"
        INSTALL_CMD="brew install"
        PY2="xterm"
        PY3="python@3"
        PIP="pip3"
    elif [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
                PKG_MANAGER="apt"
                INSTALL_CMD="sudo apt install -y"
                PY2="xterm"
                PY3="python3"
                PIP="pip"
            ;;
            fedora)
                PKG_MANAGER="dnf"
                INSTALL_CMD="sudo dnf install -y"
                PY2="xterm"
                PY3="python3"
                PIP="pip"
            ;;
            arch)
                PKG_MANAGER="pacman"
                INSTALL_CMD="sudo pacman -S --noconfirm"
                PY2="xterm"
                PY3="python"
                PIP="pip"
            ;;
            opensuse*|suse)
                PKG_MANAGER="zypper"
                INSTALL_CMD="sudo zypper install -y"
                PY2="xterm"
                PY3="python3"
                PIP="pip"
            ;;
            *)
                PKG_MANAGER="unknown"
            ;;
        esac
    else
        PKG_MANAGER="unknown"
    fi
}

clear 
clear

detect_pkg_manager

if [ "$PKG_MANAGER" = "unknown" ]; then
    echo -e "${RED}Desteklenmeyen işletim sistemi veya paket yöneticisi!${RESET}"
    exit 1
fi

echo -e "${YELLOW}$PKG_MANAGER ile paketler kuruluyor...${RESET}"

PACKAGES="$PY2 $PY3 $PIP cmatrix aircrack-ng iwd torbrowser-launcher sqlmap wireshark htop"

$INSTALL_CMD $PACKAGES

if [ "$PIP" = "pip3" ] || [ "$PY3" = "python3" ]; then
    pip3 install -r requirements.txt --break-system-packages
else
    pip install -r requirements.txt --break-system-packages
fi

clear
echo -e "${GREEN}Kurulum tamamlandı. Programı başlatmak için 'bash run.sh' komutunu girin.${RESET}"

sleep 5
