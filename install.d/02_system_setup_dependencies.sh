#!/bin/bash
source "$(dirname $0)/utils.sh"

print_message $GREEN "Installing system dependencies..."

# Declare variables
deps_file="$(dirname $0)/data/02_system_setup_dependencies.txt"
deps_args=$(file_to_oneline $deps_file)

if [[ " $* " == *" --noconfirm "* ]]; then
  su archie -c "paru -Sy $deps_args --needed --noconfirm"
else
  su archie -c "paru -Sy $deps_args --needed"
fi
