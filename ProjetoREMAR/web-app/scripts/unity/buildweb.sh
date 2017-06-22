#!/usr/bin/env bash

#   $1: Application root path (where /data, /scripts, /data etc are located)
#   $2: Game URI
#   $3: The instance process ID

root=${1::-1}
web="${root}/published/$3/web"

# Copy source files to web directory
cp -vr ${root}/data/resources/sources/$2/base/web ${root}/published/$3

# Copy generated resource files to web project's folder
cd ${web}

for FILE in *
do
    if [[ ${FILE} == *.json ]]
    then
        cp -v ${FILE} ${web}/Assets/Resources/${FILE}
        rm -v ${FILE}
    elif [[ ${FILE} == *.html ]]
    then
        # REMAR requires that the web version have a index.html file in order to run the game
        # So we will rename [uri].html to index.html
        # Since there is only one html file in a unity web project,
        #   we can rename any html to index.html
        cp -v ${FILE} index.html
        rm -v ${FILE}
    fi
done
