" Dependencies
"   use 'junegunn/vim-plug/' to manage plugin
"   'confierrot/GUN-global_vim_support' -> GNU global(http://tamacom.com/global/global-6.6.1.tar.gz)
"   'Tagbar' -> ctags
"   'Yggdroot/LeaderF' -> python
" 判断操纵系统类型
let g:iswindows = 0
let g:islinux = 0
let g:plugPATH = 0
let g:usecscope = 0  "use cscope or GNU global
if(has("win32") || has("win64"))
    let g:iswindows = 1
else
    let g:islinux = 1

endif

if(g:iswindows)    
    set guioptions-=T   "隐藏工具栏
    set guioptions-=m   "菜单栏
    set guioptions-=r   "右侧滚动条
    set guioptions-=L   "左侧滚动条
    set guifont=Consolas:h12 
    let g:plugPATH = "~/vimfiles/plugged"
else
    let g:plugPATH = '~/.vim/plugged'
endif

"=========================使用vim-plug坐插件管理器==========================================
"Unix
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"Windows
"   git clone  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   复制到plug.vim到家目录下的vimfiles/autoload
"用法
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just ::luginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ
call plug#begin(plugPATH)

"目录树插件
"按F1开/关左侧目录树窗口
Plug  'scrooloose/nerdtree'
let NERDTreeWinPos='left'
let NERDTreeWinSize=25
nmap <F1> :NERDTreeToggle<CR>

"皮肤
Plug 'liuchengxu/space-vim-dark'
"Plug 'altercation/vim-colors-solarized'

"显示函数和变量列表插件,需要系统能找到ctags可执行程序
"按F2开/关右侧tagbar窗口
Plug 'majutsushi/tagbar'
"let g:tagbar_ctags_bin='ctags'            "也可以自定ctags程序的路径
let g:tagbar_width=30                    "窗口宽度的设置
map <F2> :Tagbar<CR>

" tags设置
if(g:usecscope == 0)
"GNU global插件支持，安装该软件并在目录下执行gtags 生成tags文件   
":Gtags [-rf] pattern
Plug 'confierrot/GUN-global_vim_support'
    let g:Gtags_Auto_Update = 1
    let g:Gtags_No_Auto_Jump = 1
    let g:Gtags_Close_When_Single = 1
    nmap <F5> :GtagsCursor<CR>
    nmap <F8> :Gozilla<CR>
    if findfile("GTAGS") == "GTAGS"
        autocmd VimEnter  *  GtagsCscope              
    endif
else
     if has("cscope")
         "设定可以使用 quickfix 窗口来查看 cscope 结果 
         set cscopequickfix=s-,c-,d-,i-,t-,e-
         "使支持用 Ctrl+] 和 Ctrl+t 快捷键在代码间跳转
         set cscopetag
         "如果你想反向搜索顺序设置为1
         set csto=0
         if filereadable("cscope.out") 
             cs add cscope.out
         endif
     endif
endif
"开关quickfix窗口
nmap <F6> :copen<CR>  
nmap <F7> :cclose<CR> 
"s: Find this C symbol
"g: Find this definition
"c: Find functions calling this function
"t: Find this text string
"e: Find this egrep pattern
"f: Find this file
"i: Find files #including this file
nmap <Leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <Leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
                                                                    
" split horizontally, with search result displayed in
" the new window.
                                                                    
nmap <Leader><Leader>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <Leader><Leader>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
                                                                    
nmap <Leader>S :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>G :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>C :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>T :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>E :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>F :vert scs find f <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>I :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>

"自动补全插件
"按tab键补全
Plug 'vim-scripts/SuperTab'
let g:SuperTabRetainCompletionType=2

"高亮标签
" mx           Toggle mark 'x' and display it in the leftmost column
" dmx          Remove mark 'x' where x is a-zA-
" m<Space>     : Delete all marks
" m,           : Place the next available mark
" ]`           : Jump to next mark
" [`           : Jump to prev mark
Plug 'kshenoy/vim-signature' 

"状态栏插件
if(g:islinux)
    "+/_  在标签之间移动     <leader>n 跳到第n个标签
    Plug 'bling/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme='fairyfloss'

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
    let g:airline_exclude_filename = []  
    let g:Powerline_symbols='fancy'  
    let Powerline_symbols='fancy'  
    let g:bufferline_echo=0  
    set t_Co=256  

    let g:airline#extensions#tabline#buffer_idx_mode = 1
    nmap <leader>1 <Plug>AirlineSelectTab1
    nmap <leader>2 <Plug>AirlineSelectTab2
    nmap <leader>3 <Plug>AirlineSelectTab3
    nmap <leader>4 <Plug>AirlineSelectTab4
    nmap <leader>5 <Plug>AirlineSelectTab5
    nmap <leader>6 <Plug>AirlineSelectTab6
    nmap <leader>7 <Plug>AirlineSelectTab7
    nmap <leader>8 <Plug>AirlineSelectTab8
    nmap <leader>9 <Plug>AirlineSelectTab9

    nmap _ <Plug>AirlineSelectPrevTab
    nmap + <Plug>AirlineSelectNextTab

else
    "windows下使用该插件显示buffer内容
    "—/ +  切换buff中文件
    "  :bn  切换到标号为n的文件
    Plug 'fholgado/minibufexpl.vim'
    nmap _ :bprevious<CR>
    nmap + :bnext<CR>
endif


"bclose
"按F3关闭当前窗口
Plug 'rbgrouleff/bclose.vim'
nmap <F3> :Bclose<CR>
nmap <F4> :close<CR>
"同时选中编辑器同一文件内相同字符串
"  ctrl-n选中下一个
Plug 'terryma/vim-multiple-cursors'

" 多个关键词高亮
" Highlight with \k
" Navigate with n and N
" Clear highlights with \K
Plug  'lfv89/vim-interestingwords' 
 
"搜索神器 需要python支持
":LeaderfFile [dir] (<leader>f)	search files
":LeaderfTag	navigate tags using the tags file
":LeaderfColorscheme	switch between colorschemes
"<C-C>	quit from LeaderF
"<C-R>	switch between fuzzy search mode and regex mode
"<C-F>	switch between full path search mode and name only search mode
"<ESC>	switch to normal mode
"<C-J>(<Down>)	move the cursor downward in the result window
"<C-K>(<Up>)	move the cursor upward in the result window
"<C-S>	select multiple files
if(iswindows)
    Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
else
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
endif

nmap  tk  :LeaderfFile<CR> 
nmap  tl  :LeaderfTag<CR>


"代码缩进提醒
" 按<F12>切换提醒
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '|'
nmap <F12> :IndentLinesToggle<CR>


call plug#end()

"================================插件管理器到此结束====================================

"显示相关
set nu        "显示行号
set backspace=indent,eol,start
set showcmd   "显示命令
set ruler     "左下角显示信息
autocmd FileType text setlocal textwidth=78
"set textwidth=72
set wrap
set linebreak
"set virtualedit=all
syntax on
set showmatch    "括号匹配显示
set cursorline   "高亮当前行
"source $VIMRUNTIME/ftplugin/man.vim

nmap <Up> gk
nmap <Down> gj

"备份相关
set writebackup
set backupext=.bak
set autoread        "文件在外部被修改时自动读取

"编码设置
set fileformats=unix,dos,mac
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码

"搜索相关
set ignorecase
set incsearch       " 实时显示搜索结果
set hlsearch
nmap <F11> :nohlsearch<Enter>
set nowrapscan      " 禁止循环搜索

"缩进相关
filetype plugin indent on    " required
set expandtab       "tab转化为空格
set softtabstop=4   "使用vim编解插入tab时为4个空格长度
set tabstop=8       "保留tab原本长度
set shiftwidth=4    " shift+</>缩进长度为4
set smartindent
set autoindent       
"指定文件类型,这样.mak和Makefile文件将都会使用真实tab
autocmd FileType Makefile set noexpandtab



"折叠相关
set foldcolumn=1     "显示折叠标记
nmap <F10> :set foldmethod=syntax<CR> 
nmap <F9>  :set foldmethod=marker<CR>


"自动补全括号和花括号
"inoremap ( ()<Left>  
"inoremap [ []<Left>
"inoremap { {
}<Esc>O
nmap <Tab>  <C-W>

if(iswindows)
    colorscheme desert
else
    colorscheme space-vim-dark
endif

"退出时自动保存视图
autocmd QuitPre *.[ch]  NERDTreeClose|TagbarClose|MBECloseAll
autocmd QuitPre *.[ch]  mks! .last_session.vim

iabbrev #s /*---------------------------------------------------------------------------/
iabbrev #e /---------------------------------------------------------------------------*/
iabbrev m()  int main()
{return 0;<Esc>O<Esc>kk


