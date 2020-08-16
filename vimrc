"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Welcome to my vimrc ^__^
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Usually on Mac and using Neovim
" I write primarily Javascript and Ruby

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundles
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off

call plug#begin("~/.vim/plugged")

" Syntax Highlighting
Plug 'sheerun/vim-polyglot'

" Shell Util
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-bufferline'
Plug 'christoomey/vim-tmux-navigator'

" Editor Util
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-abolish'
Plug 'bronson/vim-trailing-whitespace'
Plug 'junegunn/vim-easy-align'

" Intellisense / Display
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Text Editing
Plug 'nathanaelkane/vim-indent-guides'

Plug 'wellle/targets.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'benmills/vimux'

" Misc
Plug 'xolox/vim-misc'

" Colors
Plug 'mhartington/oceanic-next'

call plug#end()
filetype plugin indent on

let g:python3_host_prog = expand('/usr/local/bin/python3')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Clear Search
"" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr><cr>
endfunction
call MapCR()

" Toggle Relative Number
"" For when I am pairing with others who don't VIM :)
function! EnableRelativeNumbers()
  set number
  set relativenumber
endfunc

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

" MULTIPURPOSE TAB KEY
"" Indent if we're at the beginning of a line. Else, do completion.
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings / Configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "
inoremap <C-c> <Esc>

" allow unsaved background buffers and remember marks/undo for them
set hidden

" UTF8 encoding for text editing
scriptencoding utf-8
set encoding=utf-8

" remember more commands and search history
set expandtab
set copyindent
set preserveindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set laststatus=2
set showmatch
set hlsearch

" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

" highlight current line
set nocursorline

" " Always show current position
set relativenumber
set number
set switchbuf=useopen
set numberwidth=6
set winwidth=90
" set re=1
set ttyfast
set lazyredraw
" set tags=tags;/

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" keep more context when scrolling off the end of a buffer
set scrolloff=10

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" display incomplete commands
set showcmd

" Enable highlighting for syntax
syntax on

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Turn backup off, since most stuff is in SVN
set nobackup
set nowritebackup
set nowb
set noswapfile

" enable mouse usage
set mouse=a

" Maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set guioptions-=T
set t_Co=256 " 256 colors
set colorcolumn=80
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight xBoom ctermfg=15 ctermbg=9
set statusline+=%f
set statusline+=\ %#xBoom#%m%*              "in yo face modified file
set statusline+=%=                          "align right

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Maps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast saving
nmap <leader>w :wall!<cr>

" Fast buffer closing
nmap <leader>q :bd<cr>

" Fast vim closing
nnoremap <leader>qq :q<cr>

" Switch back to previous file
nnoremap <leader><leader> <c-^>

" use K to do the opposite of J
" nnoremap K i<CR><Esc>

" move through buffers from home
map <leader>l :bn<CR>
map <leader>h :bp<CR>

" Leader r to toggle the line number counting method
nnoremap <silent><leader>r :call NumberToggle()<cr>

" " paste toggle
nnoremap <leader>P :set invpaste<CR>

" Reload plugins
nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>

nmap <leader>dd "_dd
" nnoremap <leader>dd F<space>xf<space>x

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prompt for a command to run
map <leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <leader>vl :VimuxRunLastCommand<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>p :FZF<CR>

" make file opening more like vsCode
map <c-p> :FZF<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy Align
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set .md as markdown files for syntax highlighting
au BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown textwidth=80

" Spell checking and AutoCompleting
autocmd FileType gitcommit setlocal spell textwidth=72
autocmd BufRead,BufNewFile *.md setlocal spell
set complete+=kspell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-buftabline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-N> :bnext<CR>
" nnoremap <C-P> :bprev<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:VimuxOrientation = "h"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=syntax

" Open folds on window open
" https://stackoverflow.com/a/8316817
" autocmd BufWinEnter * silent! :%foldopen!
au BufRead * normal zR

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SQL
let g:omni_sql_no_default_maps = 1

" Turn off parenthesis concealing in JSON
let g:vim_json_syntax_conceal = 0

"JSX syntax Highlighting everywhere
let g:jsx_ext_required = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" CoC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Better display for messages
" set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" " Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction
"
" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline+=%{StatusDiagnostic()}

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc Explorer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-b> :CocCommand explorer<CR>
map <leader>b :CocCommand explorer<CR>
