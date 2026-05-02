#!/bin/bash

# =============================
# 🚀 RRS ULTIMATE VPS PANEL (STABLE FIXED)
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
header(){
clear
echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════╗"
echo "║        🚀 RRS ULTIMATE VPS PANEL            ║"
echo "╠══════════════════════════════════════════════╣"
echo "║ 1️⃣  🖥 SYSTEM INFO                          ║"
echo "║ 2️⃣  🤖 BOT MANAGER                         ║"
echo "║ 3️⃣  ☁️ CLOUDFLARE CONNECT                  ║"
echo "║ 4️⃣  🔗 TAILSCALE CONNECT                   ║"
echo "║ 5️⃣  🎨 THEME                               ║"
echo "║ 6️⃣  🧩 BLUEPRINT                           ║"
echo "║ 7️⃣  ⚙️ USER TOOLS                          ║"
echo "║ 8️⃣  🎮 MC / DISCORD                        ║"
echo "║ 9️⃣  🦖 PANEL & WINGS                       ║"
echo "║ 0️⃣  EXIT                                   ║"
echo "╚══════════════════════════════════════════════╝"
echo -e "${NC}"
}

ok(){ echo -e "${GREEN}✅ $1${NC}"; }
err(){ echo -e "${RED}❌ $1${NC}"; }
info(){ echo -e "${BLUE}ℹ️ $1${NC}"; }
pause(){ read -p "Press Enter..."; }

# ================= SYSTEM =================
system_info(){
clear
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
read -p "Select: " c

case $c in
1)
read -p "Bot name: " n
mkdir -p "$BOTS/$n"
echo "console.log('Bot $n running');" > "$BOTS/$n/bot.js"
ok "Created"
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

command -v cloudflared >/dev/null 2>&1 || {
err "cloudflared not installed"
echo "Install: https://developers.cloudflare.com/cloudflare-one/"
return
}

read -p "Token: " TOKEN
[[ -z "$TOKEN" ]] && { err "Token empty"; return; }

ok "Starting Cloudflare Tunnel..."

# 🔥 STABLE METHOD
cloudflared tunnel --no-autoupdate run --token "$TOKEN"
}

# ================= TAILSCALE FIXED =================
tailscale_connect(){
clear
echo "🔗 TAILSCALE CONNECT"

command -v tailscale >/dev/null 2>&1 || {
err "tailscale not installed"
echo "Install: https://tailscale.com/download"
return
}

ok "Connecting Tailscale..."
tailscale up --accept-dns=true
}

# ================= THEME =================
theme(){
clear
echo "🎨 Theme system (demo)"
echo "1) Nebula"
echo "2) Dark"
echo "3) Neon"
read -p "Select: " t

case $t in
1) ok "Nebula applied" ;;
2) ok "Dark applied" ;;
3) ok "Neon applied" ;;
*) err "Invalid" ;;
esac
pause
}

# ================= BLUEPRINT =================
blueprint(){
mkdir -p "$BASE/blueprint"
ok "Blueprint ready"
pause
}

# ================= USER TOOLS =================
tools(){
while true; do
clear
echo "⚙️ TOOLS"
echo "1) Ports"
echo "2) Processes"
echo "3) Disk"
echo "0) Back"
read -p "Select: " c

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
mc(){
clear
echo "🎮 MC / DISCORD"
echo "Minecraft: use mineflayer"
echo "Discord: use discord.js"
pause
}

# ================= WINGS =================
wings(){
while true; do
clear
echo "🦖 PANEL & WINGS"
echo "1) Save Token"
echo "2) Show Token"
echo "3) Create Folder"
echo "0) Back"
read -p "Select: " p

case $p in
1)
read -p "Token: " t
echo "$t" > "$WINGS/token.txt"
ok "Saved"
;;
2)
cat "$WINGS/token.txt" 2>/dev/null || echo "No token"
;;
3)
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
read -p "Select: " opt

case $opt in
1) system_info ;;
2) bot_menu ;;
3) cloudflare_connect ;;
4) tailscale_connect ;;
5) theme ;;
6) blueprint ;;
7) tools ;;
8) mc ;;
9) wings ;;
0) exit 0 ;;
*) err "Invalid" ;;
esac

pause
done
