#!/bin/sh

sudo losetup /dev/loop5 $HOME/data.vol && sudo losetup /dev/loop6 $HOME/metadata.vol && sudo convoy daemon --drivers devicemapper --driver-opts dm.datadev=/dev/loop5 --driver-opts dm.metadatadev=/dev/loop6 &
cd ~/source/Docker
sudo docker-compose up
