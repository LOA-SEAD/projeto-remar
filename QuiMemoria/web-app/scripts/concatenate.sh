 #!/bin/sh

#$1 = -p or -l
#$2 = ownerId
#$3 = tile X
#$4 = tile Y
usage="$(basename "$0") [-h] [-p l] -- program to calculate the answer to life, the universe and everything

where:
    -p  portrait
    -l  landscape
"
while getopts ':pl:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    p) WIDTH=80
       HEIGHT=120
       ;;
    l) WIDTH=160
       HEIGHT=120
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

TILES_PATH="../images/data/$2/tiles/"

b=$(echo $@ | tr " " "\n")
tile_file_names=""
dot="."
for i in $b
do
	if test "${i#*$dot}" != "$i"
	then
	    tile_file_names+="$TILES_PATH$i "
	fi
done

echo $tile_file_names

magick montage -mode concatenate -tile $3x$4 -resize $WIDTHx$HEIGHT ${tile_file_names}


# water mark:::
# composite -dissolve 75% -gravity south wmark_image.png capa.png resultado_wm.png

