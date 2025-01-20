# This script will download a .deb file and install CopyQ from it.
# Some manual setup is required!


#COPY_Q_DOWNLOAD_LINK="https://github.com/hluk/CopyQ/releases/download/v9.1.0/copyq_9.1.0_Debian_12-1_amd64.deb"
#DEB_FILE_NAME="copyq_9.1.0_Debian_12-1_amd64.deb"

#wget $COPY_Q_DOWNLOAD_LINK

# install via apt
sudo apt-get install copyq

echo "##################################################################################"
echo "########  Remember to update CopyQ settings to prevent password storage!!! #######"
echo "##################################################################################"
