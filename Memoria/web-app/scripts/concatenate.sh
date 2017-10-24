 #! /bin/bash

# how to call:
# ./concatenate.sh [-v -h] 1 9 2

#$1 = -p or -l
#$2 = destino (facil, medio, dificil)
#$3 = tiles_path -> should be something like [..]/data/ownerId/taskId/tiles
usage="$(basename "$0") [-v h] -- program to calculate the answer to life, the universe and everything
jk,

program to concatenate the tiles that comes separatedly to a single file, with 2 rows: one for A pieces, other for B pieces (each pair matches A-B)

the options are:
    -v  vertical
    -h  horizontal
"
while getopts ':vh' option; do
  case "$option" in
    #h) echo "$usage" was a help command before;
    #   exit
    #   ;;
    v) WIDTH=68
       HEIGHT=108
       border_file="$3/../../../../images/back.png"
       ;;
    h) WIDTH=148
       HEIGHT=108
       border_file="$3/../../../../images/carta_virada.png"
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

TILES_PATH="$3/" # should be something like [..]/data/1/tiles/

b=$(echo $@ | tr " " "\n") # this is a list created from the params string separated by space

tile_file_names=""
dot="."
n=0

# this FOR searches for strings that contains a dot through all the params received (searches the b list)
# those are the image names to be put in the concatenate param
for i in $b
do
	if test "${i#*$dot}" != "$i"
	then
      convert $TILES_PATH$i -resize "${WIDTH}x${HEIGHT}!" $TILES_PATH$i #resizes the image to the standard size we need
      composite -gravity center $TILES_PATH$i $border_file $TILES_PATH$i #puts the uploaded image inside our borders
	  tile_file_names="$tile_file_names$TILES_PATH$i " #this will be generating a big string: img filenames separated by space
      n=$((n+1))
	fi
done

# the var "n" was representing the 'number of images'
# now it will be 'number of pairs'
n=$((n/2))

#$2 = destino (facil, medio, dificil) , will create a dir with the specified parameter
mkdir -p $TILES_PATH$2
destino="$TILES_PATH$2/cartas_difficulty.png"

montage -mode concatenate -tile ${n}x2 ${tile_file_names} $destino

# water mark:::
# composite -dissolve 75% -gravity south wmark_image.png capa.png resultado_wm.png

rm $tile_file_names