#!/bin/bash



# gera o war do jogo
cd /srv/source/$1
grails war

if [ $2 = "-mv" ]; then
	# move o arquivo war para a pasta webapps do tomcat
	echo "Movendo War para /srv/tomcat/webapps/"
	cp /srv/source/$1/target/$1-0.1.war /srv/source/$1/target/"${1,,}".war
	mv -f /srv/source/$1/target/"${1,,}".war /srv/tomcat/webapps/
else
	# remove pasta de dados e .war do jogo no remar
	echo "Excluindo /srv/tomcat/webapps/"${1,,}""
	rm -r /srv/tomcat/webapps/"${1,,}"
	rm /srv/tomcat/webapps/"${1,,}".war
fi


