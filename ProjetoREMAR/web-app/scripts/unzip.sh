#!/bin/bash
war=".war"

cd $1
echo `unzip -q -o $2$war -d $2`