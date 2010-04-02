#!/bin/bash

DATE=`date -d "23 day ago" +"%Y%m%d"`
LOGHOME=/home/home02/webstats/input/bem_logs
PREFIX=browser_data_wmwl36ppa_
POSTFIX=.gz
LOGDEST=/home/home01/nkrimm/docroot/browserStats

FILELOC=$LOGHOME/$DATE/$PREFIX$DATE$POSTFIX
echo getting log file
cp $FILELOC $LOGDEST 
gunzip -f $LOGDEST/$PREFIX$DATE$POSTFIX
#rm log
#ln -s logs/$PREFIX$DATE log

echo running parser
/home/home01/nkrimm/bin/browser_logs/log_parser $LOGDEST/$PREFIX$DATE
echo cleaning up
sleep 100
#rm $LOGDEST/$PREFIX$DATE 

