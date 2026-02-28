#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Error: Please provide playlist' URL."
    exit 1
fi

./.venv/bin/yt-dlp --abort-on-unavailable-fragments --audio-quality=0 -x --audio-format=mp3 --cookies cookies.txt  --remote-components ejs:github --js-runtimes deno:./deno -o "./%(channel)s/%(playlist)s/%(title)s.%(ext)s" "$1"
