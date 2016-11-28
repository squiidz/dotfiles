" vim: set ft=vim:
set nocompatible
" PLUGINS
" ==============================================================

" Autoinstall vim-plug
" {{{
if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}
call plug#begin('~/.nvim/plugged')

" tpope!
if !has("nvim")
  Plug 'tpope/vim-sensible'
endif
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-ragtag'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'

" Navigation
Plug 'scrooloose/nerdtree'
" {{{
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeDirArrows = 1
  let g:NERDTreeChDirMode = 2
  let g:NERDTreeAutoDeleteBuffer = 1

  map <F6> :NERDTreeToggle<CR>
  map <F5> :NERDTreeFind<CR>
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTreeToggle | endif
" }}}

" Rust Racer autocomplete
set hidden
let g:racer_cmd = "~/.cargo/bin/racer"
let $RUST_SRC_PATH="~/src/rustc-nightly/src/"
let g:racer_experimental_completer = 1


" Autocomplete/fuzzy search/ack
" Plug 'Valloric/YouCompleteMe'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" {{{
  let g:deoplete#enable_at_startup = 1
  " let g:deoplete#omni#functions = {}
  " let g:deoplete#omni#functions.ruby = 'rubycomplete#Complete'
" }}}
"Plug 'fishbullet/deoplete-ruby'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" {{{
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
" }}}
Plug 'junegunn/fzf.vim'
" {{{
  nnoremap <silent> <Leader><Leader> :Files<CR>
  nnoremap <silent> <Leader>b :Buffers<CR>
  nnoremap <silent> <Leader>o :BTags<CR>
  nnoremap <silent> <Leader>ag :Ag <C-R><C-W><C-R>
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)
" }}}

Plug 'mileszs/ack.vim'
" {{{
  let g:ackprg = 'ag --nogroup --nocolor --column'
" }}}

" Languages/editing
Plug 'vim-ruby/vim-ruby'
Plug 'bingaman/vim-sparkup'
" {{{
  let g:sparkupArgs = '--no-last-newline --expand-divs'
" }}}
Plug 'kchmck/vim-coffee-script'
Plug 'JSON.vim'
Plug 'robbles/logstash.vim'
Plug 'leafgarland/typescript-vim'
Plug 'ekalinin/Dockerfile.vim'

" Make/link
Plug 'neomake/neomake'
" {{{
  autocmd! BufWritePost * Neomake
  let g:neomake_open_list=2
" }}}

" objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'nelstrom/vim-textobj-rubyblock'

" tests
Plug 'junegunn/vim-emoji'
Plug 'kassio/neoterm'
" {{{
  let g:neoterm_run_tests_bg = 1
  let g:neoterm_raise_when_tests_fail = 1
  "let g:neoterm_close_when_tests_succeed = 1
  let g:neoterm_rspec_lib_cmd = 'zeus rspec'

  nmap <silent> <leader>r :call neoterm#test#run('file')<cr>
  nmap <silent> <leader>R :call neoterm#test#run('current')<cr>

  " toggle terminal
  nnoremap <silent> ,tt :Ttoggle<cr>
  " hide/close terminal
  nnoremap <silent> ,th :call neoterm#close()<cr>
  " clear terminal
  nnoremap <silent> ,tl :call neoterm#clear()<cr>
  " kills the current job (send a <c-c>)
  nnoremap <silent> ,tc :call neoterm#kill()<cr>
" }}}

" misc
Plug 'kshenoy/vim-signature'
Plug 'itchyny/lightline.vim'
" {{{
  let g:lightline = {
    \ 'active': {
    \   'right': [ [ 'lineinfo' ], [ 'percent' ],
    \              [ 'neoterm', 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'neoterm': 'LightlineNeoterm'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }
  set noshowmode " Remove duplicate information

  function! LightlineNeoterm()
    return g:neoterm_statusline
  endfunction
" }}}

Plug 'airblade/vim-gitgutter'
" {{{
  let g:gitgutter_map_keys = 0
  let g:gitgutter_max_signs = 200
  let g:gitgutter_realtime = 0
  let g:gitgutter_eager = 0
" }}}
"
Plug 'ludovicchabant/vim-gutentags'

Plug 'junegunn/limelight.vim'
" {{{
  let g:limelight_default_coefficient = 0.7
  nmap <silent> gl :Limelight!!<CR>
" }}}

Plug 'frankier/neovim-colors-solarized-truecolor-only'
"Plug 'fatih/molokai'

call plug#end()

" POST PLUGIN
" ==============================================================

" NEOTERM
" Dependency on vim-emoji, needs to be loaded
let g:neoterm_test_status = {
  \ 'running': emoji#for('running'),
  \ 'success': emoji#for('green_heart'),
  \ 'failed': emoji#for('broken_heart')
  \ }


" General settings
" ==============================================================
set clipboard=unnamed,unnamedplus

set title
set visualbell
set number          " show line numbers
set relativenumber  " use relative lines numbering by default
set hidden          " hide buffers instead of closing
set lazyredraw      " speed up on large files
set laststatus=2    " Show the status line all the time
set showcmd         " Display incomplete commands.
set undolevels=5000 " max undo levels
set nobackup
set nowritebackup
set noswapfile
set nowrap                        " Turn off line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

" Split below and right
set splitbelow
set splitright

" Show tabs, trailing whitespaces, extends and precedes
set list
set listchars=tab:>-,trail:·,extends:>,precedes:<,nbsp:+

" INDENTATION
" ==============================================================
set expandtab     " replace <Tab> with spaces
set tabstop=2     " number of spaces that a <Tab> in the file counts for
set softtabstop=2 " remove <Tab> symbols as it was spaces
set shiftwidth=2  " indent size for << and >>
set shiftround    " round indent to multiple of 'shiftwidth' (for << and >>)


" SEARCH
" ==============================================================
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.


" FOLDING
" ==============================================================
" Set fold method -- currently 'manual' for performance reasons (dramatically
" accelerates opening files like routes.rb)
set foldmethod=manual
" Enable a fold column
set foldcolumn=4
" Disable folding by default
set nofoldenable
" Enable folding by <Leader>f
noremap <Leader>f :setlocal foldmethod=syntax foldcolumn=4<CR>


" COLORSCHEME
" ==============================================================
set termguicolors
syntax enable
set background=dark
"let g:molokai_original=1
colorscheme solarized
let g:solarized_termcolors=256
"set t_Co=256
call togglebg#map("<F4>")

" MISC
" ==============================================================
set cursorline
set colorcolumn=80

" CTags - refresh tags
map <Leader>tt :!ctags --extra=+f --exclude=.git --exclude=log --exclude=compiled --exclude=tmp -R *<CR><CR>

" Clear the current search highlight by pressing Esc
nnoremap <silent> <esc><esc> :noh<CR><esc>

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal! g`\""
      normal! zz
    endif
  end
endfunction

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


" NVIM
" ==============================================================
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

if filereadable(glob("~/.nvimrc.local"))
  source ~/.nvimrc.local
endif
