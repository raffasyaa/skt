#!/bin/bash
clear

# Define color variables for output
Green="\e[92;1m"
RED="\033[1;31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PINK='\033[0;35m'
INDIGO='\033[38;5;54m'
CYAN_BG='\033[46;1;97m'
TEAL='\033[38;5;30m'
ORANGE='\033[38;5;208m'
BLUELIGHT='\033[38;5;117m'
PURPLE='\033[0;35m'

# Instalasi dependensi
apt install jq curl -y

# Menyiapkan direktori
rm -rf /root/xray/scdomain
mkdir -p /root/xray

clear
  echo ""
  echo -e "${TEAL} ╭──────────────────────────────────────────────┐${NC}"
  echo -e "${TEAL} │           ❐ ${YELLOW}Starting Configuration${NC} ${TEAL}❐         │${NC}"
  echo -e "${TEAL} ╰──────────────────────────────────────────────┘${NC}"
  echo ""

# Fungsi untuk memeriksa apakah subdomain sudah ada
check_subdomain_exists() {
    local subdomain=$1
    local zone_id=$2
    local cf_id=$3
    local cf_key=$4

    local exists=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${zone_id}/dns_records?name=${subdomain}" \
        -H "X-Auth-Email: ${cf_id}" \
        -H "X-Auth-Key: ${cf_key}" \
        -H "Content-Type: application/json" | jq -r .result[0].id)

    if [[ "${#exists}" -gt 10 ]]; then
        return 0  # Subdomain ada
    else
        return 1  # Subdomain tidak ada
    fi
}

# Konstanta
DOMAIN="skartissh.online"
CF_ID="skartistore@gmail.com"
CF_KEY="f85902ca3abd71622dbc250f4e38afad434df"

# Mendapatkan Zone ID
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
    -H "X-Auth-Email: ${CF_ID}" \
    -H "X-Auth-Key: ${CF_KEY}" \
    -H "Content-Type: application/json" | jq -r .result[0].id)

# Membuat subdomain acak dan memeriksa apakah sudah ada
while true; do
    sub=$(</dev/urandom tr -dc a-z0-9 | head -c3)
    SUB_DOMAIN="${sub}.${DOMAIN}"
    
    if check_subdomain_exists "${SUB_DOMAIN}" "${ZONE}" "${CF_ID}" "${CF_KEY}"; then
        echo " ❐ Subdomain ${SUB_DOMAIN} sudah ada. Membuat subdomain baru..."
    else
        break
    fi
done

set -euo pipefail

# Mendapatkan IP publik
IP=$(curl -sS ifconfig.me)

echo "Memperbarui DNS untuk ${SUB_DOMAIN}..."

# Membuat record DNS
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
    -H "X-Auth-Email: ${CF_ID}" \
    -H "X-Auth-Key: ${CF_KEY}" \
    -H "Content-Type: application/json" \
    --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)

# Menyimpan informasi subdomain
echo "$SUB_DOMAIN" > /root/domain
echo "$SUB_DOMAIN" > /root/scdomain
echo "$SUB_DOMAIN" > /etc/xray/domain
echo "$SUB_DOMAIN" > /etc/v2ray/domain
echo "$SUB_DOMAIN" > /etc/xray/scdomain
echo "IP=$SUB_DOMAIN" > /var/lib/phreakers/ipvps.conf

# Membersihkan file sementara
rm -rf cf
sleep 1

echo "Konfigurasi domain selesai."
