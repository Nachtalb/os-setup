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
config_dir="/home/archie/.config"
sway_dir="${config_dir}/sway"
if [ ! -d $sway_dir ]; then
  su archie -c "git clone https://github.com/Nachtalb/sway.git ${sway_dir}"
fi

print_message $GREEN "  Installing GO dependencies"
su archie -c "cd ${sway_dir} && go get github.com/sirupsen/logrus"
su archie -c "cd ${sway_dir} && go get github.com/Difrex/gosway/ipc"

# Building GO deps
su archie -c "cd ${sway_dir}/scripts/ && go build -o /home/archie/.local/bin/tr_in transparent_inctive.go"

print_message $GREEN "  Setting up sway && waybar"

# Sway Config
su archie -c "ln  -sf  ${sway_dir}/conf-available/workspaces.conf           ${sway_dir}/conf-enabled/00-workspaces.conf"
su archie -c "ln  -sf  ${sway_dir}/conf-available/autostart.conf            ${sway_dir}/conf-enabled/01-autostart.conf"
su archie -c "ln  -sf  ${sway_dir}/conf-available/fonts.conf                ${sway_dir}/conf-enabled/02-fonts.conf"
su archie -c "ln  -sf  ${sway_dir}/conf-available/keybindings.conf          ${sway_dir}/conf-enabled/03-keybindings.conf"
su archie -c "ln  -sf  ${sway_dir}/conf-available/layout.conf               ${sway_dir}/conf-enabled/04-key-layout.conf"
su archie -c "ln  -sf  ${sway_dir}/conf-available/terminal-dark.conf        ${sway_dir}/conf-enabled/05-terminal.conf"
su archie -c "ln  -sf  ${sway_dir}/conf-available/colors-dark.conf          ${sway_dir}/conf-enabled/20-colors.conf"
su archie -c "ln  -sf  ${sway_dir}/conf-available/gaps.conf                 ${sway_dir}/conf-enabled/30-gaps.conf"
su archie -c "ln  -sf  ${sway_dir}/conf-available/idle.conf                 ${sway_dir}/conf-enabled/40-idle.conf"
su archie -c "ln  -sf  ${sway_dir}/conf-available/screenshots.conf          ${sway_dir}/conf-enabled/50-screenshots.conf"
su archie -c "ln  -sf  ${sway_dir}/conf-available/wallpapers.conf           ${sway_dir}/conf-enabled/80-wallpapers.conf"
su archie -c "ln  -sf  ${sway_dir}/conf-available/colors-dark.conf          ${sway_dir}/conf-enabled/colors-dark.conf"
su archie -c "ln  -sf  ${sway_dir}/conf-available/mako-dark.conf            ${sway_dir}/conf-enabled/mako-dark.conf"
su archie -c "ln  -sf  ${sway_dir}/conf-available/terminal-dark.conf        ${sway_dir}/conf-enabled/terminal-dark.conf"
su archie -c "ln  -sf  ${sway_dir}/conf-available/transparent-windows.conf  ${sway_dir}/conf-enabled/transparent-windows.conf"

# Waybar Config
su archie -c "ln  -sf  ${sway_dir}/waybar-available/config          ${sway_dir}/waybar-enabled/config"
su archie -c "ln  -sf  ${sway_dir}/waybar-available/style-dark.css  ${sway_dir}/waybar-enabled/style.css"

print_message $GREEN "  Installing ranger addons..."
su archie -c 'ranger --copy-config all'
ranger_dir="${config_dir}/ranger/"
if [ ! -d "${ranger_dir}/plugins/ranger_devicons" ]; then
  suarchie -c "git clone https://github.com/alexanderjeurissen/ranger_devicons ${ranger_dir}/plugins/ranger_devicons"
fi

add_text_if_pattern_not_found "${ranger_dir}/rc.conf" "devicons" '# File icons
default_linemode devicons'

add_text_if_pattern_not_found "${ranger_dir}/rc.conf" "ueberzug" '# Image preview
set preview_images true
set preview_images_method ueberzug'


print_message $GREEN "  Configuring 'foot' (terminal)"
su archie -c "mkdir '${config_dir}/foot' -p"
su archie -c "ln -fs ${sway_dir}/foot/foot.ini ${config_dir}/foot/
