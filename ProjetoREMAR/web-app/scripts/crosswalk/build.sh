#!/usr/bin/env bash

# $1: Application root path (where /data, /scripts, /data etc are located)
# $2: Mobile Folder
# $3: Game uri
# $4: Game name
# $5: Process ID

export ANDROID_HOME="/dev-tools/android"
export CROSSWALK_PATH="/dev-tools/crosswalk"
export PATH=$ANDROID_HOME:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH

rm -f $2/tmp

mkdir $2/tmp

cd $2/tmp

cp -r ${1::-1}/data/resources/sources/$3/base/* .

cp $1/scripts/crosswalk/manifest.json .
cp $1/scripts/.REMAR .
cp $1/stats/login.js .
cp $1/stats/login.html .
cp $1/stats/logo-remar-preto-transparente.png .

#cp $1/images/logo/favicon.png ./icon.png
cp $2/../banner.png ./icon.png

cp -r $2/assets/www/* .

sed -i.bkp "s/NAME/$4/" manifest.json

${CROSSWALK_PATH}/make_apk.py --name "$4" --package br.ufscar.sead.loa.remar.published.$3$5 --manifest manifest.json --target-dir . --verbose

#mv ${3^}$5_arm.apk $3_arm.apk
#mv ${3^}$5_x86.apk $3_x86.apk

mv *.apk $2

cd $2

zip -0 $3-android.zip *.apk

rm *.apk

rm -r tmp
