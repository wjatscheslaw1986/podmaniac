#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Error: Please provide playlist' URL."
    exit 1
fi

#.venv/bin/yt-dlp --audio-quality=0 -x --audio-format=mp3 -o "./%(channel)s/%(title)s.%(ext)s" \"$1\"
#
#.venv/bin/yt-dlp -f "bv*+ba/b" -o "./%(creator)s/%(playlist)s/%(title)s.%(ext)s" \"$1\"
#.venv/bin/yt-dlp -f "bv*+ba/b" --write-auto-sub --sub-lang=en -o "./%(creator)s/%(playlist)s/%(title)s.%(ext)s" \"$1\"
#.venv/bin/yt-dlp -f "bv*+ba/b" -S "codec:265" --write-auto-sub --sub-lang=en -o "./%(creator)s/%(playlist)s/%(title)s.%(ext)s" \"$1\"
#.venv/bin/yt-dlp -f "bv*[vcodec^=avc1]+ba[acodec^=mp4a]/b[ext=mp4]" --write-auto-sub --sub-lang=en -o "./%(creator)s/%(playlist)s/%(title)s.%(ext)s" \"$1\"
#.venv/bin/yt-dlp -f "bv*[vcodec^=avc1]+ba[acodec^=mp4a]/b[ext=mp4]" -o "./%(creator)s/%(title)s.%(ext)s"
#.venv/bin/yt-dlp -f "bv*+ba/b" -o "./%(creator)s/%(title)s.%(ext)s" 
#.venv/bin/yt-dlp -S "codec:264" -o "./%(creator)s/%(title)s.%(ext)s" \"$1\"

