# OS Setup

This repository provides scripts and configurations to set up a new Arch Linux
installation with various dependencies and custom configurations. It includes
the installation of essential packages, dotfiles, and a Neovim configuration.

<p align="center">
    <img src="./wsl-terminal-preview.png" alt="WSL Terminal Preview">
    <br/>
    WSL Terminal Preview
</p>

## Features

- ✨ Automated installation of dependencies for Arch Linux.
- ✨ Easy setup of dotfiles from the [Nachtalb/dotfiles][dotfiles] repository.
- ✨ Configuration of Neovim using the [Nachtalb/vimconfig][vimconfig].
- ✨ Comprehensive toolkit pre-set and an option for a tailored
  [Sway](https://github.com/Nachtalb/sway) desktop experience.

## Tooling Insight

Curious about the toolset that comes pre-configured with this setup? Dive into
the [TOOLING.md](TOOLING.md) page to get a detailed overview of all the built-in
tools, scripts, and utilities. Whether you're on Arch Linux or Arch in WSL,
these handpicked and finely-tuned tools are crafted to elevate your experience.

## Installation

We recommend using the quick installation method to get started with the OS
setup. This method ensures a streamlined and hassle-free installation process.

### Quick Installation

For a quick installation without cloning the repository, you can use the
following command:

```bash
bash <(curl -L https://raw.githubusercontent.com/Nachtalb/os-setup/master/web-install.sh) --noconfirm
```

⚡️ This command will automatically download and run the installation script,
skipping any confirmation prompts.

> Note: The installation code will be cloned to /tmp/os-setup in case you want
> to investigate or modify anything.

### Manual Installation

If you prefer a manual installation method, you can follow these steps:

```bash
# Clone the os-setup repository:
git clone https://github.com/Nachtalb/os-setup.git
# Navigate to the cloned directory:
cd os-setup
# Run the installation script:
./install.sh
```

### Selecting Installation Stages

The installation script supports different stages that correspond to specific
files in the "install.d" folder. You can choose a specific stage by using the
argument `--[number][number]`, such as `--05` or `--00`. Each stage corresponds
to associated files in the "install.d" folder.

For example, to install files associated with stage `05` and skip any
confirmation prompts, you can use the following command:

```bash
./install.sh --05 --noconfirm
```

> You can also use the same stage selection method with the
> [web-install.sh](#quick-installation) script.

## Customization

Feel free to customize the scripts in the "install.d" folder to suit your
preferences. You can also modify the dotfiles from the
[Nachtalb/dotfiles][dotfiles] (installed to `/home/archie/.config/fish`)
repository, the Neovim configuration from the [Nachtalb/vimconfig][vimconfig]
(installed to `/home/archie/.vim`) repository.

[dotfiles]: https://github.com/Nachtalb/dotfiles
[vimconfig]: https://github.com/Nachtalb/vimconfig

## Contributions

Dive into the OS Setup and share your insights! Whether you've discovered a
groundbreaking tool, refined a configuration, or stumbled upon a quirky bug,
your perspective is invaluable. Contribute via issues, PRs, or just by
suggesting enhancements. Together, we'll shape a stellar setup.
