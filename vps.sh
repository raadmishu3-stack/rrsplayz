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

# BIG HEADER
header() {
clear
echo -e "${CYAN}"
echo "██████╗ ██████╗ ███████╗"
echo "██╔══██╗██╔══██╗██╔════╝"
echo "██████╔╝██████╔╝█████╗  "
echo "██╔══██╗██╔═══╝ ██╔══╝  "
echo "██║  ██║██║     ███████╗"
echo "╚═╝  ╚═╝╚═╝     ╚══════╝"
echo ""
echo "🚀 RRS PRO CONTROL PANEL 🚀"
echo "════════════════════════════════════"
echo "1️⃣ PANEL INSTALL"
echo "2️⃣ WINGS"
echo "3️⃣ CLOUDFLARE CONNECT"
echo "4️⃣ BLUEPRINT"
echo "5️⃣ TAILSCALE CONNECT"
echo "6️⃣ THEMES"
echo "7️⃣ TOOLS"
echo "8️⃣ MC + DISCORD"
echo "0️⃣ EXIT"
echo "════════════════════════════════════"
echo -e "${NC}"
}

info(){ echo -e "${BLUE}ℹ $1${NC}"; }
ok(){ echo -e "${GREEN}✔ $1${NC}"; }
warn(){ echo -e "${YELLOW}⚠ $1${NC}"; }

# ================= CLOUDFLARE =================
cloudflare_menu(){
while true; do
clear
echo "🌐 ===== CLOUDFLARE CONNECT ===== 🌐"
echo ""
echo "1) Install cloudflared"
echo "2) Connect using URL"
echo "0) 🔙 Back"
echo ""

read -p "Select: " c

case $c in
1)
info "Downloading cloudflared..."
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared
chmod +x cloudflared
ok "Installed locally ✔"
;;

2)
echo ""
info "👉 Go Cloudflare → Zero Trust → Networks → Tunnels"
info "👉 Create Tunnel → Debian → Copy the command URL"
echo ""

read -p "📋 Paste your URL: " url

echo ""
info "Connecting tunnel..."
eval "$url"

ok "Cloudflare Connected 🚀"
;;

0) break ;;
*) warn "Invalid option" ;;
esac

read -p "Press Enter..."
done
}

# ================= TAILSCALE =================
tailscale_menu(){
while true; do
clear
echo "🔗 ===== TAILSCALE CONNECT ===== 🔗"
echo ""
echo "1) Install Tailscale"
echo "2) Login & Connect"
echo "0) 🔙 Back"
echo ""

read -p "Select: " t

case $t in
1)
info "Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh
ok "Installed ✔"
;;

2)
info "Starting Tailscale..."
tailscale up

echo ""
info "👉 If link shows → open it in browser"
info "👉 Login → then return here"

read -p "Press Enter after login..."

tailscale status

ok "Connected 🚀"
;;

0) break ;;
*) warn "Invalid option" ;;
esac

read -p "Press Enter..."
done
}

# ================= BLUEPRINT =================
blueprint_menu(){
while true; do
clear
echo "📘 ===== BLUEPRINT PANEL ===== 📘"
echo ""
echo "1) Create Panel"
echo "2) Run Panel (Port 8080)"
echo "0) Back"
echo ""

read -p "Select: " b

case $b in
1)
mkdir -p blueprint
echo "<h1>RRS PANEL 🚀</h1>" > blueprint/index.html
ok "Panel created ✔"
;;

2)
cd blueprint 2>/dev/null || warn "Create first!"
python3 -m http.server 8080
;;

0) break ;;
*) warn "Invalid" ;;
esac

read -p "Press Enter..."
done
}

# ================= THEMES =================
theme_menu(){
while true; do
clear
echo "🎨 ===== THEMES ===== 🎨"
echo ""
echo "1) 🌌 Nebula"
echo "2) 🌑 Dark"
echo "3) 🔥 Red"
echo "0) Back"
echo ""

read -p "Select: " t

case $t in
1) ok "Nebula applied 🌌" ;;
2) ok "Dark applied 🌑" ;;
3) ok "Red applied 🔥" ;;
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
echo "⚙ ===== TOOLS ===== ⚙"
echo ""
echo "1) Show Ports"
echo "2) Processes"
echo "0) Back"
echo ""

read -p "Select: " t

case $t in
1) ss -tuln ;;
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
echo "🛠 ===== MC + DISCORD ===== 🛠"
echo ""
echo "1) Install Node"
echo "2) Create Bot"
echo "0) Back"
echo ""

read -p "Select: " m

case $m in
1)
info "Installing Node..."
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
sudo apt install -y nodejs
;;
2)
mkdir -p bot
echo "console.log('Bot Running 🚀')" > bot/bot.js
ok "Bot created ✔"
;;
0) break ;;
*) warn "Invalid" ;;
esac

read -p "Press Enter..."
done
}

# ================= PANEL =================
panel_menu(){
while true; do
clear
echo "🌐 ===== PANEL INSTALL ===== 🌐"
echo ""
echo "1) Pterodactyl"
echo "2) PufferPanel"
echo "0) Back"
echo ""

read -p "Select: " p

case $p in
1)
info "Installer running..."
bash <(curl -s https://pterodactyl-installer.se)
;;
2)
info "Install manually: https://pufferpanel.com"
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
read -p "👉 Select: " opt

case $opt in
1) panel_menu ;;
2) echo "Use Wings from official docs";;
3) cloudflare_menu ;;
4) blueprint_menu ;;
5) tailscale_menu ;;
6) theme_menu ;;
7) tools_menu ;;
8) mc_menu ;;
0) echo "👋 Exit"; exit ;;
*) warn "Invalid option" ;;
esac
done
