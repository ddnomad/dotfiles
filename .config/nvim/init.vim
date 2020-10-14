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
    call dein#add('dominikduda/vim_current_word')
    call dein#add('editorconfig/editorconfig-vim')
    call dein#add('farmergreg/vim-lastplace')

    call dein#add('iamcco/markdown-preview.nvim', {
        \'on_ft': [
            \'markdown',
            \'pandoc.markdown',
            \'rmd'
        \],
        \'build': 'cd app & yarn install'
    \})

    call dein#add('haya14busa/is.vim')
    call dein#add('honza/dockerfile.vim')
    call dein#add('jeffkreeftmeijer/vim-numbertoggle')
    call dein#add('lepture/vim-jinja')

    " TODO: Switch to COC? (lol)
    " https://github.com/neoclide/coc.nvim
    call dein#add('ncm2/float-preview.nvim')
    call dein#add('ncm2/ncm2')
    call dein#add('ncm2/ncm2-bufword')
    call dein#add('ncm2/ncm2-jedi')
    call dein#add('ncm2/ncm2-path')
    call dein#add('ncm2/ncm2-racer')
    call dein#add('filipekiss/ncm2-look.vim')
    " TODO: Add more?
    " https://github.com/ncm2/ncm2/wiki
    "
    " TODO: Check how to integrate rust-analyser and
    " whether it works properly

    call dein#add('neomake/neomake')

    " FIXME: This is a dependency of language server
    " support for NCM2. Do I need it at all?
    "call dein#add('neovim/nvim-lsp')

    call dein#add('osyo-manga/vim-anzu')
    call dein#add('RobRoseKnows/lark-vim')

    " FIXME: This should not be needed (dependency of
    " ncm2 when using vim8 but not neovim). Re-generate
    " plugins bundle and see whether anything breaks.
    " If all good - remove.
    "call dein#add('roxma/nvim-yarp')

    call dein#add('ryanoasis/vim-devicons')
    call dein#add('scrooloose/nerdtree')
    call dein#add('tmhedberg/SimpylFold')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-markdown')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('Yggdroot/indentLine')
    " Plugins block end

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
source ~/.vimrc_background

" Allow to copy/paste from the main clipboard buffer
set clipboard=unnamedplus

" Just much better way to move around
set number relativenumber
set cursorline

" Do not fold anything by default
set nofoldenable

" Non-printable characters styling
set list listchars=tab:▸\ ,trail:·,eol:¬
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

" Prevent vim jumping when linting marks appear/disappear in a sign column
set signcolumn=yes

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype specific fixes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do not expand tab in Golang and Rust files
autocmd FileType go,rust setlocal noexpandtab

" Disable indentLine for markdown files to prevent concealing of chars
autocmd FileType json,markdown let b:indentLine_enabled=0

" Fix Lark Parser highligting
autocmd BufRead,BufNewFile *.lark set filetype=antlr4

" Fix .conf files highlighting
autocmd BufRead,BufNewFile *.conf set filetype=texmf

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcut mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F2> :NERDTreeToggle<CR>
map <F3> :set spell!<CR>
map <F4> :noh<CR>
map <F5> :IndentGuidesToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Transparency hacks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi Normal guibg=none ctermbg=none
hi NonText guibg=none ctermbg=none
hi LineNr guibg=none ctermbg=none
hi CursorLineNr guibg=none ctermbg=none
hi StatusLine guibg=none ctermbg=none
hi SignColumn guibg=none ctermbg=none

hi NeomakeError cterm=underline ctermfg=9 ctermbg=none
hi NeomakeWarning cterm=underline ctermfg=3 ctermbg=none
hi NeomakeInfo cterm=underline ctermfg=4 ctermbg=none
hi NeomakeMessage cterm=underline ctermfg=4 ctermbg=none

hi GitGutterAdd guibg=none ctermbg=none
hi GitGutterChange guibg=none ctermbg=none
hi GitGutterDelete guibg=none ctermbg=none
hi GitGutterChangeDelete guibg=none ctermbg=none

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='base16'

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline_symbols={}
let g:airline_symbols.maxlinenr=''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Float Preview plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:float_preview#docked = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IndentLine plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_conceallevel = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" is.vim plugin settings (and integration with Anzu)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)
map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NCM2 plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
let g:ncm2#total_popup_limit = 10

" Close completion popup and also start a new line when pressing Enter
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neomake plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call neomake#configure#automake('nrwi', 100)

let g:neomake_error_sign={'text': "\uf00d", 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign ={'text': "\uf12a", 'texthl': 'NeomakeWarningSign'}
let g:neomake_info_sign ={'text': "\uf129", 'texthl': 'NeomakeInfoSign'}
let g:neomake_message_sign ={'text': "\uf129", 'texthl': 'NeomakeMessageSign'}

let g:neomake_python_python_exe='/usr/bin/python3'
let g:neomake_python_enabled_makers=[
    \'python',
    \'pylama',
    \'flake8',
    \'pyflakes',
    \'pycodestyle',
    \'pydocstyle',
    \'pylint'
\]
let g:neomake_python_pylint_args = neomake#makers#ft#python#pylint().args + [
    \'--load-plugins',
    \'pylint_flask'
\]

let g:neomake_go_enabled_makers= ['go', 'gometalinter', 'golint']
let g:neomake_javascript_enabled_makers= ['eslint', 'stylelint']
let g:neomake_typescript_enabled_makers= ['tsc', 'tslint', 'eslint']
let g:neomake_rust_enabled_makers=['cargo', 'cargotest', 'rustc']

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
