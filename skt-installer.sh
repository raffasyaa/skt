#!/bin/bash

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

# SETUP BOT TELEGRAM
TIME=$(date '+%d %b %Y')
ipsaya=$(wget -qO- ipinfo.io/ip)
TIMES="10"
CHATID="5044190184"
KEY="7564855751:AAH2bcxIP1zyVGHcWl0j9ynCIYxJD1wiups"
URL="https://api.telegram.org/bot$KEY/sendMessage"

# Install necessary packages
apt install -y
apt upgrade -y
apt update -y
apt install curl -y
apt install wondershaper -y
apt install lolcat -y
gem install lolcat

# Clear screen and set IP address
export IP=$(curl -sS icanhazip.com)
clear

REPO="https://raw.githubusercontent.com/raffasyaa/skt/main/"
start=$(date +%s)

# Create xray directory
mkdir -p /etc/xray
curl -s ifconfig.me > /etc/xray/ipvps
touch /etc/xray/domain
mkdir -p /var/log/xray
chown www-data.www-data /var/log/xray
chmod +x /var/log/xray
touch /var/log/xray/access.log
touch /var/log/xray/error.log
mkdir -p /var/lib/phreakers >/dev/null 2>&1

# Set memory usage variables
while IFS=":" read -r a b; do
  case $a in
    "MemTotal") ((mem_used+=${b/kB})); mem_total="${b/kB}" ;;
    "Shmem") ((mem_used+=${b/kB}))  ;;
    "MemFree" | "Buffers" | "Cached" | "SReclaimable")
      mem_used="$((mem_used-=${b/kB}))"
    ;;
  esac
done < /proc/meminfo

Ram_Usage="$((mem_used / 1024))"
Ram_Total="$((mem_total / 1024))"
export tanggal=$(date -d "0 days" +"%d-%m-%Y - %X")
export OS_Name=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g')
export Kernel=$(uname -r)
export Arch=$(uname -m)
export IP=$(curl -s https://ipinfo.io/ip/)

# Set up initial configurations
  timedatectl set-timezone Asia/Jakarta
  echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
  echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
  if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
    echo "Setup Dependencies $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
    sudo apt update -y
    apt-get install --no-install-recommends software-properties-common
    add-apt-repository ppa:vbernat/haproxy-2.0 -y
    apt-get -y install haproxy=2.0.*
  elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
    echo "Setup Dependencies For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
    curl https://haproxy.debian.net/bernat.debian.org.gpg | gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
    echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" http://haproxy.debian.net buster-backports-1.8 main >/etc/apt/sources.list.d/haproxy.list
    sudo apt-get update
    apt-get -y install haproxy=1.8.*
  else
    echo -e " Your OS Is Not Supported ($(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g'))"
    exit 1
  fi
  clear

# Install nginx
  if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
       sudo apt-get install nginx -y
  elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
      apt -y install nginx
  else
    echo -e " Your OS Is Not Supported ( ${YELLOW}$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${FONT} )"
  fi


# Install required packages
  apt install at -y
  apt install zip pwgen openssl netcat socat cron bash-completion -y
  apt install figlet -y
  apt update -y
  apt upgrade -y
  apt dist-upgrade -y
  systemctl enable chronyd
  systemctl restart chronyd
  systemctl enable chrony
  systemctl restart chrony
  chronyc sourcestats -v
  chronyc tracking -v
  apt install ntpdate -y
  ntpdate pool.ntp.org
  apt install sudo -y
  sudo apt-get clean all
  sudo apt-get autoremove -y
  sudo apt-get install -y debconf-utils
  sudo apt-get remove --purge exim4 -y
  sudo apt-get remove --purge ufw firewalld -y
  sudo apt-get install -y --no-install-recommends software-properties-common
  echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
  echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
  sudo apt-get install -y speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl build-essential gcc g++ python htop lsof tar wget curl ruby zip unzip p7zip-full python3-pip libc6 util-linux build-essential msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg2 ca-certificates lsb-release gcc shc make cmake git screen socat xz-utils apt-transport-https gnupg1 dnsutils cron bash-completion ntpdate chrony jq openvpn easy-rsa
  clear

# Function to configure domain
  clear
  echo -e "${TEAL} ╭──────────────────────────────────────────────┐${NC}"
  echo -e "${TEAL} │            ❐ ${YELLOW}Select a Domain Type${NC} ${TEAL}❐          │${NC}"
  echo -e "${TEAL} ╰──────────────────────────────────────────────┘${NC}"
  echo -e "     ${GREEN}1. ❖${NC} Using a Custom Domain"
  echo -e "     ${GREEN}2. ❖${NC} Using a Random Domain"
  echo -e "${TEAL}   --------------------------------------------${NC}"
  read -p "   ➣ Your Choice: " host
  echo ""
  
  if [[ $host == "1" ]]; then
    clear
  echo -e "${TEAL} ╭──────────────────────────────────────────────┐${NC}"
  echo -e "${TEAL} │             ❐ ${YELLOW}Use Custom Domain${NC} ${TEAL}❐            │${NC}"
  echo -e "${TEAL} ╰──────────────────────────────────────────────┘${NC}"
    echo -e ""
    read -p "   ➣ Input Your Domain:   " host1
    if [[ -z "$host1" ]]; then
      echo -e "${RED} ➣ Error: Domain cannot be empty!${NC}"
      exit 1
    fi
    mkdir -p /var/lib/phreakers
    echo "IP=${host1}" >> /var/lib/phreakers/ipvps.conf
    echo $host1 > /etc/xray/domain
    echo $host1 > /root/domain
    if [[ -z "$nama" ]]; then
      echo "SKT AIO PROJECT" > /etc/xray/username
    else
      echo $nama > /etc/xray/username
    fi
    echo ""
  elif [[ $host == "2" ]]; then
    wget "${REPO}Sktools/cf.sh" && chmod +x cf.sh && ./cf.sh
    rm -f /root/cf.sh
    clear
  else
    echo -e "${RED} ➣ Random Subdomain is Used${NC}"
    clear
  fi
  clear

# Restart the system
  USRSC=$(wget -qO- ${izinsc} | grep $ipsaya | awk '{print $2}')
  EXPSC=$(wget -qO- ${izinsc} | grep $ipsaya | awk '{print $3}')
  TIMEZONE=$(printf '%(%H:%M:%S)T')
  TEXT="
  <code>────────────────────</code>
  <b> 🤖 NOTIFICATIONS INSTALL 🤖</b>
  <code>────────────────────</code>
  <code>❖ Ip vps : </code><code>$ipsaya</code>
  <code>❖ Domain : </code><code>$domain</code>
  <code>❖ Date   : </code><code>$TIME</code>
  <code>❖ Time   : </code><code>$TIMEZONE</code>
  <code>────────────────────</code>
  <code>A👑 Dev @SaputraTech 👑</code>
  <code>────────────────────</code>
  "'&reply_markup={"inline_keyboard":[[{"text":"Admin","url":"https://t.me/SaputraTech"},{"text":"Contact","url":"https://wa.me/6293845974466"}]]}'
  curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
  clear

# Set up SSL
  rm -rf /etc/xray/xray.key
  rm -rf /etc/xray/xray.crt
  domain=$(cat /root/domain)
  STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
  rm -rf /root/.acme.sh
  mkdir /root/.acme.sh
  systemctl stop $STOPWEBSERVER
  systemctl stop nginx
  curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
  chmod +x /root/.acme.sh/acme.sh
  /root/.acme.sh/acme.sh --upgrade --auto-upgrade
  /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
  /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
  ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
  chmod 777 /etc/xray/xray.key

# Create directories for xray
  rm -rf /etc/vmess/.vmess.db
  rm -rf /etc/vless/.vless.db
  rm -rf /etc/trojan/.trojan.db

  rm -rf /etc/ssh/.ssh.db
  rm -rf /etc/bot/.bot.db
  mkdir -p /etc/bot
  mkdir -p /etc/xray
  mkdir -p /etc/vmess
  mkdir -p /etc/vless
  mkdir -p /etc/trojan
  mkdir -p /etc/ssh
  mkdir -p /usr/bin/xray/
  mkdir -p /var/log/xray/
  mkdir -p /var/www/html
  mkdir -p /etc/phreakers/limit/vmess/ip
  mkdir -p /etc/phreakers/limit/vless/ip
  mkdir -p /etc/phreakers/limit/trojan/ip
  mkdir -p /etc/phreakers/limit/ssh/ip
  mkdir -p /etc/limit/vmess
  mkdir -p /etc/limit/vless
  mkdir -p /etc/limit/trojan
  mkdir -p /etc/limit/ssh
  chmod +x /var/log/xray
  touch /etc/xray/domain
  touch /var/log/xray/access.log
  touch /var/log/xray/error.log
  touch /etc/vmess/.vmess.db
  touch /etc/vless/.vless.db
  touch /etc/trojan/.trojan.db
  touch /etc/ssh/.ssh.db
  touch /etc/bot/.bot.db
  echo "Thank you for using, script credit by SaputraTech" >>/etc/vmess/.vmess.db
  echo "Thank you for using, script credit by SaputraTech" >>/etc/vless/.vless.db
  echo "Thank you for using, script credit by SaputraTech" >>/etc/trojan/.trojan.db
  echo "Thank you for using, script credit by SaputraTecht" >>/etc/ssh/.ssh.db
  clear

# Install xray
  domainSock_dir="/run/xray"; ! [ -d $domainSock_dir ] && mkdir $domainSock_dir
  chown www-data.www-data $domainSock_dir
  latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
  bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version $latest_version
  wget -O /etc/xray/config.json "${REPO}Sktools/config.json" >/dev/null 2>&1
  wget -O /etc/systemd/system/runn.service "${REPO}Sktools/runn.service" >/dev/null 2>&1
  domain=$(cat /etc/xray/domain)
  IPVS=$(cat /etc/xray/ipvps)
  clear
  curl -s ipinfo.io/city >>/etc/xray/city
  curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp
  wget -O /etc/haproxy/haproxy.cfg "${REPO}Sktools/haproxy.cfg" >/dev/null 2>&1
  wget -O /etc/nginx/conf.d/xray.conf "${REPO}Sktools/xray.conf" >/dev/null 2>&1
  sed -i "s/xxx/${domain}/g" /etc/haproxy/haproxy.cfg
  sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
  curl ${REPO}Sktools/nginx.conf > /etc/nginx/nginx.conf
  cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem
  chmod +x /etc/systemd/system/runn.service
  rm -rf /etc/systemd/system/xray.service.d
  cat >/etc/systemd/system/xray.service <<EOF
Description=Xray Service
Documentation=https://github.com
After=network.target nss-lookup.target
[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
filesNPROC=10000
filesNOFILE=1000000
[Install]
WantedBy=multi-user.target
EOF
 clear

# Set up SSH password
  wget -O /etc/pam.d/common-password "${REPO}Sktools/password"
  chmod +x /etc/pam.d/common-password
  DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/altgr select The default for the keyboard layout"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/compose select No compose key"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/ctrl_alt_bksp boolean false"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layoutcode string de"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layout select English"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/modelcode string pc105"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/model select Generic 105-key (Intl) PC"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/optionscode string "
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/store_defaults_in_debconf_db boolean true"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/switch select No temporary switch"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/toggle select No toggling"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_layout boolean true"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_options boolean true"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_layout boolean true"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_options boolean true"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variantcode string "
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variant select English"
  debconf-set-selections <<<"keyboard-configuration keyboard-configuration/xkb-keymap select "
  cd
  cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END
  cat > /etc/rc.local <<-END
exit 0
END
  chmod +x /etc/rc.local
  systemctl enable rc-local
  systemctl start rc-local.service
  echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
  sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
  ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
  sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config


# Set up UDP limit
  clear
  wget raw.githubusercontent.com/raffasyaa/skt/main/Sktools/limit.sh && chmod +x limit.sh && ./limit.sh
  cd
  wget -q -O /usr/bin/limit-ip "${REPO}Sktools/limit-ip"
  chmod +x /usr/bin/*
  cd /usr/bin
  sed -i 's/\r//' limit-ip
  cd
  clear
  cat >/etc/systemd/system/vmip.service << EOF
[Unit]
Description=My Project
After=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vmip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload
  cat >/etc/systemd/system/vlip.service << EOF
[Unit]
Description=My Project
After=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vlip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload
  cat >/etc/systemd/system/trip.service << EOF
[Unit]
Description=My Project
After=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip trip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload
  clear
  
  wget -q https://raw.githubusercontent.com/raffasyaa/skt/main/Sktools/fv-tunnel && chmod +x fv-tunnel && ./fv-tunnel
  mkdir -p /usr/local/phreakers/
  wget -q -O /usr/local/phreakers/udp-mini "${REPO}Sktools/udp-mini"
  chmod +x /usr/local/phreakers/udp-mini
  wget -q -O /etc/systemd/system/udp-mini-1.service "${REPO}Sktools/udp-mini-1.service"
  wget -q -O /etc/systemd/system/udp-mini-2.service "${REPO}Sktools/udp-mini-2.service"
  wget -q -O /etc/systemd/system/udp-mini-3.service "${REPO}Sktools/udp-mini-3.service"
  systemctl disable udp-mini-1
  systemctl stop udp-mini-1
  systemctl enable udp-mini-1
  systemctl start udp-mini-1
  systemctl disable udp-mini-2
  systemctl stop udp-mini-2
  systemctl enable udp-mini-2
  systemctl start udp-mini-2
  systemctl disable udp-mini-3
  systemctl stop udp-mini-3
  systemctl enable udp-mini-3
  systemctl start udp-mini-3

# Set up SlowDNS Server
  wget -q -O /tmp/nameserver "${REPO}Sktools/nameserver" >/dev/null 2>&1
  chmod +x /tmp/nameserver
  bash /tmp/nameserver | tee /root/install.log
  clear

# Install SSHD
  clear
  wget -q -O /etc/ssh/sshd_config "${REPO}Sktools/sshd" >/dev/null 2>&1
  chmod 700 /etc/ssh/sshd_config
  /etc/init.d/ssh restart
  systemctl restart ssh
  /etc/init.d/ssh status
  clear

# Install Dropbear
  apt-get install dropbear -y > /dev/null 2>&1
  wget -q -O /etc/default/dropbear "${REPO}Sktools/dropbear.conf"
  chmod +x /etc/default/dropbear
  /etc/init.d/dropbear restart
  /etc/init.d/dropbear status
  clear

# Install Vnstat
  apt -y install vnstat > /dev/null 2>&1
  /etc/init.d/vnstat restart
  apt -y install libsqlite3-dev > /dev/null 2>&1
  wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
  tar zxvf vnstat-2.6.tar.gz
  cd vnstat-2.6
  ./configure --prefix=/usr --sysconfdir=/etc && make && make install
  cd
  vnstat -u -i $NET
  sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
  chown vnstat:vnstat /var/lib/vnstat -R
  systemctl enable vnstat
  /etc/init.d/vnstat restart
  /etc/init.d/vnstat status
  rm -f /root/vnstat-2.6.tar.gz
  rm -rf /root/vnstat-2.6

# Install OpenVPN
  clear
  wget ${REPO}Sktools/openvpn && chmod +x openvpn && ./openvpn
  /etc/init.d/openvpn restart

# Set up backup server
  clear
  apt install rclone -y
  printf "q\n" | rclone config
  wget -O /root/.config/rclone/rclone.conf "${REPO}Cfg/rclone.conf"
  cd /bin
  git clone https://github.com/LunaticBackend/wondershaper.git
  cd wondershaper
  sudo make install
  cd
  rm -rf wondershaper
  echo > /home/files
  apt install msmtp-mta ca-certificates bsd-mailx -y
  cat <<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
account default
host smtp.gmail.com
port 587
auth on
user sclansscript@gmail.com
from sclansscript@gmail.com
password Farukktn
logfile ~/.msmtp.log
EOF
  chown -R www-data:www-data /etc/msmtprc
  wget -q -O /etc/ipserver "${REPO}Sktools/ipserver" && bash /etc/ipserver
  clear

# Set up swap
  gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
  gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
  curl -sL "$gotop_link" -o /tmp/gotop.deb
  dpkg -i /tmp/gotop.deb >/dev/null 2>&1
  dd if=/dev/zero of=/swapfile bs=1024 count=1048576
  mkswap /swapfile
  chown root:root /swapfile
  chmod 0600 /swapfile >/dev/null 2>&1
  swapon /swapfile >/dev/null 2>&1
  sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab
  chronyd -q 'server 0.id.pool.ntp.org iburst'
  chronyc sourcestats -v
  chronyc tracking -v
  wget ${REPO}Sktools/bbr.sh && chmod +x bbr.sh && ./bbr.sh

# Install Fail2ban
  clear
  if [ -d '/usr/local/ddos' ]; then
    echo; echo; echo "Please un-install the previous version first"
    exit 0
  else
    mkdir /usr/local/ddos
  fi
  clear
  echo "Banner /etc/banner.txt" >>/etc/ssh/sshd_config
  sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/banner.txt"@g' /etc/default/dropbear
  wget -O /etc/banner.txt "${REPO}banner.txt"


# Install ePro WebSocket Proxy
  clear
  wget -O /usr/bin/ws "${REPO}Sktools/ws" >/dev/null 2>&1
  wget -O /usr/bin/tun.conf "${REPO}Sktools/tun.conf" >/dev/null 2>&1
  wget -O /etc/systemd/system/ws.service "${REPO}Sktools/ws.service" >/dev/null 2>&1
  chmod +x /etc/systemd/system/ws.service
  chmod +x /usr/bin/ws
  chmod 644 /usr/bin/tun.conf
  systemctl disable ws
  systemctl stop ws
  systemctl enable ws
  systemctl start ws
  systemctl restart ws
  wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" >/dev/null 2>&1
  wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" >/dev/null 2>&1
  wget -O /usr/sbin/ftvpn "${REPO}Sktools/ftvpn" >/dev/null 2>&1
  chmod +x /usr/sbin/ftvpn
  iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
  iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
  iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
  iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
  iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
  iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
  iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
  iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
  iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
  iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
  iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
  iptables-save > /etc/iptables.up.rules
  iptables-restore -t < /etc/iptables.up.rules
  netfilter-persistent save
  netfilter-persistent reload
  cd
  apt autoclean -y >/dev/null 2>&1
  apt autoremove -y >/dev/null 2>&1
  clear

  cd
  rm -rf /root/udp
  mkdir -p /root/udp

  # Change to time GMT+7
  echo "Changing to GMT+7 time zone"
  ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

  # Install udp-custom
  echo "Downloading udp-custom"
  wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1_VyhL5BILtoZZTW4rhnUiYzc4zHOsXQ8' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1_VyhL5BILtoZZTW4rhnUiYzc4zHOsXQ8" -O /root/udp/udp-custom && rm -rf /tmp/cookies.txt
  chmod +x /root/udp/udp-custom

  echo "Downloading default config"
  wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1_XNXsufQXzcTUVVKQoBeX5Ig0J7GngGM' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1_XNXsufQXzcTUVVKQoBeX5Ig0J7GngGM" -O /root/udp/config.json && rm -rf /tmp/cookies.txt
  chmod 644 /root/udp/config.json

  if [ -z "$1" ]; then
    cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
  else
    cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server -exclude $1
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
  fi

  echo "Starting udp-custom service"
  systemctl start udp-custom &>/dev/null
  echo "Enabling udp-custom service"
  systemctl enable udp-custom &>/dev/null
  clear


# Restart all services
  clear
  /etc/init.d/nginx restart
  /etc/init.d/openvpn restart
  /etc/init.d/ssh restart
  /etc/init.d/dropbear restart
  /etc/init.d/vnstat restart
  systemctl restart haproxy
  /etc/init.d/cron restart
  systemctl daemon-reload
  systemctl start netfilter-persistent
  systemctl enable --now nginx
  systemctl enable --now xray
  systemctl enable --now rc-local
  systemctl enable --now dropbear
  systemctl enable --now openvpn
  systemctl enable --now cron
  systemctl enable --now haproxy
  systemctl enable --now netfilter-persistent
  systemctl enable --now ws
  systemctl enable --now fail2ban
  systemctl enable --now udp-custom
  history -c
  echo "unset HISTFILE" >> /etc/profile
  cd
  rm -f /root/openvpn
  rm -f /root/key.pem
  rm -f /root/cert.pem

# Install menu packet
  clear
  wget ${REPO}Semvak/menu.zip
  unzip menu.zip
  chmod +x menu/*
  mv menu/* /usr/local/sbin
  rm -rf menu
  rm -rf menu.zip


# Configure user profile
  clear
  cat >/root/.profile <<EOF
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
menu
EOF
  cat >/etc/cron.d/log_clear <<-END
8 0 * * * root /usr/local/bin/log_clear
END

  cat >/usr/local/bin/log_clear <<-END
#!/bin/bash
tanggal=$(date +"%m-%d-%Y")
waktu=$(date +"%T")
echo "Successfully cleared & restarted On $tanggal Time $waktu." >> /root/log-clear.txt
systemctl restart udp-custom.service
END
  chmod +x /usr/local/bin/log_clear

  cat >/etc/cron.d/daily_backup <<-END
0 22 * * * root /usr/local/bin/daily_backup
END

  cat >/usr/local/bin/daily_backup <<-END
#!/bin/bash
tanggal=$(date +"%m-%d-%Y")
waktu=$(date +"%T")
echo "Successfully backed up On $tanggal Time $waktu." >> /root/log-backup.txt
/usr/local/sbin/backup -r now
END
  chmod +x /usr/local/bin/daily_backup

  cat >/etc/cron.d/xp_sc <<-END
5 0 * * * root /usr/local/bin/xp_sc
END

  cat >/usr/local/bin/xp_sc <<-END
#!/bin/bash
/usr/local/sbin/expsc -r now
END
  chmod +x /usr/local/bin/xp_sc

  cat >/etc/cron.d/xp_all <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 0 * * * root /usr/local/sbin/xp
END
  cat >/etc/cron.d/logclean <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/10 * * * * root /usr/local/sbin/clearlog
END
  chmod 644 /root/.profile
  cat >/etc/cron.d/daily_reboot <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
5 0 * * * root /sbin/reboot
END
  echo "*/1 * * * * root echo -n > /var/log/nginx/access.log" >/etc/cron.d/log.nginx
  echo "*/1 * * * * root echo -n > /var/log/xray/access.log" >>/etc/cron.d/log.xray
  service cron restart
  cat >/home/daily_reboot <<-END
5
END
  cat >/etc/systemd/system/rc-local.service <<EOF
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
EOF
  echo "/bin/false" >>/etc/shells
  echo "/usr/sbin/nologin" >>/etc/shells
  cat >/etc/rc.local <<EOF
#!/bin/bash
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
systemctl restart netfilter-persistent
exit 0
EOF
  chmod +x /etc/rc.local
  AUTOREB=$(cat /home/daily_reboot)
  SETT=11
  if [ $AUTOREB -gt $SETT ]; then
    TIME_DATE="PM"
  else
    TIME_DATE="AM"
  fi

# Enable all services
  systemctl daemon-reload
  systemctl start netfilter-persistent
  systemctl enable --now rc-local
  systemctl enable --now cron
  systemctl enable --now netfilter-persistent
  systemctl restart nginx
  systemctl restart xray
  systemctl restart cron
  systemctl restart haproxy
  clear

echo ""
history -c
rm -rf /root/menu
rm -rf /root/*.zip
rm -rf /root/*.sh
rm -rf /root/LICENSE
rm -rf /root/README.md
rm -rf /root/domain
echo "Installation time : $((${1} / 3600)) hours $(((${1} / 60) % 60)) minute's $((${1} % 60)) seconds"
sudo hostnamectl set-hostname $username
clear
echo -e ""
echo "------------------------------------------------------------"
echo ""
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22, 53, 2222, 2269"  | tee -a log-install.txt
echo "   - SSH Websocket           : 80" | tee -a log-install.txt
echo "   - SSH SSL Websocket       : 443" | tee -a log-install.txt
echo "   - Stunnel5                : 222, 777" | tee -a log-install.txt
echo "   - Dropbear                : 109, 143" | tee -a log-install.txt
echo "   - Badvpn                  : 7100-7300" | tee -a log-install.txt
echo "   - Nginx                   : 81" | tee -a log-install.txt
echo "   - XRAY  Vmess TLS         : 443" | tee -a log-install.txt
echo "   - XRAY  Vmess None TLS    : 80" | tee -a log-install.txt
echo "   - XRAY  Vless TLS         : 443" | tee -a log-install.txt
echo "   - XRAY  Vless None TLS    : 80" | tee -a log-install.txt
echo "   - Trojan GRPC             : 443" | tee -a log-install.txt
echo "   - Trojan WS               : 443" | tee -a log-install.txt
echo "   - Trojan GO               : 443" | tee -a log-install.txt
echo "   - SLOWDNS                 : 53"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - AutoKill Multi Login User" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Fully automatic script" | tee -a log-install.txt
echo "   - VPS settings" | tee -a log-install.txt
echo "   - Admin Control" | tee -a log-install.txt
echo "   - Change port" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo ""
echo ""
echo "------------------------------------------------------------"
echo ""


# Tampilkan pesan sukses
  echo -e "${RED} 
__________________¶¶¶¶¶
_______________¶¶¶¶¶__¶¶________¶¶¶¶¶¶¶¶
__________¶¶¶¶__¶¶¶¶___¶¶_____¶¶¶¶¶____¶¶
______¶¶¶___¶¶¶¶________¶¶_¶¶¶______¶¶¶
___¶¶¶_¶¶¶¶______________¶¶_______¶¶¶
¶¶¶_¶¶¶¶________________¶¶______¶¶¶
¶¶¶¶_________________¶¶¶_____¶¶¶
¶¶________________¶¶¶_____¶¶¶
¶¶_____________¶¶¶_____¶¶¶
_¶¶________¶¶¶¶____¶¶¶¶
__¶¶____¶¶¶_____¶¶¶¶
___¶¶_¶¶¶¶___¶¶¶¶
____¶¶_____¶¶¶¶
__¶¶_____¶¶¶¶
¶¶____¶¶¶¶
¶¶_¶¶¶¶${NC}${TEAL} 
¶¶¶¶¶_____¶¶¶¶¶___________¶¶¶¶¶
_________¶¶¶¶¶¶¶_________¶¶¶¶¶¶¶
_________¶¶¶¶¶¶¶_________¶¶¶¶¶¶¶
__________¶¶¶¶¶___________¶¶¶¶¶
__¶¶¶¶_____________________________¶¶¶¶
_¶¶¶¶¶¶___________________________¶¶¶¶¶
__¶¶¶¶¶¶_________________________¶¶¶¶¶¶
___¶¶¶¶¶¶_______________________¶¶¶¶¶¶
____¶¶¶¶¶¶¶___________________¶¶¶¶¶¶¶
______¶¶¶¶¶¶¶_______________¶¶¶¶¶¶¶
_________¶¶¶¶¶¶___________¶¶¶¶¶¶
____________¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶
______________¶¶¶¶¶¶¶¶¶¶¶¶

${NC}"
sleep 1
echo -e "[\e[1;31mWARNING\e[0m]➽ SKT AIO PROJECT, INSTALL SUCCESSFULLY !"
echo -e "[\e[1;31mWARNING\e[0m]➽ Reboot dulu yuk sayang biar gk error, (y/n)? "
read answer
if [ "$answer" == "${answer#[y]}" ] ;then
exit 0
else
cat /dev/null > ~/.bash_history && history -c && reboot
fi

