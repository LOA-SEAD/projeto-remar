#!/bin/sh

sudo losetup /dev/loop20 $HOME/data.vol && sudo losetup /dev/loop21 $HOME/metadata.vol && sudo convoy daemon --drivers devicemapper --driver-opts dm.datadev=/dev/loop20 --driver-opts dm.metadatadev=/dev/loop21

