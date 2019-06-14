#!/bin/bash
file="/raid/daten/alle/autopul/adduser.txt"
filelog="/raid/daten/alle/autopul/adduser.log"
if [ -f "$file" ]
then
        while read line;
        do
		/usr/sbin/useradd ${line}
                #useradd -g users -- "${line}"
		[ ! -d /raid/daten/${line} ] && mkdir -p /raid/daten/${line}
		[ -d /raid/daten/${line} ] && chgrp users /raid/daten/${line}
		tee -a /etc/samba/smb.conf << EOFORT

[${line}]
	comment = Daten von ${line}
	path = /raid/daten/${line}
	browsable = no
	writeable = yes
	available = yes
	create mask = 0777
	directory mask = 0777
	valid users = ${line} +administratoren
	force group = users
	force user = root

EOFORT
        done < $file

        date >> $filelog
        cat $file >> $filelog
        rm $file
	# SAMBA RESTART
	/etc/init.d/smb restart
fi
#else

