#!/bin/bash
source "$(dirname $0)/utils.sh"

export NOTMUX=1

print_message $GREEN "Setting up dotfiles..."
print_message $GREEN "  Downloading dotfiles from GitHub..."

dotfiles_dir="/home/archie/.config/fish"

# Check if dotfiles directory already exists
if [ -d "$dotfiles_dir" ]; then
  print_message $GREEN "  Backing up existing dotfiles directory..."
  mv "$dotfiles_dir" "$dotfiles_dir.bak"
fi

# Clone the dotfiles repository
su archie -c "git clone https://github.com/Nachtalb/dotfiles.git $dotfiles_dir"

# Install dependencies with Poetry
print_message $GREEN "  Installing dotfiles dependencies with Poetry..."
su archie -c "cd $dotfiles_dir && poetry install"

# Create symlinks
print_message $GREEN "  Creating symlinks for black, isort, mypy, ruff, ruff-lsp, and xdg-open..."
su archie -c "cd $dotfiles_dir && poetry run ln -fs \"\$(poetry run which defaultpoetry)\"    \"bin/defaultpoetry\""

# Run dotfiles_install_symlinks script
print_message $GREEN "  Running dotfiles setup..."
su archie -c "fish -c 'dotfiles setup'"

# Run update-neovim-nightly.sh script
print_message $GREEN "  Running update-neovim-nightly.sh script..."
su archie -c "fish -c 'yes | update-neovim-nightly'"

print_message $ORANGE "  You can start TMUX with either 'tmux' or 'st' (reattach existing sessions) commands."
print_message $ORANGE "  After starting TMUX for the first time it CTRL-B then I to install it's plugins."
