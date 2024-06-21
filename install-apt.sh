#!/bin/bash

# Exit on errors
set -e

apt update

echo "Installing dependecies..."
apt install -y build-essential curl tar git

echo "Downloading neovim..."
curl -sLO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

echo "Installing neovim..."
tar -xzf nvim-linux64.tar.gz
ls nvim-linux64/ | xargs -I {} cp -r nvim-linux64/{}/ /usr/local
rm -rf nvim-linux64*

echo "Installing packer.vim..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim || {
  echo "packer already installed"
}

echo "Applying neovim configs..."
neovim_config_path=~/.config/nvim
if [ -d $neovim_config_path ]; then
  rm -rf $neovim_config_path
fi
git clone --depth 1 https://github.com/vncsmyrnk/vim-config.git $neovim_config_path

echo "neovim is installed and configured. You can now open neovim with 'nvim' command"
echo "On first run, make sure to execute :PackerSync to install dependencies. You may need to run it a couple times and restart neovim in order to complete the installation"
