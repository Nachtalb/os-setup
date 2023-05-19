#!/bin/bash
source "$(dirname $0)/utils.sh"

print_message $GREEN "Creating user 'archie'..."

if ! id -u archie >/dev/null 2>&1; then
    useradd archie -m
    print_message $GREEN "  User 'archie' created successfully."
else
    print_message $GREEN "  User 'archie' already exists."
fi

echo "archie ALL=(ALL:ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

print_message $GREEN "  User 'archie' created successfully."
