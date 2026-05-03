#!/bin/bash

BASE="$HOME/rrs9"

GREEN='\033[1;32m'
RED='\033[1;31m'
CYAN='\033[1;36m'
PURPLE='\033[1;35m'
NC='\033[0m'

ok(){ echo -e "${GREEN}✔ $1${NC}"; }
err(){ echo -e "${RED}✖ $1${NC}"; }
pause(){ read -p "Press Enter..."; }

header(){
clear
echo -e "${PURPLE}"
echo "👑 RRS 9 ROYAL CONTROL PANEL 👑"
echo -e "${NC}"
echo "================================"
}

# ================= BLUEPRINT CHECK =================
bp_check(){
command -v blueprint >/dev/null 2>&1
}

install_bp(){
bp_check || { err "Blueprint not installed"; return; }

name=$1
url=$2

if [ -z "$url" ]; then
err "Missing URL"
return
fi

file="/tmp/$name.blueprint"

wget -q "$url" -O "$file"

if [ -f "$file" ]; then
blueprint -install "$file" >/dev/null 2>&1
ok "$name installed"
rm -f "$file"
else
err "$name failed"
fi
}

# ================= BLUEPRINT MENU =================
blueprint_menu(){
while true; do
header
echo "🧩 BLUEPRINT MENU"
echo "1) blueannoucements"
echo "2) eggchanger"
echo "3) huxregister"
echo "4) mclogs"
echo "5) nightadmin"
echo "6) serverbackgrounds"
echo "7) serverimporter"
echo "8) snowflakes"
echo "9) startupchanger"
echo "10) subdomains"
echo "11) versionchanger"
echo "0) Back"

read -p "Select: " b

case $b in
1) install_bp "blueannoucements" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/blueannoucements.blueprint" ;;
2) install_bp "eggchanger" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/eggchanger.blueprint" ;;
3) install_bp "huxregister" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/huxregister.blueprint" ;;
4) install_bp "mclogs" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/mclogs.blueprint" ;;
5) install_bp "nightadmin" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/nightadmin.blueprint" ;;
6) install_bp "serverbackgrounds" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/serverbackgrounds.blueprint" ;;
7) install_bp "serverimporter" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/serverimporter.blueprint" ;;
8) install_bp "snowflakes" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/snowflakes.blueprint" ;;
9) install_bp "startupchanger" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/startupchanger.blueprint" ;;
10) install_bp "subdomains" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/subdomains.blueprint" ;;
11) install_bp "versionchanger" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/versionchanger.blueprint" ;;
0) break ;;
*) err "Invalid" ;;
esac

pause
done
}

# ================= MC TOOLS =================
mc_menu(){
while true; do
header
echo "🎮 MC TOOLS"
echo "1) eggchanger"
echo "2) huxregister"
echo "3) mclogs"
echo "4) nightadmin"
echo "5) serverbackgrounds"
echo "6) serverimporter"
echo "7) snowflakes"
echo "8) startupchanger"
echo "9) subdomains"
echo "10) versionchanger"
echo "11) Install ALL"
echo "0) Back"

read -p "Select: " m

case $m in
1) install_bp "eggchanger" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/eggchanger.blueprint" ;;
2) install_bp "huxregister" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/huxregister.blueprint" ;;
3) install_bp "mclogs" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/mclogs.blueprint" ;;
4) install_bp "nightadmin" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/nightadmin.blueprint" ;;
5) install_bp "serverbackgrounds" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/serverbackgrounds.blueprint" ;;
6) install_bp "serverimporter" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/serverimporter.blueprint" ;;
7) install_bp "snowflakes" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/snowflakes.blueprint" ;;
8) install_bp "startupchanger" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/startupchanger.blueprint" ;;
9) install_bp "subdomains" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/subdomains.blueprint" ;;
10) install_bp "versionchanger" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/versionchanger.blueprint" ;;
11)
for t in eggchanger huxregister mclogs nightadmin serverbackgrounds serverimporter snowflakes startupchanger subdomains versionchanger; do
install_bp "$t" "https://raw.githubusercontent.com/DreamHost2ws/blueprients/main/$t.blueprint"
done
ok "ALL MC TOOLS INSTALLED"
;;
0) break ;;
*) err "Invalid" ;;
esac

pause
done
}

# ================= PANEL + WINGS =================
panel_menu(){
while true; do
header
echo "🩺 PANEL + WINGS"
echo "1) PufferPanel + Wings"
echo "2) Pterodactyl Panel"
echo "3) Pterodactyl Wings"
echo "0) Back"

read -p "Select: " p

case $p in
1)
bash <(curl -s https://raw.githubusercontent.com/pufferpanel/pufferpanel/master/install.sh)
ok "PufferPanel Installed"
;;
2)
curl -sSL https://pterodactyl-installer.se | bash
ok "Panel Installed"
;;
3)
curl -sSL https://pterodactyl-installer.se | bash -s wings
ok "Wings Installed"
;;
0) break ;;
*) err "Invalid" ;;
esac

pause
done
}

# ================= TAILSCALE =================
tailscale_menu(){
while true; do
header
echo "🔗 TAILSCALE"
echo "1) Install"
echo "2) Connect"
echo "3) Uninstall"
echo "0) Back"

read -p "Select: " t

case $t in
1) curl -fsSL https://tailscale.com/install.sh | sh && ok "Installed" ;;
2) tailscale up && ok "Connected" ;;
3) rm -f /usr/bin/tailscale && ok "Removed" ;;
0) break ;;
*) err "Invalid" ;;
esac

pause
done
}

# ================= THEME =================
theme_menu(){
while true; do
header
echo "🎨 THEME"
echo "1) Dark"
echo "2) Neon"
echo "3) Royal"
echo "0) Back"

read -p "Select: " th

case $th in
1) echo "dark" > "$BASE/theme.txt" && ok "Dark set" ;;
2) echo "neon" > "$BASE/theme.txt" && ok "Neon set" ;;
3) echo "royal" > "$BASE/theme.txt" && ok "Royal set" ;;
0) break ;;
*) err "Invalid" ;;
esac

pause
done
}

# ================= MAIN =================
while true; do
header
echo "1) 🧩 Blueprint"
echo "2) 🎮 MC Tools"
echo "3) 🩺 Panel + Wings"
echo "4) 🔗 Tailscale"
echo "5) 🎨 Theme"
echo "0) Exit"

read -p "Select: " o

case $o in
1) blueprint_menu ;;
2) mc_menu ;;
3) panel_menu ;;
4) tailscale_menu ;;
5) theme_menu ;;
0) exit ;;
*) err "Invalid" ;;
esac

pause
done
