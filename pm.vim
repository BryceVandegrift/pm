" pm.vim - Stupidly Simple Vim/NeoVim plugin manager
" Author: Bryce Vandegrift <https://brycevandegrift.xyz>
" Version: 0.3

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

function! s:updatePlugins()
	echom "Updating plugins..."
	let l:paths = globpath(g:pm_path, "*", 0, 1)
	call filter(l:paths, "isdirectory(v:val)")
	for item in l:paths
		execute "!git -C " . item . " pull"
	endfor
	echom "Done!"
endfunction

function! s:updatePM()
	echom "Updating pm..."
	if has("nvim")
		let l:update_path = trim(system('echo ${XDG_DATA_DIR:-$HOME/.local/share}/nvim/site/plugin/'))
	else
		let l:update_path = trim(system('echo $HOME/.vim/plugin/'))
	endif
	execute "!curl -fL https://git.sr.ht/~bpv/pm/blob/master/pm.vim > " . l:update_path . "pm.vim"
	echom "Done!"
endfunction

command! -nargs=0 DownloadPlugins call s:downloadPlugins()
command! -nargs=0 UpdatePlugins call s:updatePlugins()
command! -nargs=0 UpdatePM call s:updatePM()
