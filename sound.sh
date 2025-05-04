#!/bin/bash

# Give X11 chromium sound & camera & GPU
setfacl -R -m u:100007:rw /dev/snd
setfacl -m u:100007:rw /dev/dri/card0
setfacl -m u:100007:rw /dev/video0

# Give X11 telegram sound & camera & GPU
setfacl -R -m u:100021:rw /dev/snd
setfacl -m u:100021:rw /dev/dri/card0
setfacl -m u:100021:rw /dev/video0

# Give Wayland sayonara sound
setfacl -R -m u:109823:rw /dev/snd

# Give Wayland VLC sound 
setfacl -R -m u:109813:rw /dev/snd
setfacl -m u:109813:rw /dev/dri/card0
