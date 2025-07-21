#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : RakhaVPN
# (C) Copyright 2025
# =========================================

clear
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")

# Ambil IP VPS
MYIP=$(curl -sS ifconfig.me)
domain=$(cat /root/domain)
MYIP2=$(curl -sS ipv4.icanhazip.com)

# Warna
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
purple='\e[0;35m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

clear
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\\E[0;47;30m         TAMBAH AKUN TROJAN WS            \E[0m"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    read -rp "➤ Masukkan Username/Password: " -e user
    user_EXISTS=$(grep -w $user /usr/local/etc/xray/trojanws.json | wc -l)
    if [[ ${user_EXISTS} == '1' ]]; then
        clear
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\\E[0;47;30m         TAMBAH AKUN TROJAN WS            \E[0m"
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e ""
        echo -e "❌ Username sudah digunakan, silakan gunakan nama lain."
        echo ""
        read -n 1 -s -r -p "Tekan sembarang tombol untuk kembali ke menu"
        menu
    fi
done

read -p "➤ Alamat Bug (contoh: www.google.com) : " address
read -p "➤ Bug SNI/Host (contoh : m.facebook.com) : " hst
read -p "➤ Masa aktif (hari) : " masaaktif

bug_addr=${address}.
bug_addr2=${address}
sts=${bug_addr2}
[[ -n $address ]] && sts=$bug_addr

bug=${hst}
bug2=${domain}
sni=${bug2}
[[ -n $hst ]] && sni=$bug

exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
hariini=$(date -d "0 days" +"%Y-%m-%d")

# Tambah user ke config
sed -i '/#tr$/a\### '"$user $exp"'\n},{"password": "'""$user""'","email": "'""$user""'"' /usr/local/etc/xray/trojanws.json
sed -i '/#trnone$/a\### '"$user $exp"'\n},{"password": "'""$user""'","email": "'""$user""'"' /usr/local/etc/xray/trnone.json

# Restart layanan
systemctl restart xray@trojanws.service
systemctl restart xray@trnone.service
service cron restart

# Link
trojanlink1="trojan://${user}@${domain}:443?type=ws&security=tls&host=${domain}&path=/trojan&sni=${sni}#${user}"
trojanlink2="trojan://${user}@${domain}:80?type=ws&security=none&host=${domain}&path=/trojan#${user}"

# YAML
cat > /home/vps/public_html/$user-$exp-TRTLS.yaml <<EOF
port: 7890
socks-port: 7891
redir-port: 7892
mixed-port: 7893
tproxy-port: 7895
ipv6: false
mode: rule
log-level: silent
allow-lan: true
external-controller: 0.0.0.0:9090
secret: ""
bind-address: "*"
unified-delay: true
profile:
  store-selected: true
  store-fake-ip: true
dns:
  enable: true
  ipv6: false
  use-host: true
  enhanced-mode: fake-ip
  listen: 0.0.0.0:7874
  nameserver:
    - 8.8.8.8
    - 1.0.0.1
    - https://dns.google/dns-query
  fallback:
    - 1.1.1.1
    - 8.8.4.4
    - https://cloudflare-dns.com/dns-query
    - 112.215.203.254
  default-nameserver:
    - 8.8.8.8
    - 1.1.1.1
    - 112.215.203.254
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - "*.lan"
    - "*.localdomain"
    - "*.example"
    - "*.invalid"
    - "*.localhost"
    - "*.test"
    - "*.local"
    - "*.home.arpa"
    - time.*.com
    - time.*.gov
    - time.*.edu.cn
    - time.*.apple.com
    - time1.*.com
    - time2.*.com
    - time3.*.com
    - time4.*.com
    - time5.*.com
    - time6.*.com
    - time7.*.com
    - ntp.*.com
    - ntp1.*.com
    - ntp2.*.com
    - ntp3.*.com
    - ntp4.*.com
    - ntp5.*.com
    - ntp6.*.com
    - ntp7.*.com
    - "*.time.edu.cn"
    - "*.ntp.org.cn"
    - +.pool.ntp.org
    - time1.cloud.tencent.com
    - music.163.com
    - "*.music.163.com"
    - "*.126.net"
    - musicapi.taihe.com
    - music.taihe.com
    - songsearch.kugou.com
    - trackercdn.kugou.com
    - "*.kuwo.cn"
    - api-jooxtt.sanook.com
    - api.joox.com
    - joox.com
    - y.qq.com
    - "*.y.qq.com"
    - streamoc.music.tc.qq.com
    - mobileoc.music.tc.qq.com
    - isure.stream.qqmusic.qq.com
    - dl.stream.qqmusic.qq.com
    - aqqmusic.tc.qq.com
    - amobile.music.tc.qq.com
    - "*.xiami.com"
    - "*.music.migu.cn"
    - music.migu.cn
    - "*.msftconnecttest.com"
    - "*.msftncsi.com"
    - msftconnecttest.com
    - msftncsi.com
    - localhost.ptlogin2.qq.com
    - localhost.sec.qq.com
    - +.srv.nintendo.net
    - +.stun.playstation.net
    - xbox.*.microsoft.com
    - xnotify.xboxlive.com
    - +.battlenet.com.cn
    - +.wotgame.cn
    - +.wggames.cn
    - +.wowsgame.cn
    - +.wargaming.net
    - proxy.golang.org
    - stun.*.*
    - stun.*.*.*
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - heartbeat.belkin.com
    - "*.linksys.com"
    - "*.linksyssmartwifi.com"
    - "*.router.asus.com"
    - mesu.apple.com
    - swscan.apple.com
    - swquery.apple.com
    - swdownload.apple.com
    - swcdn.apple.com
    - swdist.apple.com
    - lens.l.google.com
    - stun.l.google.com
    - +.nflxvideo.net
    - "*.square-enix.com"
    - "*.finalfantasyxiv.com"
    - "*.ffxiv.com"
    - "*.mcdn.bilivideo.cn"
    - +.media.dssott.com
proxies:
  - name: XRAY_TROJAN_TLS_${user}
    server: ${sts}${domain}
    port: 443
    type: trojan
    password: ${user}
    skip-cert-verify: true
    sni: ${sni}
    network: ws
    ws-opts:
      path: /trojan
      headers:
        Host: ${domain}
    udp: true
proxy-groups:
  - name: RakhaVPN-Autoscript
    type: select
    proxies:
      - XRAY_TROJAN_TLS_${user}
      - DIRECT
rules:
  - MATCH,rakhaVPN-Autoscript
$(cat /home/vps/public_html/$user-$exp-TRTLS.yaml)
EOF

clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\\E[0;47;30m            XRAY TROJAN WS DETAIL           \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "➤ Username          : ${user}"
echo -e "➤ Domain            : ${domain}"
echo -e "➤ IP VPS            : ${MYIP}"
echo -e "➤ Port TLS          : 443"
echo -e "➤ Port None TLS     : 80, 8080, 8880"
echo -e "➤ Password          : ${user}"
echo -e "➤ Security          : TLS"
echo -e "➤ Encryption        : None"
echo -e "➤ Network           : WS"
echo -e "➤ Path TLS          : /trojan"
echo -e "➤ Path NTLS         : /trojan"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "➤ Dibuat tanggal    : $hariini"
echo -e "➤ Berakhir tanggal  : $exp"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "➤ Link WS TLS       :"
echo -e "${green}${trojanlink1}${NC}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "➤ Link WS Non TLS   :"
echo -e "${green}${trojanlink2}${NC}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "➤ YAML WS TLS       : http://${MYIP2}:81/$user-TRTLS.yaml"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e "           Script By RakhaVPN"
echo -e ""

read -p "$( echo -e "Tekan ${red}[ ${NC}${green}Enter${NC} ${red}]${NC} untuk kembali ke menu...") "
menu
