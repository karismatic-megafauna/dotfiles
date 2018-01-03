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

" Spell checking and AutoCompleting
autocmd FileType gitcommit setlocal spell textwidth=72
autocmd BufRead,BufNewFile *.md setlocal spell
set complete+=kspell

" JSON formatting
autocmd BufNewFile,BufRead *.json set ft=javascript

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" " Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

augroup vimrcEx
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exe "normal g`\"" |
        \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et

  autocmd BufRead, BufNewFile *.sass setfiletype sass
augroup END

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

" let g:syntastic_scss_checkers = ['scss_lint']

"eslint linter
" let g:syntastic_javascript_checkers = ['eslint']

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
" http://stackoverflow.com/questions/4789605/how-do-i-enable-automatic-folds-in-vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=syntax
set foldlevelstart=1
let javaScript_fold=1
autocmd BufWinEnter * silent! :%foldopen!
"experimental
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
