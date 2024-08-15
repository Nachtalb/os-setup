#!/bin/bash
source "$(dirname $0)/utils.sh"

export NOTMUX=1

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

print_message $GREEN "  Setting up NEOVIM, this may take a while"

su archie -c "ln -sf ~/.vim/init.vim ~/.config/nvim/init.vim"
su archie -c "ln -sf ~/.vim/coc-settings.json ~/.config/nvim/coc-settings.json"
su archie -c "ln -sf ~/.vim/config.vim ~/.vimrc"
su archie -c 'nvim +PlugUpgrade +qa'
su archie -c 'nvim +PlugInstall +qa'
su archie -c 'nvim +UpdateRemotePlugins +TSUpdate +qa'
su archie -c 'nvim +CocInstall +qa'

print_message $ORANGE "  You can start NEOVIM with either 'nvim' or 'vim' (auto load Session.vim if it exists)."
print_message $ORANGE "  During the first start remaining dependencies will be installed automatically."
print_message $ORANGE "  NEOVIM nightly is installed, use 'update-neovim-nightly' to update your NEOVIM."
