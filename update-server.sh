#!/bin/bash

#Changing the default SSH listening port
#fail2ban
#ssh port change
#Set up auto updates
#https://opensource.com/article/19/10/linux-server-security
#NTP Client
# sudo nano /etc/host.conf
# : order bind,hosts
# : nospoof on

# Disable Password Auth in ssh (MAKE SURE YOU HAVE authorized_keys SET UP BEFORE DOING THIS!!!!)
# sed -i -e 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
# echo -e "\nAllowUsers $NEW_USER_NAME\n" >> /etc/ssh/sshd_config

# # If we have authorized_keys set up in root we'll copy them over
# # to our new user and disable password auth
# if [ -a "/root/.ssh/authorized_keys" ]; then
#     if [[ $(stat -c%s "/root/.ssh/authorized_keys") -gt 10 ]]; then
#         echo -e "Detected authorized_keys file. Copying to $NEW_USER_NAME and disabled password authentication via SSH.\n"
#         mkdir /home/$NEW_USER_NAME/.ssh
#         cp /root/.ssh/authorized_keys /home/$NEW_USER_NAME/.ssh/authorized_keys
#         chown -R $NEW_USER_NAME:$NEW_USER_NAME /home/$NEW_USER_NAME/
#         chmod 700 /home/$NEW_USER_NAME/.ssh
#         chmod 400 /home/$NEW_USER_NAME/.ssh/authorized_keys
#         sed -i -e 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
#     fi
# fi

#### [ Variables ]


green="$(printf '\033[0;32m')"
red="$(printf '\033[1;31m')"
nc="$(printf '\033[0m')"


##### End of [ Variables ]

read -p "New Username:" USERNAME

echo "Updating apt"
sudo apt-get update -y
echo "Update Finished"
sudo apt-get upgrade -y
echo "Upgrade finished"

echo "Cleanup"
sudo apt-get autoremove
sudo apt-get autoclean

echo "Installing Requirements"
sudo apt-get install uidmap -y
sudo apt-get install curl -y




if [ ! -d "$HOME/.ssh" ]; then
    echo 'The /.ssh directory could not be found. The server must be configured with SSH.'
    exit
fi

# Create user and immediately expire password to force a change on login
sudo useradd --create-home --shell "/bin/bash" --groups sudo "${USERNAME}"
sudo passwd --delete "${USERNAME}"
# sudo chage --lastday 0 "${USERNAME}"

sudo loginctl enable-linger "${USERNAME}"


# Create SSH directory for sudo user and move keys over
sudo home_directory="$(eval echo ~${USERNAME})"
sudo mkdir --parents "${home_directory}/.ssh"
sudo cp $HOME/.ssh/authorized_keys "${home_directory}/.ssh"
sudo chmod 0700 "${home_directory}/.ssh"
sudo chmod 0600 "${home_directory}/.ssh/authorized_keys"
sudo chown --recursive "${USERNAME}":"${USERNAME}" "${home_directory}/.ssh"
sudo deluser "${USERNAME}" sudo

read -p "Disable root SSH login with password(y/n)? " -n 1 -r
echo    # (optional) move to a new line
if [ "$REPLY" == "y" ]; then
    # Disable root SSH login with password
    sed --in-place 's/^PermitRootLogin.*/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config
    if sshd -t -q; then systemctl restart sshd; fi
fi


echo "${red}------------Rebooting Required------------${nc}"
echo
echo "Before restarting the machine, make sure you can login with the existing SSH key and '${USERNAME}' user."
echo

read -p "${red}Reboot Machine(y/n)${nc}?" -n 1 -r
echo    # (optional) move to a new line
if [ "$REPLY" == "y" ]; then
   sudo reboot
fi