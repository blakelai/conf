"
" Setup vim
"
" Author:
"   Blake Lai <blackxwhite@gmail.com>
" Reference:
"   vgod's vimrc : https://github.com/vgod/vimrc
"   dotvim : https://github.com/dotphiles/dotvim

" For compatibility with fish
if $SHELL =~ 'bin/fish'
    set shell=/bin/sh
endif
" Vundle
set nocompatible               " be iMproved
filetype off                   " required!

" http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
" Setting up Vundle - the vim plugin bundler
let VundleInstalled=0
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let VundleInstalled=1
endif
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'
"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'
" My Plugins
" General
"Plugin 'Shougo/unite.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'YankRing.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'jistr/vim-nerdtree-tabs'
"Plugin 'sudo.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'mbbill/undotree'
"Plugin 'mhinz/vim-signify'
Plugin 'Raimondi/delimitMate'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'Lokaltog/vim-easymotion'
if v:version > 703
    Plugin 'myusuf3/numbers.vim'
endif
" General Programming
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdcommenter'
if executable('ack')
    Plugin 'mileszs/ack.vim'
endif
if v:version > 700
    Plugin 'scrooloose/syntastic'
    if executable('ctags')
        Plugin 'majutsushi/tagbar'
    endif
endif
" Git
if executable('git')
    Plugin 'tpope/vim-fugitive'
    Plugin 'airblade/vim-gitgutter'
endif
" Snippets & AutoComplete
Plugin 'Shougo/neocomplcache.vim'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'scrooloose/snipmate-snippets'
Plugin 'honza/vim-snippets'
Plugin 'Indent-Guides'
" Python
Plugin 'hynek/vim-python-pep8-indent'
" Javascript
Plugin 'leshill/vim-json'
"Plugin 'groenewege/vim-less'
Plugin 'taxilian/vim-web-indent'
" HTML
Plugin 'mattn/emmet-vim'
Plugin 'HTML-AutoCloseTag'
"Plugin 'ChrisYip/Better-CSS-Syntax-for-Vim'
"Plugin 'tache/vim-mustache-handlebars'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

if VundleInstalled == 1
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :PluginInstall
endif
" Setting up Vundle - the vim plugin bundler end


" General Settings
set bs=2                " allow backspacing over everything in insert mode
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set autoread            " auto read when file is changed from outside
syntax on               " syntax highlight
set hlsearch            " search highlighting

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

set t_Co=256            " 256 color mode
set cursorline          " highlight current line
colors Tomorrow-Night-Bright
set clipboard=unnamed   " yank to the system register (*) by default
set showmatch           " Cursor shows matching ) and }
set showmode            " Show current mode
set wildchar=<TAB>      " start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set autoindent          " auto indentation
set incsearch           " incremental search
set nobackup            " no *~ backup files
set copyindent          " copy the previous indentation on autoindenting
set ignorecase          " ignore case when searching
set smartcase           " ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab            " insert tabs on the start of a line according to context
set pastetoggle=<F2>    " pastetoggle (sane indentation on pastes)

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" TAB setting{
    set expandtab        "replace <TAB> with spaces
    set softtabstop=4
    set shiftwidth=4

    au FileType Makefile set noexpandtab
"}

" status line {
    set laststatus=2
"}

" mouse settings
if has("mouse")
    set mouse=a
endif
set mousehide " Hide mouse pointer on insert mode."

"---------------------------------------------------------------------------
" ENCODING SETTINGS
"---------------------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

fun! ViewUTF8()
    set encoding=utf-8
    set termencoding=big5
endfun

fun! UTF8()
    set encoding=utf-8
    set termencoding=big5
    set fileencoding=utf-8
    set fileencodings=ucs-bom,big5,utf-8,latin1
endfun

fun! Big5()
    set encoding=big5
    set fileencoding=big5
endfun

" C/C++ specific settings
autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"---------------------------------------------------------------------------
" Tip #382: Search for <cword> and replace with input() in all open buffers
"---------------------------------------------------------------------------
fun! Replace()
    let s:word = input("Replace " . expand('<cword>') . " with:")
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge'
    :unlet! s:word
endfun

"---------------------------------------------------------------------------
" USEFUL SHORTCUTS
"---------------------------------------------------------------------------
" set leader to ,
let mapleader=","
let g:mapleader=","

"replace the current word in all opened buffers
map <leader>r :call Replace()<CR>

" open the error console
map <leader>cc :botright cope<CR>
" move to next error
map <leader>] :cn<CR>
" move to the prev error
map <leader>[ :cp<CR>

" --- move around splits {
" move to and maximize the below split
map <C-j> <C-w>j<C-w>_
" move to and maximize the above split
map <C-k> <C-w>k<C-w>_
" move to and maximize the left split
nmap <C-h> <C-w>h<C-w>_
" move to and maximize the right split
nmap <C-l> <C-w>l<C-w>_
"set wmw=0                     " set the min width of a window to 0 so we can maximize others
"set wmh=0                     " set the min height of a window to 0 so we can maximize others
" }

" move around tabs. conflict with the original screen top/bottom
" comment them out if you want the original H/L
" go to prev tab
map <S-h> gT
" go to next tab
map <S-l> gt

" new tab
map <C-t><C-t> :tabnew<CR>
" close tab
map <C-t><C-w> :tabclose<CR>

" ,/ turn off search highlighting
nmap <leader>/ :nohl<CR>

" Bash like keys for the command line
cnoremap <C-a>      <Home>
cnoremap <C-e>      <End>
cnoremap <C-k>      <C-u>

" <F2> toggles paste mode
nnoremap <F2> :set invpaste paste?<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" Writing Restructured Text (Sphinx Documentation) {
   " Ctrl-u 1:    underline Parts w/ #'s
   noremap  <C-u>1 yyPVr#yyjp
   inoremap <C-u>1 <esc>yyPVr#yyjpA
   " Ctrl-u 2:    underline Chapters w/ *'s
   noremap  <C-u>2 yyPVr*yyjp
   inoremap <C-u>2 <esc>yyPVr*yyjpA
   " Ctrl-u 3:    underline Section Level 1 w/ ='s
   noremap  <C-u>3 yypVr=
   inoremap <C-u>3 <esc>yypVr=A
   " Ctrl-u 4:    underline Section Level 2 w/ -'s
   noremap  <C-u>4 yypVr-
   inoremap <C-u>4 <esc>yypVr-A
   " Ctrl-u 5:    underline Section Level 3 w/ ^'s
   noremap  <C-u>5 yypVr^
   inoremap <C-u>5 <esc>yypVr^A
"}

" remove trailing spaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \if &omnifunc == "" |
        \setlocal omnifunc=syntaxcomplete#Complete |
        \endif
endif

"---------------------------------------------------------------------------
" PLUGIN SETTINGS
"---------------------------------------------------------------------------
" --- Airline {
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
"}

" --- NerdTree {
" Ctrl-F4 to Display the file browser tree
nmap <F4> :NERDTreeTabsToggle<CR>
" ,p to show current file in the tree
nmap <leader>p :NERDTreeFind<CR>
"}

" --- EasyMotion {
"let g:EasyMotion_leader_key = '<Leader>m' " default is <Leader>w
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
"}

" --- Ctrlp {
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:25'

" Directories to ignore
set wildignore+=*/vendor/**
set wildignore+=*/bower_components/**
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_follow_symlinks = 1
"}

" --- Indent-guides {
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 2
"}

" --- TagBar {
" toggle TagBar with F7
nnoremap <silent> <F7> :TagbarToggle<CR>
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1
"}

" --- neocomplcache {
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"}

" --- neosnippet {
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
"}

" --- Numbers {
nnoremap <F5> :NumbersToggle<CR>
"}

" --- Syntastic {
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=1
let g:syntastic_php_checkers=['php']
let g:syntastic_json_checkers=['jsonlint', 'jsonval']
let g:syntastic_twig_checkers=['twiglint']
let g:syntastic_auto_loc_list=0
let g:syntastic_enable_highlighting=1
let g:syntastic_echo_current_error=1
"}

" --- Undotree {
nnoremap <F3> :UndotreeToggle<cr>
"}

" --- Yankring {
nnoremap <silent> <F8> :YRShow<CR>
let g:yankring_replace_n_pkey = '<C-n>'
let g:yankring_replace_n_nkey = '<C-b>'
let g:yankring_history_dir = $HOME.'/.vim/'
let g:yankring_history_file = '.yankring_history'
"}
