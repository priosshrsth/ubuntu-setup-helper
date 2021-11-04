#!/bin/env bash

## Set zsh as default shell
echo "Setting up zsh"

## Install oh-my-zsh
sh -c --unattended "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
source ~/.zshrc
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

if [[ -r "${XDG_CACHE_HOME:-$HOME/.ssh}/" ]]; then
  chmod -R 700 ~/.ssh/
fi

source ~/.zshrc

## Setup ruby
./ruby-setup.sh

## Setup nvm
./nvm-setup.sh

cp ./../configs/. ~/

source ~/.zshrc

./docker-setup.sh

sudo tee -a ~/.profile > /dev/null <<EOT
xset led on

EOT