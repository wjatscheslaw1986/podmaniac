#!/bin/bash
podman build -t ftps --build-arg USR=ftpuser --build-arg PSWRD=$1 .
