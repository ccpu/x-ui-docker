#!/bin/bash

git clone https://github.com/ccpu/x-ui.git

cd x-ui
 docker build --rm -f "Dockerfile" -t local/xui "."

cd ..

echo "Image Created."

docker run \
  -v "$PWD/db/:/etc/x-ui" \
  -v "$PWD/cert/:/root/cert" \
  -p 54321:54321 \
  --name x-ui \
  --restart unless-stopped \
  -it local/xui:latest

echo "Image Created."