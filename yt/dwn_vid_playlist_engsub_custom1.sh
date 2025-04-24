#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Error: Please provide playlist' URL."
    exit 1
fi

./.venv/bin/yt-dlp -f "bv*[vcodec^=avc1]+ba[acodec^=mp4a]/b[ext=mp4]" --merge-output-format mp4 --abort-on-unavailable-fragments --write-auto-sub --sub-lang=en -o "./%(creator)s/%(playlist)s/%(title)s.%(ext)s" "$1"
