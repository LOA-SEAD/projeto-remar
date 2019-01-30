#!/bin/bash

for i in `find $1 -name "stats.js"`
do
sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' $i 
done

for i in `find $1 -name "login.js"`
do
sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' $i
done

for i in `find $1 -name "manifest.json"`
do
sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' $i
done

for i in `find $1 -name "manifest.json.bkp"`
do
sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' $i
done

if [ -n "$2" ]; then

	cd $1/ROOT/data/resources/sources/escolamagica/
	unzip linux.zip
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' linux/resources/app/login.js
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' linux/resources/app/stats.js
	zip -mr linux linux
	unzip windows.zip
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' windows/resources/app/login.js
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' windows/resources/app/stats.js
	zip -mr windows windows
	unzip mac.zip
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' mac/escolamagica.app/Contents/Resources/app/login.js
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' mac/escolamagica.app/Contents/Resources/app/stats.js
	zip -mr mac mac

	cd $1/ROOT/data/resources/sources/forca/
	unzip linux.zip
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' linux/resources/app/login.js
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' linux/resources/app/stats.js
	zip -mr linux linux
	unzip windows.zip
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' windows/resources/app/login.js
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' windows/resources/app/stats.js
	zip -mr windows windows
	unzip mac.zip
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' mac/forca.app/Contents/Resources/app/login.js
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' mac/forca.app/Contents/Resources/app/stats.js
	zip -mr mac mac

	cd $1/ROOT/data/resources/sources/mahjong/
	unzip linux.zip
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' linux/resources/app/login.js
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' linux/resources/app/stats.js
	zip -mr linux linux
	unzip windows.zip
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' windows/resources/app/login.js
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' windows/resources/app/stats.js
	zip -mr windows windows
	unzip mac.zip
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' mac/mahjong.app/Contents/Resources/app/login.js
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' mac/mahjong.app/Contents/Resources/app/stats.js
	zip -mr mac mac

	cd $1/ROOT/data/resources/sources/respondasepuder/
	unzip linux.zip
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' linux/resources/app/login.js
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' linux/resources/app/stats.js
	zip -mr linux linux
	unzip windows.zip
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' windows/resources/app/login.js
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' windows/resources/app/stats.js
	zip -mr windows windows
	unzip mac.zip
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' mac/respondasepuder.app/Contents/Resources/app/login.js
	sed -i -e 's/remar.dc.ufscar.br/alfa.remar.online/g' mac/respondasepuder.app/Contents/Resources/app/stats.js
	zip -mr mac mac

fi
