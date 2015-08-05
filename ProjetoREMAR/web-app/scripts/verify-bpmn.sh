#!/bin/bash
bpmn=".bpmn"

cd $1

file=`find . -type f -name $2$bpmn`

if [[ -n "$file" ]]; then
	cp $file ../../../processes/
	echo "1"
else
	echo "0" 
fi