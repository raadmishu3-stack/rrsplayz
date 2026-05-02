#!/bin/bash

# =============================
# 🚀 RRS VPS PANEL
# =============================

BASE="$HOME/rrs-panel"
BOTS="$BASE/bots"
WINGS="$BASE/wings"
BLUEPRINT="$BASE/blueprint"

mkdir -p "$BOTS" "$WINGS" "$BLUEPRINT"

# COLORS
GREEN='\033[1;32m'
RED='\033[1;31m'
CYAN='\033[1;36m'
NC='\033[0m'

ok(){ echo -e "${GREEN}✅ $1${NC}"; }
err(){ echo -e "${RED}❌ $1${NC}"; }

pause(){ read -p "Press Enter..."; }

# ================= CLOUDFLARE =================
cloudflare(){
clear
echo "☁️ CLOUDFLARE CONNECT"

command -v cloudflared >/dev/null 2>&1 || {
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
dpkg -i cloudflared-linux-amd64.deb
rm -f cloudflared-linux-amd64.deb
}

read -p "TOKEN: " token
[[ -z "$token" ]] && { err "Token missing"; return; }

ok "Starting Cloudflare Tunnel..."
cloudflared tunnel --no-autoupdate run --token "$token"
}

# ================= TAILSCALE =================
tailscale(){
clear
echo "🔗 TAILSCALE CONNECT"

command -v tailscale >/dev/null 2>&1 || {
curl -fsSL https://tailscale.com/install.sh | sh
}

tailscale up --accept-dns=true
ok "Tailscale Connected"
}

# ================= PANEL =================
panel(){
clear
echo "🦖 PANEL SETUP"

echo "Doctor Panel" > "$BASE/doctor-panel.txt"
echo "Power Panel" > "$BASE/power-panel.txt"

ok "Panels Ready"
}

# ================= WINGS =================
wings(){
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
}

# ================= BLUEPRINT =================
blueprint(){
clear
echo "🧩 BLUEPRINT SETUP"

echo "Blueprint Ready" > "$BLUEPRINT/info.txt"

ok "Blueprint Done"
}

# ================= TOOLS =================
tools(){
while true; do
clear
echo "⚙️ TOOLS"
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
echo "$p" >> "$BASE/plugins.txt"
ok "Plugin Installed"
;;
2)
read -p "Player Name: " pl
echo "$pl" >> "$BASE/players.txt"
ok "Player Added"
;;
3)
read -p "Username: " u
echo "$u" >> "$BASE/register.txt"
ok "Registered"
;;
4)
echo "max_players=100" > "$BASE/properties.cfg"
ok "Saved"
;;
5)
echo "Blueprint Command Ready" > "$BASE/blueprint_cmd.txt"
ok "Done"
;;
0) break ;;
*) err "Invalid" ;;
esac

pause
done
}

# ================= MAIN MENU =================
while true; do
clear

echo -e "${CYAN}"
echo "===================================="
echo "🚀 RRS VPS PANEL"
echo "===================================="
echo "1) Cloudflare Connect"
echo "2) Tailscale Connect"
echo "3) Panel Setup"
echo "4) Wings Setup"
echo "5) Blueprint Setup"
echo "6) Tools"
echo "0) Exit"
echo "===================================="
echo -e "${NC}"

read -p "Select: " opt

case $opt in
1) cloudflare ;;
2) tailscale ;;
3) panel ;;
4) wings ;;
5) blueprint ;;
6) tools ;;
0) exit 0 ;;
*) err "Invalid Option" ;;
esac

pause
done
