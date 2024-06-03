# vim-config

This is my local vim/nvim config using lua.

To work properly this repo should be cloned on `~/.config/nvim` and [packer.vim](https://github.com/wbthomason/packer.nvim) must be installed.

The Neovim version `0.9` and `0.10` are compatible with the configuration.

## Install

To install it just run:

```bash
git clone --depth 1 https://github.com/vncsmyrnk/vim-config.git /.config/nvim
```
\**Note that the last command will override any existing nvim config*

### Install nvim + config

To install neovim and apply the config, run the `install-apt.sh` script. To download and run it:

```bash
wget https://raw.githubusercontent.com/vncsmyrnk/vim-config/main/install-apt.sh
chmod u+x install-apt.sh
./install-apt.sh
```

Some errors may appear on the first `nvim` run, make sure to close all and run `:PackerSync` to install the plugins. The execution of `:PackerSync` itself may result in errors on first try, run it twice and it will install all plugins. After all of that, restart `nvim`.

## Credits

Based on [@ThePrimeagen](https://github.com/ThePrimeagen)'s config.
