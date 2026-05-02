#!/bin/bash

BASE="$HOME/rrs9"

GREEN='\033[1;32m'
RED='\033[1;31m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

ok(){ echo -e "${GREEN}✅ $1${NC}"; }
err(){ echo -e "${RED}❌ $1${NC}"; }

pause(){ read -p "👉 Press Enter..."; }

# ================= CLOUD FLARE =================
cloudflare(){
while true; do
clear
echo -e "${CYAN}"
echo "☁️ CLOUD FLARE MENU"
echo "1) 📥 Install"
echo "2) 🚀 Run (Token)"
echo "3) 🗑 Uninstall"
echo "0) 🔙 Back"
echo -e "${NC}"

read -p "Select: " c

case $c in
1)
if ! command -v cloudflared &>/dev/null; then
curl -L -o cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
chmod +x cloudflared
sudo mv cloudflared /usr/local/bin/
fi
ok "Cloudflare Installed"
;;
2)
read -p "🔑 Token: " t
cloudflared tunnel run --token "$t"
;;
3)
sudo rm -f /usr/local/bin/cloudflared
ok "Removed"
;;
0) break ;;
*) err "Invalid" ;;
esac
pause
done
}

# ================= TAILSCALE =================
tailscale(){
while true; do
clear
echo -e "${YELLOW}"
echo "🔗 TAILSCALE MENU"
echo "1) 📥 Install"
echo "2) 🚀 Connect"
echo "3) 🗑 Uninstall"
echo "0) 🔙 Back"
echo -e "${NC}"

read -p "Select: " t

case $t in
1)
curl -fsSL https://tailscale.com/install.sh | sh
ok "Installed"
;;
2)
tailscale up
ok "Connected"
;;
3)
sudo rm -rf /usr/bin/tailscale
ok "Removed"
;;
0) break ;;
*) err "Invalid" ;;
esac
pause
done
}

# ================= BLUEPRINT =================
blueprint(){
while true; do
clear
echo "🧩 BLUEPRINT MENU"
echo "1) 📥 Install"
echo "2) 🗑 Remove"
echo "0) Back"

read -p "Select: " b

case $b in
1)
mkdir -p "$BASE"
echo "active" > "$BASE/blueprint.txt"
ok "Installed"
;;
2)
rm -f "$BASE/blueprint.txt"
ok "Removed"
;;
0) break ;;
*) err "Invalid" ;;
esac
pause
done
}

# ================= THEME =================
theme(){
while true; do
clear
echo "🎨 THEME MENU"
echo "1) 🌑 Dark"
echo "2) 💜 Neon"
echo "3) 👑 Royal"
echo "0) Back"

read -p "Select: " t

case $t in
1) echo "dark" > "$BASE/theme.txt"; ok "Dark" ;;
2) echo "neon" > "$BASE/theme.txt"; ok "Neon" ;;
3) echo "royal" > "$BASE/theme.txt"; ok "Royal" ;;
0) break ;;
*) err "Invalid" ;;
esac
pause
done
}

# ================= PANEL =================
panel(){
while true; do
clear
echo "🩺 PANEL MENU"
echo "1) 📥 Install"
echo "2) 🗑 Remove"
echo "0) Back"

read -p "Select: " p

case $p in
1)
echo "doctor" > "$BASE/panel.txt"
ok "Installed"
;;
2)
rm -f "$BASE/panel.txt"
ok "Removed"
;;
0) break ;;
*) err "Invalid" ;;
esac
pause
done
}

# ================= WINGS =================
wings(){
while true; do
clear
echo "🪽 WINGS MENU"
echo "1) 📥 Install"
echo "2) 🗑 Remove"
echo "0) Back"

read -p "Select: " w

case $w in
1)
cat > "$BASE/wings.yml" <<EOF
debug: false
token: RRS9
api:
  host: 0.0.0.0
  port: 8080
EOF
ok "Installed"
;;
2)
rm -f "$BASE/wings.yml"
ok "Removed"
;;
0) break ;;
*) err "Invalid" ;;
esac
pause
done
}

# ================= MC TOOLS =================
mc(){
while true; do
clear
echo "🎮 MC TOOLS MENU"
echo "1) 📥 Install"
echo "2) 🗑 Remove"
echo "0) Back"

read -p "Select: " m

case $m in
1)
echo "mc tools active" > "$BASE/mc.txt"
ok "Installed"
;;
2)
rm -f "$BASE/mc.txt"
ok "Removed"
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

echo -e "${PURPLE}"
echo "👑═══════════════════════════════👑"
echo "       🌈 RRS 9 ROYAL PANEL"
echo "👑═══════════════════════════════👑"
echo -e "${NC}"

echo "☁️ 1) Cloudflare"
echo "🔗 2) Tailscale"
echo "🧩 3) Blueprint"
echo "🎨 4) Theme"
echo "🩺 5) Panel"
echo "🪽 6) Wings"
echo "🎮 7) MC Tools"
echo "0) ❌ Exit"

read -p "👉 Select: " opt

case $opt in
1) cloudflare ;;
2) tailscale ;;
3) blueprint ;;
4) theme ;;
5) panel ;;
6) wings ;;
7) mc ;;
0) exit ;;
*) err "Invalid Option" ;;
esac

pause
done
