#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : RakhaVPN
# (C) Copyright 2025
# =========================================
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(cat /home/limit)
NIC=$(ip -o $ANU -4 route show to default | awk '{print $5}');
function start () {
clear
echo -e "Batasi Kecepatan Semua Layanan"
read -p "Tetapkan kecepatan pengunduhan maksimum (in Kbps): " down
read -p "Tetapkan kecepatan Pengunggahan maksimum (in Kbps): " up
if [[ -z "$down" ]] && [[ -z "$up" ]]; then
echo > /dev/null 2>&1
else
echo "Mulai Konfigurasi"
sleep 0.5
wondershaper -a $NIC -d $down -u $up > /dev/null 2>&1
systemctl enable --now wondershaper.service
echo "start" > /home/limit
echo "Done"
sleep 1
clear
menu
fi
}
function stop () {
clear
wondershaper -ca $NIC
systemctl stop wondershaper.service
echo "Hentikan Konfigurasi"
sleep 0.5
echo > /home/limit
echo "Done"
sleep 1
clear
menu
}
if [[ "$cek" = "start" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;47;30m      BATASI KECEPATAN BANDWITH         \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m
\033[1;37mLimit Bandwith Speed By RakhaVPN\033[0m
\033[1;37mTelegram : https://t.me/RakhaVPN / @RakhaVPN\033[0m"
echo ""
echo -e "   Status : $sts"
echo -e "
 [\033[1;36m•1 \033[0m]  Mulai Batas
 [\033[1;36m•2 \033[0m]  Berhenti Batas
 [\033[1;36m•3 \033[0m]  kembali ke menu"
echo ""
echo -e " \033[1;37mTekan [ Ctrl+C ] • Untuk-Keluar-Script\033[0m"
echo ""
read -rp "Pilih menu : " -e num
if [[ "$num" = "1" ]]; then
start
elif [[ "$num" = "2" ]]; then
stop
elif [[ "$num" = "3" ]]; then
menu
else
clear
echo " Silahkan Masukkan Nomor yang Benar!"
sleep 0.5
limit
fi
