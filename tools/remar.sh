cd /srv/source/ProjetoREMAR
grails war
rm -r /srv/tomcat/webapps/ROOT*
cp target/ProjetoREMAR-0.1.war /srv/tomcat/webapps/ROOT.war

cd /srv/tomcat
bin/catalina.sh start
