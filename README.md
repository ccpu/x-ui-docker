# Security Updates

Update/upgrade server and secure server.

```
sudo apt-get update && sudo apt-get install curl &&
curl -sf -L https://raw.githubusercontent.com/ccpu/x-ui-docker/main/update-server.sh -o update-server.sh &&
chmod +x update-server.sh && sudo ./update-server.sh && sudo rm update-server.sh

```

```
sudo apt-get update && sudo apt-get install curl &&
curl -sf -L https://raw.githubusercontent.com/ccpu/x-ui-docker/main/install-rootless-docker.sh -o install-rootless-docker.sh &&
chmod +x install-rootless-docker.sh && sudo ./install-rootless-docker.sh && sudo rm install-rootless-docker.sh

```
