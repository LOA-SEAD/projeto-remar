 #! /bin/bash

#$1 = -p or -l
#$2 = destino (facil, medio, dificil)
#$3 = tiles_path
usage="$(basename "$0") [-v h] -- program to calculate the answer to life, the universe and everything
jk,

program to concatenate the tiles that comes separatedly to a single file, with 2 rows: one for A pieces, other for B pieces (each pair matches A-B)

the options are:
    -v  vertical
    -h  horizontal
"
while getopts ':v:h:' option; do
  case "$option" in
    #h) echo "$usage" was a help command before;
    #   exit
    #   ;;
    v) WIDTH=80
       HEIGHT=120
       texture_file="$3/../../../images/back.png"
       ;;
    h) WIDTH=160
       HEIGHT=120
       # TODO change this to a texture image that is 160x120
       texture_file="$3/../../../images/back.png"
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
# how to call:
# ./script.sh -p 1 9 2 

TILES_PATH="$3/" # should be something like [..]/data/1/tiles/

b=$(echo $@ | tr " " "\n")
tile_file_names=""
dot="."
n=0

# this for searches in all the params this script receives for strings that contains a dot
# those are the image names to be put in the concatenate param
for i in $b
do
	if test "${i#*$dot}" != "$i"
	then
	  tile_file_names="$tile_file_names$TILES_PATH$i " #this will be generating a big string: img filenames separated by space
      n=$((n+1))
	fi
done

n=$((n/2))

echo "${WIDTH}x${HEIGHT}"
mkdir -p $TILES_PATH$2
destino="$TILES_PATH$2/cartas_difficulty.png"
montage -mode concatenate -tile ${n}x2 -texture $texture_file -geometry ${WIDTH}x${HEIGHT} ${tile_file_names} $destino

rm $tile_file_names
# water mark:::
# composite -dissolve 75% -gravity south wmark_image.png capa.png resultado_wm.png