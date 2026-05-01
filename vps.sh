#!/bin/bash
set -e

# =============================
# 🚀 RRS VPS CONTROL PANEL
# =============================

# 🎨 COLORS
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

# ================= HEADER =================
header() {
clear
echo -e "${CYAN}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 RRS VPS CONTROL PANEL"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BLUE}1️⃣ VPS Install"
echo -e "${PURPLE}2️⃣ Windows Install"
echo -e "${CYAN}3️⃣ 🌐 Cloudflare Setup"
echo -e "${YELLOW}4️⃣ 🤖 Bot Manager"
echo -e "${GREEN}5️⃣ 🎨 Theme Selector"
echo -e "${BLUE}6️⃣ 📘 Blueprint Tools"
echo -e "${PURPLE}7️⃣ 🛠 Minecraft Tools"
echo -e "${YELLOW}8️⃣ 🤖 Discord Bot Info"
echo -e "${CYAN}9️⃣ 🧩 Tealsceal Install"
echo -e "${RED}0️⃣ Exit"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${NC}"
}

# ================= STATUS =================
info(){ echo -e "${BLUE}ℹ️ $1${NC}"; }
ok(){ echo -e "${GREEN}✔ $1${NC}"; }
warn(){ echo -e "${YELLOW}⚠ $1${NC}"; }

# ================= VPS INSTALL =================
vps_install() {
echo "🚀 VPS INSTALL GUIDE"
echo "----------------------"
echo "sudo apt update"
echo "sudo apt upgrade -y"
echo "install git, curl, wget"
echo ""
info "Manual setup required"
}

# ================= WINDOWS INSTALL =================
windows_install() {
echo "🪟 WINDOWS INSTALL ON VPS"
echo "----------------------"
echo "Use QEMU/KVM"
echo "ISO required (Windows)"
echo "Minimum RAM: 4GB"
echo ""
info "No auto install allowed"
}

# ================= CLOUDFLARE =================
cloudflare_setup() {
echo "🌐 CLOUDFLARE SETUP"
echo "----------------------"
echo "1. Add domain"
echo "2. Change nameservers"
echo "3. Enable proxy (orange cloud)"
echo "4. SSL → Full"
}

# ================= BOT =================
bot_menu() {
echo "🤖 BOT MANAGER"
echo "1) Create Bot"
echo "2) Delete Bot"
read -p "Select: " c

case $c in
1)
read -p "Bot name: " n
mkdir -p bots/$n
echo "console.log('Bot $n running')" > bots/$n/index.js
ok "Bot created"
;;
2)
read -p "Bot name: " n
rm -rf bots/$n
ok "Bot deleted"
;;
esac
}

# ================= THEME =================
theme_menu() {
echo "🎨 THEMES"
echo "1) 🌌 Nebula"
echo "2) 🌑 Dark"
read -p "Select: " t

case $t in
1) ok "Nebula theme selected 🌌" ;;
2) ok "Dark theme selected 🌑" ;;
esac
}

# ================= BLUEPRINT =================
blueprint_menu() {
echo "📘 BLUEPRINT SYSTEM"
echo "----------------------"
echo "✔ Dashboard UI concept"
echo "✔ API system design"
echo "✔ Plugin architecture"
}

# ================= MINECRAFT =================
mc_menu() {
echo "🛠 MINECRAFT TOOLS"
echo "----------------------"
echo "✔ plugins folder"
echo "✔ server.properties"
echo "✔ LuckPerms system"
}

# ================= DISCORD BOT =================
discord_menu() {
echo "🤖 DISCORD BOT"
echo "----------------------"
echo "Install: npm install discord.js"
echo "Token must be added manually"
}

# ================= TEAL SCEAL INSTALL =================
tealsceal_install() {
echo "🧩 TEALSCEAL INSTALL"
echo "----------------------"

BASE="$HOME/tealsceal"
mkdir -p "$BASE"/{core,ui,security,plugins}

echo "Creating system..."

cat > "$BASE/core/config.sh" <<EOF
SYSTEM_NAME=Tealsceal
VERSION=1.0
SECURITY=HIGH
EOF

cat > "$BASE/security/auth.sh" <<EOF
#!/bin/bash
echo "🔐 Login System Active"
EOF

chmod +x "$BASE/security/auth.sh"

ok "Tealsceal installed at $BASE"
}

# ================= MAIN LOOP =================
while true; do
header
read -p "👉 Select option: " opt

case $opt in
1) vps_install ;;
2) windows_install ;;
3) cloudflare_setup ;;
4) bot_menu ;;
5) theme_menu ;;
6) blueprint_menu ;;
7) mc_menu ;;
8) discord_menu ;;
9) tealsceal_install ;;
0) echo "👋 Exit"; exit ;;
*) echo "❌ Invalid option" ;;
esac

echo ""
read -p "Press Enter..."
done
