#!/bin/bash

# Install dependencies
apt install jq curl -y

# Setup directories
rm -rf /root/xray/scdomain
mkdir -p /root/xray

clear
echo ""
echo ""
echo ""

# Function to check if the subdomain exists
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
        return 0  # Subdomain exists
    else
        return 1  # Subdomain does not exist
    fi
}

# Set constants
DOMAIN=24clan.com
CF_ID=farukbrowser0@gmail.com
CF_KEY=95b295f79baa8c7a3c264ca5cc31b75131c6d

# Get zone ID
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)

# Generate random subdomain and check if it exists
while true; do
    sub=$(</dev/urandom tr -dc a-z0-9 | head -c3)
    SUB_DOMAIN=${sub}.${DOMAIN}
    if check_subdomain_exists "${SUB_DOMAIN}" "${ZONE}" "${CF_ID}" "${CF_KEY}"; then
        echo "Subdomain ${SUB_DOMAIN} already exists. Generating a new one..."
    else
        break
    fi
done

set -euo pipefail

# Get public IP
IP=$(curl -sS ifconfig.me)

echo "Updating DNS for ${SUB_DOMAIN}..."

# Create DNS record
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)

# Save subdomain information
echo "$SUB_DOMAIN" > /root/domain
echo "$SUB_DOMAIN" > /root/scdomain
echo "$SUB_DOMAIN" > /etc/xray/domain
echo "$SUB_DOMAIN" > /etc/v2ray/domain
echo "$SUB_DOMAIN" > /etc/xray/scdomain
echo "IP=$SUB_DOMAIN" > /var/lib/kyt/ipvps.conf

# Cleanup
rm -rf cf
sleep 1
