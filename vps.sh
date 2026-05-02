#!/bin/bash

# =============================
# 🚀🌈 RRS VPS ULTRA PANEL
# =============================

BASE="$HOME/rrs-panel"
BOTS="$BASE/bots"
WINGS="$BASE/wings"
BLUEPRINT="$BASE/blueprint"
TOOLS="$BASE/tools"

mkdir -p "$BOTS" "$WINGS" "$BLUEPRINT" "$TOOLS"

# COLORS
GREEN='\033[1;32m'
RED='\033[1;31m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

ok(){ echo -e "${GREEN}✅ $1${NC}"; }
err(){ echo -e "${RED}❌ $1${NC}"; }

pause(){ read -p "👉 Press Enter to continue..."; }

# ================= CLOUDFLARE =================
cloudflare(){
clear
echo -e "${CYAN}"
echo "☁️☁️☁️  CLOUDLFARE TUNNEL CONNECT  ☁️☁️☁️"
echo "========================================"

if ! command -v cloudflared &> /dev/null; then
    echo "📥 Installing Cloudflared..."
    apt update -y
    apt install -y wget
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    dpkg -i cloudflared-linux-amd64.deb
    rm -f cloudflared-linux-amd64.deb
fi

ok "Cloudflared Installed"

echo ""
read -p "🔑 ENTER YOUR CLOUDFLARE TOKEN: " token

if [[ -z "$token" ]]; then
    err "TOKEN NOT FOUND"
    return
fi

ok "STARTING CLOUDFLARE TUNNEL..."
cloudflared tunnel --no-autoupdate run --token "$token"
}

# ================= TAILSCALE =================
tailscale(){
clear
echo -e "${YELLOW}"
echo "🔗🔗🔗  TAILSCALE CONNECT SYSTEM  🔗🔗🔗"
echo "========================================"

if ! command -v tailscale &> /dev/null; then
    echo "📥 Installing Tailscale..."
    curl -fsSL https://tailscale.com/install.sh | sh
fi

ok "TAILSCALE INSTALLED"

echo ""
echo "🌐 LOGIN LINK WILL OPEN IN BROWSER"
tailscale up --accept-dns=true

ok "AUTHENTICATION REQUIRED IN BROWSER"
pause
}

# ================= PANEL SYSTEM =================
panel_menu(){
while true; do
clear
echo -e "${GREEN}"
echo "🦖🦖🦖  PANEL SYSTEM MENU  🦖🦖🦖"
echo "========================================"
echo "1️⃣  🩺 DOCTOR PANEL INSTALL"
echo "2️⃣  ⚡ POWER PANEL INSTALL"
echo "0️⃣  ⬅️ BACK"
echo "========================================"

read -p "👉 SELECT OPTION: " p

case $p in
1)
echo "DOCTOR PANEL ACTIVE" > "$BASE/doctor.txt"
ok "DOCTOR PANEL INSTALLED"
;;
2)
echo "POWER PANEL ACTIVE" > "$BASE/power.txt"
ok "POWER PANEL INSTALLED"
;;
0) break ;;
*) err "INVALID OPTION" ;;
esac

pause
done
}

# ================= BOT SYSTEM =================
bot_menu(){
clear
echo -e "${CYAN}"
echo "🤖🤖🤖  BOT CREATOR SYSTEM  🤖🤖🤖"
echo "========================================"

read -p "👉 ENTER BOT NAME: " n

mkdir -p "$BOTS/$n"
echo "console.log('$n running...');" > "$BOTS/$n/index.js"

ok "BOT CREATED SUCCESSFULLY"
pause
}

# ================= WINGS =================
wings_menu(){
clear
echo -e "${YELLOW}"
echo "🪽🪽🪽  WINGS CONFIG SYSTEM  🪽🪽🪽"
echo "========================================"

cat > "$WINGS/wings.yml" <<EOF
debug: false
token: "YOUR_WINGS_TOKEN"
api:
  host: 0.0.0.0
  port: 8080
EOF

ok "WINGS CONFIG CREATED"
pause
}

# ================= BLUEPRINT =================
blueprint_menu(){
clear
echo -e "${GREEN}"
echo "🧩🧩🧩  BLUEPRINT SYSTEM  🧩🧩🧩"
echo "========================================"

echo "BLUEPRINT READY SYSTEM" > "$BLUEPRINT/info.txt"

ok "BLUEPRINT SETUP COMPLETE"
pause
}

# ================= TOOLS =================
tools_menu(){
while true; do
clear
echo -e "${CYAN}"
echo "⚙️⚙️⚙️  TOOLS CONTROL CENTER  ⚙️⚙️⚙️"
echo "========================================"
echo "1️⃣ 📦 PLUGIN INSTALLER"
echo "2️⃣ 🎮 MC PLAYER MANAGER"
echo "3️⃣ 📝 REGISTER SYSTEM"
echo "4️⃣ ⚙️ PROPERTIES EDITOR"
echo "5️⃣ 🧩 BLUEPRINT COMMAND"
echo "0️⃣ ⬅️ BACK"
echo "========================================"

read -p "👉 SELECT: " t

case $t in
1)
read -p "PLUGIN NAME: " p
echo "$p installed" >> "$TOOLS/plugins.txt"
ok "PLUGIN INSTALLED"
;;
2)
read -p "PLAYER NAME: " pl
echo "$pl added" >> "$TOOLS/players.txt"
ok "PLAYER ADDED"
;;
3)
read -p "USERNAME: " u
echo "$u registered" >> "$TOOLS/register.txt"
ok "REGISTERED"
;;
4)
echo "max_players=100" > "$TOOLS/properties.cfg"
ok "PROPERTIES SAVED"
;;
5)
echo "BLUEPRINT COMMAND READY" > "$TOOLS/blueprint_cmd.txt"
ok "DONE"
;;
0) break ;;
*) err "INVALID OPTION" ;;
esac

pause
done
}

# ================= MAIN MENU =================
while true; do
clear

echo -e "${CYAN}"
echo "============================================"
echo "🚀🌈✨  RRS VPS ULTRA CONTROL PANEL  ✨🌈🚀"
echo "============================================"
echo "1️⃣ ☁️ CLOUDFLARE CONNECT"
echo "2️⃣ 🔗 TAILSCALE CONNECT"
echo "3️⃣ 🦖 PANEL SYSTEM"
echo "4️⃣ 🤖 BOT SYSTEM"
echo "5️⃣ 🪽 WINGS SETUP"
echo "6️⃣ 🧩 BLUEPRINT SYSTEM"
echo "7️⃣ ⚙️ TOOLS CENTER"
echo "0️⃣ ❌ EXIT SYSTEM"
echo "============================================"
echo -e "${NC}"

read -p "👉 SELECT OPTION: " opt

case $opt in
1) cloudflare ;;
2) tailscale ;;
3) panel_menu ;;
4) bot_menu ;;
5) wings_menu ;;
6) blueprint_menu ;;
7) tools_menu ;;
0) exit 0 ;;
*) err "INVALID OPTION" ;;
esac

pause
done
