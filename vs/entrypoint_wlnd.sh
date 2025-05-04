#!/bin/bash
set -e
export PATH=$(echo $PATH):/home/$1/jdk-24.0.1/bin
export PATH=$(echo $PATH):/home/$1/VSCode-linux-x64/bin
code --verbose
