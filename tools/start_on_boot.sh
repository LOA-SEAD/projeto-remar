#!/bin/bash

REMAR_DIR=/home/hugo/projeto-remar
DATA_FILE=$REMAR_DIR/data.vol
METADATA_FILE=$REMAR_DIR/metadata.vol
DOCKER_DIR=/srv/source/Docker

if [ ! -f $DATA_FILE ]; then
	echo "Creating $DATA_FILE."
	truncate -s 100G $DATA_FILE
fi

if [ ! -f $METADATA_FILE ]; then
	echo "Creating $METADATA_FILE."
	truncate -s 1G $METADATA_FILE
fi

sudo losetup /dev/loop5 $DATA_FILE
sudo losetup /dev/loop6 $METADATA_FILE

echo "Starting automatic docker-compose up from boot (CRONTAB)" >> $REMAR_DIR/convoy.log
sudo convoy daemon --drivers devicemapper --driver-opts dm.datadev=/dev/loop5 --driver-opts dm.metadatadev=/dev/loop6 >> $REMAR_DIR/convoy.log &

cd $DOCKER_DIR
sudo service docker start
sudo docker-compose up
