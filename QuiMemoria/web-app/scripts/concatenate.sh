 #!/bin/sh

#$1 = -p or -l
#$2 = ownerId
#$3 = destino (facil, medio, dificil)
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
       texture_file="../images/back.png"
       ;;
    l) WIDTH=160
       HEIGHT=120
       texture_file="../images/back.png"
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

TILES_PATH="../data/$2/tiles/"

b=$(echo $@ | tr " " "\n")
tile_file_names=""
dot="."
n=0
for i in $b
do
	if test "${i#*$dot}" != "$i"
	then
	    tile_file_names+="$TILES_PATH$i "
      let "n++"
	fi
done

n=$((n/2))

echo "${WIDTH}x${HEIGHT}"
mkdir -p $TILES_PATH$3
destino="$TILES_PATH$3/cartas_new.png"
montage -mode concatenate -tile ${n}x2 -texture $texture_file -geometry ${WIDTH}x${HEIGHT} ${tile_file_names} $destino

# water mark:::
# composite -dissolve 75% -gravity south wmark_image.png capa.png resultado_wm.png