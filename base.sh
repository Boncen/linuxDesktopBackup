#!/bin/bash

userName="boncen" # your name
userEmail="boncen@outlook.com" # your email

debianInitial() {
	echo "debian initial func"
	# source.list
	echo '' > /etc/apt/sources.list
	echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware' >> /etc/apt/sources.list
	echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware' >> /etc/apt/sources.list
	echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware' >> /etc/apt/sources.list
	echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware' >> /etc/apt/sources.list

	# sudoer
	echo "$userName ALL=(ALL:ALL) ALL" > /etc/sudoers.d/boncen  # boncen
	sudo apt update && sudo apt upgrade
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
if [ -f /usr/share/applications/QQ.desktop ]; then
	echo "qq ......ok"
else
	if [ -d /home/boncen/softs/qq ]; then
		cd /home/boncen/softs/qq

		touch ./QQ.desktop
		echo '[Desktop Entry]' >> ./QQ.desktop
		echo 'Comment=qq' >> ./QQ.desktop
		echo "Exec=`pwd`/app.AppImage" >> ./QQ.desktop
		echo "Icon=`pwd`/QQ.png" >> ./QQ.desktop
		echo 'Name=qq' >> ./QQ.desktop
		echo 'StartupNotify=true' >> ./QQ.desktop
		echo 'Terminal=false' >> ./QQ.desktop
		echo 'Type=Application' >> ./QQ.desktop

		sudo cp ./QQ.desktop /usr/share/applications/QQ.desktop
		rm ./QQ.desktop
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
	

if command -v dotnet >/dev/null 2>&1; then
    echo "dotnet ......ok"
else
    echo "dotnet ......installing"
	cd /home/boncen
	wget https://download.visualstudio.microsoft.com/download/pr/dd6ee0c0-6287-4fca-85d0-1023fc52444b/874148c23613c594fc8f711fc0330298/dotnet-sdk-8.0.302-linux-x64.tar.gz
	mkdir -p /home/boncen/dotnet && tar zxf dotnet-sdk-8.0.302-linux-x64.tar.gz -C /home/boncen/dotnet
	echo 'export DOTNET_ROOT=$HOME/dotnet' >>  /home/boncen/.bashrc
	echo 'export PATH=$PATH:$HOME/dotnet' >>  /home/boncen/.bashrc
fi

if command -v virtualbox >/dev/null 2>&1; then
    echo "virtualbox ......ok"
else
    echo "virtualbox ......installing"
    cd /home/boncen
    wget https://download.virtualbox.org/virtualbox/7.0.18/VirtualBox-7.0.18-162988-Linux_amd64.run
    chmod +x VirtualBox-7.0.18-162988-Linux_amd64.run
    bash VirtualBox-7.0.18-162988-Linux_amd64.run
    sudo usermod -a -G vboxusers boncen
fi

if command -v flatpak >/dev/null 2>&1; then
    echo "flatpak ......ok"
else
    echo "flatpak ......installing"
    eval "$installer flatpak"
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub
fi

