#!/usr/bin/env bash

#   $1: Application root path (where /data, /scripts, /data etc are located)
#   $2: Game URI

root=${1::-1}

# Unzip files
cd ${root}/data/resources/sources/$2/base

find windows.zip -type f | xargs unzip -d ./windows -q
find linux.zip -type f | xargs unzip -d ./linux -q
find mac.zip -type f | xargs unzip -d ./mac -q

# Remove zip files
rm -v ./windows.zip ./linux.zip ./mac.zip
