#!/usr/bin/python
#coding: utf-8

# $1 = input text
# $2 = output file name

import subprocess
import codecs
import sys

command = 'gtts-cli \'{0}\' --lang pt --output tmp.mp3; mpg123 -w {1} tmp.mp3 > /dev/null 2>&1; rm tmp.mp3'
params = sys.argv
command = command.format(params[1], params[2])
print command
subprocess.call(command, shell=True)
