#!/usr/bin/env bash

cd $1

find windows -type f | xargs zip windows.zip
find linux -type f | xargs zip linux.zip
find mac -type f | xargs zip mac.zip

rm -rf windows linux mac

for FILE in *
do
    mv ${FILE} $2-${FILE}
done