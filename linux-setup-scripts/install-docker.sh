
# This script installs the Docker Engine and CLI on a Linux Mint machine (or Ubuntu machine with 1 line modification) 
# In addition it adds the 'docker' group to user, so non-root users can run docker (required for Spock tests to run)
# 
# The script is based on the following instructions from Docker's documentation:
# 1. https://docs.docker.com/engine/install/ubuntu/
# 2. https://docs.docker.com/engine/install/linux-postinstall/

# 1. Install Docker with apt

## Add Docker's official GPG key:
echo "sudo apt-get update" && sudo apt-get update
echo "sudo apt-get install ca-certificates curl" && sudo apt-get install ca-certificates curl
echo "sudo install -m 0755 -d /etc/apt/keyrings" && sudo install -m 0755 -d /etc/apt/keyrings
echo "sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc" && sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
echo "sudo chmod a+r /etc/apt/keyrings/docker.asc" && sudo chmod a+r /etc/apt/keyrings/docker.asc

## Add the repository to Apt sources:

# Note: If you use an Ubuntu derivative distribution, such as Linux Mint, you may need to use UBUNTU_CODENAME instead of VERSION_CODENAME.
UBUNTU_VERSION_CODENAME="$(. /etc/os-release && echo "$UBUNTU_CODENAME")"
if [ "${UBUNTU_VERSION_CODENAME}" = "" ]; then 
	echo "UBUNTU_CODENAME is empty. Maybe you need to use VERSION_CODENAME in the UBUNTU_VERSION_CODENAME declaration instead?"
	exit 1
fi

echo "Running deb command which includes 'sudo tee /etc/apt/sources.list.d/docker.list > /dev/null'"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
   ${UBUNTU_VERSION_CODENAME} stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "sudo apt-get update" && sudo apt-get update

echo "sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## Verify docker installed correctly
sudo docker run hello-world

# 2. Post-install config

## Create 'docker' group if it does not exist
if [ $(cat /etc/group | grep docker) = "" ]; then
	echo "sudo groupadd docker" && sudo groupadd docker
fi

## Add your user to the docker group.
echo "sudo usermod -aG docker ${USER}" && sudo usermod -aG docker
echo ""
echo "### Restart your VM and then try to run 'docker run hello-world' to see if it works."

echo "Note: If you initially ran Docker CLI commands using sudo before adding your user to the docker group, you may see the following error:"

echo "'WARNING: Error loading config file: /home/user/.docker/config.json -
stat /home/user/.docker/config.json: permission denied'"

echo "This error indicates that the permission settings for the ~/.docker/ directory are incorrect, due to having used the sudo command earlier."

echo "To fix this problem, either remove the ~/.docker/ directory (it's recreated automatically, but any custom settings are lost), or change its ownership and permissions"
