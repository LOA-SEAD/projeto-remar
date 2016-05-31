#!/usr/bin/env bash

# APP_DIR="./test"
APP_DIR="/srv/production/tomcat/webapps/ROOT"

function dir_not_supplied {
	echo "Directory not supplied: assuming '/srv/backups/folders'"
	BACKUP_DIR="/srv/backups/folders"
}

function backup {
	rm -rf $BACKUP_DIR
	mkdir -p $BACKUP_DIR
	mkdir $BACKUP_DIR/images
	mkdir $BACKUP_DIR/forca
	mkdir $BACKUP_DIR/escolamagica
	mkdir $BACKUP_DIR/mahjong
	mkdir $BACKUP_DIR/respondasepuder

	cp -r $APP_DIR/data $BACKUP_DIR
	echo '/data backuped'

	cp $APP_DIR/images/*-banner.png $BACKUP_DIR/images
	echo '/images/*-banner.png backuped'

	cp -r $APP_DIR/propeller $BACKUP_DIR
	echo '/propeller backuped'

	cp -r $APP_DIR/published $BACKUP_DIR
	echo '/published backuped'

	cp -r $APP_DIR/../forca/data $BACKUP_DIR/forca
	echo '/forca/data backuped'

	cp -r $APP_DIR/../escolamagica/data $BACKUP_DIR/escolamagica
	echo '/escolamagica/data backuped'

	cp -r $APP_DIR/../mahjong/data $BACKUP_DIR/mahjong
	echo '/mahjong/data backuped'

	cp -r $APP_DIR/../respondasepuder/data $BACKUP_DIR/respondasepuder
	echo '/respondasepuder/data backuped'

	echo "Backing up MySQL tables (user, user_role and role):"
	mysqldump -uroot -p remar user user_role role > $BACKUP_DIR/../backup.sql

	echo 'DONE'
}

function restore {
	echo "Are you sure that you want to restore '$BACKUP_DIR' contents? (y/n)"
	read yn

	if [ $yn != "y" ]; then
		echo "Aborting"
		exit
	fi

	cp -r $BACKUP_DIR/data $APP_DIR
	echo '/data restored'

	cp $BACKUP_DIR/images/*-banner.png $APP_DIR/images
	echo '/images/*-banner.png restored'

	cp -r $BACKUP_DIR/propeller $APP_DIR
	echo '/propeller restored'

	cp -r $BACKUP_DIR/published $APP_DIR
	echo '/published restored'

	cp -r $BACKUP_DIR/forca/data $APP_DIR/../forca
	echo '/forca/data restored'

	cp -r $BACKUP_DIR/escolamagica/data $APP_DIR/../escolamagica
	echo '/escolamagica/data restored'

	cp -r $BACKUP_DIR/mahjong/data $APP_DIR/../mahjong
	echo '/mahjong/data restored'

	cp -r $BACKUP_DIR/respondasepuder/data $APP_DIR/../respondasepuder
	echo '/respondasepuder/data restored'

	echo "Restoring MySQL tables (user, user_role and role):"
	mysql -uroot -p remar < $BACKUP_DIR/../backup.sql

	echo 'DONE'
}

if [ -n "$1" ]; then
	if [ $1 = "-r" ] || [ $1 = "--restore" ]; then
		if [ -z "$2" ]; then
			dir_not_supplied
		else 
			BACKUP_DIR="$2"
		fi
		restore
	else
		BACKUP_DIR="$1"
		backup
	fi
else
	dir_not_supplied
	backup
fi
