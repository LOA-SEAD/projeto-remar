#!/bin/bash

# $1 = wav file name
# $2 = mp3 file name

# To install lame
# execute: 
# apt install lame

lame -V2 -f $1 $2 > /dev/null 2>&1

