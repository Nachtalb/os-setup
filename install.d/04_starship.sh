#!/bin/bash
source "$(dirname $0)/utils.sh"

export NOTMUX=1

print_message $GREEN "Setting up starship..."
# Create ~/.config/fish/config.fish in case 03_dotfiles.sh wasn't run
fish -c "exit"
su archie -c "fish -c 'exit'"

# Check if starship init is needed for Fish shell
add_text_if_pattern_not_found ~/.config/fish/config.fish "starship" 'starship init fish | source'
add_text_if_pattern_not_found /home/archie/.config/fish/config.fish "starship" 'starship init fish | source'

# Check if starship init is needed for Bash
add_text_if_pattern_not_found ~/.bashrc "starship" 'eval "$(starship init bash)"'
add_text_if_pattern_not_found /home/archie/.bashrc "starship" 'eval "$(starship init bash)"'

# Check if starship init is needed for Zsh
add_text_if_pattern_not_found ~/.zshrc "starship" 'eval "$(starship init zsh)"'
add_text_if_pattern_not_found /home/archie/.zshrc "starship" 'eval "$(starship init zsh)"'
