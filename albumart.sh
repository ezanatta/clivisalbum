#!/bin/bash

#
# By Emilio Zanatta
#

for (( ; ;  ))
do
    ALBUM="$(ncmpcpp --current-song %b -q)"
    ARTIST="$(ncmpcpp --current-song %a -q)"

    glyrc cover --artist "$ARTIST" --album "$ALBUM" -v=0 --write current_art.png

    chafa --color-space=din99d current_art.png -c 240 --symbols=block+dot+stipple+hhalf+vhalf+ascii --fill none --work=9
    convert current_art.png +dither -colors 5 -unique-colors txt: > current_colors
    awk 'NR>=2 {print $3}' current_colors > awk_current_colors
    echo 'gradient=false' >> awk_current_colors
    cp awk_current_colors ~/.config/vis/colors/dark

    sleep 30
done
