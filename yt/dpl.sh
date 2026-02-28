#!/bin/bash

# Trap interrupts to prevent premature exit
trap 'echo "Script interrupted. Exiting..."; exit 1' SIGINT SIGTERM

if [[ $# -ne 1 ]]; then
    echo "Error: Please provide playlist URL."
    exit 1
fi

# Initialize counter
counter=1

# Get list of video URLs from the playlist
video_urls=$(./.venv/bin/yt-dlp --remote-components ejs:github --js-runtimes deno:./deno --get-id "$1" | sed 's/^/https:\/\/www.youtube.com\/watch?v=/')

# Loop through each video URL
while IFS= read -r url; do
    # Format counter as three-digit number
    formatted_counter=$(printf "%03d" $counter)
    
    # Download video with prefixed number in filename
    ./.venv/bin/yt-dlp --abort-on-unavailable-fragments \
        -f "bv*+ba/b" \
	--restrict-filenames \
	--cookies ./cookies.txt \
	--remote-components ejs:github \
	--js-runtimes deno:./deno \
        -o "./%(creator)s/%(playlist)s/${formatted_counter}_%(title)s.%(ext)s" \
        "$url"
    
    # Increment counter
    ((counter++))
done <<< "$video_urls"

# Explicitly wait for all background processes (if any)
wait

echo "All downloads completed successfully."
