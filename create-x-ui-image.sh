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

# sudo docker run \
#   -v "$PWD/db/:/etc/x-ui" \
#   -v "$PWD/cert/:/root/cert" \
#   -p 54321:54321 \
#   --name x-ui \
#   --security-opt no-new-privileges \
#   --restart unless-stopped \
#   --read-only \
#   --tmpfs /home/pwuser/bin:uid=4001 \
#   --cap-drop all \
#   -it local/xui:latest

# https://www.techrepublic.com/article/how-to-use-docker-bench-for-security-to-audit-your-container-deployments/
# https://developers.hp.com/epic-stories/blog/docker-bench-security-container-hardening-and-auditing-host-security?language=pt