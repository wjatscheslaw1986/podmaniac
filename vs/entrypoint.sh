#!/bin/bash
set -e
export PATH=$(echo $PATH):/home/$1/jdk-23.0.1/bin
code --verbose
