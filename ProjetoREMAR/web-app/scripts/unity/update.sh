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

echo "Step 1 - Copy"

for FILE in *;
do
	if [ -d "${FILE}" ] ; then
		mkdir -p ${base}/windows/Assets/Resources/${FILE} && cp -v ${FILE}/* ${base}/windows/Assets/Resources/${FILE}
		mkdir -p ${base}/linux/Assets/Resources/${FILE} && cp -v ${FILE}/* ${base}/linux/Assets/Resources/${FILE}
		mkdir -p ${base}/mac/$4.app/Contents/Data/Resources/${FILE} && cp -v ${FILE}/* ${base}/mac/$4.app/Contents/Data/Assets/Resources/${FILE}
	else
	    cp -v ${FILE} ${base}/windows/Assets/Resources/${FILE}
	    cp -v ${FILE} ${base}/linux/Assets/Resources/${FILE}
	    cp -v ${FILE} ${base}/mac/$4.app/Contents/Data/Assets/Resources/${FILE}
	fi
done

echo "Step 2 - With all files in their places, zip the source again"

# With all files in their places, zip the source again
cd ${base}/windows
zip -rq ${desktop}/$2-windows.zip *
cd ${base}/linux
zip -rq ${desktop}/$2-linux.zip *
cd ${base}/mac
zip -rq ${desktop}/$2-mac.zip *

echo "Step 3 - Remove Custom files"

# Remove custom files
cd ${root}/published/$3/desktop/windows/resources/app

for FILE in *;
do
    rm -rv ${base}/windows/Assets/Resources/${FILE}
    rm -rv ${base}/linux/Assets/Resources/${FILE}
    rm -rv ${base}/mac/$4.app/Contents/Data/Assets/Resources/${FILE}
done
