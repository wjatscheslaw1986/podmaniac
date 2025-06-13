#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Error: Please provide video' URL and format."
    exit 1
fi

# Format line example: -f "bv*[vcodec^=avc1]+ba[acodec^=mp4a]/b[ext=mp4]" \

./.venv/bin/yt-dlp \
    -f $2 \
    --merge-output-format mp4 \
    --abort-on-unavailable-fragments \
    --write-auto-sub \
    --sub-lang=en \
    --cookies-from-browser firefox:o7m672el.default-release \
    --cookies ./c.txt \ -o "./%(creator)s/%(title)s.%(ext)s" "$1"
