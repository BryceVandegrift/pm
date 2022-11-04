# pm

A stupidly simple Vim/NeoVim plugin manager

## Install

Requirements:

- [Vim](https://www.vim.org/) > 8.0 or [NeoVim](https://neovim.io/)
- cURL
- Git

### Vim

``` sh
curl -fLO ~/.vim/plugin/ --create-dirs https://sr.ht/*Url here*
```

### NeoVim

``` sh
sh -c 'curl -fLO "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/plugin/ --create-dirs https://sr.ht/*Url here*'
```

## Usage

Create plugin list

### Example

In your `.vim` file (Vim) or `init.vim` (NeoVim) file create a list variable
named `g:plugins`.

``` vim
let g:plugins = ["https://github.com/ap/vim-css-color.git", "https://git.sr.ht/~k1nkreet/gemivim"]
```

### Commands

- `DownloadPlugins`: Downloads all plugins from thier Git repos
