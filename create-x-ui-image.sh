#!/bin/bash

git clone https://github.com/vaxilu/x-ui

cd x-ui
 docker build --rm -f "Dockerfile" -t local/xui "."

cd ..

echo "Image Created."

docker run --network=host \
  -v "$PWD/db/:/etc/x-ui:rw" \
  -v "$PWD/cert/:/root/cert:rw" \
  -p 54321:54321 \
  --name x-ui --restart=unless-stopped \
  -it local/xui:latest

echo "Image Created."