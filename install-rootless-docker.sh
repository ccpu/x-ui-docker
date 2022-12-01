#!/bin/bash

echo "Installing Requirements"

curl -fsSL https://get.docker.com/rootless | sh

echo "export XDG_RUNTIME_DIR=/home/${USER}/.docker/run" >> ~/.bashrc
echo "export PATH=/home/${USER}/bin:\$PATH" >> ~/.bashrc
echo "export DOCKER_HOST=unix:///run/user/${UID}/docker.sock" >> ~/.bashrc

systemctl --user start docker
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)

read -p "Reboot Required, Reboot machine(y/n)?" -n 1 -r
echo    # (optional) move to a new line
if [ "$REPLY" == "y" ]; then
   sudo reboot
fi
