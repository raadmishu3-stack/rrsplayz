#!/usr/bin/env bash
# ==========================================
#        🚀 RRSOFFICIALS PANEL 🚀
# ==========================================

set -u

# --- ANSI COLORS ---
C=$'\033[36m'  # Cyan
G=$'\033[32m'  # Green
R=$'\033[31m'  # Red
B=$'\033[34m'  # Blue
Y=$'\033[33m'  # Yellow
W=$'\033[97m'  # White
N=$'\033[0m'   # Reset

# --- HEADER FUNCTION ---
header() {
    clear
    echo -e "${B}╔══════════════════════════════════════════════╗${N}"
    echo -e "${B}║        🚀  R R S  O F F I C I A L S  🚀       ║${N}"
    echo -e "${B}╚══════════════════════════════════════════════╝${N}"
    echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
    echo -e "${Y}🔥  POWERED BY RRplayz64 🔥${N}"
    echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
    echo ""
}

# --- PAUSE FUNCTION ---
pause() {
    echo ""
    read -p "${W}⏸️  Press [Enter] to return to menu...${N}" dummy
}

# --- MAIN LOOP ---
while true; do
    header

    echo -e "${C} 1️⃣  ${W}Dependency Installer ${G}(Node + Mineflayer)${N}"
    echo -e "${C} 2️⃣  ${W}Bot Maker ${G}(Create app.js)${N}"
    echo -e "${C} 3️⃣  ${W}Auto Restarter Setup ${G}(Systemd Service)${N}"
    echo -e "${C} 4️⃣  ${W}Bot Remover ${G}(Manager)${N}"
    echo -e "${C} 5️⃣  ${W}Discord Server Link 💬${N}"
    echo -e "${C} 6️⃣  ${W}YouTube Channel Link 📺${N}"
    echo -e "${C} 7️⃣  ${W}VM Installer ${G}(IDX VPS) 💻${N}"
    echo -e "${C} 8️⃣  ${W}RDP Installer ${G}(Desktop Environment) 🖥️${N}"
    echo -e "${C} 9️⃣  ${W}Tailscale Installer ${G}(VPN) 🌐${N}"
    echo -e "${R} 🔟 Exit ❌${N}"

    echo ""
    echo -e "${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
    read -p "${Y}👉 Select an option [1-10]: ${N}" choice

    case $choice in
        1)
            echo -e "${Y}🔄 Installing Dependencies...${N}"
            curl -fsSL https://raw.githubusercontent.com/Sagargamin/INSTALLER-REPO/main/dependency.sh | bash
            pause
            ;;
        2)
            echo -e "${Y}🛠️  Running Bot Maker...${N}"
            curl -fsSL https://raw.githubusercontent.com/Sagargamin/INSTALLER-REPO/main/bot_maker.sh | bash
            pause
            ;;
        3)
            echo -e "${Y}⚙️  Setting Auto Restart...${N}"
            curl -fsSL https://raw.githubusercontent.com/Sagargamin/INSTALLER-REPO/main/autorestarter.sh | bash
            pause
            ;;
        4)
            echo -e "${Y}🗑️  Removing Bot...${N}"
            curl -fsSL https://raw.githubusercontent.com/Sagargamin/INSTALLER-REPO/main/bot_remover.sh | bash
            pause
            ;;
        5)
            echo -e "${B}💬 Discord Server:${N}"
            echo -e "${G}🔗 https://discord.gg/ZAAyrb4J6s${N}"
            pause
            ;;
        6)
            echo -e "${R}📺 YouTube Channel:${N}"
            echo -e "${Y}🔗 https://www.youtube.com/@OfficialNotGamerPie${N}"
            pause
            ;;
        7)
            echo -e "${Y}💻 Installing VPS (IDX)...${N}"
            bash <(curl -fsSL https://raw.githubusercontent.com/raadmishu3-stack/yt1/main/vps.sh)
            pause
            ;;
        😎
            echo -e "${Y}🖥️  Installing RDP...${N}"
            curl -fsSL https://raw.githubusercontent.com/Sagargamin/INSTALLER-REPO/main/rdp_installer.sh | bash
            pause
            ;;
        9)
            echo -e "${Y}🌐 Installing Tailscale VPN...${N}"
            curl -fsSL https://tailscale.com/install.sh | sh
            pause
            ;;
        10)
            echo -e "${G}👋 Exiting...${N}"
            exit 0
            ;;
        *)
            echo -e "${R}❌ Invalid Option!${N}"
            sleep 2
            ;;
    esac
done
