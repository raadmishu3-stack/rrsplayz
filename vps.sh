#!/bin/bash

# =============================
# 🚀 RRS ULTIMATE VPS PANEL (FIXED)
# =============================

# COLORS
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

BASE="$HOME/rrs-panel"
BOTS="$BASE/bots"
WINGS="$BASE/wings"

mkdir -p "$BOTS" "$WINGS"

# ================= HEADER =================
header() {
clear
echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════╗"
echo "║        🚀 RRS ULTIMATE VPS PANEL            ║"
echo "╠══════════════════════════════════════════════╣"
echo "║ 1️⃣  🖥 SYSTEM INFO                          ║"
echo "║ 2️⃣  🤖 BOT MANAGER                         ║"
echo "║ 3️⃣  ☁️ CLOUDFLARE CONNECT                  ║"
echo "║ 4️⃣  🔗 TAILSCALE CONNECT                   ║"
echo "║ 5️⃣  🎨 THEME SELECTOR                      ║"
echo "║ 6️⃣  🧩 BLUEPRINT SETUP                     ║"
echo "║ 7️⃣  ⚙️ USER TOOLS                          ║"
echo "║ 8️⃣  🎮 MC / DISCORD INFO                   ║"
echo "║ 9️⃣  🦖 PANEL & WINGS                       ║"
echo "║ 0️⃣  EXIT                                   ║"
echo "╚══════════════════════════════════════════════╝"
echo -e "${NC}"
}

ok(){ echo -e "${GREEN}✅ $1${NC}"; }
info(){ echo -e "${BLUE}ℹ️ $1${NC}"; }
warn(){ echo -e "${YELLOW}⚠️ $1${NC}"; }
err(){ echo -e "${RED}❌ $1${NC}"; }

pause(){ read -p "🔁 Press Enter..."; }

# ================= SYSTEM INFO =================
system_info(){
clear
echo "🖥 SYSTEM INFO"
echo "----------------------"
uname -a
echo ""
free -h
echo ""
df -h
echo ""
whoami
}

# ================= BOT =================
bot_menu(){
while true; do
clear
echo "🤖 BOT MANAGER"
echo "1) Create Bot"
echo "2) Delete Bot"
echo "3) List Bots"
echo "0) Back"
read -p "👉 Select: " c

case $c in
1)
read -p "Bot name: " n
mkdir -p "$BOTS/$n"
echo "console.log('Bot $n running');" > "$BOTS/$n/bot.js"
ok "Bot created"
;;
2)
read -p "Bot name: " n
rm -rf "$BOTS/$n"
ok "Deleted"
;;
3)
ls "$BOTS"
;;
0) break ;;
*) err "Invalid" ;;
esac
pause
done
}

# ================= CLOUDFLARE FIXED =================
cloudflare_connect(){
clear
echo "☁️ CLOUDFLARE CONNECT"
echo "--------------------------"

command -v cloudflared >/dev/null 2>&1 || {
err "cloudflared NOT installed"
echo "Install: https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/downloads/"
return
}

read -p "📋 Paste Tunnel Token: " TOKEN

if [[ -z "$TOKEN" ]]; then
err "Token empty"
return
fi

ok "Starting Cloudflared Tunnel..."

# FIX: proper run mode
cloudflared tunnel run --token "$TOKEN"
}

# ================= TAILSCALE FIXED =================
tailscale_connect(){
clear
echo "🔗 TAILSCALE CONNECT"

command -v tailscale >/dev/null 2>&1 || {
err "tailscale NOT installed"
echo "Install: https://tailscale.com/download"
return
}

ok "Starting Tailscale..."
tailscale up --accept-dns=true
}

# ================= THEME =================
theme_menu(){
while true; do
clear
echo "🎨 THEMES"
echo "1) Nebula 🌌"
echo "2) Dark 🌑"
echo "3) Neon 💜"
echo "0) Back"
read -p "👉 Select: " t

case $t in
1) ok "Nebula Applied" ;;
2) ok "Dark Applied" ;;
3) ok "Neon Applied" ;;
0) break ;;
*) err "Invalid" ;;
esac
pause
done
}

# ================= BLUEPRINT =================
blueprint_setup(){
mkdir -p "$BASE/blueprint"
ok "Blueprint ready"
}

# ================= USER TOOLS =================
user_tools(){
while true; do
clear
echo "⚙️ USER TOOLS"
echo "1) Ports"
echo "2) Processes"
echo "3) Disk"
echo "0) Back"
read -p "👉 Select: " c

case $c in
1) ss -tulnp ;;
2) ps aux | head ;;
3) df -h ;;
0) break ;;
*) err "Invalid" ;;
esac
pause
done
}

# ================= MC =================
mc_tools(){
while true; do
clear
echo "🎮 MC / DISCORD"
echo "1) Minecraft Bot Info"
echo "2) Discord Bot Info"
echo "0) Back"
read -p "👉 Select: " c

case $c in
1) info "Use mineflayer.js" ;;
2) info "Use discord.js" ;;
0) break ;;
*) err "Invalid" ;;
esac
pause
done
}

# ================= WINGS =================
panel_menu(){
while true; do
clear
echo "🦖 PANEL & WINGS"
echo "1) Panel Guide"
echo "2) Save Wings Token"
echo "3) Show Token"
echo "4) Create Wings Folder"
echo "0) Back"
read -p "👉 Select: " p

case $p in
1)
echo "https://pterodactyl.io"
;;
2)
read -p "Wings Token: " t
echo "$t" > "$WINGS/token.txt"
ok "Saved"
;;
3)
cat "$WINGS/token.txt" 2>/dev/null || echo "No token"
;;
4)
mkdir -p "$WINGS"
ok "Created"
;;
0) break ;;
*) err "Invalid" ;;
esac
pause
done
}

# ================= MAIN =================
while true; do
header
read -p "👉 Select Option: " opt

case $opt in
1) system_info ;;
2) bot_menu ;;
3) cloudflare_connect ;;
4) tailscale_connect ;;
5) theme_menu ;;
6) blueprint_setup ;;
7) user_tools ;;
8) mc_tools ;;
9) panel_menu ;;
0) exit 0 ;;
*) err "Invalid option" ;;
esac

pause
done
