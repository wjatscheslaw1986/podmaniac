#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Error: Please provide playlist' URL."
    exit 1
fi

./.venv/bin/yt-dlp --abort-on-unavailable-fragments --restrict-filenames --cookies-from-browser firefox:z3tq06dx.default-esr --remote-components ejs:github --js-runtimes deno:./deno --cookies cookies.txt -o "%(title)s.%(ext)s" $1
