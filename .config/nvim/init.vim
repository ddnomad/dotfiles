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
  call dein#add('airblade/vim-gitgutter')
  call dein#add('chriskempson/base16-vim')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('neomake/neomake')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('scrooloose/nerdtree')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('Yggdroot/indentLine')
  " Plugins block end

  call dein#end()
  call dein#save_state()
endif

" General settings
set encoding=utf8
set nocompatible
filetype plugin indent on
syntax on

" Color scheme
let base16colorspace=256
source ~/.vimrc_background

" Workaround for theming bs to reenable transparency
hi Normal guibg=none ctermbg=none
hi NonText guibg=none ctermbg=none
hi LineNr guibg=none ctermbg=none
hi CursorLineNr guibg=none ctermbg=none
hi StatusLine guibg=none ctermbg=none
hi SignColumn guibg=none ctermbg=none

" Allow to copy/paste from the main clipboard buffer
set clipboard=unnamedplus

" Just much better way to move around
set number relativenumber

" Default indentation
set tabstop=4
set shiftwidth=4
set expandtab

" Use terminal cursor & font styling
set guicursor=
set guifont=

" Explicitly disable modeline for security reasons
" More info: https://security.stackexchange.com/a/157739/90606
set nomodeline

" Non-printable characters styling
set list listchars=tab:▸\ ,trail:·,eol:¬
set showbreak=↳\ \ \ 
set cpo+=n

" Airline plugin settings
let g:airline_selection_c='%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
let g:airline_theme='base16'

" IndentLine plugin settings
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Neomake plugin settings
autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_error_sign={'text': "\uf00d", 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign ={'text': "\uf12a", 'texthl': 'NeomakeWarningSign'}
let g:neomake_info_sign ={'text': "\uf129", 'texthl': 'NeomakeInfoSign'}
let g:neomake_message_sign ={'text': "\uf129", 'texthl': 'NeomakeMessageSign'}

" Additional F layer mappings
map <F2> :NERDTreeToggle<CR>
map <F3> :set spell!<CR>
map <F4> :noh<CR>
map <F5> :IndentGuidesToggle<CR>
