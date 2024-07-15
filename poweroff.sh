#!/bin/bash
#
gitNotesPaths=(
	"/home/boncen/notes"
)
githubReposPath="/home/boncen/github"

for path in $gitNotesPaths
do
	cd $path
	if [[ ! -z $(git status -s) ]];then
		echo $path + '下的内容还未提交,关机终止。'
		exit 1	
	fi
	echo $path
done

for path in $(ls $githubReposPath )
do
	cd "$githubReposPath/$path"
	if [[ ! -z $(git status -s)  ]];then
		echo "$githubReposPath/$path" + '内容未提交，关机终止。'
		exit 1
	fi
done

echo "准备关机～"
sudo poweroff
