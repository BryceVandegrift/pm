" pm.vim - Stupidly Simple Vim/NeoVim plugin manager
" Author: Bryce Vandegrift <https://brycevandegrift.xyz>
" Version: 0.1

if exists("g:pm_loaded") || &cp || v:version < 800
	finish
endif
let g:pm_loaded = 1

if !exists("g:pm_path")
	if has("nvim")
		let g:pm_path = trim(system('echo ${XDG_DATA_DIR:-$HOME/.local/share}/nvim/site/pack/plugins/start/'))
	else
		let g:pm_path = trim(system('echo $HOME/.vim/pack/plugins/start/'))
	endif
endif

if !isdirectory("g:pm_path")
	silent execute "!mkdir -p " . g:pm_path
endif

if !exists("g:plugins")
	let g:plugins = []
endif

function! s:downloadPlugins()
	echom "Downloading plugins..."
	for item in g:plugins
		execute "!cd " . g:pm_path . ";git clone " . item
	endfor
	echom "Done!"
endfunction

command! -nargs=0 DownloadPlugins call s:downloadPlugins()
