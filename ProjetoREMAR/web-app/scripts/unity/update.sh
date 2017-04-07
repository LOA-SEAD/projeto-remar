#!/usr/bin/env bash

#   $1: Application root path (where /data, /scripts, /data etc are located)
#   $2: Game URI
#   $3: The instance process ID

root=${1::-1}
desktop="${root}/published/$3/desktop"

# Make temporary directories
mkdir ${desktop}/windows/temp
mkdir ${desktop}/linux/temp
mkdir ${desktop}/mac/temp

# Unzip files to temporary directories
cd ${root}/data/resources/sources/$2/base

find windows.zip -type f | xargs unzip -d ${desktop}/windows/temp
find linux.zip -type f | xargs unzip -d ${desktop}/linux/temp
find mac.zip -type f | xargs unzip -d ${desktop}/mac/temp

# Copy generated resource files to each platform project's folder
# Since the files generated are the same for all platforms, we can copy them to all projects at once
cd ${desktop}/windows/resources/app

for FILE in *;
do
    cp ${FILE} ${desktop}/windows/temp/Assets/Resources/
    cp ${FILE} ${desktop}/linux/temp/Assets/Resources/
    cp ${FILE} ${desktop}/mac/temp/$2.app/Contents/Data/Resources/
done

# With all files in their places, zip the source again
cd ${desktop}/windows/temp
zip -r ${desktop}/$2-windows.zip *
cd ${desktop}/linux/temp
zip -r ${desktop}/$2-linux.zip *
cd ${desktop}/mac/temp/
zip -r ${desktop}/$2-mac.zip *

# Remove temporary folders
rm -r ${desktop}/windows/temp
rm -r ${desktop}/linux/temp
rm -r ${desktop}/mac/temp
