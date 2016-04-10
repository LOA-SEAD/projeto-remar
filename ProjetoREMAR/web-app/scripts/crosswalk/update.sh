#!/usr/bin/env bash

APK_1=$3-arm.apk
APK_2=$3-x86.apk
ZIPALIGN_PARENT=$1/scripts/crosswalk
KEYSTORE=${ZIPALIGN_PARENT}/keystore

chmod +x ${ZIPALIGN_PARENT}/zipalign

cd $2

find assets -type f | xargs zip ${APK_1}
find assets -type f | xargs zip ${APK_2}

zip -d ${APK_1} META-INF/\*
jarsigner -sigalg SHA1withRSA -digestalg SHA1 -keystore ${KEYSTORE} -storepass android ${APK_1} androiddebugkey
${ZIPALIGN_PARENT}/zipalign 4 ${APK_1} ${APK_1}-tmp
mv ${APK_1}-tmp ${APK_1}

zip -d ${APK_2} META-INF/\*
jarsigner -sigalg SHA1withRSA -digestalg SHA1 -keystore ${KEYSTORE} -storepass android ${APK_2} androiddebugkey
${ZIPALIGN_PARENT}/zipalign 4 ${APK_2} ${APK_2}-tmp
mv ${APK_2}-tmp ${APK_2}

zip -0 $3-android.zip *.apk

rm -f ${APK_1} ${APK_2}