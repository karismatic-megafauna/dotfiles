
" Michael Hinrich's vimrc, forked from -
" Michael Stock's vimrc -- http://github.com/mikeastock/dotfiles
" Last updated 01/27/2014

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VUNDLE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
"Always show current position
set ruler
set relativenumber
set number
set cmdheight=2
set switchbuf=useopen
set numberwidth=6
set showtabline=2
set winwidth=90
set tags=tags;/
set colorcolumn=80
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader = " "

" enable mouse usage
" set mouse=a

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

"ctags custom mappings
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"vim ruby commands
imap <S-CR> <CR><CR>end<Esc>-cc

" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
"
" Start interactive EasyAlign with a Vim movement
nmap <Leader>a <Plug>(EasyAlign)

" Resize panes
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Spell checking and AutoCompleting
autocmd FileType *.md,gitcommit setlocal spell textwidth=72
set complete+=kspell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set guioptions-=T
set t_Co=256 " 256 colors
colorscheme mango
set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme = 'wombat'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1
" let g:airline_powerline_fonts = 1
let g:bufferline_echo = 0

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle Paste
set pastetoggle=<leader>p

" Fast saving
nmap <leader>w :w!<cr>

" Fast buffer closing
nmap <leader>q :bd<cr>

" Fast vim closing
nnoremap <leader>qq :q<cr>

" Switch back to previous file
nnoremap <leader><leader> <c-^>

" Find and Replace Highlighted Word with <C-r>
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
nmap <leader>W :%s/\(<c-r>=expand("<cword>")<cr>\)/

" Move around in panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" EXPERIMENTAL move through buffers from home
map <leader>L :bn<cr>
map <leader>H :bp<cr>

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" Control-C to return to Command Mode
imap <c-c> <esc>

" Clear the search buffer when hitting return
function! MapCR()
    nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

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
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRLP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
        \ --ignore .git
        \ --ignore .svn
        \ --ignore .hg
        \ --ignore .DS_Store
        \ --ignore node_modules
        \ --ignore images
        \ -g ""'
endif

" let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_max_height = 30
" let g:ctrlp_working_path_mode = 0

map <leader>gv :CtrlP app/views<cr>
map <leader>gh :CtrlP app/helpers<cr>
map <leader>ga :CtrlP app/assets<cr>
map <leader>gp :CtrlP config<cr>
map <leader>f :CtrlP frontend<cr>
map <leader>b :CtrlPBuffer<cr>
let g:CtrlMaxFiles=40000

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Linters
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"SCSS-lint
let g:syntastic_scss_checkers = ['scss_lint']

"eslint linter
let g:syntastic_javascript_checkers = ['eslint']

"JSX syntax Highlighting everywhere
let g:jsx_ext_required = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" net-rw
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>o :Vex<cr>
let g:netrw_liststyle=3

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" White-space trimming
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
map <leader>sts :ShowSpaces 1<cr>
map <leader>dts :TrimSpaces<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
" http://stackoverflow.com/questions/4789605/how-do-i-enable-automatic-folds-in-vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=syntax
set foldlevelstart=1

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

" Folding for SCSS
autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}
