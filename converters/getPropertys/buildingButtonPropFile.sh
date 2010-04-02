#!/bin/bash

grep -r --include="*jsp" "<img" $1 | sed "s/.*\(<img[^>]*>\).*/\1/" | egrep -v "(c:out|orbitz:|\bd\.gif)" | grep "buttons" | sort - | uniq -  | ./buildImgPropFileHelper.pl - >> button.list.out
