#!/usr/bin/python
#coding: utf-8

# $1 = input text
# $2 = output file name

# To Install AWS Polly
# execute: 
# curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"; unzip awscli-bundle.zip; /awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

import subprocess
import codecs
import sys

command = 'aws polly synthesize-speech --output-format mp3 --text-type ssml --voice-id "{0}" --text "<speak>{1}</speak>" {2}'

params = sys.argv
print params
command = command.format("Vitoria", params[1], params[2])
print command
subprocess.call(command, shell=True)


