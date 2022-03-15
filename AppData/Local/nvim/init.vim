"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" A minimal NeoVim config specifically for Windows hosts.
"
" Nothing fancy, just bare essentials to improve editing experience from
" PowerShell and other CLI environments on Windows. For full-fledged
" configuration, see dot_config/nvim/init.vim.tmpl in the project root.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf8
set nocompatible
filetype plugin indent on
syntax on

" Color scheme
colorscheme industry

" Allow to copy/paste from the main clipboard buffer
set clipboard=unnamedplus

" Just much better way to move around
set number relativenumber
set cursorline

" Do not fold anything by default
set nofoldenable

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

" Hide files that have edits when opening a file in the same buffer
" NOTE: This is required for LanguageClient-neovim to work correctly.
set hidden

" Prevent vim jumping when linting marks appear/disappear in a sign column
set signcolumn=yes

" Leader configuration
let mapleader=";"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype specific fixes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent with 4 spaces for JSON/YAML
autocmd FileType json,yaml setlocal shiftwidth=2 tabstop=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcut mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <F3> :set spell!<CR>
map <silent> <F4> :noh<CR>

" Switching between buffers
" NOTE: Also <leader>-<number> can be used (see airline configuration)
map <silent> <c-j> :bn<CR>
map <silent> <c-k> :bp<CR>

" Switching between splits
map <C-H> <C-W>h
map <C-L> <C-W>l

" Close current buffer
map <silent> <C-Q> :bd<CR>
