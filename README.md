# pm

A stupidly simple Vim/NeoVim plugin manager

## Why?

Vim and NeoVim now have plugin management builtin so I have no need for
a "bloated" plugin manager that is thousands of lines long. All I need
is a Vim/NeoVim script that will download and update my plugins.

## Install

Requirements:

- [Vim](https://www.vim.org/) > 8.0 or [NeoVim](https://neovim.io/)
- cURL
- Git

### Vim

``` sh
curl -fLo ~/.vim/plugin/pm.vim --create-dirs https://git.sr.ht/~bpv/pm/blob/master/pm.vim
```

#### Documentation for Vim

``` sh
curl -fLo ~/.vim/doc/pm.txt --create-dirs https://git.sr.ht/~bpv/pm/blob/master/pm.txt
vim -c "helptags ~/.vim/doc | q"
```

### NeoVim

``` sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/plugin/pm.vim --create-dirs https://git.sr.ht/~bpv/pm/blob/master/pm.vim'
```

#### Documentation for NeoVim

``` sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/doc/pm.txt --create-dirs https://git.sr.ht/~bpv/pm/blob/master/pm.txt'
nvim -c "lua dir = os.getenv('XDG_DATA_HOME') or os.getenv('HOME') .. '/.local/share' ; vim.cmd('helptags ' .. dir .. '/nvim/site/doc') ; vim.cmd(':q!')"
```

## Usage

Create plugin list

### Example

In your `.vim` file (Vim) or `init.vim` (NeoVim) file create a list variable
named `g:plugins`. This is where you will list the Git urls of all the plugins
that you want to download.

``` vim
let g:plugins = ["https://github.com/ap/vim-css-color.git", "https://git.sr.ht/~k1nkreet/gemivim"]
```

### Commands

- `:DownloadPlugins`: Downloads all plugins from thier Git repos
- `:UpdatePlugins`: Updates all installed plugins
- `:PurgePlugins`: Removes all plugins not defined in `g:plugins`
- `:UpdatePM`: Downloads and updates pm
