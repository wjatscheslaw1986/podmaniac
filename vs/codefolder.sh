#!/bin/bash

setfacl -R -m u:100019:rxw /home/$(whoami)/Code
