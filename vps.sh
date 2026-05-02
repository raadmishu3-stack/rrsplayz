#!/bin/bash

# =============================
# 👑 RRS 9 ROYAL VPS PANEL
# =============================

BASE="$HOME/rrs9"
BLUEPRINT="$BASE/blueprint"
THEME="$BASE/theme"
WINGS="$BASE/wings"
MC="$BASE/mc"

mkdir -p "$BASE" "$BLUEPRINT" "$THEME" "$WINGS" "$MC"

# COLORS
GREEN='\033[1;32m'
RED='\033[1;31m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
NC='\033[0m'

ok(){ echo -e "${GREEN}✅ $1${NC}"; }
err(){ echo -e "${RED}❌ $1${NC}"; }

pause(){ read -p "👉 Press Enter..."; }

# ================= HEADER =================
header(){
clear
echo -e "${PURPLE}"
echo "👑═══════════════════════════════════════👑"
echo "        🚀 R R S   9   R O Y A L 🚀"
echo "        VPS CONTROL PANEL SYSTEM"
echo "👑═══════════════════════════════════════👑"
echo -e "${NC}"
}

# ================= CLOUDFLARE =================
cloudflare(){
clear
echo "☁️ RRS 9 CLOUD FLARE"

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

ok "Cloudflare Ready"

read -p "🔑 TOKEN: " token
[[ -z "$token" ]] && { err "Missing Token"; return; }

cloudflared tunnel --no-autoupdate run --token "$token"
}

# ================= TAILSCALE =================
tailscale(){
clear
echo "🔗 RRS 9 TAILSCALE"

if ! command -v tailscale &> /dev/null; then
    echo "📥 Installing Tailscale..."
    curl -fsSL https://tailscale.com/install.sh | sh
fi

ok "Tailscale Ready"

tailscale up --accept-dns=true </dev/null &

ok "Running in background"
pause
}

# ================= BLUEPRINT =================
blueprint(){
clear
echo "🧩 RRS 9 BLUEPRINT SYSTEM"
echo "ACTIVE" > "$BLUEPRINT/info.txt"
ok "Blueprint Enabled"
pause
}

# ================= THEME =================
theme(){
while true; do
clear
echo "🎨 RRS 9 THEME SYSTEM"
echo "1) Dark 🌑"
echo "2) Neon 💜"
echo "3) Royal 👑"
echo "0) Back"

read -p "Select: " t

case $t in
1) echo "dark" > "$THEME/style.txt"; ok "Dark Theme" ;;
2) echo "neon" > "$THEME/style.txt"; ok "Neon Theme" ;;
3) echo "royal" > "$THEME/style.txt"; ok "Royal Theme" ;;
0) break ;;
*) err "Invalid" ;;
esac

pause
done
}

# ================= WINGS =================
wings(){
clear
echo "🪽 RRS 9 WINGS CONFIG"

cat > "$WINGS/wings.yml" <<EOF
debug: false
token: "RRS9-WINGS"
api:
  host: 0.0.0.0
  port: 8080
EOF

ok "Wings Config Ready"
pause
}

# ================= MC TOOLS =================
mc(){
clear
echo "🎮 RRS 9 MC TOOLS"
echo "mineflayer / discord bot support ready" > "$MC/info.txt"
ok "MC Tools Ready"
pause
}

# ================= MAIN MENU =================
while true; do
header

echo "1) ☁️ Cloudflare Connect"
echo "2) 🔗 Tailscale Connect"
echo "3) 🧩 Blueprint"
echo "4) 🎨 Theme"
echo "5) 🪽 Wings"
echo "6) 🎮 MC Tools"
echo "0) ❌ Exit"

read -p "👉 Select: " opt

case $opt in
1) cloudflare ;;
2) tailscale ;;
3) blueprint ;;
4) theme ;;
5) wings ;;
6) mc ;;
0) exit ;;
*) err "Invalid Option" ;;
esac

pause
done
