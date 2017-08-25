#!/bin/sh

#$1 = TILES_PATH , should be something like [..]/data/1/tiles
TILES_PATH="$1"
convert -append ${TILES_PATH}/../../../images/flipped.jpg ${TILES_PATH}/facil/cartas_difficulty.png ${TILES_PATH}/medio/cartas_difficulty.png ${TILES_PATH}/dificil/cartas_difficulty.png ${TILES_PATH}/cartas.png
