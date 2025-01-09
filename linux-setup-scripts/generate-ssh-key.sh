# This script is made based on the GitHub guides located at:
# 1. https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys
# 2. https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

SCRIPT_NAME="generate-ssh-key.sh"
echo "Starting ${SCRIPT_NAME}"

# TODO:  Check for existing ssh key
echo "TODO: check for existing ssh key"

cd ~/.ssh/ || echo "~/.ssh/ folder does not exist. Creating it." && mkdir ~/.ssh

# To ensure successful navigation to .ssh regardless of folder existence.
cd ~./ssh/

read -p "Enter e-mail to be associated with ssh-key: " EMAIL
ssh-keygen -t ed25519 -C ${EMAIL}
echo ""
echo "
Next step is to add the .pub ssh key in the settings of your GitHub account. Which has been output below between START and STOP:

=== START ===
$(cat ~/.ssh/id_ed25519.pub)
=== STOP ===
"

echo "See 'https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account' if you are unsure of how to do it."

echo "Finished ${SCRIPT_NAME}"
