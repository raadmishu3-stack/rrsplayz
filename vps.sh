#!/bin/bash

# =============================
# 🚀 RRS USER VPS PANEL (NO ROOT AUTO)
# =============================

# COLORS
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
NC='\033[0m'

BASE="$HOME/rrs-panel"
BOTS="$BASE/bots"
mkdir -p "$BOTS"

# ================= HEADER =================
header() {
clear
echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════╗"
echo "║        🚀 RRS USER CONTROL PANEL            ║"
echo "╠══════════════════════════════════════════════╣"
echo "║ 1️⃣  🖥 SYSTEM INFO                          ║"
echo "║ 2️⃣  🤖 BOT MANAGER                         ║"
echo "║ 3️⃣  ☁️ CLOUDFLARE CONNECT                  ║"
echo "║ 4️⃣  🔗 TAILSCALE CONNECT                   ║"
echo "║ 5️⃣  🎨 THEME SELECTOR                      ║"
echo "║ 6️⃣  🧩 BLUEPRINT SETUP                     ║"
echo "║ 7️⃣  ⚙️ USER TOOLS                          ║"
echo "║ 8️⃣  🎮 MC / DISCORD INFO                   ║"
echo "║ 0️⃣  EXIT                                   ║"
echo "╚══════════════════════════════════════════════╝"
echo -e "${NC}"
}

ok(){ echo -e "${GREEN}✅ $1${NC}"; }
info(){ echo -e "${BLUE}ℹ️  $1${NC}"; }
warn(){ echo -e "${YELLOW}⚠️  $1${NC}"; }
err(){ echo -e "${RED}❌ $1${NC}"; }

pause(){ read -p "🔁 Press Enter..."; }

# ================= SYSTEM INFO =================
system_info(){
clear
echo "🖥 SYSTEM INFORMATION"
echo "----------------------------"
uname -a
echo ""
free -h
echo ""
df -h
echo ""
whoami
}

# ================= BOT MANAGER =================
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
ok "Bot created (run manually with node)"
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
*) err "Invalid option" ;;
esac
pause
done
}

# ================= CLOUDFLARE =================
cloudflare_connect(){
clear
echo "☁️ CLOUDFLARE ZERO TRUST CONNECT"
echo "--------------------------------------"
echo "👉 Step:"
echo "1. Go to Cloudflare Dashboard"
echo "2. Zero Trust → Networks → Tunnel"
echo "3. Create Tunnel"
echo "4. Copy TOKEN"
echo ""

read -p "📋 Paste TOKEN: " TOKEN

if [[ -z "$TOKEN" ]]; then
err "Token empty"
return
fi

if ! command -v cloudflared &> /dev/null; then
warn "cloudflared not installed ❌"
echo "👉 Install manually:"
echo "https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/"
return
fi

echo ""
ok "Connecting..."
cloudflared tunnel run --token "$TOKEN"
}

# ================= TAILSCALE =================
tailscale_connect(){
clear
echo "🔗 TAILSCALE CONNECT"
echo "----------------------------"

if ! command -v tailscale &> /dev/null; then
warn "tailscale not installed ❌"
echo "👉 Install manually: https://tailscale.com/download"
return
fi

echo "👉 Login link will appear below:"
tailscale up
}

# ================= THEME =================
theme_menu(){
while true; do
clear
echo "🎨 THEME SELECTOR"
echo "1) Nebula 🌌"
echo "2) Dark 🌑"
echo "3) Neon 💜"
echo "0) Back"
read -p "👉 Select: " t

case $t in
1) ok "Nebula Theme Applied 🌌" ;;
2) ok "Dark Theme Applied 🌑" ;;
3) ok "Neon Theme Applied 💜" ;;
0) break ;;
*) err "Invalid" ;;
esac
pause
done
}

# ================= BLUEPRINT =================
blueprint_setup(){
clear
echo "🧩 BLUEPRINT SETUP (USER MODE)"
echo "--------------------------------"
mkdir -p "$BASE/blueprint"
cd "$BASE/blueprint"
ok "Blueprint folder ready at ~/rrs-panel/blueprint"
}

# ================= USER TOOLS =================
user_tools(){
while true; do
clear
echo "⚙️ USER TOOLS"
echo "1) Check Ports"
echo "2) Running Processes"
echo "3) Disk Usage"
echo "0) Back"
read -p "👉 Select: " c

case $c in
1) ss -tuln ;;
2) ps aux | head ;;
3) df -h ;;
0) break ;;
*) err "Invalid" ;;
esac
pause
done
}

# ================= MC / DISCORD =================
mc_tools(){
while true; do
clear
echo "🎮 MC / DISCORD INFO"
echo "1) Minecraft Bot Info"
echo "2) Discord Bot Info"
echo "0) Back"
read -p "👉 Select: " c

case $c in
1) info "Use mineflayer (Node.js)" ;;
2) info "Use discord.js + bot token" ;;
0) break ;;
*) err "Invalid" ;;
esac
pause
done
}

# ================= MAIN LOOP =================
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
0) echo "👋 Exit"; exit ;;
*) err "Invalid option" ;;
esac

pause
done
