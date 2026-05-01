#!/bin/bash

# =============================
# 🚀 RRS OFFICIAL VPS PANEL
# =============================

# COLORS
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

# HEADER
header() {
clear
echo -e "${CYAN}"
echo "╔══════════════════════════════════════╗"
echo "║ 🚀 RRS VPS CONTROL PANEL           ║"
echo "╠══════════════════════════════════════╣"
echo "║ 1️⃣ Panel Install Guide             ║"
echo "║ 2️⃣ Wings Install Guide             ║"
echo "║ 3️⃣ Cloudflare Install Guide        ║"
echo "║ 4️⃣ Blueprint Info                  ║"
echo "║ 5️⃣ Tealsceal Install Guide         ║"
echo "║ 6️⃣ Theme Selector                  ║"
echo "║ 7️⃣ Tools Menu                      ║"
echo "║ 8️⃣ Minecraft / Discord Setup       ║"
echo "║ 0️⃣ Exit                            ║"
echo "╚══════════════════════════════════════╝"
echo -e "${NC}"
}

# STATUS
info(){ echo -e "${BLUE}ℹ $1${NC}"; }
ok(){ echo -e "${GREEN}✔ $1${NC}"; }
warn(){ echo -e "${YELLOW}⚠ $1${NC}"; }

# PANEL
panel_menu() {
echo "1) Pterodactyl 🌐"
echo "2) PufferPanel 🌐"
read -p "Select: " p

case $p in
1)
info "https://pterodactyl.io (manual install)"
;;
2)
info "https://pufferpanel.com (manual install)"
;;
*) warn "Invalid option" ;;
esac
}

# WINGS
wings_menu() {
info "Wings Install 🪽"
echo "curl -s https://get.docker.com | bash"
echo "Then follow official docs"
}

# CLOUDFLARE
cloudflare_menu() {
info "Cloudflare Setup 🌐"
echo "1. Add domain"
echo "2. Change nameservers"
echo "3. Enable proxy"
}

# BLUEPRINT
blueprint_menu() {
info "Blueprint 📘"
echo "UI + API + Dashboard system design layer"
}

# TEAL SCEAL
tealsceal_menu() {
info "Tealsceal 🧩"
echo "Manual install only:"
echo "Upload files → configure → run"
}

# THEMES
theme_menu() {
echo "1) 🌌 Nebula"
echo "2) 🌑 Dark"
echo "3) 📘 Blueprint"
read -p "Select: " t

case $t in
1) ok "Nebula theme 🌌" ;;
2) ok "Dark theme 🌑" ;;
3) ok "Blueprint theme 📘" ;;
*) warn "Invalid" ;;
esac
}

# TOOLS
tools_menu() {
echo "1) Register Plugin"
echo "2) Player Manager"
echo "3) MC Properties"
echo "4) Discord Bot"
echo "5) Minecraft Bot"
read -p "Select: " t

case $t in
1) info "Plugin = manual install in plugins folder" ;;
2) info "PlayerManager plugin" ;;
3) info "server.properties edit" ;;
4) info "discord.js bot" ;;
5) info "mineflayer bot" ;;
*) warn "Invalid" ;;
esac
}

# MC + DISCORD
mc_menu() {
info "Minecraft / Discord Setup 🛠"
echo "- Minecraft bot: mineflayer"
echo "- Discord bot: discord.js"
echo "- Node.js required (manual install)"
}

# MAIN LOOP
while true; do
header
read -p "👉 Select option: " opt

case $opt in
1) panel_menu ;;
2) wings_menu ;;
3) cloudflare_menu ;;
4) blueprint_menu ;;
5) tealsceal_menu ;;
6) theme_menu ;;
7) tools_menu ;;
8) mc_menu ;;
0) echo "👋 Exit"; exit ;;
*) warn "Invalid option" ;;
esac

echo ""
read -p "Press Enter..."
done
