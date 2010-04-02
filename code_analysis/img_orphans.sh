#!/bin/bash

# A diagnostic tool for detailing image use and
# helping to identify images no longer in use

# CONSTANTS

ROOTDIR=~/work/tip/novo/webapp
IMGDIR=$ROOTDIR/img

cd $IMGDIR
IMG_COUNT=0

echo ""
echo "------------------------------"
echo "Orbitz.com Image Orphan Script"
echo "------------------------------"
echo "Report started at: "`date`
echo 
echo "Searching for unused images..."
echo ""
echo "Directory: $IMGDIR"

for ENTRY in `ls -Rp`
do
	IS_DIR=false
	IS_IMAGE=false

	# This if statement extracts valid files (.gif/.jpg) and subdirectories from 
	# the 'ls' command.  IS_DIR is set to true if the current entry from 'ls' is
	# a directory.  IS_IMAGE is set to true if the current entry from 'ls' is a
	# valid image file.
	
	if [[ $ENTRY != ".:" && (`expr index $ENTRY /` -ne `expr length $ENTRY`) ]]
	then
		if [ `expr index $ENTRY .` -eq 1 ]
		then
			IS_DIR=true
			LENGTH=`expr length $ENTRY`
			LENGTH=`expr $LENGTH - 2`
			ENTRY=`expr substr $ENTRY 2 $LENGTH`
		elif [[ ${ENTRY: -4} = ".gif" || ${ENTRY: -4} = ".jpg" ]]
		then
			IS_IMAGE=true	
		fi		 
	fi
	
	if [ $IS_DIR = true ]
	then

		# Print the directory that we are currently exploring.

		echo ""
		echo "Directory: $IMGDIR$ENTRY"
	elif [ $IS_IMAGE = true ]
	then

		# Grep the ROOTDIR for occurrences of the image file.  If the image
		# name does not occur, then output the filename.

		FILE_EXP="[/\"]$ENTRY"
		COUNT=`grep -rls --include="*.jsp" $FILE_EXP $ROOTDIR | wc -l`
		if [ $COUNT -eq 0 ]
		then
			IMG_COUNT=$(( $IMG_COUNT + 1 ))
			echo " $ENTRY"
		fi
	fi
done
echo ""
echo "------------------------------"
echo "Total # of unused images: $IMG_COUNT"
echo ""
echo "Report completed at: "`date`
echo ""

exit 0
