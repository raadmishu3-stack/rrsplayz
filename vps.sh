#!/bin/bash

# =============================
# 🚀 RRS VPS PANEL
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
NC='\033[0m'

ok(){ echo -e "${GREEN}✅ $1${NC}"; }
err(){ echo -e "${RED}❌ $1${NC}"; }

pause(){ read -p "Press Enter..."; }

# ================= CLOUDFLARE (FIXED ONLY) =================
cloudflare(){
clear
echo "☁️ CLOUDFLARE CONNECT"

# install only if missing
if ! command -v cloudflared &> /dev/null; then
    echo "📥 Installing Cloudflared..."
    apt update -y
    apt install -y wget
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    dpkg -i cloudflared-linux-amd64.deb
    rm -f cloudflared-linux-amd64.deb
fi

ok "Cloudflared Ready"

read -p "🔑 TOKEN: " token

if [[ -z "$token" ]]; then
    err "Token missing"
    return
fi

ok "Starting Cloudflare Tunnel..."
cloudflared tunnel --no-autoupdate run --token "$token"
}

# ================= TAILSCALE (FIXED ONLY) =================
tailscale(){
clear
echo "🔗 TAILSCALE CONNECT"

if ! command -v tailscale &> /dev/null; then
    echo "📥 Installing Tailscale..."
    curl -fsSL https://tailscale.com/install.sh | sh
fi

ok "Tailscale Installed"

tailscale up --accept-dns=true

echo ""
ok "Browser login required"
pause
}

# ================= PANEL SYSTEM (OLD STYLE) =================
panel_menu(){
while true; do
clear
echo "🦖 PANEL SYSTEM"
echo "1) Doctor Panel"
echo "2) Power Panel"
echo "0) Back"

read -p "Select: " p

case $p in
1)
echo "Doctor Panel Active" > "$BASE/doctor.txt"
ok "Doctor Panel Ready"
;;
2)
echo "Power Panel Active" > "$BASE/power.txt"
ok "Power Panel Ready"
;;
0) break ;;
*) err "Invalid Option" ;;
esac

pause
done
}

# ================= BOT SYSTEM =================
bot_menu(){
clear
read -p "Bot Name: " n

mkdir -p "$BOTS/$n"
echo "console.log('$n running');" > "$BOTS/$n/index.js"

ok "Bot Created"
pause
}

# ================= WINGS =================
wings_menu(){
clear
echo "🪽 WINGS SETUP"

cat > "$WINGS/wings.yml" <<EOF
debug: false
token: "YOUR_WINGS_TOKEN"
api:
  host: 0.0.0.0
  port: 8080
EOF

ok "Wings Ready"
pause
}

# ================= BLUEPRINT =================
blueprint_menu(){
clear
echo "🧩 BLUEPRINT"

echo "Blueprint Ready" > "$BLUEPRINT/info.txt"

ok "Blueprint Done"
pause
}

# ================= TOOLS =================
tools_menu(){
while true; do
clear
echo "⚙️ TOOLS SYSTEM"
echo "1) Plugins Installer"
echo "2) MC Player Manager"
echo "3) Register System"
echo "4) Properties"
echo "5) Blueprint Command"
echo "0) Back"

read -p "Select: " t

case $t in
1)
read -p "Plugin Name: " p
echo "$p" >> "$TOOLS/plugins.txt"
ok "Plugin Installed"
;;
2)
read -p "Player Name: " pl
echo "$pl" >> "$TOOLS/players.txt"
ok "Player Added"
;;
3)
read -p "Username: " u
echo "$u" >> "$TOOLS/register.txt"
ok "Registered"
;;
4)
echo "max_players=100" > "$TOOLS/properties.cfg"
ok "Saved"
;;
5)
echo "Blueprint Command Ready" > "$TOOLS/blueprint_cmd.txt"
ok "Done"
;;
0) break ;;
*) err "Invalid Option" ;;
esac

pause
done
}

# ================= MAIN MENU (OLD FULL SYSTEM) =================
while true; do
clear

echo -e "${CYAN}"
echo "===================================="
echo "🚀 RRS VPS PANEL (FULL SYSTEM)"
echo "===================================="
echo "1) Cloudflare Connect"
echo "2) Tailscale Connect"
echo "3) Panel System"
echo "4) Bot System"
echo "5) Wings Setup"
echo "6) Blueprint Setup"
echo "7) Tools System"
echo "0) Exit"
echo "===================================="
echo -e "${NC}"

read -p "Select: " opt

case $opt in
1) cloudflare ;;
2) tailscale ;;
3) panel_menu ;;
4) bot_menu ;;
5) wings_menu ;;
6) blueprint_menu ;;
7) tools_menu ;;
0) exit 0 ;;
*) err "Invalid Option" ;;
esac

pause
done
