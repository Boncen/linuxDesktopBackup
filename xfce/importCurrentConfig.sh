#!/bin/bash

if [ -d ./configs ];then
	cp -f ./configs/*   $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/
fi