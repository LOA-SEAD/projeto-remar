#!/usr/bin/env bash

uri=$3
firstLetter=${uri:0:1}
firstLetter=${firstLetter^^}
apk_name=${firstLetter}${uri:1}

APK_1=${apk_name}-arm.apk
APK_2=${apk_name}-x86.apk

ZIPALIGN_PARENT=$1/scripts/crosswalk
KEYSTORE=${ZIPALIGN_PARENT}/keystore
BUILD_TOOLS="/dev-tools/android/build-tools/current"

cd $2

cp $1/data/resources/sources/$3/android/*.apk .

find assets -type f | xargs zip ${APK_1}

find assets -type f | xargs zip ${APK_2}

zip -d ${APK_1} META-INF/\*

jarsigner -sigalg SHA1withRSA -digestalg SHA1 -keystore ${KEYSTORE} -storepass android ${APK_1} androiddebugkey

${BUILD_TOOLS}/zipalign 4 ${APK_1} ${APK_1}-tmp

mv ${APK_1}-tmp ${APK_1}

zip -d ${APK_2} META-INF/\*
jarsigner -sigalg SHA1withRSA -digestalg SHA1 -keystore ${KEYSTORE} -storepass android ${APK_2} androiddebugkey
${BUILD_TOOLS}/zipalign 4 ${APK_2} ${APK_2}-tmp
mv ${APK_2}-tmp ${APK_2}

zip -0 $3-android.zip *.apk

rm -f ${APK_1} ${APK_2}
