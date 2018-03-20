" Michael Hinrichs' vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Imports
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

if filereadable(expand("~/.vimrc.functions"))
  source ~/.vimrc.functions
endif

if filereadable(expand("~/.vimrc.basic_configs"))
  source ~/.vimrc.basic_configs
endif

if filereadable(expand("~/.vimrc.color"))
  source ~/.vimrc.color
endif

if filereadable(expand("~/.vimrc.key_maps"))
  source ~/.vimrc.key_maps
endif

if filereadable(expand("~/.vimrc.statusline"))
  source ~/.vimrc.statusline
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc Configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set .md as markdown files for syntax highlighting
au BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown textwidth=80
let vim_markdown_preview_github=1

let vim_markdown_preview_temp_file=1

" Spell checking and AutoCompleting
autocmd FileType gitcommit setlocal spell textwidth=72
autocmd BufRead,BufNewFile *.md setlocal spell
set complete+=kspell

" JSON formatting
autocmd BufNewFile,BufRead *.json set ft=javascript

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:VimuxOrientation = "h"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linters / Ale
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_column_always = 1

let g:ale_sign_error = ">>"
let g:ale_sign_warning = "--"
let g:ale_fix_on_save = 1
let g:ale_linters = {
			\'javascript': ['eslint'],
			\}

"JSX syntax Highlighting everywhere
let g:jsx_ext_required = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerd Tree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" change default arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"close NERDTree if it is only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=syntax

" Open folds on window open
" https://stackoverflow.com/a/8316817
autocmd BufWinEnter * silent! :%foldopen!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
