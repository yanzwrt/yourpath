#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edisi   : Stable Edition V1.0
# Pembuat : RakhaVPN
# (C) Hak Cipta 2025
# =========================================

clear
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")

MYIP=$(curl -sS ifconfig.me)
domain=$(cat /root/domain)
MYIP2=$(curl -sS ipv4.icanhazip.com)

# WARNA
NC='\e[0m'
RB='\e[31;1m' # Merah
GB='\e[32;1m' # Hijau
YB='\e[33;1m' # Kuning
BB='\e[34;1m' # Biru
WB='\e[37;1m' # Putih

# TAMPILAN MENU
clear
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
    echo -e "${BB}════════════════════════════════════════════════${NC}"
    echo -e "${WB}         Tambah Akun XRAY VMESS WS             ${NC}"
    echo -e "${BB}════════════════════════════════════════════════${NC}"
    
    read -rp "➤ Masukkan Nama Pengguna : " -e user
    CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)

    if [[ ${CLIENT_EXISTS} == '1' ]]; then
        echo -e "${RB}⚠️  Nama pengguna sudah terdaftar. Silakan gunakan nama lain.${NC}"
        read -n 1 -s -r -p "$(echo -e "${YB}Tekan tombol apa saja untuk kembali ke menu${NC}")"
        menu
    fi
done

read -p "➤ Bug Address (cth: www.google.com) : " address
read -p "➤ Bug SNI/Host (cth: m.facebook.com) : " hst
read -p "➤ Masa Aktif (hari) : " masaaktif

bug_addr=${address}.
bug_addr2=${address}
sts=${bug_addr2}
[[ $address != "" ]] && sts=${bug_addr}

bug=${hst}
bug2=${domain}
sni=${bug2}
[[ $hst != "" ]] && sni=${bug}

uuid=$user
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
hariini=$(date +"%Y-%m-%d")

# Tambah ke config Xray
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'$uuid'","alterId": 0,"email": "'$user'"' /usr/local/etc/xray/config.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'$uuid'","alterId": 0,"email": "'$user'"' /usr/local/etc/xray/none.json

# Buat file konfigurasi vmess
cat > /usr/local/etc/xray/$user-tls.json <<EOF
{
  "v": "2",
  "ps": "XRAY_VMESS_TLS_${user}",
  "add": "${sts}${domain}",
  "port": "443",
  "id": "${uuid}",
  "aid": "0",
  "net": "ws",
  "path": "/vmess",
  "type": "none",
  "host": "${domain}",
  "tls": "tls",
  "sni": "${sni}"
}
EOF

cat > /usr/local/etc/xray/$user-none.json <<EOF
{
  "v": "2",
  "ps": "XRAY_VMESS_NTLS_${user}",
  "add": "${sts}${domain}",
  "port": "80",
  "id": "${uuid}",
  "aid": "0",
  "net": "ws",
  "path": "/vmess",
  "type": "none",
  "host": "${domain}",
  "tls": "none"
}
EOF

# Encode base64
vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"

# Restart layanan
systemctl restart xray.service
systemctl restart xray@none.service
service cron restart

# OUTPUT
clear
echo -e "${BB}════════════════════════════════════════════════${NC}"
echo -e "${WB}             Detail Akun XRAY VMESS WS          ${NC}"
echo -e "${BB}════════════════════════════════════════════════${NC}"
echo -e "📌 Username         : ${user}"
echo -e "🌐 Domain           : ${domain}"
echo -e "🔐 IP/Host          : ${MYIP}"
echo -e "🔒 Port TLS         : 443"
echo -e "🔓 Port Non-TLS     : 80, 8080, 8880"
echo -e "🆔 UUID             : ${uuid}"
echo -e "🔁 AlterId          : 0"
echo -e "🔗 Path TLS         : /vmess"
echo -e "🔗 Path Non-TLS     : /vmess"
echo -e "📆 Tanggal Dibuat   : ${hariini}"
echo -e "⏳ Berakhir Pada    : ${exp}"
echo -e "${BB}════════════════════════════════════════════════${NC}"
echo -e "🔗 Link TLS         : ${vmesslink1}"
echo -e "${BB}════════════════════════════════════════════════${NC}"
echo -e "🔗 Link Non-TLS     : ${vmesslink2}"
echo -e "${BB}════════════════════════════════════════════════${NC}"
echo -e "📄 YAML TLS         : http://${MYIP2}:81/$user-VMESSTLS.yaml"
echo -e "📄 YAML Non-TLS     : http://${MYIP2}:81/$user-VMESSNTLS.yaml"
echo -e "${BB}════════════════════════════════════════════════${NC}"
echo -e "✨ Script oleh: RakhaVPN"
echo ""
read -p "$(echo -e "${YB}Tekan Enter untuk kembali ke menu ...${NC}")"
menu
