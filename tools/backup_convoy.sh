#!/usr/bin/env bash
DATE=`date +%Y-%m-%d`

function no_backup_folder_given {
	echo "Directory not supplied: assuming '/srv/backups/folders'"
	BACKUP_DIR="/srv/backups/folders"
}

function backup {
	rm -rf $BACKUP_DIR
	mkdir -p $BACKUP_DIR
	rm -f backup_urls
	touch backup_urls

	MYSQL_SNAP="$(convoy snapshot create docker_mysql-data)"
	convoy backup create $MYSQL_SNAP --dest vfs://$BACKUP_DIR >> backup_urls

	echo "Generated MYSQL backup on ${DATE} from snapshot ${MYSQL_SNAP}"


	MONGO_SNAP="$(convoy snapshot create docker_mongo-data)"
	convoy backup create $MONGO_SNAP --dest vfs://$BACKUP_DIR >> backup_urls

	echo "Generated MongoDB backup on ${DATE} from snapshot ${MONGO_SNAP}"

	cp -r $HOME/volume_docker_remar "${BACKUP_DIR}/volume_docker_remar_${DATE}"

	echo "Generated REMAR files backup on ${DATE}"
}

function restore {
	head backup_urls | {
		read -r CURRENT_BACKUP;
		convoy delete docker_mysql-data;
		convoy create docker_mysql-data --backup CURRENT_BACKUP;
		read -r CURRENT_BACKUP;
		convoy delete docker_mongo-data;
		convoy create docker_mongo-data --backup CURRENT_BACKUP;
	}
}

if [ -n "$1" ]; then
	if [ $1 = "-r" ] || [ $1 = "--restore" ]; then
		if [ -z "$2" ]; then
			no_backup_folder_given
		else
			BACKUP_DIR="$2"
		fi
		restore
	else
		BACKUP_DIR="$1"
		backup
	fi
else
	no_backup_folder_given
	backup
fi
