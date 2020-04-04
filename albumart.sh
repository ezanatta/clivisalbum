#!/bin/bash

#
# By Emilio Zanatta
#

get_cover() {

    glyrc cover --artist "$ARTIST" --album "$ALBUM" -v=0 --write current_art.png

    chafa --color-space=din99d current_art.png -c 240 --symbols=block+dot+stipple+hhalf+vhalf+ascii --fill none --work=9

}

vis_colors() {
    convert current_art.png +dither -colors 10 -unique-colors txt: > current_colors
    awk 'NR>=2 {print $3}' current_colors > awk_current_colors
    echo 'gradient=false' >> awk_current_colors
    cp awk_current_colors ~/.config/vis/colors/dark
}

ALBUM="$(ncmpcpp --current-song %b -q)"
ARTIST="$(ncmpcpp --current-song %a -q)"

get_cover
vis_colors

for (( ; ;  ))
do
    ALBUM2="$(ncmpcpp --current-song %b -q)"
    ARTIST="$(ncmpcpp --current-song %a -q)"

    if [ "$ALBUM2" = "$ALBUM" ]; then
        ALBUM="$ALBUM2"
        continue
    fi

    ALBUM="$ALBUM2"

    get_cover
    vis_colors
done
