#!/bin/bash
source "$(dirname $0)/utils.sh"

print_message $GREEN "Setting up starship..."
fish -c "exit"
su archie -c "fish -c 'exit'"

echo "starship init fish | source" | tee -a ~/.config/fish/config.fish
echo 'eval "$(starship init bash)"' | tee -a ~/.bashrc /home/archie/.bashrc
echo 'eval "$(starship init zsh)"' | tee -a ~/.zshrc /home/archie/.zshrc
