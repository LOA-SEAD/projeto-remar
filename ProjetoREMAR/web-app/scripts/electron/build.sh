#!/usr/bin/env bash

# $1: Application root path (where /data, /scripts, /data etc are located)
# $2: Game uri
# $3: Game name

cd $1/data/resources/sources/$2/base

cp $1/scripts/electron/main.js .
cp $1/scripts/electron/package.json .
cp $1/scripts/.REMAR .
cp $1/stats/login.js .
cp $1/stats/login.html .
cp $1/stats/logo-remar-preto-transparente.png .


sed -i.bkp "s/NAME/$3/" package.json

electron-packager . $3 --platform win32 --arch ia32 --version 0.37.5 --out ..
electron-packager . $3 --platform linux --arch x64 --version 0.37.5 --out ..
electron-packager . $3 --platform darwin --arch all --version 0.37.5 --out ..

rm main.js package.json package.json.bkp .REMAR login.js login.html logo-remar-preto-transparente.png

cd ..

mv *win32-ia32 windows
mv *linux-x64 linux
mv *darwin-x64 mac

zip -r windows.zip windows
zip -r linux.zip linux
zip -r mac.zip mac

rm -rf windows linux mac