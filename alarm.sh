#!/bin/sh

############################################################################################
## 
##  EMAIL AND SMS ALARM
##
##  Date: 2005-07-01
##  Author: Li Zhan
##
##  Usage: sh -x alarm.sh "message" level
##
##level: 1 ALERT, email and sms alarm (default)
##       3 ERR,   email alarm
############################################################################################

#############################################################
EMAIL=""
#MOBILE=""
MOBILE=""
PATH_GSMSEND="./"
#############################################################
msg=$1" ["`date +%T`"]"

if [ -z $2 ]; then
    LEVEL=1
else
    LEVEL=$2
fi

if [ $LEVEL -ne 3 ]; then
    for MBLID in $MOBILE
    do
	/bin/gsmsend -s 10.23.199.131:15003 -s 10.23.248.104:15003 $MBLID@"$msg"
    done 
fi

msg=`hostname`": "$1" ["`date +%T`"]"
echo $msg | mail -s "$msg" $EMAIL