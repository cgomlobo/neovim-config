# Neovim configuration

## Introduction

The content of this repository contains the necesary files to use neovim as a quite capable code editor.

## Installation

### Prerequisites

Install a recent version of neovim, >0.7 should be enough but latest version is recommended. To install the last stable version from source do:

1. Clone neovim repository:

   ```
   git clone https://github.com/neovim/neovim.git
   cd ./neovim
   ```

2. Select the stable version branch:

```
git checkout stable
```

3. Go throgh the installation steps described on [neovim documentation](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-source), including the [prerequisites](https://github.com/neovim/neovim/blob/master/BUILD.md#build-prerequisites).

### Install plugins and configuration

In order to install all the plugins correctly go through the following steps in order:

1. Create nvim config file:
   
   ```
   mkdir ~/.config/nvim
   ```
3. Clone packer plugin manager repository:

   ```
   mkdir ~/.local/share/nvim/site/pack/packer/start/packer.nvim
   git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
   ```
4. Clone the contents of this repository in nvim config directory:

   ```
   cd ~/.config/nvim
   git clone https://github.com/charlyg9/neovim-config.git .
   ```
5. Open packer lua script:

   ```
   nvim ~/.config/nvim/lua/cgomlobo/packer.lua
   ```
   
6. Run `:PackerSync` to install all the plugins.
7. Now you just need to install the language servers you're going to use. For that refer to the `after/plugin/lsp.lua` script follow the instruction for each one.
8. Enjoy!
