#!/bin/sh

echo "Copying over keybindings for code-server"
cp -f code-server/keybindings.json  /home/coder/.local/share/code-server/User/keybindings.json

echo "Copying over settings for code-server"
cp -f code-server/settings.json  /home/coder/.local/share/code-server/User/settings.json


###########################
# zsh setup
###########################
echo -e "⤵ Installing zsh..."
sudo apt update && sudo apt-get -y install zsh
echo -e "✅ Successfully installed zsh version: $(zsh --version)"

# Set up zsh tools
PATH_TO_ZSH_DIR=$HOME/.oh-my-zsh
echo -e "Checking if .oh-my-zsh directory exists at $PATH_TO_ZSH_DIR..."
if [ -d $PATH_TO_ZSH_DIR ]
then
   echo -e "\n$PATH_TO_ZSH_DIR directory exists!\nSkipping installation of zsh tools.\n"
else
   echo -e "\n$PATH_TO_ZSH_DIR directory not found."
   echo -e "⤵ Configuring zsh tools in the $HOME directory..."

   (cd $HOME && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended)
   echo -e "✅ Successfully installed zsh tools"
fi

# Copy over .zshrc
cp -f ./dotfiles-test/.zshrc ~/.zshrc

# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo -e "⤵ Changing the default shell"
sudo chsh -s $(which zsh) $USER
echo -e "✅ Successfully modified the default shell"

### neovim install and setup
sudo apt install -y software-properties-common
sudo apt update && sudo add-apt-repository --yes ppa:neovim-ppa/unstable
sudo apt-get install -y neovim
echo -e "✅ Successfully installed neovim version: $(nvim --version)"

# switch shell to zsh
exec zsh