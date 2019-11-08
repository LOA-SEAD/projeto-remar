#!/usr/bin/python
#coding: utf-8

# $1 = input text
# $2 = output file name

# To Install GTTS and mpg123
# execute: apt update; apt install python-pip mpg123; pip install setuptools --upgrade; pip install gTTS

import subprocess
import codecs
import sys

command = 'gtts-cli \'{0}\' --lang pt-br --output tmp.mp3; mpg123 -w {1} tmp.mp3 > /dev/null 2>&1; rm tmp.mp3'
params = sys.argv
command = command.format(params[1], params[2])
print command
subprocess.call(command, shell=True)
