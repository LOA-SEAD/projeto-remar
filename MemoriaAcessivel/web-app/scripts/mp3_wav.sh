#!/bin/bash

# $1 = mp3 file name
# $2 = wav file name

# To install mpg123
# execute: 
# apt install mpg123

mpg123 -w $2 $1 > /dev/null 2>&1

