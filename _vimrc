"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                                _                                          "
"                         _   __(_)___ ___  __________                      "
"                        | | / / / __ `__ \/ ___/ ___/                      "
"                        | |/ / / / / / / / /  / /__                        "
"                        |___/_/_/ /_/ /_/_/   \___/                        "
"                                                                           "
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

"" general {{{1

set nocompatible            " use vim in more useful way
set clipboard=unnamed       " share clipboard with other systems

"" text formatting {{{1

set autoindent              " automatic indent new lines
set smartindent             " be smart about it
inoremap # x<bs>#
set wrap                    " wrap lines
set sidescroll=5
set softtabstop=2
set shiftwidth=2
set shiftround
set tabstop=4
set expandtab               " expand tabs to spaces
set nosmarttab              " fuck tabs
set formatoptions+=n        " support for numbered/bullet lists
set textwidth=79            " wrap at 79 chars by default
if v:version >= 703
  setlocal colorcolumn=80
endif
set wrapmargin=0
set virtualedit=block       " allow virtual edit in visual block ..


"" remapping {{{1

let mapleader=','           " lead with ,
" jump to vimrc
nnoremap <space><space> :<c-u>edit $home/.vimrc<cr>
" reload vimrc setting
nnoremap <space>s       :<c-u>source $home/.vimrc<cr>
" create new tab
cnoremap <c-t> <c-u>tabnew<cr>
nnoremap <c-h> :<c-u>tabprevious<cr>
nnoremap <c-l> :<c-u>tabnext<cr>

"" ui {{{1

set ruler                   " show the cursor position all the time
" highlight cursor line in current window{{{2
augroup cch
  autocmd! cch
  autocmd winleave * set nocursorline
  autocmd winenter,bufread * set cursorline
augroup end
highlight clear cursorline
highlight cursorline ctermbg=black
" }}}2
set showcmd                 " display incomplete commands
set number                  " line numbers
set nolazyredraw            " don't redraw while executing macros
set wildmenu                " turn on wild menu
set wildmode=list:longest,full
set cmdheight=1             " command line height
" enable all keys to move the cursor left/right to the previous/next line
set whichwrap=b,s,h,l,<,>,[,]
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set shortmess=filtiooa      " shorten messages
set report=0                " tell us about changes
set nostartofline           " don't jum to the start of line when scrolling
set showmatch               " brackets/braces that is
set matchtime=3             " duration to show matching brace (1/10 sec)
set laststatus=2            " the last window always have status line
set scrolloff=5             " keep at least 5 lines above and below the cursor
set visualbell t_vb=        " no beep sound
" treat octal and hexadecimal number as decimal number
" octal  numbers that start with a zero will be considered to be octal
"        example: using ctrl-a on "007" results in "010"
" hex    numbers starting with "0x" or "0x" will be considered to be hexadecimal
"        example: using ctrl-x on "0x100" results in "0x0ff"
set nrformats-=octal,hex
if has("mouse") " enable the use of the mouse in all modes
  set mouse=a
endif

syntax on
"" colorize {{{2

" keep this order!
" solarized - http://ethanschoonover.com/solarized
colorscheme molokai
set background=dark

" highlight whitespaces
highlight whitespaceeol ctermbg=red
matc whitespaceeol /\s\+$/

" highlight comments
"highlight comment ctermfg=darkcyan

"" backup {{{1

" backup current file, deleted afterwards
set nobackup
set writebackup
if !filewritable($home."/.vim-backup")
    call mkdir($home."/.vim-backup", "p")
endif
set backupdir=$home/.vim-backup
if !filewritable($home."/.vim-swap")
    call mkdir($home."/.vim-swap", "p")
endif
set directory=$home/.vim-swap

"" search {{{1

set history=100             " keep 100 lines of command line histories
set ignorecase
set smartcase
set wrapscan                " searches wrap around the end of the file
" while typing a search command, show where the pattern matches
set incsearch
set hlsearch                " highlighting matches
" turn off highlight by esc x 2
nmap <esc><esc> :nohlsearch<cr><esc>

"" character encoding {{{1

set encoding=utf-8          " use utf-8
set termencoding=utf-8      " ..
set fileencodings=utf-8     " ..
" automatic end-of-file format detection
set fileformats=unix,mac,dos

"" plugins {{{1
"" neobundle {{{2
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
" let neobundle manage neobundle
neobundle 'shougo/neobundle.vim'

"" for version > 702 only {{{2
if v:version > 702
  "" unite.vim {{{3
  neobundle 'shougo/unite.vim'

  let g:unite_enable_split_vertically = 1
  let g:unite_winwidth = 50
  let g:unite_enable_start_insert = 1
  let g:unite_source_file_mru_ignore_pattern = '.*\/$\|.*application\ data.*'
  nnoremap [unite] <nop>
  nmap     <space>u [unite]
  nnoremap <silent> [unite]u :<c-u>unitewithbufferdir -horizontal -buffer-name=files file file/new<cr>
  nnoremap <silent> [unite]c :<c-u>unitewithcurrentdir -horizontal -buffer-name=files buffer file_mru<cr>
  nnoremap <silent> [unite]i :<c-u>unite -buffer-name=files buffer_tab<cr>
  nnoremap <silent> [unite]b :<c-u>unite -buffer-name=files bookmark<cr>
  nnoremap <silent> [unite]r :<c-u>unite -buffer-name=register register<cr>
  nnoremap <silent> [unite]l :<c-u>unite line<cr>
  nnoremap <silent> [unite]t :<c-u>unite -immediately -horizontal tab:no-current<cr>
  nnoremap <silent> [unite]m :<c-u>unite -no-empty git_modified<cr>

  nnoremap <silent> <c-g>    :<c-u>unite vcs_grep/git<cr>
  "nnoremap <silent> <c-h>    :<c-u>unite -start-insert help<cr>

  autocmd filetype *      nnoremap <silent><buffer> k :<c-u>unite -start-insert -default-action=vsplit ref/man<cr>
  autocmd filetype erlang nnoremap <silent><buffer> k :<c-u>unite -start-insert -default-action=vsplit ref/erlang<cr>
  autocmd filetype ruby   nnoremap <silent><buffer> k :<c-u>unite -start-insert -default-action=vsplit ref/ri<cr>
  autocmd filetype python nnoremap <silent><buffer> k :<c-u>unite -start-insert -default-action=vsplit ref/pydoc<cr>
  autocmd filetype perl   nnoremap <silent><buffer> k :<c-u>unite -start-insert -default-action=vsplit ref/perldoc<cr>

  autocmd filetype unite call s:unite_my_settings()
  function! s:unite_my_settings()
    " overwrite settings
    nmap <buffer><esc>  <plug>(unite_exit)
    nmap <buffer><c-c>  <plug>(unite_exit)
    "imap <buffer>jj     <plug>(unite_insert_leave)
    imap <buffer><c-w>  <plug>(unite_delete_backward_path)


    " <c-l>: manual neocomplecache completion.
    inoremap <buffer><c-l>  <c-x><c-u><c-p><down>

    nmap <buffer><expr><c-d>  unite#do_action('delete')
    imap <buffer><expr><c-d>  unite#do_action('delete')
    nmap <buffer><expr><c-b>  unite#do_action('bookmark')
    imap <buffer><expr><c-b>  unite#do_action('bookmark')
    nmap <buffer><expr><c-k>  unite#do_action('above')
    imap <buffer><expr><c-k>  unite#do_action('above')
    nmap <buffer><expr><c-i>  unite#do_action('left')
    imap <buffer><expr><c-i>  unite#do_action('left')
  endfunction

  " unite plugins
    "" unite-git_grep {{{4
    neobundle 'sgur/unite-git_grep'

    "" unite-git {{{4
    neobundle 'taka84u9/unite-git'

    "" unite-outline {{{4
    neobundle 'h1mesuke/unite-outline'

    "" unite-help {{{4
    neobundle 'tsukkee/unite-help'


  "" vim-ref {{{3
  neobundle 'thinca/vim-ref'

  let g:ref_perldoc_complete_head = 1
  let g:ref_open = 'vsplit'

    " vim-ref plugins
    "" vim-ref-ri {{{4
    neobundle 'taka84u9/vim-ref-ri'

  "" neocomplcache {{{3
  neobundle 'shougo/neocomplcache'
  neobundle 'shougo/neocomplcache-snippets-complete'

  "imap <c-k> <plug>(neocomplcache_snippets_expand)
  "smap <c-k> <plug>(neocomplcache_snippets_expand)

  let g:neocomplcache_enable_auto_select = 1

  " use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " use underbar completion.
  let g:neocomplcache_enable_underbar_completion = 1
  " set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

  " use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " use camel case completion.
  let g:neocomplcache_enable_camel_case_completion = 1
  " select with <tab>
  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

  let g:neocomplcache_ctags_arguments_list = {
        \ 'perl' : '-r -h ".pm"'
        \ }

  let g:neocomplcache_snippets_dir = "~/.vim/snippets"
  " define dictionary.
  let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default'    : '',
        \ 'perl'       : $home . '/.vim/dict/perl.dict'
        \ }

  " define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  "" vimfiler {{{3
  neobundle 'shougo/vimfiler'

  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_safe_mode_by_default = 0

  "" indent-guides {{{3
  neobundle 'nathanaelkane/vim-indent-guides'

  let g:indent_guides_auto_colors = 0 " read help txt
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_color_change_percent = 30
  "let g:indent_guides_guide_size = 1

  "" localrc {{{3
  neobundle "thinca/vim-localrc"

  "" syntastic {{{3
  neobundle "scrooloose/syntastic"

  let g:syntastic_mode_map = { 'mode': 'passive',
        \ 'active_filetypes': ['ruby', 'javascript', 'python', 'cpp', 'coffeescript'],
        \ 'passive_filetypes': [] }

  "" vimproc {{{3
  neobundle 'shougo/vimproc'

endif "}}}2

"" all version {{{2

  "" vim-fugitive {{{3
  neobundle 'tpope/vim-fugitive'

  "" vim-surround {{{3
  neobundle 'tpope/vim-surround'
  let g:surround_{char2nr("#")} = "{# \r #}"
  let g:surround_{char2nr("*")} = "/* \r */"
  let g:surround_{char2nr("p")} = "<?php \r ?>"

  "" rails.vim {{{3
  neobundle 'tpope/vim-rails'

  "" quick run {{{3
  neobundle 'thinca/vim-quickrun'

  nmap <leader>r <plug>(quickrun)

  "" easymotion {{{3
  neobundle 'lokaltog/vim-easymotion'

  let g:easymotion_leader_key = '<space>j'

  "" gist.vim {{{3
  neobundle "mattn/gist-vim"
  neobundle "mattn/webapi-vim"

  let g:gist_detect_filetype = 1
  let g:github_user = "taka84u9"
  let g:github_token = "e9f46f535783ba347658b0569a450f74"

  "" vim-coffee-script {{{3
  neobundle "kchmck/vim-coffee-script"

  nnoremap <silent> <space>c :coffeecompile watch vert <cr><c-w>h
  let coffee_compile_vert = 1

  "" vim-powerline {{{3
  neobundle "lokaltog/vim-powerline"
  "let g:powerline_symbols = 'fancy'

  "" vim-less {{{3
  neobundle "groenewege/vim-less"

  "" vim-perl {{{3
  neobundle 'petdance/vim-perl'

  "" foldcc {{{3
  neobundle 'leafcage/foldcc'
  set foldtext=foldcctext()
  hi folded ctermfg=darkblue
  hi foldcolumn ctermfg=lightgrey

  "" vim-markdown {{{3
  neobundle 'tpope/vim-markdown'

  filetype plugin indent on
  "
  " brief help
  " :neobundlelist       - list configured bundles
  " :neobundleinstall(!) - install(update) bundles
  " :neobundleclean(!)   - confirm(or auto-approve) removal of unused bundles
  "

" }}}2

"" source {{{1

autocmd bufread,bufnewfile gemfile set filetype=ruby
autocmd bufread,bufnewfile *.json set filetype=javascript

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
