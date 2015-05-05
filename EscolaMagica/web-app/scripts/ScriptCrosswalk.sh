#!/bin/bash

ANDROID_HOME=/home/loa/Denis/android-sdk-linux/ 
JAVA_HOME=/usr/lib/jvm/java-7-oracle 
CROSSWALK_HOME=/home/loa/Denis/crosswalk-cordova-12.41.296.9-x86
PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platforms:$CROSSWALK_HOME

make_apk.py --mode=shared --package=$1 --manifest=$2  --target-dir=$3 --name=$4
