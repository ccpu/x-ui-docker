#!/bin/bash

git clone https://github.com/ccpu/x-ui.git

# https://github.com/moby/moby/issues/2259
# Docker image with none root user cant access volumes
# Hence giving access to user created in the image using chown
mkdir db
mkdir cert
chown -R 4001 /home/mo/db/
chown -R 4001 /home/mo/cert/

cd x-ui
 docker build --rm -f "Dockerfile" -t local/xui "."

cd ..

echo "Image Created."