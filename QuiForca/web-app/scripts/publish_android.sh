#!/bin/bash

##########################################################################################
# USAGE:                                                                                 #
# publish_android.sh root_dir package manifest_dir target_dir                            #
##########################################################################################
# DEPENDENCIES:                                                                          #
# Java SDK (JDK)                                                                         #
# Android SDK (ADK)                                                                      #
# Apache Ant                                                                             #
# Crosswalk                                                                              #
# Latest version of Android SDK Platform-tools, Android SDK Build tools and SDK Platform #
#   (Download via <android> command)                                                     #
##########################################################################################
# NECESSARY CONFIGS:                                                                     #
# Edit sources.sh to fit your environment                                                #
# Ensure permission to execute (chmod +x)                                                #
##########################################################################################

source $1/web-app/scripts/sources.sh # TODO: REMOVE WHEN RUNNING PRODUCTION <---------
source $1/scripts/sources.sh

make_apk.py --package=$2 --manifest=$3 --target-dir=$4

cd $4

zip forca_android.zip *.apk

rm -rf *.apk