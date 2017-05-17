#!/bin/bash
# user_umbenennen.sh

read -p "Bitte geben Sie Alt- und Neu- Usernamen ein: " NAMEALT NAMENEU

if [ -d /raid/daten/$NAMEALT ]
  then
    echo "Der Ordner $NAMEALT in Pingus ist da."
	
	if [ -d /raid/daten/$NAMENEU ]
		then
			echo "Der Ordner $NAMENEU in Pingus ist da."
			echo "ACHTUNG! User $NAMENEU ist bereit vorhanden"
		else
			echo "Der Ordner $NAMENEU in Pingus fehlt."
			echo " - Ordner $NAMEALT in $NAMENEU umbenennen"
			mv /raid/daten/$NAMEALT /raid/daten/$NAMENEU
			#extern script (useradd, samba, gruppen, altuserdel, sambareload)
			./externscript.sh  --p1 $NAMEALT --p2 $NAMENEU
	fi
	
  else
    echo "Der Ordner $NAMEALT in Pingus fehlt."
	read -p "ACHTUNG: SAMBA fuer $NAMENEU trotzdem bearbeiten? Ja oder Nein?:" answer

	case "$answer" in
			Ja|ja|J|j|"") echo "Ok los geht's"
						#extern script (useradd, samba, gruppen, altuserdel, sambareload)
						./externscript.sh  --p1 $NAMEALT --p2 $NAMENEU
				;;
			Nein|nein|N|n) echo "Abbruch."
					   exit 1
				;;
				*) echo "Unbekannter Parameter" 
				;;
	esac

fi
