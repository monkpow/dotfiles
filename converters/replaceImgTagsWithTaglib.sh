#!/bin/bash
for entry in `cat short.img.list | grep ".src"`; do
	SRC=`echo $entry | sed 's/[^=]*=//' -`
	KEY=`echo $entry | sed 's/.src=.*//' -`
	for target in `grep -rl --include="*jsp" $SRC .`; do 
			cp $target $target.bak
			./replaceImgTagsWithTagLibHelper.pl $target $SRC $KEY;
			done;  
done;

