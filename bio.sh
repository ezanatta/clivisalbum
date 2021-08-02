#!/bin/bash

get_print_bio(){

    ARTIST="$(mpc current --format='%artist%')"

    glyrc artistbio -f "lastfm" --artist "$ARTIST" -l=eng --write current_bio.txt

}

ARTIST="$(mpc current --format='%artist%')"

while true; do
    ARTIST2="$(mpc current --format='%artist%' --wait)"

    if [ "$ARTIST2" = "$ARTIST" ]; then
        ARTIST="$ARTIST2"
        continue
    fi

    ARTIST="$ARTIST2"

    get_print_bio
done
