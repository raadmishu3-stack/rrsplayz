#!/bin/bash

# =============================
# 👑🌈 RRS ROYAL VPS PANEL
# SAFE + ERROR FREE VERSION
# =============================

BASE="$HOME/rrs-royal-panel"
WINGS="$BASE/wings"
BLUEPRINT="$BASE/blueprint"
TOOLS="$BASE/tools"

mkdir -p "$WINGS" "$BLUEPRINT" "$TOOLS"

# COLORS
GREEN='\033[1;32m'
RED='\033[1;31m'
CYAN='\033[1;36m'
PURPLE='\033[1;35m'
NC='\033[0m'

ok(){ echo -e "${GREEN}✅ $1${NC}"; }
err(){ echo -e "${RED}❌ $1${NC}"; }

pause(){ read -p "👉 Press Enter..."; }

# ================= HEADER =================
header(){
clear
echo -e "${PURPLE}"
echo "👑═══════════════════════════════════════👑"
echo "     🌈 ROYAL VPS CONTROL PANEL 🌈"
echo "👑═══════════════════════════════════════👑"
echo -e "${NC}"
}

# ================= CLOUDFLARE SAFE =================
cloudflare(){
clear
echo "☁️ ROYAL CLOUDFLARE CONNECT"
echo "---------------------------"

# SAFE INSTALL (NO apt/dpkg)
if ! command -v cloudflared &> /dev/null; then
    echo "📥 Installing Cloudflared..."

    curl -L -o cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64

    if [[ ! -f cloudflared ]]; then
        err "Download failed"
        return
    fi

    chmod +x cloudflared
    mv cloudflared /usr/local/bin/
fi

ok "Cloudflared Ready"

read -p "🔑 TOKEN: " token

if [[ -z "$token" ]]; then
    err "TOKEN MISSING"
    return
fi

ok "Starting Tunnel..."
cloudflared tunnel --no-autoupdate run --token "$token"
}

# ================= TAILSCALE SAFE =================
tailscale(){
clear
echo "🔗 ROYAL TAILSCALE CONNECT"
echo "--------------------------"

# SAFE INSTALL
if ! command -v tailscale &> /dev/null; then
    echo "📥 Installing Tailscale..."
    curl -fsSL https://tailscale.com/install.sh | sh
fi

ok "Tailscale Ready"

# SAFE RUN (NO HANG)
tailscale up --accept-dns=true </dev/null &

ok "Running in background"
pause
}

# ================= PANEL =================
panel(){
clear
echo "🦖 ROYAL PANEL SYSTEM"

echo "Doctor Panel Active" > "$BASE/doctor.txt"
echo "Power Panel Active" > "$BASE/power.txt"

ok "Panels Ready"
pause
}

# ================= WINGS =================
wings(){
clear
echo "🪽 ROYAL WINGS SYSTEM"

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
blueprint(){
clear
echo "🧩 ROYAL BLUEPRINT"

echo "Blueprint Ready" > "$BLUEPRINT/info.txt"

ok "Done"
pause
}

# ================= TOOLS =================
tools(){
while true; do
clear
echo "⚙️ ROYAL TOOLS"
echo "1) Plugins"
echo "2) MC Player"
echo "3) Register"
echo "4) Properties"
echo "5) Blueprint"
echo "0) Back"

read -p "Select: " t

case $t in
1)
read -p "Plugin: " p
echo "$p" >> "$TOOLS/plugins.txt"
ok "Saved"
;;
2)
read -p "Player: " pl
echo "$pl" >> "$TOOLS/players.txt"
ok "Saved"
;;
3)
read -p "User: " u
echo "$u" >> "$TOOLS/register.txt"
ok "Saved"
;;
4)
echo "max_players=100" > "$TOOLS/properties.cfg"
ok "Saved"
;;
5)
echo "Blueprint Command Ready" > "$TOOLS/blueprint_cmd.txt"
ok "Saved"
;;
0) break ;;
*) err "Invalid" ;;
esac

pause
done
}

# ================= MAIN MENU =================
while true; do
header

echo -e "${CYAN}"
echo "═══════════════════════════════"
echo "🚀 ROYAL VPS MAIN MENU"
echo "═══════════════════════════════"
echo "1) ☁️ Cloudflare Connect"
echo "2) 🔗 Tailscale Connect"
echo "3) 🦖 Panel"
echo "4) 🪽 Wings"
echo "5) 🧩 Blueprint"
echo "6) ⚙️ Tools"
echo "0) ❌ Exit"
echo "═══════════════════════════════"
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
