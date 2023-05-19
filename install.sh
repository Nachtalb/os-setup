#!/bin/bash
set -e  # Exit immediately on error

for file in $(dirname $0)/install.d/*.sh; do
    source $file $1
done

print_message $GREEN "Installation finished look out for orange messages for further instructions."
