#!/bin/bash

echo "Updating apt"

sudo apt-get update -y
echo "Update Finished"
sudo apt-get upgrade -y
echo "Upgrade finished"