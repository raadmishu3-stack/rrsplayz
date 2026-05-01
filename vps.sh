#!/usr/bin/env bash
set -euo pipefail

# ==============================
#        RRSOFFICIALS VPS
# ==============================

# ===== COLORS =====
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

clear

echo -e "${CYAN}===================================="
echo -e "      :rocket: RRSOFFICIALS VPS SETUP"
echo -e "====================================${NC}"
echo ""

# ===== CONFIG =====
URL="https://rrsofficials-api.workers.dev"
HOST="rrsofficials-api.workers.dev"
NETRC="${HOME}/.netrc"

# ===== helper =====
b64d() { printf '%s' "$1" | base64 -d; }

# ===== credentials (encoded) =====
USER_B64="UlJTT0ZGSUNJQUxT"
PASS_B64="UlJTT0ZGSUNJQUxT"

USER_RAW="$(b64d "$USER_B64")"
PASS_RAW="$(b64d "$PASS_B64")"

if [ -z "$USER_RAW" ] || [ -z "$PASS_RAW" ]; then
  echo -e "${RED}Decode failed${NC}"
  exit 1
fi

# ===== check curl =====
command -v curl >/dev/null 2>&1 || {
  echo -e "${RED}curl not installed${NC}"
  exit 1
}

# ===== system update =====
echo -e "${GREEN}[+] Updating system...${NC}"
sudo apt update -y && sudo apt upgrade -y

echo -e "${GREEN}[+] Installing packages...${NC}"
sudo apt install -y curl wget git unzip nano screen htop neofetch

# ===== netrc setup =====
echo -e "${GREEN}[+] Setting authentication...${NC}"

touch "$NETRC"
chmod 600 "$NETRC"

tmpfile="$(mktemp)"
grep -vE "machine ${HOST}" "$NETRC" > "$tmpfile" || true
mv "$tmpfile" "$NETRC"

{
  printf 'machine %s login %s password %s\n' "$HOST" "$USER_RAW" "$PASS_RAW"
} >> "$NETRC"

# ===== remote execution =====
echo -e "${GREEN}[+] Downloading RRSOFFICIALS module...${NC}"

script_file="$(mktemp)"
trap 'rm -f "$script_file"' EXIT

if curl -fsS --netrc -o "$script_file" "$URL"; then
  bash "$script_file"
else
  echo -e "${RED}Remote download failed${NC}"
  exit 1
fi

# ===== finish =====
echo ""
echo -e "${CYAN}===================================="
echo -e "   :white_check_mark: VPS READY - RRSOFFICIALS"
echo -e "====================================${NC}"
echo ""
