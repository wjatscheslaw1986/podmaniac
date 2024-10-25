#!/bin/bash
set -e -x
curl -L https://www.openssl.org/source/openssl-3.3.2.tar.gz -o openssl.tar.gz
echo "2e8a40b01979afe8be0bbfb3de5dc1c6709fedb46d6c89c10da114ab5fc3d281 ./openssl.tar.gz" | sha256sum -c -
curl -L https://www.openssl.org/source/openssl-3.3.2.tar.gz.asc -o openssl.tar.gz.asc