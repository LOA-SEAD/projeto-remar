#!/bin/sh

#$1 = ownerId
TILES_PATH="../data/$1/tiles"
convert -append ../images/flipped.jpg ${TILES_PATH}/facil/cartas_new.png ${TILES_PATH}/medio/cartas_new.png ${TILES_PATH}/dificil/cartas_new.png ${TILES_PATH}/cartas_final.png