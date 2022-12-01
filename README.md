# Security Updates

## Setup

1. Run following command:

```
sudo apt-get update && sudo apt-get install -y git && git clone https://github.com/ccpu/x-ui-docker tmp && mv tmp/* . && rm -rf tmp
```

2. Install docker by running `sudo bash install-docker.sh` script.

   > Note: You can run install-rootless-docker.sh bash script to install docker rootless, but be cautious when hardening linux with [this script](https://github.com/konstruktoid/hardening). It will cause problem such as [this issue](https://github.com/docker/docker-install/issues/324.) for rootless docker.

3. Create by running `sudo bash create-x-ui-image.sh`.
4. Run `sudo docker compose up`

## TODO

### Run Docker as none root user

> Docker sometime throw 'unable to open database file: no such file or directory', its because the user in docker image 'pwuser' don't have a permission to read the mounted volume.

### server hardening

1. Create none root user and disable root user using following functions in this [repo](https://github.com/ccpu/secure-linux):
   - add_user
   - disable_passauth
   - prompt_rootlogin
2. Use instauration [in here](https://marketing-assets.us-east-1.linodeobjects.com/Linode_eBook_HackerSploit_DockerSecurityEssentials.pdf) to harden machine.
