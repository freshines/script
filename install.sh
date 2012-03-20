#!/bin/sh
for item in `cat slave`;
do
	ssh $item '(echo 522 |spawn "sudo -S apt-get install build-essential"; expect "*Y/n*" send "Y\n");' 	
	if [ #? -eq 0 ];
	then
		echo "$item success.";
	else
		echo "$item failed.";
	fi
done
