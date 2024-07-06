#!/bin/bash

if [ ! -d ./configs ];then
	mkdir .configs
fi

cp -f $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/* ./configs/