![NeoVim](https://img.shields.io/badge/NeoVim-darkgreen?style=plastic&logo=neovim)
![Lua](https://img.shields.io/badge/Lua-darkblue?style=plastic&logo=lua)

# myconfig.nvim

This is my [nvim](https://neovim.io/) config.

To work properly this repo should be cloned/copied to `~/.config/nvim`.

[lazy.nvim](https://github.com/folke/lazy.nvim) is used as a plugin manager.

> [!NOTE]
> [Latest nvim releases](https://github.com/neovim/neovim/releases) should be compatible with this configuration.

## Dependencies

- [nvim](https://neovim.io/)
- [stow](https://www.gnu.org/software/stow/)
- [tree-sitter](https://tree-sitter.github.io/tree-sitter/)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [gh](https://cli.github.com/)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [luarocks](https://luarocks.org/)

## Install

This project uses [just](https://github.com/casey/just) and [stow](https://www.gnu.org/software/stow/) for the installation.

```bash
just install
```
