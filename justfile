os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

default:
  just --list

install-deps:
  #!/bin/bash
  if [ "{{os}}" = "Debian GNU/Linux" ] || [ "{{os}}" = "Ubuntu" ]; then
    sudo apt-get install build-essential curl tar git ripgrep stow xclip
    if ! type brew; then /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; fi
    brew install luarocks neovim gh lazygit
  elif [ "{{os}}" = "Arch Linux" ]; then
    sudo pacman -S base-devel curl tar git ripgrep stow luarocks neovim github-cli xclip lazygit
  fi

install: install-deps config config-gh

config:
  mkdir -p {{home_dir()}}/.config/nvim
  stow -t {{home_dir()}}/.config/nvim .

[confirm]
config-gh:
  if [[ ! $(gh auth status) ]]; then gh auth login; fi

delete-config:
  stow -D -t {{home_dir()}}/.config/nvim .

clean-lazy:
  rm -rf ~/.local/share/nvim/lazy
