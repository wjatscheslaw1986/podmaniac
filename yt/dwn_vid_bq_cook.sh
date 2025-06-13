#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Error: Please provide playlist' URL."
    exit 1
fi

./.venv/bin/yt-dlp --abort-on-unavailable-fragments --write-auto-sub --sub-lang=en --cookies-from-browser firefox:o7m672el.default-release --cookies ./c.txt -f "bv*+ba/b" -o "./%(creator)s/%(title)s.%(ext)s" $1
