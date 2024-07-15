#!/bin/bash

if [ ! -d /home/boncen/.themes ];then
	mkdir /home/boncen/.themes
fi

cp -rf ./themes/*  /home/boncen/.themes/