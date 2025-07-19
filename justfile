os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

default:
  just --list

check-deps:
  #!/bin/bash
  dependencies=(curl tar git stow xclip rg nvim luarocks gh lazygit fd)
  missing_dependencies=($(for dep in "${dependencies[@]}"; do command -v "$dep" &> /dev/null || echo "$dep"; done))

  if [ ${#missing_dependencies[@]} -gt 0 ]; then
    echo "Dependencies not found: ${missing_dependencies[*]}"
    echo "Please install them with the appropriate package manager"
    exit 1
  fi

install: check-deps config config-gh

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
