os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

default:
  just --list

check-deps:
  #!/usr/bin/env bash
  dependencies=(curl tar git stow xclip rg nvim luarocks gh lazygit fd tree-sitter)
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

# Works for x86_86 only
install-neovim-latest-manually:
  #!/usr/bin/env bash
  latest_version=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.tag_name')
  if command -v nvim >/dev/null; then
    current_version=$(nvim --version | head -n 1 | cut -d ' ' -f2)
    if [[ "$latest_version" = "$current_version" ]]; then
      echo "latest version installed"
      exit 0
    fi
  fi
  just install-neovim-manually $latest_version

# Works for x86_86 only
install-neovim-manually version:
  #!/usr/bin/env bash
  DOWNLOAD_DIR=/tmp
  INSTALL_DIR=/usr/local/stow

  curl -L -o "$DOWNLOAD_DIR/nvim.tar.gz"  "https://github.com/neovim/neovim/releases/download/{{version}}/nvim-linux-x86_64.tar.gz"
  tar -xzvf "$DOWNLOAD_DIR/nvim.tar.gz" -C "$DOWNLOAD_DIR"
  rm -rf "$DOWNLOAD_DIR/nvim"
  mv "$DOWNLOAD_DIR/nvim-linux-x86_64" "$DOWNLOAD_DIR/nvim"
  sudo mkdir -p "$INSTALL_DIR"
  sudo cp -r "$DOWNLOAD_DIR"/nvim "$INSTALL_DIR"
  cd "$INSTALL_DIR"
  sudo stow nvim
