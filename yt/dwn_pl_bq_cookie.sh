#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Error: Please provide playlist' URL."
    exit 1
fi

./.venv/bin/yt-dlp --abort-on-unavailable-fragments --cookies cookies.txt --cookies-from-browser firefox:z3tq06dx.default-esr -f "bv*+ba/b" -o "./%(creator)s/%(playlist)s/%(title)s.%(ext)s" $1
