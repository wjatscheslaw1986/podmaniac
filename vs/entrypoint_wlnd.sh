#!/bin/bash
set -e
export PATH=$(echo $PATH):/home/$1/VSCode-linux-x64/bin
code --verbose
