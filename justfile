os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

default:
  just --list

install-deps:
  #!/bin/bash
  if [ "{{os}}" = "Debian GNU/Linux" ] || [ "{{os}}" = "Ubuntu" ]; then
    sudo apt-get install build-essential curl tar git ripgrep stow xclip fd-find
    command -v nix-env >/dev/null || {
      read -p "nix has the latest version for neovim, apt version is outdated. Install neovim over nix or exit? (Y/n)" choice
      [[ ${choice-y} == "y" ]] || {
        exit 0
      }
    }
    nix-env -iA nixpkgs.lua51Packages.luarocks nixpkgs.neovim nixpkgs.gh nixpkgs.lazygit
  elif [ "{{os}}" = "Arch Linux" ]; then
    sudo pacman -S base-devel curl tar git ripgrep stow luarocks neovim github-cli xclip lazygit fd gh
  fi

install: install-deps config config-gh

config:
  mkdir -p {{home_dir()}}/.config/nvim
  stow -t {{home_dir()}}/.config/nvim .

[confirm]
config-gh:
  if [[ ! $(gh auth status) ]]; then gh auth login; fi

unset-config:
  stow -D -t {{home_dir()}}/.config/nvim .

clean-lazy:
  rm -rf ~/.local/share/nvim/lazy
