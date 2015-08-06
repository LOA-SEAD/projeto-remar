#!/bin/bash

##########################################################################################
# USAGE:                                                                                 #
# publish_android.sh package manifest_dir target_dir                                     #
#                                                                                        #
# Dependencies:                                                                          #
# Java SDK (JDK)                                                                         #
# Android SDK (ADK)                                                                      #
# Apache Ant                                                                             #
# Crosswalk                                                                              #
# Latest version of Android SDK Platform-tools, Android SDK Build tools and SDK Platform #
#   (Download via <android> command)                                                     #
#                                                                                        #
# Necessary configs:                                                                     #
# create "sources.sh" on this directory and put the following:                           #
#   export PATH=<path to ant>/bin:$PATH                                                  #
#   export PATH=<path to JDK>/bin:$PATH                                                  #
#   export JAVA_HOME=<path to JDK>                                                       #
#   export ANDROID_HOME=<path to Android SDK>                                            #
#   export PATH=$ANDROID_HOME:$PATH                                                      #
#   export PATH=$ANDROID_HOME/tools:$PATH                                                #
#   export PATH=$ANDROID_HOME/platform-tools:$PATH                                       #
#   export PATH=<path to crosswalk>:$PATH                                                #
#                                                                                        #
# Ensure permission to execute (chmod +x)                                                #
##########################################################################################

source `pwd`/web-app/scripts/sources.sh

 make_apk.py --package=$1 --manifest=$2  --target-dir=$3 --verbose


