#!/bin/bash

# Give chromium sound & camera & GPU
setfacl -R -m u:100007:rw /dev/snd
setfacl -m u:100007:rw /dev/dri/card0
setfacl -m u:100007:rw /dev/video0

# Give telegram sound & camera & GPU
setfacl -R -m u:100021:rw /dev/snd
setfacl -m u:100021:rw /dev/dri/card0
setfacl -m u:100021:rw /dev/video0
