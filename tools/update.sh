#!/usr/bin/env bash

./backup.sh
cd /srv/production/source
git pull
cd ProjetoREMAR
grails war
cd target
cp ProjetoREMAR-0.1.war /srv/production/tomcat/webapps/ROOT.war
cd /srv/production
./backup-folders.sh --restore