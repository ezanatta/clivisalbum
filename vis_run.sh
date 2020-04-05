inotifywait -m -e modify ~/.config/vis/colors/dark |
    while read events; do
        vis
    done
