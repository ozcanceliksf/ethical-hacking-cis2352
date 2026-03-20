#!/bin/bash
# ============================================================
# nmap_scan.sh — Network Reconnaissance Script
# Author: Ozcan Celik | Ethical Hacking CIS2352
# ============================================================

TARGET=$1
OUTPUT_DIR="./scan_results"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

if [ -z "$TARGET" ]; then
  echo "[!] Usage: ./nmap_scan.sh <target_ip_or_range>"
  echo "    Example: ./nmap_scan.sh 192.168.1.0/24"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

echo "[*] Starting reconnaissance on: $TARGET"
echo "[*] Timestamp: $TIMESTAMP"
echo "-------------------------------------------"

# 1. Host Discovery
echo "[*] Phase 1: Host Discovery"
nmap -sn "$TARGET" -oN "$OUTPUT_DIR/host_discovery_$TIMESTAMP.txt"

# 2. Port Scan
echo "[*] Phase 2: Port Scan (Top 1000 ports)"
nmap -sV -sC --top-ports 1000 "$TARGET" -oN "$OUTPUT_DIR/port_scan_$TIMESTAMP.txt"

# 3. OS Detection
echo "[*] Phase 3: OS Detection"
nmap -O "$TARGET" -oN "$OUTPUT_DIR/os_detection_$TIMESTAMP.txt"

# 4. Vulnerability Scan
echo "[*] Phase 4: Vulnerability Scripts"
nmap --script vuln "$TARGET" -oN "$OUTPUT_DIR/vuln_scan_$TIMESTAMP.txt"

echo "-------------------------------------------"
echo "[+] Scan complete. Results saved to: $OUTPUT_DIR"
