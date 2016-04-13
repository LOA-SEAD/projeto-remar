#!/usr/bin/env bash

# $1: Application root path (where /data, /scripts, /data etc are located)
# $2: Game uri
# $3: Game name

source $1/scripts/crosswalk/env.sh

cd $1/data/resources/sources/$2/base

cp $1/scripts/crosswalk/manifest.json .
cp $1/scripts/.REMAR .

sed -i.bkp "s/NAME/$3/" manifest.json

make_apk.py --package br.ufscar.sead.loa.remar.published.$2 --manifest manifest.json --target-dir ..

#rm manifest.json manifest.json.bkp .REMAR

cd ..

mkdir android
mv *.apk android


for i in $(find . -name "*.apk")
do
    mv "$i" "$(echo $i | tr \_ \-)"
done