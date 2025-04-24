#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Error: Please provide playlist' URL."
    exit 1
fi

./.venv/bin/yt-dlp --abort-on-unavailable-fragments -f "bv*+ba/b" -o "./%(creator)s/%(title)s.%(ext)s" $1
