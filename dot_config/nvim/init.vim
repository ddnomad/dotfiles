"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dein plugin manager setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:dein_dir = expand('~/.config/nvim/dein')
let g:dein_plugin_dir = expand('~/.config/nvim/dein_plugins')

" Clone Dein if not already
if empty(glob(g:dein_dir))
    exec 'silent !mkdir -p '.g:dein_dir
    exec '!git clone https://github.com/Shougo/dein.vim.git '.g:dein_dir
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
exec 'set runtimepath^='.g:dein_dir

if dein#load_state(g:dein_plugin_dir)
    call dein#begin(g:dein_plugin_dir)
    call dein#add(g:dein_dir)

    " Plugins block start
    call dein#add('airblade/vim-gitgutter')
    call dein#add('chr4/nginx.vim')
    call dein#add('chriskempson/base16-vim')
    call dein#add('ctrlpvim/ctrlp.vim')
    call dein#add('dense-analysis/ale')
    call dein#add('dominikduda/vim_current_word')
    call dein#add('editorconfig/editorconfig-vim')
    call dein#add('farmergreg/vim-lastplace')
    call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'], 'build': 'cd app & yarn install'})
    call dein#add('haya14busa/is.vim')
    call dein#add('honza/dockerfile.vim')
    call dein#add('jeffkreeftmeijer/vim-numbertoggle')
    call dein#add('lepture/vim-jinja')
    call dein#add('kevinoid/vim-jsonc')
    call dein#add('neoclide/coc-json', {'build': 'yarn install --frozen-lockfile'})
    call dein#add('neoclide/coc.nvim', {'merged': 0, 'build': 'yarn install --frozen-lockfile'})
    call dein#add('fannheyward/coc-pyright', {'build': 'yarn install'})
    call dein#add('josa42/coc-lua', {'build': 'yarn install --frozen-lockfile'})
    call dein#add('fannheyward/coc-rust-analyzer', {'build': 'yarn install --frozen-lockfile'})
    call dein#add('osyo-manga/vim-anzu')
    call dein#add('RobRoseKnows/lark-vim')
    call dein#add('ryanoasis/vim-devicons')
    call dein#add('sheerun/vim-polyglot')
    call dein#add('scrooloose/nerdtree')
    call dein#add('terryma/vim-multiple-cursors')
    call dein#add('tmhedberg/SimpylFold')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-markdown')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-surround')
    call dein#add('Valloric/ListToggle')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('Yggdroot/indentLine')
    " Plugins block end

    " TODO
    " https://github.com/wellle/targets.vim
    " https://github.com/wellle/context.vim
    " https://github.com/wellle/tmux-complete.vim
    " https://awesomeopensource.com/project/camspiers/lens.vim
    "
    " https://awesomeopensource.com/projects/neovim-plugin
    "
    " XXX
    " https://github.com/numirias/semshi - Nice idea but fucks with my colorscheme too much.

  call dein#end()
  call dein#save_state()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf8
set nocompatible
filetype plugin indent on
syntax on

" Color scheme
let base16colorspace=256
colorscheme base16-default-dark

" Allow to copy/paste from the main clipboard buffer
set clipboard=unnamedplus

" TODO: Needed to support MacOS
"set clipboard=unnamed

" Just much better way to move around
set number relativenumber
set cursorline

" Do not fold anything by default
set nofoldenable

" Non-printable characters styling
set list listchars=tab:\|\ ,trail:·,eol:¬
set showbreak=↳\ \ \ 
set cpo+=n

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
" Do not expand tab in Golang and Rust files
autocmd FileType go,rust setlocal noexpandtab

" Indent with 4 spaces for JSON/YAML
autocmd FileType json,yaml setlocal shiftwidth=2 tabstop=2

" Disable indentLine for markdown files to prevent concealing of chars
autocmd FileType json,markdown let b:indentLine_enabled=0

" Fix Lark Parser highligting
autocmd BufRead,BufNewFile *.lark set filetype=antlr4

" Fix .conf files highlighting
autocmd BufRead,BufNewFile *.conf set filetype=texmf

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Transparency hacks
" TODO: Only apply when on Arch
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi Normal guibg=none ctermbg=none
hi NonText guibg=none ctermbg=none
hi LineNr guibg=none ctermbg=none
hi CursorLineNr guibg=none ctermbg=none
hi StatusLine guibg=none ctermbg=none
hi SignColumn guibg=none ctermbg=none

hi ALEErrorSign ctermfg=9 ctermbg=none
hi ALEWarningSign ctermfg=3 ctermbg=none
hi ALEInfoSign ctermfg=4 ctermbg=none

hi ALEError cterm=underline ctermfg=9 ctermbg=none
hi ALEWarning cterm=underline ctermfg=3 ctermbg=none
hi ALEInfo cterm=underline ctermfg=4 ctermbg=none

hi CocCodeLens ctermfg=8 ctermbg=none
hi CocRustChainingHint ctermfg=8 ctermbg=none

hi GitGutterAdd guibg=none ctermbg=none
hi GitGutterChange guibg=none ctermbg=none
hi GitGutterDelete guibg=none ctermbg=none
hi GitGutterChangeDelete guibg=none ctermbg=none

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme = 'base16'

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline_symbols={}
let g:airline_symbols.linenr = "\ufa70"
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.readonly = "\uf023"

let g:airline#extensions#ale#error_symbol = "\uf00d "
let g:airline#extensions#ale#warning_symbol = "\uf12a "
let g:airline#extensions#ale#open_lnum_symbol = '['
let g:airline#extensions#ale#close_lnum_symbol = ']'

let g:airline#extensions#tabline#left_sep = ""
let g:airline#extensions#tabline#left_alt_sep = ""
let g:airline#extensions#tabline#right_sep = ""
let g:airline#extensions#tabline#right_alt_sep = ""

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':p:.'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#show_close_button = 0

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_disable_lsp = 1
let g:ale_cursor_detail = 0
let g:ale_virtualtext_cursor = 1
let g:ale_close_preview_on_insert = 1
let g:ale_lint_delay = 200

let g:ale_linter_aliases = {
    \'bash': 'sh',
    \'zsh': 'sh'
\}

let g:ale_linters = {
    \'dockerfile': [
        \'hadolint'
    \],
    \'javascript': [
        \'eslint',
        \'standard',
    \],
    \'lua': [
        \'luac',
        \'luacheck'
    \],
    \'python': [
        \'python',
        \'pylama',
        \'flake8',
        \'pycodestyle',
        \'pydocstyle',
        \'pylint'
    \],
    \'rust': ['cargo', 'cargotest', 'rustc'],
    \'sh': ['shell', 'shellcheck'],
    \'sql': ['sqlint'],
\}

let g:ale_python_mypy_auto_pipenv = 1
let g:ale_python_pylint_auto_pipenv = 1
let g:ale_python_pylint_options = '--load-plugins pylint_flask'

let g:ale_rust_cargo_use_clippy = 1

let g:ale_virtualtext_prefix = '❯ '
let g:ale_sign_error = "\uf00d"
let g:ale_sign_warning = "\uf12a"
let g:ale_sign_info = "\u129"

nmap q <Plug>(ale_detail)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> gd <Plug>(coc-definition)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader><leader> :CtrlPBuffer<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Float Preview plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:float_preview#docked = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IndentLine plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" is.vim plugin settings (and integration with Anzu)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)
map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <Tab> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python-syntax plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python_highlight_all = 1
let g:python_highlight_indent_errors = 0
let g:python_highlight_space_errors = 0
let g:python_version_2 = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SimpylFold plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_fold_import = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim_current_word plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_current_word#highlight_current_word = 0
hi CurrentWordTwins gui=italic

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ListToggle plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:lt_location_list_toggle_map = '<c-l>'
let g:lt_height = 12
