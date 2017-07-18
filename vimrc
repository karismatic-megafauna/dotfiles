" Michael Hinrichs' vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Imports
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

if filereadable(expand("~/.vimrc.basic_configs"))
  source ~/.vimrc.basic_configs
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Specific Configurations
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
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set guioptions-=T
" set t_Co=256 " 256 colors
set colorcolumn=80
set background=dark
let g:gruvbox_contrast_dark='medium'
colorscheme gruvbox

" " Fix Transparency
" hi Normal ctermbg=none
" hi NonText ctermbg=none

" " Line numbers
" hi LineNr ctermbg=none
" hi LineNr ctermfg=248

" " ColorColumn (80)
" hi ColorColumn ctermbg=234
" hi ColorColumn ctermfg=161

" " Colors for TODO/FIXME
" hi Todo cterm=bold
" hi Todo ctermbg=none
" hi Todo ctermfg=200

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimux Configs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:VimuxOrientation = "h"

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast saving
nmap <leader>w :wall!<cr>

" Fast buffer closing
nmap <leader>q :bd<cr>

" Fast vim closing
nnoremap <leader>qq :q<cr>

" Switch back to previous file
nnoremap <leader><leader> <c-^>

" use K to do the opposite of J
nnoremap K i<CR><Esc>

" EXPERIMENTAL move through buffers from home
map <leader>l :bn<CR>
map <leader>h :bp<CR>

" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr><cr>
endfunction
call MapCR()

" Enables relative numbers.
function! EnableRelativeNumbers()
  set number
  set relativenumber
endfunc

" Disables relative numbers.
function! DisableRelativeNumbers()
  set number
  set norelativenumber
endfunc

function! NumberToggle()
  if(&relativenumber == 1)
    call DisableRelativeNumbers()
    let g:relativemode = 0
  else
    call EnableRelativeNumbers()
    let g:relativemode = 1
  endif
endfunc

" Leader r to toggle the line number counting method
nnoremap <silent><leader>r :call NumberToggle()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>f :FZF<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy Align
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linters / Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable :lnext and :lprev
let g:syntastic_always_populate_loc_list = 1

"SCSS-lint
let g:syntastic_scss_checkers = ['scss_lint']

"eslint linter
let g:syntastic_javascript_checkers = ['eslint']

"JSX syntax Highlighting everywhere
let g:jsx_ext_required = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerd Tree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add control slash and command slash (like atom) to collapse and expand
map <C-o> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>

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
" Toggles
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable mouse usage
set mouse=a
" autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
" map <leader>t :!npm t<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline -- to use :hi, you must define below any :colorscheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi xBoom ctermfg=15 ctermbg=9
set statusline=%f%r%h%w\                    "flags
set statusline+=%{fugitive#statusline()}\   "what branch you are on
set statusline+=\ %#xBoom#%m%*              "in yo face modified file
set statusline+=%=                          "align right
set statusline+=%{VisualPercent()}          "scrollbar

" Flip order of tab completion
let g:SuperTabDefaultCompletionType = "<c-n>"

let g:elm_format_autosave = 1
