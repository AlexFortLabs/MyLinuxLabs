#!/bin/bash
# zerogroups.sh
# 1- Zuerst führe den unteren Befehl in Konsole aus:
# 	cut -d: -f 1,1 /etc/passwd | grep p0 > zerogroups.txt
# oder für /etc/group. Du bekommst eine Datei zerogroups.txt mit allen User/Gruppen deren Name begingt auf p0 (z.B. p05446).
#
# 2- danach starte diesen Script um alle gelistete, in der Datei zerogroups.txt, User/Gruppen zu löschen
#

for i in $(cat zerogroups.txt); do
	#echo $i
	id $i
	userdel $i
	delgroup $i
	id $i
done;
