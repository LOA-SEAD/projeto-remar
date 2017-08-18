#!/bin/sh

#1 - template.scss
#2 - output.css
#3 - parametro que substituirá char_orientacao
#4 - parametro que substituirá facilPares
#5 - parametro que substituirá medioPares
#6 - parametro que substituirá dificilPares

cp $1 ./style.scss


sed -i -- 's/<char_orientacao>/'$3'/g' style.scss
sed -i -- 's/<facilPares>/'$4'/g' style.scss
sed -i -- 's/<medioPares>/'$5'/g' style.scss
sed -i -- 's/<dificilPares>/'$6'/g' style.scss

sass style.scss $2
rm style.scss
rm -rf .sass-cache