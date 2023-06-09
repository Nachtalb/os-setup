#!/bin/bash
source "$(dirname $0)/utils.sh"

if [[ " $* " == *" --de "* ]]; then
  print_message $GREEN "Setting up desktop environment..."
else
  print_message $ORANGE "Skipping desktop environment installation. Use --de to install the desktop environment."
  exit
fi
print_message $GREEN "  Installing desktop dependencies..."

# Declare variables
deps_file="$(dirname $0)/data/06_desktop_environment.txt"
deps_args=$(file_to_oneline $deps_file)

if [[ " $* " == *" --noconfirm "* ]]; then
  su archie -c "paru -Sy $deps_args --needed --noconfirm"
else
  su archie -c "paru -Sy $deps_args --needed"
fi

print_message $GREEN "  Downloading sway config..."
git clone https://github.com/Nachtalb/sway.git ~/.config/sway
wd0=$(pwd)
cd ~/.config/sway

print_message $GREEN "  Installing GO dependencies"
go get github.com/sirupsen/logrus
go get github.com/Difrex/gosway/ipc

# Building GO deps
wd1=$(pwd)
cd scripts
go build -o ~/.local/bin/tr_in transparent_inctive.go
cd "${wd1}"

print_message $GREEN "  Setting up sway && waybar"

# Sway Config
ln  -s  ~/.config/sway/conf-available/workspaces.conf           ~/.config/sway/conf-enabled/00-workspaces.conf
ln  -s  ~/.config/sway/conf-available/autostart.conf            ~/.config/sway/conf-enabled/01-autostart.conf
ln  -s  ~/.config/sway/conf-available/fonts.conf                ~/.config/sway/conf-enabled/02-fonts.conf
ln  -s  ~/.config/sway/conf-available/keybindings.conf          ~/.config/sway/conf-enabled/03-keybindings.conf
ln  -s  ~/.config/sway/conf-available/layout.conf               ~/.config/sway/conf-enabled/04-key-layout.conf
ln  -s  ~/.config/sway/conf-available/terminal-dark.conf        ~/.config/sway/conf-enabled/05-terminal.conf
ln  -s  ~/.config/sway/conf-available/colors-dark.conf          ~/.config/sway/conf-enabled/20-colors.conf
ln  -s  ~/.config/sway/conf-available/gaps.conf                 ~/.config/sway/conf-enabled/30-gaps.conf
ln  -s  ~/.config/sway/conf-available/idle.conf                 ~/.config/sway/conf-enabled/40-idle.conf
ln  -s  ~/.config/sway/conf-available/screenshots.conf          ~/.config/sway/conf-enabled/50-screenshots.conf
ln  -s  ~/.config/sway/conf-available/wallpapers.conf           ~/.config/sway/conf-enabled/80-wallpapers.conf
ln  -s  ~/.config/sway/conf-available/colors-dark.conf          ~/.config/sway/conf-enabled/colors-dark.conf
ln  -s  ~/.config/sway/conf-available/mako-dark.conf            ~/.config/sway/conf-enabled/mako-dark.conf
ln  -s  ~/.config/sway/conf-available/terminal-dark.conf        ~/.config/sway/conf-enabled/terminal-dark.conf
ln  -s  ~/.config/sway/conf-available/transparent-windows.conf  ~/.config/sway/conf-enabled/transparent-windows.conf

# Waybar Config
ln  -s  ~/.config/sway/waybar-available/config          ~/.config/sway/waybar-enabled/config
ln  -s  ~/.config/sway/waybar-available/style-dark.css  ~/.config/sway/waybar-enabled/style.css


print_message $GREEN "  Installing ranger addons..."
ranger --copy-config all
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
echo "# File icons
default_linemode devicons

# Image preview
set preview_images true
set preview_images_method ueberzug" >> ~/.config/ranger/rc.conf`

print_message $GREEN "  Configuring 'foot' (terminal)"
mkdir ~/.config/foot -p
ln -s ~/.config/sway/foot/foot.ini ~/.config/foot/

cd "${wd0}"
