echo -e "[ ${green}INFO${NC} ] Menyiapkan instalasi autoscript ~"
apt install git curl -y >/dev/null 2>&1
echo -e "[ ${green}INFO${NC} ] File instalasi siap untuk dipasang!"
sleep 1

if [ -f "/usr/local/etc/xray/domain" ]; then
echo "Script sudah terpasang!"
exit 0
fi

mkdir /var/lib/premium-script;
mkdir /var/lib/crot-script;
clear

echo -e "${red}    ♦️${NC} ${green} PENGATURAN DOMAIN VPS     ${NC}"
echo -e "${red}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo "1. Gunakan domain otomatis dari script"
echo "2. Masukkan domain sendiri"
echo -e "${red}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
read -rp "Pilih metode pengaturan domain : " dom 

if test $dom -eq 1; then
clear
wget -q -O /root/cf.sh "https://${Server_URL}/cf.sh"
chmod +x /root/cf.sh
./cf.sh
elif test $dom -eq 2; then
read -rp "Masukkan nama domain anda : " domen 
echo $domen > /root/domain
else 
echo "Pilihan tidak ditemukan!"
exit 1
fi

echo -e "${GREEN}Berhasil mengatur domain!${NC}"
sleep 2
clear

echo "IP=$host" >> /var/lib/premium-script/ipvps.conf
echo "IP=$host" >> /var/lib/crot-script/ipvps.conf
echo "$host" >> /root/domain

# Instalasi SSH-VPN
echo -e "\e[0;32mMEMULAI INSTALASI SSH-VPN...\e[0m"
sleep 1
wget https://${Server_URL}/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
sleep 3

# Instalasi XRAY Core
clear
echo -e "\e[0;32mMEMULAI INSTALASI XRAY CORE...\e[0m"
sleep 3
wget -q -O /root/xray.sh "https://${Server_URL}/xray.sh"
chmod +x /root/xray.sh
./xray.sh
echo -e "${GREEN}Selesai!${NC}"
sleep 2

# Instalasi SET-BR
clear
echo -e "\e[0;32mMEMULAI INSTALASI SET-BR...\e[0m"
sleep 1
wget -q -O /root/set-br.sh "https://${Server_URL}/set-br.sh"
chmod +x /root/set-br.sh
./set-br.sh
echo -e "${GREEN}Selesai!${NC}"
sleep 2
clear

# Hapus sisa file instalasi
rm -f /root/ins-xray.sh
rm -f /root/set-br.sh
rm -f /root/ssh-vpn.sh

# Versi
echo "1.0" > /home/ver

clear
echo ""
echo -e "${RB}      .-------------------------------------------.${NC}"
echo -e "${RB}      |${NC}     ${CB}INSTALASI TELAH SELESAI${NC}             ${RB}|${NC}"
echo -e "${RB}      '-------------------------------------------'${NC}"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "     ${WB}Multiport Websocket Autoscript Oleh Rakha-VPN${NC}"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${WB}»»» Layanan Protokol «««          |  »»» Jaringan Protokol «««${NC}  "
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Vmess Websocket${NC}         ${WB}|${NC}  ${YB}- Websocket (CDN) TLS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Vless Websocket${NC}         ${WB}|${NC}  ${YB}- Websocket (CDN) NTLS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Trojan Websocket${NC}        ${WB}|${NC}  ${YB}- TCP XTLS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Trojan TCP XTLS${NC}         ${WB}|${NC}  ${YB}- TCP TLS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Trojan TCP${NC}              ${WB}|${NC}"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "          ${WB}»»» Informasi YAML Config «««${NC}            "
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${RB}♦️${NC} ${YB}YAML XRAY VMESS WS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}YAML XRAY VLESS WS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}YAML XRAY TROJAN WS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}YAML XRAY TROJAN XTLS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}YAML XRAY TROJAN TCP${NC}"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "             ${WB}»»» Informasi Server «««${NC}               "
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Zona Waktu            : Asia/Kuala_Lumpur (GMT +8)${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Fail2Ban              : [AKTIF]${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Dflate                : [AKTIF]${NC}"
echo -e "  ${RB}♦️${NC} ${YB}IPtables              : [AKTIF]${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Auto-Reboot           : [AKTIF]${NC}"
echo -e "  ${RB}♦️${NC} ${YB}IPV6                  : [NONAKTIF]${NC}"
echo ""
echo -e "  ${RB}♦️${NC} ${YB}Auto reboot pukul 06.00 (GMT +8)${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Backup & Restore Data VPS${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Hapus Otomatis Akun Expired${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Pantau Bandwidth${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Pantau RAM & CPU${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Cek Login Pengguna${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Cek Config Dibuat${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Clear Log Otomatis${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Media Checker${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Pengganti DNS${NC}"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "           ${WB}»»» Informasi Port Jaringan «««${NC}          "
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${RB}♦️${NC} ${YB}HTTP    : 80, 8080, 8880${NC}"
echo -e "  ${RB}♦️${NC} ${YB}HTTPS   : 443${NC}"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo ""
secs_to_human "$(($(date +%s) - ${start}))"
echo ""
read -p "$( echo -e "Tekan ${orange}[ ${NC}${green}Enter${NC} ${CYAN}]${NC} untuk Reboot") "
reboot
