#!/usr/bin/env bash
set -e

clear

echo "===================================="
echo "      🚀 RRSOFFICIALS VPS SETUP"
echo "===================================="
echo ""
echo "Developer: RRSOFFICIALS"
echo "Starting setup..."
echo ""

sleep 2

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y curl wget git unzip nano screen

echo ""
echo "===================================="
echo "   ✅ VPS READY - RRSOFFICIALS"
echo "===================================="
