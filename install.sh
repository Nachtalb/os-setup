#!/bin/bash
set -e  # Exit immediately on error
source "$(dirname $0)/utils.sh"

show_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --help       Display this help message"
    echo "  --noconfirm  Skip confirmation prompts"
    echo "  --de         Install desktop environment"
    echo "  --[stage]    Select a specific installation stage (e.g., --05)"
}

# Check if "--help" option is provided
if [[ "$*" == *--help* || "$*" == *-h* ]]; then
    show_help
    exit 0
fi

# ------------------------------------------------------------------------------

# Check if "--[stage]" option is provided
if [[ "$*" == --[0-9][0-9] ]]; then
    stage_option=$(echo "$*" | grep -oE -- '--[0-9]{2}' | cut -c 3-)
    stage_file=$(dirname $0)/install.d/"$stage_option"*

    # Check if the stage file exists
    if [ -f "$stage_file" ]; then
        source "$stage_file" $@
    else
        print_message $RED "Error: Stage file '$stage_option' not found."
        exit 1
    fi
else
    # Source all files in "install.d" folder
    for file in $(dirname $0)/install.d/*.sh; do
        source "$file" $@
    done
fi

print_message $GREEN "Installation finished look out for orange messages for further instructions."
