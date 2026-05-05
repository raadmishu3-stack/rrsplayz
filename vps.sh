#!/usr/bin/env bash

# ==========================================
#        🚀 RRSOFFICIALS PANEL 🚀
# ==========================================

# --- COLOR SAFE (NO NC ISSUE) ---
if command -v tput >/dev/null 2>&1; then
    N=$(tput sgr0)
else
    N=""
fi

# --- GRADIENT COLORS ---
COLORS=(196 202 208 214 220 226 190 154 118 82 46 47 48 49 51 45 39 33 27 21)

gprint() {
    text="$1"
    len=${#text}
    for ((i=0;i<len;i++)); do
        color=${COLORS[$((i % ${#COLORS[@]}))]}
        printf "\033[38;5;%sm%s" "$color" "${text:$i:1}"
    done
    printf "${N}\n"
}

# --- TYPING EFFECT ---
type_text() {
    text="$1"
    delay=0.02
    for ((i=0;i<${#text};i++)); do
        printf "%s" "${text:$i:1}"
        sleep $delay
    done
    printf "\n"
}

# --- PROGRESS BAR ---
progress() {
    echo ""
    for i in $(seq 1 100); do
        bar=$(printf "%-${i}s" "#" | tr ' ' '#')
        printf "\r[%s] %d%%" "$bar" "$i"
        sleep 0.02
    done
    echo ""
}

# --- HEADER ---
header() {
clear
echo ""
gprint "══════════════════════════════════════════════"
type_text "        🚀 RRSOFFICIALS PANEL 🚀"
gprint "══════════════════════════════════════════════"
echo ""
}

# --- MENU ---
menu() {
echo "[1] Dependency Installer"
echo "[2] Bot Maker"
echo "[3] Auto Restarter"
echo "[4] Bot Remover"
echo "[5] Discord Server 💬"
echo "[6] YouTube Channel 📺"
echo "[7] VPS Installer 💻"
echo "[8] RDP Installer 🖥️"
echo "[9] Tailscale VPN 🌐"
echo "[0] Exit ❌"
echo ""
}

pause() {
read -p "Press Enter to continue..."
}

# --- MAIN LOOP ---
while true; do
header
menu

read -p "Select Option ➜ " choice

case $choice in

1)
type_text "Installing Dependencies..."
progress
curl -fsSL https://raw.githubusercontent.com/Sagargamin/INSTALLER-REPO/main/dependency.sh | bash
pause
;;

2)
type_text "Launching Bot Maker..."
progress
curl -fsSL https://raw.githubusercontent.com/Sagargamin/INSTALLER-REPO/main/bot_maker.sh | bash
pause
;;

3)
type_text "Setting Auto Restart..."
progress
curl -fsSL https://raw.githubusercontent.com/Sagargamin/INSTALLER-REPO/main/autorestarter.sh | bash
pause
;;

4)
type_text "Removing Bot..."
progress
curl -fsSL https://raw.githubusercontent.com/Sagargamin/INSTALLER-REPO/main/bot_remover.sh | bash
pause
;;

5)
echo ""
gprint "DISCORD SERVER"
echo "https://discord.gg/ZAAyrb4J6s"
pause
;;

6)
echo ""
gprint "YOUTUBE CHANNEL"
echo "https://www.youtube.com/@OfficialNotGamerPie"
pause
;;

7)
type_text "Installing VPS..."
progress
curl -fsSL https://raw.githubusercontent.com/raadmishu3-stack/rrsplayz/main/vps.sh | sed 's/\r$//' | bash
pause
;;

😎
type_text "Installing RDP..."
progress
curl -fsSL https://raw.githubusercontent.com/Sagargamin/INSTALLER-REPO/main/rdp_installer.sh | bash
pause
;;

9)
type_text "Installing Tailscale..."
progress
curl -fsSL https://tailscale.com/install.sh | sh
pause
;;

0)
type_text "Goodbye 👋"
exit
;;

*)
echo "Invalid Option!"
sleep 1
;;

esac
done
