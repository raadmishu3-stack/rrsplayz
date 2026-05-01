#!/bin/bash
set -e

# ===== ROOT CHECK =====
if [ "$EUID" -ne 0 ]; then
  echo "❌ Run as root"
  exit
fi

# ===== COLORS =====
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

# ===== HEADER =====
clear
echo -e "${CYAN}🚀 RRSOFFICIALS CONTROL PANEL${NC}"
echo

# ===== MENU LOOP =====
while true; do
echo -e "${YELLOW}=========== MENU ===========${NC}"
echo "1) Install Panel"
echo "2) Install Wings"
echo "3) Install Cloudflare Tunnel"
echo "4) Install Tailscale"
echo "5) Install Blueprint"
echo "6) Install Nebula Theme"
echo "7) Install Minecraft Tools"
echo "0) Exit"
echo

read -p "👉 Choose option: " opt

case $opt in

1)
echo -e "${GREEN}📦 Installing Panel...${NC}"
bash <(curl -s https://pterodactyl-installer.se)
;;

2)
echo -e "${GREEN}📦 Installing Wings...${NC}"
bash <(curl -s https://pterodactyl-installer.se)
;;

3)
echo -e "${BLUE}🌐 Installing Cloudflare Tunnel...${NC}"
curl -fsSL https://developers.cloudflare.com/cloudflare-one/static/documentation/connections/connect-apps/install-and-setup/installation/linux.sh | bash
;;

4)
echo -e "${CYAN}🔐 Installing Tailscale...${NC}"
curl -fsSL https://tailscale.com/install.sh | sh
tailscale up
;;

5)
echo -e "${YELLOW}🧩 Installing Blueprint...${NC}"
bash <(curl -s https://raw.githubusercontent.com/BlueprintFramework/installer/main/install.sh)
;;

6)
echo -e "${GREEN}🎨 Installing Nebula Theme...${NC}"
bash <(curl -s https://raw.githubusercontent.com/Nebula-Theme/pterodactyl/main/install.sh)
;;

7)
echo -e "${CYAN}🎮 Installing Minecraft Tools...${NC}"
mkdir -p /home/mc-tools
cd /home/mc-tools
git clone https://github.com/Pterodactyl-Panel/egg-minecraft.git
echo -e "${GREEN}✔ Done${NC}"
;;

0)
echo -e "${RED}👋 Exit...${NC}"
exit
;;

*)
echo -e "${RED}❌ Invalid option${NC}"
;;

esac

echo
read -p "Press Enter to continue..."
clear
done
