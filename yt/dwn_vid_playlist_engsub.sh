#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Error: Please provide playlist' URL."
    exit 1
fi

./.venv/bin/yt-dlp --abort-on-unavailable-fragments -f "bv*+ba/b" --write-auto-sub --sub-lang=en -o "./%(creator)s/%(playlist)s/%(title)s.%(ext)s" "$1"
