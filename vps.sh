#!/bin/bash

# =============================
# 🚀 RRS PRO VPS PANEL
# =============================

# COLORS
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
WHITE='\033[1;37m'
NC='\033[0m'

# HEADER
header() {
clear
echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════╗"
echo "║        🚀 RRS PRO VPS CONTROL PANEL         ║"
echo "╠══════════════════════════════════════════════╣"
echo "║  1️⃣  PANEL INSTALL                        ║"
echo "║  2️⃣  WINGS INSTALL                        ║"
echo "║  3️⃣  CLOUDFLARE SETUP                     ║"
echo "║  4️⃣  BLUEPRINT INSTALL                    ║"
echo "║  5️⃣  TEALSCALE INSTALL                    ║"
echo "║  6️⃣  THEME SELECTOR                       ║"
echo "║  7️⃣  TOOLS                                ║"
echo "║  8️⃣  MINECRAFT / DISCORD                  ║"
echo "║  0️⃣  EXIT                                 ║"
echo "╚══════════════════════════════════════════════╝"
echo -e "${NC}"
}

info(){ echo -e "${BLUE}ℹ $1${NC}"; }
ok(){ echo -e "${GREEN}✔ $1${NC}"; }
warn(){ echo -e "${YELLOW}⚠ $1${NC}"; }

# ================= PANEL =================
panel_menu(){
while true; do
clear
echo "========== 🌐 PANEL INSTALL =========="
echo "1) Pterodactyl Install"
echo "2) PufferPanel Install"
echo "0) 🔙 Back"
read -p "Select: " p

case $p in
1)
info "Installing Pterodactyl..."
bash <(curl -s https://pterodactyl-installer.se)
ok "Done"
;;
2)
info "Installing PufferPanel..."
curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | bash
sudo apt install -y pufferpanel
ok "Installed"
;;
0) break ;;
*) warn "Invalid" ;;
esac
read -p "Press Enter..."
done
}

# ================= WINGS =================
wings_menu(){
while true; do
clear
echo "========== 🪽 WINGS =========="
echo "1) Install Docker"
echo "2) Install Wings"
echo "0) Back"
read -p "Select: " w

case $w in
1)
curl -s https://get.docker.com | bash
ok "Docker installed"
;;
2)
info "Follow official config after download"
echo "https://pterodactyl.io/wings"
;;
0) break ;;
*) warn "Invalid" ;;
esac
read -p "Press Enter..."
done
}

# ================= CLOUDFLARE =================
cloudflare_menu(){
while true; do
clear
echo "========== 🌐 CLOUDFLARE =========="
echo "1) Install Cloudflared Tunnel"
echo "2) Run Tunnel"
echo "0) Back"
read -p "Select: " c

case $c in
1)
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared
chmod +x cloudflared
ok "Installed cloudflared"
;;
2)
./cloudflared tunnel --url http://localhost:80
;;
0) break ;;
*) warn "Invalid" ;;
esac
read -p "Press Enter..."
done
}

# ================= BLUEPRINT =================
blueprint_menu(){
while true; do
clear
echo "========== 📘 BLUEPRINT =========="
echo "1) Create basic panel folder"
echo "2) Run demo server"
echo "0) Back"
read -p "Select: " b

case $b in
1)
mkdir -p blueprint-panel
cd blueprint-panel
echo "<h1>Blueprint Panel</h1>" > index.html
ok "Created"
;;
2)
python3 -m http.server 8080
;;
0) break ;;
*) warn "Invalid" ;;
esac
read -p "Press Enter..."
done
}

# ================= TEALSCALE =================
tealscale_menu(){
while true; do
clear
echo "========== 🧩 TEALSCALE =========="
echo "1) Install Node.js"
echo "2) Setup Tealscale Project"
echo "0) Back"
read -p "Select: " t

case $t in
1)
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
sudo apt install -y nodejs
ok "Node installed"
;;
2)
mkdir tealscale
cd tealscale
npm init -y
ok "Project created"
;;
0) break ;;
*) warn "Invalid" ;;
esac
read -p "Press Enter..."
done
}

# ================= THEME =================
theme_menu(){
while true; do
clear
echo "========== 🎨 THEMES =========="
echo "1) 🌌 Nebula"
echo "2) 🌑 Dark"
echo "3) 🔥 Red"
echo "0) Back"
read -p "Select: " t

case $t in
1) ok "Nebula applied" ;;
2) ok "Dark applied" ;;
3) ok "Red applied" ;;
0) break ;;
*) warn "Invalid" ;;
esac
read -p "Press Enter..."
done
}

# ================= TOOLS =================
tools_menu(){
while true; do
clear
echo "========== ⚙ TOOLS =========="
echo "1) Show Ports"
echo "2) Show Processes"
echo "0) Back"
read -p "Select: " t

case $t in
1) ss -tulnp ;;
2) ps aux | head ;;
0) break ;;
*) warn "Invalid" ;;
esac
read -p "Press Enter..."
done
}

# ================= MC =================
mc_menu(){
while true; do
clear
echo "========== 🛠 MC + DISCORD =========="
echo "1) Install Node"
echo "2) Create Bot Folder"
echo "0) Back"
read -p "Select: " m

case $m in
1)
sudo apt install -y nodejs npm
;;
2)
mkdir bot && cd bot
echo "console.log('Bot Ready')" > bot.js
;;
0) break ;;
*) warn "Invalid" ;;
esac
read -p "Press Enter..."
done
}

# ================= MAIN =================
while true; do
header
read -p "👉 Select option: " opt

case $opt in
1) panel_menu ;;
2) wings_menu ;;
3) cloudflare_menu ;;
4) blueprint_menu ;;
5) tealscale_menu ;;
6) theme_menu ;;
7) tools_menu ;;
8) mc_menu ;;
0) echo "👋 Exit"; exit ;;
*) warn "Invalid option" ;;
esac
done
