#!/bin/bash
file="/raid/daten/alle/autopul/adduser.txt"
filelog="/raid/daten/alle/autopul/adduser.log"
if [ -f "$file" ]
then
        while read line;
        do
                useradd -g users -- "${line}"
        done < $file

        date >> $filelog
        cat $file >> $filelog
        rm $file
fi
#else
#       echo "$file not found."
#fi
