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
				installer="sudo pacman -S -unconfirm "
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
	eval "git config --global user.name $userName"
	eval "git config --global user.email $userEmail"
    git config --global credential.helper store
fi


	
