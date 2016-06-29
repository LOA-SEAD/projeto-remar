#!/usr/bin/env bash

function rm_war {
	rm -rf target/*.war
}

function cp_war {
	cp target/*.war /srv/production/tomcat/webapps/$1.war
}

./backup.sh
cd /srv/production/source
git pull

cd ProjetoREMAR
rm_war
grails war
cp_war ROOT

if [ -n "$1" ]; then
	if [ $1 = "-a" ] || [ $1 = "--all" ]; then
		cd ../EscolaMagica
		rm_war
		grails war
		cp_war escolamagica

		cd ../MahJong
		rm_war
		grails war
		cp_war mahjong

		cd ../Forca
		rm_war
		grails war
		cp_war forca

		cd ../RespondaSePuder
		rm_war
		grails war
		cp_war respondasepuder
	fi
fi

../tools/backup.sh --restore
