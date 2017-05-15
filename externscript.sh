#!/bin/bash
# externscript.sh

NAMEALT=""
NAMENEU=""

while [ $# -gt 0 ]; do
  arg=$1
  shift
  case $arg in
      --p1)
              NAMEALT=$1
              shift
              ;;
       --p2)
              NAMENEU=$1
              shift
              ;;
  esac
done

echo Var1: $NAMEALT
echo Var2: $NAMENEU

echo " - Den User $NAMENEU darf erstellt werden"
useradd $NAMENEU -g users
echo " - SAMBA editieren"
sed -i.$(date +%F) "s/$NAMEALT/$NAMENEU/g" /etc/samba/smb.conf
echo " - Hier die Gruppenbearbeitung"
# START Gruppen ermitteln und zuweisen
unset m; i=0
allgroups="$(groups $NAMEALT)"

for nextgroup in ${allgroups}; do
		#echo "Gruppe gefunden: ${nextgroup}"
		((i++))
		if [ $i -gt 3 ]
		  then
			echo "In $i Gruppe $nextgroup hinzufuegen"
			usermod -A $nextgroup $NAMENEU
		fi
done
echo " - Zeige in welchen Gruppen $NAMENEU"
groups $NAMENEU
# ENDE Gruppen ermitteln und zuweisen

echo " - Alten User entfernen"
userdel $NAMEALT

read -p "ACHTUNG: SAMBA neustarten? Ja oder Nein?:" answer
	case "$answer" in
			Ja|ja|J|j|"") echo "Ok los geht's"
						/etc/init.d/smb reload
						#/etc/init.d/smb restart
				;;
			Nein|nein|N|n) echo "Abbruch."
					   exit 1
				;;
				*) echo "Unbekannter Parameter" 
				;;
	esac
