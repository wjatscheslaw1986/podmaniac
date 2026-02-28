#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Error: Please provide playlist' URL."
    exit 1
fi

./.venv/bin/yt-dlp --abort-on-unavailable-fragments --restrict-filenames --cookies cookies.txt --remote-components ejs:github --js-runtimes deno:./deno -o "%(title)s.%(ext)s" $1
