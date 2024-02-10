" pm.vim - Stupidly Simple Vim/NeoVim plugin manager
" Author: Bryce Vandegrift <https://brycevandegrift.xyz>
" Version: 0.6.0

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

" Takes a git url and returns base repo name
function! s:namefromgit(str)
	let l:split_url = split(substitute(a:str, "\.git$", "", ""), "/")
	return l:split_url[-1]
endfunction

" Checks if val is not in list
function! s:notinlist(val, list)
	for item in a:list
		if (match(item, a:val) != -1)
			return v:false
		endif
	endfor
	return v:true
endfunction

" Runs helptags on doc files
function! s:updatedocs(item)
	if isdirectory(g:pm_path . a:item . "/doc")
		execute "helptags " . g:pm_path . a:item . "/doc"
		echom "Adding docs for " . a:item . "..."
	endif
endfunction

function! s:clonePlugin(url)
	echom "Cloning " . a:url . "..."
	execute "!cd " . g:pm_path . ";git clone " . a:url
	call s:updatedocs(s:namefromgit(a:url))
	echom "Done!"
endfunction

function! s:downloadPlugins()
	echom "Downloading plugins..."
	if empty(g:plugins)
		echom "No plugins defined!"
		return
	endif
	for item in g:plugins
		execute "!cd " . g:pm_path . ";git clone " . item
		call s:updatedocs(s:namefromgit(item))
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

function! s:purgePlugins()
	echom "Purging plugins..."
	if empty(g:plugins)
		echom "No plugins defined!"
		return
	endif
	" Lots of filtering and mapping
	let l:paths = globpath(g:pm_path, "*", 0, 1)
	call filter(l:paths, "isdirectory(v:val)")
	call map(l:paths, "split(v:val, '/')")
	call map(l:paths, "get(v:val, -1)")
	let l:plugs = map(g:plugins[0:], "s:namefromgit(v:val)")
	call filter(l:paths, "s:notinlist(v:val, l:plugs)")
	for item in l:paths
		execute "!rm -rf " . g:pm_path . item
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
command! -nargs=1 ClonePlugin call s:clonePlugin(<args>)
command! -nargs=0 UpdatePlugins call s:updatePlugins()
command! -nargs=0 PurgePlugins call s:purgePlugins()
command! -nargs=0 UpdatePM call s:updatePM()
