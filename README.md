# Security Updates

Update/upgrade server and secure server.

```
sudo apt-get update && sudo apt-get install curl &&
curl -sf -L https://raw.githubusercontent.com/ccpu/x-ui-docker/main/update-server.sh -o update-server.sh &&
chmod +x update-server.sh && sudo ./update-server.sh && sudo rm update-server.sh

```

```
curl -sf -L https://raw.githubusercontent.com/ccpu/x-ui-docker/main/install-rootless-docker.sh -o install-rootless-docker.sh &&
chmod +x install-rootless-docker.sh && ./install-rootless-docker.sh && rm install-rootless-docker.sh
```

```
sudo apt-get install -y uidmap && sudo apt-get install -y curl && sudo apt-get install -y git
```

```
curl -sf -L https://raw.githubusercontent.com/ccpu/x-ui-docker/main/create-x-ui-image.sh -o create-x-ui-image.sh &&
chmod +x create-x-ui-image.sh && ./create-x-ui-image.sh && rm create-x-ui-image.sh
```
