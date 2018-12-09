" Define Dein dirs
let g:dein_dir = expand('~/.config/nvim/dein')
let g:dein_plugin_dir = expand('~/.config/nvim/dein_plugins')

" Clone Dein if not already
if empty(glob(g:dein_dir))
  exec 'silent !mkdir -p '.g:dein_dir
  exec '!git clone https://github.com/Shougo/dein.vim.git '.g:dein_dir
endif

" Enable Dein and load plugins
exec 'set runtimepath^='.g:dein_dir
if dein#load_state(g:dein_plugin_dir)
  call dein#begin(g:dein_plugin_dir)
  call dein#add(g:dein_dir)

  " Plugins block start
  call dein#add('chriskempson/base16-vim')
  " Plugins block end

  call dein#end()
  call dein#save_state()
endif

" Color scheme
let base16colorspace=256
source ~/.vimrc_background

" Workaround for theming bs to reenable transparency
autocmd VimEnter * hi Normal guibg=none ctermbg=none
autocmd VimEnter * hi NonText guibg=none ctermbg=none
autocmd VimEnter * hi LineNr guibg=none ctermbg=none
autocmd VimEnter * hi CursorLineNr guibg=none ctermbg=none
autocmd VimEnter * hi StatusLine guibg=none ctermbg=none

" Allow to copy/paste from the main clipboard buffer
set clipboard=unnamedplus

" Just much better way to move around
set number relativenumber

" Default indentation
set tabstop=4
set shiftwidth=4
set expandtab

" Use terminal cursor styling
set guicursor=
