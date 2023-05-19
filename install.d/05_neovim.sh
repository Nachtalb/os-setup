#!/bin/bash
source "$(dirname $0)/utils.sh"

print_message $GREEN "Setting up NEOVIM..."
print_message $GREEN "  Downloading NEOVIM config from GitHub..."

vim_dir="/home/archie/.vim"

# Check if neovim directory already exists
if [ -d "$vim_dir" ]; then
  print_message $GREEN "  Backing up existing vim config directory..."
  mv "$vim_dir" "$vim_dir.bak"
fi

vim_dir_config="/home/archie/.config/nvim"
su archie -c "mkdir -p $vim_dir_config"

# Clone the neovim config repository
su archie -c "git clone https://github.com/Nachtalb/vimconfig.git $vim_dir"

print_message $GREEN "  Setting up NEOVIM"

su archie -c "ln -sf ~/.vim/init.vim ~/.config/nvim/init.vim"
su archie -c "ln -sf ~/.vim/coc-settings.json ~/.config/nvim/coc-settings.json"
su archie -c "ln -sf ~/.vim/.vimrc ~/.vimrc"
su archie -c 'nvim -c "PlugInstall" -c "qa"'
su archie -c 'nvim -c "PlugInstall" -c "qa"'
su archie -c 'nvim -c "CocUpdate" -c "qa"'
su archie -c 'nvim -c "UpdateRemotePlugins" -c "qa"'
