#!/bin/bash

ANDROID_HOME=/home/loa/ADT/sdk 
JAVA_HOME=/usr/lib/jvm/jdk 
CROSSWALK_HOME=/home/loa/Desenvolvimento/crosswalk/crosswalk-10.39.235.15/
PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$CROSSWALK_HOME

make_apk.py --mode=shared --package=$1 --manifest=$2  --target-dir=$3 --name=$4
