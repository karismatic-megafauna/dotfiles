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

if filereadable(expand("~/.vimrc.vim_configs"))
  source ~/.vimrc.vim_configs
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

if filereadable(expand("~/.vimrc.pacakge_configs"))
  source ~/.vimrc.package_configs
endif

