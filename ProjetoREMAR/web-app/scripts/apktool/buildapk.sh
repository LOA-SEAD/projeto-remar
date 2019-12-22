#!/usr/bin/env bash

#   $1: Application root path (where /data, /scripts, /data etc are located)
#   $2: Game URI
#   $3: The instance process ID

root=${1::-1}
desktop="${root}/published/$3/desktop"
base="${root}/data/resources/sources/$2/base"

apktool=${root}/scripts/apktool
tmp=$(pwd)/tmp

echo "Step 1 - Create temporary folder"

mkdir -p ${tmp}

echo "Step 2 - Copy"

cp -v ${base}/$2.apk ${tmp}

echo "Step 3 - Build apk"

cd ${tmp}

java -jar ${apktool}/apktool.jar d -f $2.apk

cd ${root}/published/$3/mobile/assets/www
for FILE in *;
do
	if [ -d "${FILE}" ] ; then
		mkdir -p ${tmp}/$2/assets/${FILE} && cp -v ${FILE}/* ${tmp}/$2/assets/${FILE}
	else
		cp -v ${FILE} ${tmp}/$2/assets/${FILE}
	fi
done

cd ${tmp}

java -jar ${apktool}/apktool.jar b $2 -o tmp.apk
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore ${apktool}/remar.keystore -storepass remarloa tmp.apk remar
jarsigner -verify tmp.apk
rm $2.apk
zipalign -v 4 tmp.apk $2.apk

echo "Step 4 - Move apk to published dir"

zip -m $2-android.zip $2.apk
mv $2-android.zip ${root}/published/$3/mobile

echo "Step 4 - Remove temporary folder"

cd ..
rm -rf ${tmp}
