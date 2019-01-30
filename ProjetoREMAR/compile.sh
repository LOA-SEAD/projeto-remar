#!/bin/sh

grails war
cd target
sudo rm -rf ROOT
mkdir ROOT
unzip ProjetoREMAR-0.1.war -d ROOT
cd ROOT
sudo cp -rv * ~/volume_docker_remar/ROOT
