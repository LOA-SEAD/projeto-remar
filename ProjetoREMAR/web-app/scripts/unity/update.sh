#!/usr/bin/env bash

#   $1: Application root path (where /data, /scripts, /data etc are located)
#   $2: Game URI
#   $3: The instance process ID
#   $4: Game Name

root=${1::-1}
desktop="${root}/published/$3/desktop"
base="${root}/data/resources/sources/$2/base"

# Copy generated resource files to each platform project's folder
# Since the files generated are the same for all platforms, we can copy them to all projects at once
cd ${root}/published/$3/desktop/windows/resources/app

for FILE in *;
do
    cp -v ${FILE} ${base}/windows/Assets/Resources/${FILE}
    cp -v ${FILE} ${base}/linux/Assets/Resources/${FILE}
    cp -v ${FILE} ${base}/mac/$4.app/Contents/Data/Resources/${FILE}
done

# With all files in their places, zip the source again
cd ${base}/windows
zip -rq ${desktop}/$2-windows.zip *
cd ${base}/linux
zip -rq ${desktop}/$2-linux.zip *
cd ${base}/mac
zip -rq ${desktop}/$2-mac.zip *

# Remove custom files
cd ${root}/published/$3/desktop/windows/resources/app

for FILE in *;
do
    rm -v ${base}/windows/Assets/Resources/${FILE}
    rm -v ${base}/linux/Assets/Resources/${FILE}
    rm -v ${base}/mac/$4.app/Contents/Data/Resources/${FILE}
done
