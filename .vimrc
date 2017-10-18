set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"------------tagbar插件-------------
"按F2开/关右侧tagbar窗口
Bundle 'majutsushi/tagbar'
"nmap <Leader>tb :TagbarToggle<CR>        "快捷键设置
let g:tagbar_ctags_bin='ctags'            "ctags程序的路径
let g:tagbar_width=30                    "窗口宽度的设置
map <F2> :Tagbar<CR>
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()     
"如果是c语言的程序的话，tagbar自动开启

"---------------目录树插件-----------------
"按F1开/关左侧目录树窗口
Bundle 'scrooloose/nerdtree'
let NERDTreeWinPos='left'
let NERDTreeWinSize=25
nmap <F1> :NERDTreeToggle<CR>

"--------------状态栏插件-----------------
"+/_
Bundle 'bling/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
let g:airline_theme='kolor'
set laststatus=2

let g:airline_powerline_fonts=1
let g:airline#extensions#syntastic#enabled=1
let g:airline#extensions#whitespace#enable=0
let g:airline#extensions#whitespace#symbol='!'
let g:airline#extensions#tabline#enabled=1
let g:airline#extension#tabline#buffer_nr_show=1
let g:airline#extension#tabline#idx_mode=0
let g:airline#extension#tabline#show_splits=1
let g:airline#extension#tabline#fnamemod=':t'

let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap ,1 <Plug>AirlineSelectTab1
nmap ,2 <Plug>AirlineSelectTab2
nmap ,3 <Plug>AirlineSelectTab3
nmap ,4 <Plug>AirlineSelectTab4
nmap ,5 <Plug>AirlineSelectTab5
nmap ,6 <Plug>AirlineSelectTab6
nmap ,7 <Plug>AirlineSelectTab7
nmap ,8 <Plug>AirlineSelectTab8
nmap ,9 <Plug>AirlineSelectTab9

nmap _ <Plug>AirlineSelectPrevTab
nmap + <Plug>AirlineSelectNextTab

"------------皮肤包----------------
Plugin 'flazz/vim-colorschemes'

"------------自动补全插件-------------
"按tab键在预选项中选择
Bundle 'Shougo/neocomplete'
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'




call vundle#end()            " required
filetype plugin indent on    " required

"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just ::luginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set nu
set incsearch 
set hlsearch
set smartindent
set backspace=indent,eol,start
set showcmd
set ruler
autocmd FileType text setlocal textwidth=78
syntax on
"set autowrite
set writebackup
set backupext=.bak
set shiftwidth=4
set textwidth=72
source $VIMRUNTIME/ftplugin/man.vim
set fileformats=unix,dos
set showmatch
iabbrev #s /*---------------------------------------------------------------------------/
iabbrev #e /---------------------------------------------------------------------------*/
" 用空格代替制表符
set expandtab
" 统一缩进为4
set softtabstop=4
set tabstop=8
"set smarttab
"指定文件类型,这样.mak和Makefile文件将都会使用真实tab
autocmd FileType Makefile set noexpandtab
set wrap
set linebreak
"set virtualedit=all

set foldcolumn=1 

nmap <F10> :set foldmethod=syntax<CR>
"autocmd BufReadPost *.[ch] set foldmethod=syntax
"autocmd BufReadPost *.py set foldmethod=indent
"---------------cscope 相关配置----------------------
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
	    cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
	    cs add $CSCOPE_DB
	endif
	set csverb
endif

"s: Find this C symbol
"g: Find this definition
"d: Find functions called by this function
"c: Find functions calling this function
"t: Find this text string
"e: Find this egrep pattern
"f: Find this file
"i: Find files #including this file
"a: Find places where this symbol is assigned a value

nmap <F6>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <F6>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <F6>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <F6>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <F6>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <F6>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <F6>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <F6>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <F6>a :cs find a <C-R>=expand("<cword>")<CR><CR>
                                                                    
" split horizontally, with search result displayed in
" the new window.
                                                                    
nmap <F7>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <F5>  :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <F7>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <F7>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <F7>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <F7>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <F7>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <F7>d :scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <F7>a :scs find a <C-R>=expand("<cword>")<CR><CR>
                                                                    
                                                                    
nmap <F8>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <F8>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <F8>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <F8>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <F8>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <F8>f :vert scs find f <C-R>=expand("<cword>")<CR><CR>
nmap <F8>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <F8>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <F8>a :vert scs find a <C-R>=expand("<cword>")<CR><CR>

nmap <F4> :close<CR>
nmap <Up> gk
nmap <Down> gj
"自动补全括号和花括号
inoremap ( ()<Left>  
inoremap [ []<Left>
inoremap { {}<Esc>O
nmap <Tab>  <C-W>w
nmap <F9> :nohlsearch<Enter>
nmap <F3> :Bclose<CR>
"autocmd WinEnter * normal '0 
"autocmd WinLeave * normal zm
"autocmd BufReadPost *.[ch] normal '0
"set cursorline
"highlight CursorLine   cterm=NONE ctermbg=black ctermfg=green
colorscheme space-vim-dark
"set background=dark
"colorscheme solarized
set cursorline
"退出时自动保存视图
autocmd QuitPre *.[ch]  NERDTreeClose|TagbarClose
autocmd QuitPre *.[ch]  mks! .last_session.vim
