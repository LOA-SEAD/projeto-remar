#!/usr/bin/python
#coding: utf-8

# $1 = input text
# $2 = output file name

# To Install GTTS
# execute: apt update; apt install python-pip; pip install setuptools --upgrade; pip install gTTS

import subprocess
import codecs
import sys

command = 'gtts-cli \'{0}\' --lang pt-br --output {1}'
params = sys.argv
print params
command = command.format(params[1], params[2])
print command
subprocess.call(command, shell=True)


