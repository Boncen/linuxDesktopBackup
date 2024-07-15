#!/bin/bash
#
gitNotesPaths=(
	"/home/boncen/notes"
)
githubReposPath="/home/boncen/github"
input="y"
for path in $gitNotesPaths
do
	cd $path
	if [[ ! -z $(git status -s) ]];then
		echo "$path 下的内容还未提交,关机终止"
		read -p "Skip?(Y/n)" input
		if [[ $input == "y" || -z $input ]];then
			echo "skip $path"
		else
			exit 1
		fi
	fi
done

for path in $(ls $githubReposPath )
do
	cd "$githubReposPath/$path"
	if [[ ! -z $(git status -s)  ]];then
		echo "$githubReposPath/$path 内容未提交，关机终止"
		read -p "Skip?(Y/n)" input
		if [[ $input == "y" || -z $input ]];then
			echo "skip $path"
		else
			exit 1
		fi
	fi
done

echo "Ready for poweroff ～"
sync && sync && sync && sudo poweroff
