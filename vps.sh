##!/bin/bash
set -e

# =============================
# 🚀 RRS OFFICIAL VPS PANEL
# =============================

# 🎨 COLORS
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

# 📁 BASE FOLDER
BASE="$HOME/rrs-panel"
BOTS="$BASE/bots"
TOOLS="$BASE/tools"
THEMES="$BASE/themes"

mkdir -p "$BOTS" "$TOOLS" "$THEMES"

# ================= HEADER =================
header() {
    clear
    echo -e "${CYAN}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🚀 RRS OFFICIAL VPS PANEL"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${PURPLE}1️⃣ VPS Info"
    echo -e "2️⃣ 🤖 Bot Manager"
    echo -e "${BLUE}3️⃣ 🌐 Cloudflare Info"
    echo -e "4️⃣ 🎨 Theme Selector"
    echo -e "${YELLOW}5️⃣ 📘 Blueprint Info"
    echo -e "6️⃣ 🛠 Minecraft Tools"
    echo -e "7️⃣ 🤖 Discord Bot Info"
    echo -e "8️⃣ 🧩 Tools Menu"
    echo -e "${RED}0️⃣ Exit"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${NC}"
}

# ================= STATUS =================
info(){ echo -e "${BLUE}ℹ️ $1${NC}"; }
ok(){ echo -e "${GREEN}✔ $1${NC}"; }
warn(){ echo -e "${YELLOW}⚠ $1${NC}"; }
error(){ echo -e "${RED}❌ $1${NC}"; }

# ================= VPS INFO =================
vps_info() {
    echo -e "${CYAN}📊 VPS INFORMATION${NC}"
    uname -a
    echo ""
    free -h
    echo ""
    df -h
}

# ================= BOT MANAGER =================
bot_menu() {
    echo "🤖 BOT MANAGER"
    echo "1) Create Bot"
    echo "2) Delete Bot"
    echo "3) List Bots"
    read -p "Select: " c

    case $c in
        1)
            read -p "Bot name: " n
            mkdir -p "$BOTS/$n"
            echo "console.log('Bot $n running')" > "$BOTS/$n/index.js"
            ok "Bot created ✔"
            ;;
        2)
            read -p "Bot name: " n
            rm -rf "$BOTS/$n"
            ok "Bot deleted ✔"
            ;;
        3)
            ls "$BOTS"
            ;;
    esac
}

# ================= CLOUDFLARE =================
cloudflare_menu() {
    echo -e "${BLUE}🌐 CLOUDFLARE GUIDE${NC}"
    echo "✔ Add domain to Cloudflare"
    echo "✔ Change nameservers"
    echo "✔ Enable proxy (orange cloud)"
    echo ""
    info "No auto-install allowed — manual setup required"
}

# ================= THEMES =================
theme_menu() {
    echo "🎨 THEMES"
    echo "1) 🌌 Nebula"
    echo "2) 🌑 Dark"
    echo "3) 📘 Blueprint"

    read -p "Select: " t

    case $t in
        1) ok "Nebula theme selected 🌌" ;;
        2) ok "Dark theme selected 🌑" ;;
        3) ok "Blueprint theme selected 📘" ;;
        *) error "Invalid option" ;;
    esac
}

# ================= BLUEPRINT =================
blueprint_menu() {
    echo "📘 BLUEPRINT INFO"
    echo "✔ Web UI structure design"
    echo "✔ Dashboard concept"
    echo "✔ Plugin system idea"
    echo "✔ API system architecture"
}

# ================= MINECRAFT =================
mc_menu() {
    echo "🛠 MINECRAFT TOOLS"
    echo "1) server.properties info"
    echo "2) plugin folder guide"
    echo "3) player manager info"

    read -p "Select: " c

    case $c in
        1) info "Edit server.properties manually" ;;
        2) info "Put .jar files inside plugins folder" ;;
        3) info "Use LuckPerms plugin for players" ;;
    esac
}

# ================= DISCORD BOT =================
discord_menu() {
    echo "🤖 DISCORD BOT"
    echo "✔ Install: npm install discord.js"
    echo "✔ Token must be added manually in code"
}

# ================= TOOLS =================
tools_menu() {
    echo "🧩 TOOLS"
    echo "1) Register System"
    echo "2) Player Manager"
    echo "3) MC Properties View"

    read -p "Select: " t

    case $t in
        1) info "Register system = plugin based system" ;;
        2) info "Use LuckPerms plugin" ;;
        3) cat server.properties 2>/dev/null || warn "File not found" ;;
    esac
}

# ================= MAIN LOOP =================
while true; do
    header
    read -p "👉 Select option: " opt

    case $opt in
        1) vps_info ;;
        2) bot_menu ;;
        3) cloudflare_menu ;;
        4) theme_menu ;;
        5) blueprint_menu ;;
        6) mc_menu ;;
        7) discord_menu ;;
        8) tools_menu ;;
        0) echo "👋 Exit"; exit ;;
        *) error "Invalid option" ;;
    esac

    echo ""
    read -p "Press Enter..."
done
