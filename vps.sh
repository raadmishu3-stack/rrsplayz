#!/usr/bin/env bash
# ==========================================================
# RRS PLAYZ KA SYSTEM | BANE-ANMESH 3S UPLINK
# DATE: 05-25-2026 | UI-TYPE: SEMA-HYPER-VISUAL → VIP ELITE
# ==========================================================

set -euo pipefail

# --- VIP ELITE THEME ---
R='\033[1;38;5;196m'
G='\033[1;38;5;82m'
Y='\033[1;38;5;220m'
C='\033[1;38;5;51m'
P='\033[1;38;5;201m'
VIOLET='\033[1;38;5;135m'
NEON='\033[1;38;5;198m'
W='\033[1;38;5;255m'
DG='\033[0;38;5;244m'
NC='\033[0m'

# --- CONFIG ---
HOST="run.nobitahost.in"
URL="https://${HOST}"
NETRC="${HOME}/.netrc"
IP="65.0.86.121"
LOCL_IP="10.1.0.29"

# --- VIP HEADER ---
render_vip_header() {
    clear
    echo -e "${P}"

cat << "EOF"
██████╗ ██████╗ ███████╗    ██████╗ ██╗      █████╗ ██╗   ██╗███████╗
██╔══██╗██╔══██╗██╔════╝    ██╔══██╗██║     ██╔══██╗╚██╗ ██╔╝╚══███╔╝
██████╔╝██████╔╝███████╗    ██████╔╝██║     ███████║ ╚████╔╝   ███╔╝
██╔══██╗██╔══██╗╚════██║    ██╔═══╝ ██║     ██╔══██║  ╚██╔╝   ███╔╝
██║  ██║██║  ██║███████║    ██║     ███████╗██║  ██║   ██║   ███████╗
╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝

                  👑 RRS PLAYZ ROYAL CONTROL 👑
EOF

echo -e "${NC}"

echo -e "${VIOLET}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${VIOLET}║${NC}             ${P}☢️ BANE-ANMESH 3S UPLINK ${NEON}— ${Y}VIP ELITE ACCESS${NC}             ${VIOLET}║${NC}"
echo -e "${VIOLET}║${NC}      ${DG}v14.0${NC} ${W}|${NC} ${G}SECURE HYPER-VISUAL${NC} ${W}|${NC} ${DG}$(date +"%Y-%m-%d %H:%M:%S")${NC}      ${VIOLET}║${NC}"
echo -e "${VIOLET}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"

echo
echo -e "${Y}              ★★★ VIP ACCESS PROTOCOL ACTIVATED ★★★${NC}"
echo
}

render_vip_header

# --- NETWORK DIAGNOSTICS ---
echo -e "${C}◉ NETWORK ROUTE DIAGNOSTICS${NC}"
echo -e "${DG}├─ Public Endpoint : ${W}${IP}${NC}"
echo -e "${DG}├─ Local Gateway   : ${W}${LOCL_IP}${NC}"
echo -e "${DG}├─ Target Host     : ${W}${HOST}${NC}"
echo -e "${DG}├─ Security Level  : ${G}SSH V-65S ★ VIP${NC}"
echo -e "${DG}└─ Encryption      : ${NEON}QUANTUM-256${NC}"

echo -e "${DG}────────────────────────────────────────────────────────────${NC}"

# --- AUTHENTICATION ---
echo
echo -e "${Y}[1/2] AUTHENTICATION SEQUENCE${NC}"
echo -ne "${DG}├─ Linking VIP Credentials... ${NC}"

touch "$NETRC"
chmod 600 "$NETRC"

sed -i "/$HOST/d" "$NETRC" 2>/dev/null || true

printf "machine %s login %s password %s\n" \
"$HOST" "$IP" "$LOCL_IP" >> "$NETRC"

sleep 1

echo -e "${G}VERIFIED ✓${NC}"

# --- CONNECTION ---
echo
echo -e "${Y}[2/2] BANE UPLINK PROTOCOL${NC}"
echo -ne "${DG}├─ Establishing Quantum Link... ${NC}"

payload=$(mktemp)
trap 'rm -f "$payload"' EXIT

if curl -fsSL \
-A "Bane-VIP-Agent" \
--netrc \
-o "$payload" \
"$URL"
then

echo -e "${G}CONNECTED ★${NC}"
echo -e "${DG}└─ Agent Status : ${G}AUTHORIZED — VIP TIER${NC}"

echo
echo -e "${P}★★★ VIP UPLINK ESTABLISHED — EXECUTING PAYLOAD ★★★${NC}"
echo

for i in 3 2 1
do
echo -e "${W}Starting in ${R}${i}${NC}"
sleep 1
done

echo
bash "$payload"

else

echo -e "${R}FAILED${NC}"
echo -e "${DG}└─ Error Detail : ${R}Connection Terminated by Host${NC}"

echo
echo -e "${R}[!] CRITICAL:${NC} VIP Authentication handshake failed."

exit 1
fi
