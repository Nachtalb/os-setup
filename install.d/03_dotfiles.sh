#!/bin/bash
source "$(dirname $0)/utils.sh"

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

# Create symlinks for black, isort, mypy, ruff, ruff-lsp, and xdg-open
print_message $GREEN "  Creating symlinks for black, isort, mypy, ruff, ruff-lsp, and xdg-open..."
su archie -c "cd $dotfiles_dir && poetry run ln -s \"\$(poetry run which black)\"    \"bin/black\""
su archie -c "cd $dotfiles_dir && poetry run ln -s \"\$(poetry run which isort)\"    \"bin/isort\""
su archie -c "cd $dotfiles_dir && poetry run ln -s \"\$(poetry run which mypy)\"     \"bin/mypy\""
su archie -c "cd $dotfiles_dir && poetry run ln -s \"\$(poetry run which ruff)\"     \"bin/ruff\""
su archie -c "cd $dotfiles_dir && poetry run ln -s \"\$(poetry run which ruff-lsp)\" \"bin/ruff-lsp\""
su archie -c "cd $dotfiles_dir && poetry run ln -s \"\$(poetry run which xdg-open)\" \"bin/xdg-open\""

# Run dotfiles_install_symlinks script
print_message $GREEN "  Running dotfiles_install_symlinks script..."
su archie -c "fish -c dotfiles_install_symlinks"

# Run update-neovim-nightly.sh script
print_message $GREEN "  Running update-neovim-nightly.sh script..."
su archie -c "fish -c 'yes | update-neovim-nightly'"

print_message $ORANGE "  You can start TMUX with either 'tmux' or 'st' (reattach existing sessions) commands."
print_message $ORANGE "  After starting TMUX for the first time it CTRL-B then I to install it's plugins."
