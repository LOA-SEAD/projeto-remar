#!/bin/bash

##################################################
# USAGE:                                         #
# publish_android.sh root_dir app_dir target_dir #
##################################################
# DEPENDENCIES:                                  #
# Latest TideSDK                                 #
##################################################
# NECESSARY CONFIGS:                             #
# Edit sources.sh to fit your environment        #
# Ensure permission to execute (chmod +x)        #
##################################################

source $1/web-app/scripts/sources.sh # TODO: REMOVE WHEN RUNNING PRODUCTION <---------
source $1/scripts/sources.sh


tidebuilder.py -d $3 $2

cd $3

zip -r mathjong_linux.zip MathJong