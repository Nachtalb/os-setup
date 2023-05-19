#!/bin/bash
set -e  # Exit immediately on error

# Help message
show_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --help       Display this help message"
    echo "  --noconfirm  Skip confirmation prompts"
    echo "  --[stage]    Select a specific installation stage (e.g., --05)"
    # Add more options and descriptions as needed
}

# Check if "--help" option is provided
if [[ "$*" == *--help* || "$*" == *-h* ]]; then
    show_help
    exit 0
fi

for file in $(dirname $0)/install.d/*.sh; do
    source $file $1
done

print_message $GREEN "Installation finished look out for orange messages for further instructions."
