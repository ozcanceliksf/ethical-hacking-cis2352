#!/bin/bash
# ============================================================
# enum.sh — Basic System & Network Enumeration Script
# Author: Ozcan Celik | Ethical Hacking CIS2352
# ============================================================

TARGET=$1

if [ -z "$TARGET" ]; then
  echo "[!] Usage: ./enum.sh <target_ip>"
  exit 1
fi

echo "============================================"
echo " ENUMERATION — $TARGET"
echo " $(date)"
echo "============================================"

# Banner Grabbing
echo ""
echo "[*] Banner Grabbing (ports 21, 22, 80, 443)"
for PORT in 21 22 80 443; do
  echo "[+] Port $PORT:"
  timeout 3 bash -c "echo '' | nc -w 2 $TARGET $PORT 2>/dev/null" || echo "    closed/filtered"
done

# HTTP Headers
echo ""
echo "[*] HTTP Headers"
curl -sI "http://$TARGET" 2>/dev/null | head -20 || echo "    No HTTP response"

# DNS Lookup
echo ""
echo "[*] DNS Lookup"
nslookup "$TARGET" 2>/dev/null || host "$TARGET" 2>/dev/null

# Whois
echo ""
echo "[*] Whois"
whois "$TARGET" 2>/dev/null | grep -E "NetName|OrgName|Country|CIDR" | head -10

echo ""
echo "[+] Enumeration complete."
