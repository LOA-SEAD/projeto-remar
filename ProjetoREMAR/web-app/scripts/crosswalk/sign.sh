#!/bin/bash

# $1: APK(s) parent directory
# $2: zipalign parent directory
# $3: keystore path

for APK in $(find $1 -name "*.apk")
do
    zip -d $APK META-INF/\*
    jarsigner -sigalg SHA1withRSA -digestalg SHA1 -keystore $3 -storepass android $APK androiddebugkey
    $2/zipalign 4 $APK $APK-tmp
    mv $APK-tmp $APK
done