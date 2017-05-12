if [[ $1 = "-s" ]]; then
	/srv/tomcat/bin/catalina.sh stop
fi

cd /srv/source/ProjetoREMAR
grails war
rm -r /srv/tomcat/webapps/ROOT*
cp target/ProjetoREMAR-0.1.war /srv/tomcat/webapps/ROOT.war

rm /srv/tomcat/logs/*
/srv/tomcat/bin/catalina.sh start
tail -f /srv/tomcat/logs/catalina.out

