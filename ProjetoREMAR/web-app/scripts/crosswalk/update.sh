#!/usr/bin/env bash

# $1: Application root path (where /data, /scripts, /data etc are located)
# $2: Mobile Folder
# $3: Game uri
# $4: Game name

export ANDROID_HOME="/dev-tools/android"
export CROSSWALK_PATH="/dev-tools/crosswalk"
export PATH=$ANDROID_HOME:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH

mkdir $2/tmp

cd $2/tmp

cp -r $1/data/resources/sources/$3/base/* .

cp $1/scripts/crosswalk/manifest.json .
cp $1/scripts/.REMAR .
cp $1/stats/login.js .
cp $1/stats/login.html .
cp $1/stats/logo-remar-preto-transparente.png .

cp -r $2/assets/www/* .

sed -i.bkp "s/NAME/$4/" manifest.json

name=${4,,}

${CROSSWALK_PATH}/make_apk.py --package br.ufscar.sead.loa.remar.published.$3.$name --manifest manifest.json --target-dir .

ls

mv *.apk $2

cd $2

zip -0 $3-android.zip *.apk

rm *.apk

rm -r tmp
