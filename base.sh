#!/bin/bash

userName="boncen" # your name
userEmail="boncen@outlook.com" # your email

debianInitial() {
	echo "debian initial func"
	# source.list
	
	# sudoer
	echo "$userName ALL=(ALL:ALL) ALL" > /etc/sudoers.d/boncen  # boncen
}

if [ -f /etc/os-release ]; then
	. /etc/os-release
	case "$ID" in
		ubuntu|debian)
			installer="sudo apt install -y "
			debianInitial
			;;
		centos|rhel)
			installer="sudo yum install -y "
			;;
		fedora)
			installer="sudo dnf install -y "
			;;
		*)
			if command -v pacman >/dev/null 2>&1; then
				installer="sudo pacman -S --noconfirm "
			else
				echo "unsupported $ID"
				exit 1
			fi
			;;
	esac
else
	echo "unknown linux"
	exit 1
fi

# ensure install git
if command -v git >/dev/null 2>&1; then
    echo "Git ......ok"
else
    echo "Git ......installing"
	eval "$installer git"
fi
eval "git config --global user.name $userName"
eval "git config --global user.email $userEmail"
git config --global credential.helper store

# wget
if command -v wget >/dev/null 2>&1; then
    echo "wget ......ok"
else
    echo "wget ......installing"
	eval "$installer wget"
fi

# flameshot
if command -v flameshot >/dev/null 2>&1; then
    echo "flameshot ......ok"
else
    echo "flameshot ......installing"
	eval "$installer flameshot"
fi

# clash
if [ -f /home/boncen/.config/mihomo/clash-linux ]; then
    echo "clash ......ok"
else
    mkdir  /home/boncen/.config/
    mkdir  /home/boncen/.config/mihomo/
    cd     /home/boncen/.config/mihomo/

    wget -U "Mozilla/6.0"  https://v2free.net/ssr-download/clash-linux.tar.gz
    tar xvf clash-linux.tar.gz
    chmod +x clash-linux
    wget -U "Mozilla/6.0" -O /home/boncen/.config/mihomo/config.yaml "https://v2free.net/link/THroaEAZJetImIBG?clash=2"

    echo 'alias allproxy="export all_proxy=http://127.0.0.1:7890;export HTTP_PROXY=http://127.0.0.1:7890;export HTTPS_PROXY=http://127.0.0.1:7890"' >> /home/boncen/.bashrc
    echo 'alias allproxyoff="export all_proxy=;export HTTP_PROXY=;export HTTPS_PROXY=;"' >> /home/boncen/.bashrc
    echo 'alias clashrun="/home/boncen/.config/mihomo/clash-linux"' >> /home/boncen/.bashrc
    echo 'alias clashoff="pkill clash-linux"' >> /home/boncen/.bashrc
    source /home/boncen/.bashrc
fi

cd /home/boncen

# QQ
if [ -f /usr/share/applications/qqq.desktop ]; then
	echo "qq ......ok"
else
	if [ -d /home/boncen/softs/qq ]; then
		cd /home/boncen/softs/qq

		touch ./qqq.desktop
		echo '[Desktop Entry]' >> ./qqq.desktop
		echo 'Comment=qq' >> ./qqq.desktop
		echo "Exec=`pwd`/app.AppImage" >> ./qqq.desktop
		echo "Icon=`pwd`/icon.png" >> ./qqq.desktop
		echo 'Name=qq' >> ./qqq.desktop
		echo 'StartupNotify=true' >> ./qqq.desktop
		echo 'Terminal=false' >> ./qqq.desktop
		echo 'Type=Application' >> ./qqq.desktop

		sudo cp ./qqq.desktop /usr/share/applications/qqq.desktop
		rm ./qqq.desktop
	else
		echo "cannot find directory /home/boncen/softs/qq, qq skip."
	fi
fi

# wechat-dev-tool
if [ -f /usr/share/applications/wechat-dev.desktop ]; then
	echo "wechat-devtool ......ok"
else
	if [ -d /home/boncen/softs/wechat-devtool ]; then
		cd /home/boncen/softs/wechat-devtool

		touch ./wechat-dev.desktop
		echo '[Desktop Entry]' >> ./wechat-dev.desktop
		echo 'Comment=wechat-devtool' >> ./wechat-dev.desktop
		echo "Exec=`pwd`/app.AppImage" >> ./wechat-dev.desktop
		echo "Icon=`pwd`/icon.png" >> ./wechat-dev.desktop
		echo 'Name=wechat-devtool' >> ./wechat-dev.desktop
		echo 'StartupNotify=true' >> ./wechat-dev.desktop
		echo 'Terminal=false' >> ./wechat-dev.desktop
		echo 'Type=Application' >> ./wechat-dev.desktop

		sudo cp ./wechat-dev.desktop /usr/share/applications/wechat-dev.desktop
		rm ./wechat-dev.desktop
	else
		echo "cannot find directory /home/boncen/softs/wechat-devtool, wechat-devtool skip."
	fi
fi
	

