#!/bin/sh

#$1 = TILES_PATH , should be something like [..]/data/ownerId/taskId/tiles
#$2 = ORIENTATION, should be "v" or "h"
TILES_PATH="$1"
ORIENTATION="$2"
convert -append ${TILES_PATH}/../../../../images/flipped_${ORIENTATION}.jpg ${TILES_PATH}/facil/cartas_difficulty.png ${TILES_PATH}/medio/cartas_difficulty.png ${TILES_PATH}/dificil/cartas_difficulty.png ${TILES_PATH}/cartas.png
