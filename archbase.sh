#!/bin/bash

sudo pacman -Syu --noconfirm

if command -v cherrytree >/dev/null 2>&1; then
    echo "cherrytree ......ok"
else
    echo "cherrytree ......installing"
	sudo pacman -S --noconfirm cherrytree
fi


if command -v lazygit >/dev/null 2>&1; then
    echo "lazygit ......ok"
else
    echo "lazygit ......installing"
	sudo pacman -S --noconfirm lazygit
fi

if command -v dbeaver >/dev/null 2>&1; then
    echo "dbeaver ......ok"
else
    echo "dbeaver ......installing"
	sudo pacman -S --noconfirm dbeaver
fi

if command -v code >/dev/null 2>&1; then
    echo "code ......ok"
else
    echo "code ......installing"
	sudo pacman -S --noconfirm code
fi

if command -v fcitx5 >/dev/null 2>&1; then
    echo "fcitx5 ......ok"
else
    echo "fcitx5 ......installing"
	sudo pacman -S --noconfirm fcitx5 fcitx5-chinese-addons fcitx5-material-color
	echo "GTK_IM_MODULE=fcitx" >> /etc/envirment
	echo "QT_IM_MODULE=fcitx" >> /etc/envirment
	echo "XMODIFIERS=@im=fcitx" >> /etc/envirment
fi

if [ -f /usr/share/applications/qq.desktop ]; then
    echo "qq ......ok"
else
    echo "qq ......installing"
	yay linuxqq
fi

if command -v virtualbox >/dev/null 2>&1; then
    echo "virtualbox ......ok"
else
    echo "virtualbox ......installing"
	sudo pacman -S --noconfirm virtualbox virtualbox-host-modules-arch virtualbox-guest-iso
fi

font_installed=$(fc-list | grep -q "cjk" && echo "yes" || echo "no")
if [ "$font_installed" == "yes" ]; then
    echo "cjk font ......ok"
else
    echo "cjk font ......installing"
	sudo pacman -S --noconfirm noto-fonts-cjk
fi

font_installed=$(fc-list | grep -q "Fira" && echo "yes" || echo "no")
if [ "$font_installed" == "yes" ]; then
    echo "fira font ......ok"
else
    echo "fira font ......installing"
	sudo pacman -S --noconfirm ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-firacode-nerd
fi

# if linuxqq cannot input via fcitx5, edit the desktop file, add params '--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime'

