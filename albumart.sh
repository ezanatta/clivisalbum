#!/bin/bash

#
# By Emilio Zanatta
#

get_cover() {

    glyrc cover --artist "$ARTIST" --album "$ALBUM" -v=0 --write current_art.png
    #chafa --color-space=din99d current_art.png -c 240 --symbols=block+dot+stipple+hhalf+vhalf+ascii --fill none --work=9
    convert current_art.png -resize 50x50 current_art_panel.png
    chafa current_art.png
}

vis_colors() {
    convert current_art.png +dither -colors 10 -unique-colors txt: > current_colors
    awk 'NR>=2 {print $3}' current_colors > awk_current_colors
    echo 'gradient=false' >> awk_current_colors
    cp awk_current_colors ~/.config/vis/colors/dark
}

ALBUM="$(mpc current --format='%album%')"
ARTIST="$(mpc current --format='%artist%')"

get_cover
vis_colors

#for (( ; ;  ))
#do
while true; do
    ALBUM2="$(mpc current --format='%album%' --wait)"
    ARTIST="$(mpc current --format='%artist%')"

    if [ "$ALBUM2" = "$ALBUM" ]; then
        ALBUM="$ALBUM2"
        continue
    fi

    ALBUM="$ALBUM2"

    get_cover
    vis_colors

    # sleep 180
done
