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
		exit
	fi
else
	php -S 127.0.0.1:$1 & ngrok http $1
fi
