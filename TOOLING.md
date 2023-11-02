# Tooling Overview

Welcome to the tooling section! This page offers a deep dive into the various
tools and utilities that come bundled with the OS setup. From custom scripts to
pre-configured applications, everything here is tailored to elevate both the
Arch Linux and Arch in WSL experiences, ensuring seamless integration and
optimal performance across platforms. Whether you're diving into development or
just navigating your system, these tools are here to make your journey smoother.
Let's explore!

## Self-Written Tools

Delve into the custom suite of tools, specifically curated and developed to
complement this OS setup. These tools, found primarily in the `bin/` and
`functions/` folders of the
[Nachtalb/dotfiles](https://github.com/Nachtalb/dotfiles) repository, are
tailored to enhance your system operations, making everyday tasks more efficient
and intuitive. From clipboard management to Git operations, each tool
encapsulates a unique functionality, designed with the user in mind.

|     | Tool                       | Description                                                          |
| --- | -------------------------- | -------------------------------------------------------------------- |
| 📋  | `ccopy` & `cpaste`         | Clipboard interaction (Linux, macOS, Windows/WSL).                   |
| 📦  | `install-pandoc`           | Pandoc dependencies and themes.                                      |
| 📦  | `to-pdf`                   | File to PDF conversion with Pandoc.                                  |
| 📦  | `extract`                  | Extract common archives.                                             |
| 🔄  | `update-neovim-nightly`    | Update Neovim on Arch. [not self written, but fits this list better] |
| 📤  | `catbox` & `litterbox`     | File uploads.                                                        |
| 🌍  | `docker-compose-open`      | Open a service defined in docker compose in the browser.             |
| 🚀  | `git tohttp` & `git tossh` | Rewriting Git remotes.                                               |
| 🚀  | `git clear`                | Delete branches merged on a remote.                                  |
| 🚀  | `git vlog`                 | Visual git log popout window for rebase sessions.                    |
| 🐙  | `gh` & `gl`                | Cloning from GitHub and GitLab.                                      |
| ✨  | `vim`                      | Wrapper for Neovim with Session.vim support.                         |
| ⚙   | `dotfiles`                 | Manage these dotfiles.                                               |

## Configured and Ready to Use

Beyond custom tools, this setup boasts a wide array of third-party tools and
utilities, all pre-configured and optimised for immediate use. Whether it's
development in Python, C, or simply navigating your desktop environment, this
section details tools that are set up and tuned for seamless integration into
your workflow. Dive in and discover the power and convenience packed into this
Arch Linux setup.

### General

- **[Tmux](https://github.com/tmux/tmux/wiki)**: Terminal multiplexer.
- **[OpenJDK](https://openjdk.org/)**: Open-source implementation of the Java
  Platform, Standard Edition.
- **[Starship](https://starship.rs/)**: Customizable shell prompt.
- **Command-not-found**: Hook for
  [Pacman](https://wiki.archlinux.org/title/pacman).
- **[Python Environment](https://www.python.org/)**: Ready for use.
- **Default Browser**: Configured as per system preference.
- **[Wayland](https://wayland.freedesktop.org/)**: Specific config if enabled.
- **[SSH-agent](https://man.archlinux.org/man/ssh-agent.1.en)** &
  **[GPG-agent](https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html)**:
  For secure access and encryption.
- **[Pyenv](https://github.com/pyenv/pyenv)**: Python version management.
- **[Autojump](https://github.com/wting/autojump)**: Directory navigation.
- **Git**: Fully configured with [Delta](https://github.com/dandavison/delta),
  default ignores, and more.

### Replacements

- **[Exa](https://github.com/ogham/exa)**: `ls` replacement.
- **[Bat](https://github.com/sharkdp/bat)**: Replaces `cat`, `man`, and default
  pager.

### Package Managers & Installers

- **[Pacui](https://github.com/excalibur1234/pacui)** &
  **[Paru](https://github.com/Morganamilo/paru)**: AUR helpers.
- **[Yarn](https://yarnpkg.com/)**: JavaScript package manager.
- **[Ruby](https://bun.sh/)**: Including `bun` for version management.
- **[Deno](https://deno.com/)**: JavaScript/TypeScript runtime.
- **[NPM](https://www.npmjs.com/)** & **[Node.js](https://nodejs.org/en)**:
  JavaScript runtime and package manager.
- **[Helm](https://github.com/helm/helm)** &
  **[Kubectl](https://kubernetes.io/docs/reference/kubectl/)**: Kubernetes
  tools.
- **[Rustup](https://rustup.rs/)** &
  **[Cargo](https://doc.rust-lang.org/cargo/)**: Rust toolchain installer and
  package manager.
- **[Pyenv](https://github.com/pyenv/pyenv)** &
  **[Poetry](https://python-poetry.org/)**: Python version management and
  dependency management.
- **[Magick](https://imagemagick.org/index.php)**: Image manipulation tool.

### Utilities & Tools

- **[FZF](https://github.com/junegunn/fzf)**: Fuzzy finder.
- **[Ripgrep](https://github.com/BurntSushi/ripgrep)**: Search tool.
- **[Tree-sitter](https://tree-sitter.github.io/tree-sitter/)**: Parser
  generator.
- **[YT-DLP](https://github.com/yt-dlp/yt-dlp)**: YouTube downloader.
- **[FFmpeg](https://www.ffmpeg.org/)**: Multimedia framework.

### Python Development

- **Interpreters & Environments**

  - **[Python Environment](https://www.python.org/)**: Default setup with
    readline support and more.
  - **[Pyenv](https://github.com/pyenv/pyenv)**: Python version management.
  - **[Poetry](https://python-poetry.org/)**: Dependency management.

- **Tools & Linters**
  - **[Mypy](https://mypy-lang.org/)**: Static type checker.
  - **[Ruff](https://docs.astral.sh/ruff/)** &
    **[Ruff LSP](https://docs.astral.sh/ruff/)**: Rust-like enum types and
    Language Server Protocol.
  - **[Isort](https://pycqa.github.io/isort/)**: Import sorter.
  - **[Black](https://github.com/psf/black)**: Code formatter.

### C Development

- **Compilers & Interpreters**

  - **[Clang](https://clang.llvm.org/)**: Compiler front-end for the C
    languages.

- **Tools & Utilities**
  - **[ccls](https://github.com/MaskRay/ccls)**: C/C++/ObjC language server.
  - **[ctags](https://github.com/universal-ctags/ctags)**: Source code indexing.

### Desktop Environment (if installed)

- **Window Management & Interface**

  - **[Sway](https://swaywm.org/)**: Tiling window manager for Wayland.
  - **[Waybar](https://github.com/Alexays/Waybar)**: Highly customizable Wayland
    bar.

- **Tools & Utilities**

  - **[Swaylock](https://github.com/swaywm/swaylock)**: Screen locker for Sway.
  - **[Rofi](https://wiki.archlinux.org/title/rofi)**: Window switcher,
    application launcher.
  - **[Slurp](https://github.com/emersion/slurp)** &
    **[Grim](https://sr.ht/~emersion/grim/)**: Region selection and screenshot
    utility.
  - **[Pywal](https://github.com/dylanaraps/pywal/blob/master/pywal/templates/colors-sway)**:
    Generate and change color schemes.
  - **[Feh](https://feh.finalrewind.org/)**: Image viewer and setter.

- **Fonts & Themes**
  - **[Nerd Font](https://www.nerdfonts.com/font-downloads)**: Fira Code
    variant.
