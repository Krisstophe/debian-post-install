" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
    set nobackup		" do not keep a backup file, use versions instead
else
    set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif

    augroup END

else


endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif



" ===== VIM PERSONAL SETTING . UPDATED 20140425 . ZHAZHA =====


" ===== Initial =====

filetype plugin on  "enable plugins
filetype indent on  "enable indent

syntax enable
syntax on
set background=dark
colorscheme solarized
" colorscheme elflord "颜色配置方案 - ron为深色背景，desert/elda均不错
call togglebg#map("<F5>")
" hi normal ctermbg=11

set mouse=nv        "原mouse=a，vim接管鼠标，但ssh时本机需右键copy
" nv可让vim在插入状态放弃控制鼠标
" 于是本地机器可右键复制vim文本(即屏幕文本)
set t_Co=256        "number of colors
set ru              "ruler 显示标尺(右下角)
set nu              "number 显示行号
set ic              "ignorecase　忽略大小写
set is              "incsearch 输入即搜索
set hls             "hlsearch 高亮搜索结果
set nocp            "nocompatible 与vi不兼容模式
set ai              "autoindent 自动缩进
set so=5            "scrolloff 光标上下两侧至少保留的屏幕行数
set ch=2            "cmdheight 命令行高度
" set laststatus=2    " 状态栏
set ww=h,l          "whichwrap 在Normal/Visual模式下按下h,l
" 可以在行间跳转，而不是到了行头/尾即停下
set lbr             "linebreak 一行较长换行时尽量不在英文单词中间断开
set nocin           "nocindent
if (&modifiable)
    set fenc=utf-8      "fileencoding 让vim可以自动识别各种常见编码
    " -M 禁止修改时 set fenc 会报错
endif
set fencs=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" fileencodings
set nobackup        "不自动备份文件

" set shell=/bin/bash\ -i    "方便使用shell定义的alias, :!运行或映射在脚本中

" 错误提示
" set noerrorbells   "关闭错误提示
" set novisualbell   "关闭使用可视代替呼叫
" set t_vb=""        "置空错误提示

" 默认使用系统剪贴板
set clipboard=unnamed       "使用系统剪贴板, or simply C+Ins/S-Ins
	"设置copy&paste命令，用于与其他程序交换，使用"+或"*寄存器
nmap ,v "+p
vmap ,c "+y
nmap ,c "+y

" ===== 显示风格 =====

" 突出光标所在行/列
set cursorline
set cursorcolumn
hi CursorColumn cterm=None term=reverse ctermbg=0 guibg=Grey40:w
hi CursorLine cterm=None term=reverse ctermbg=0 guibg=Grey40:w
" Tab颜色
hi TabLineSel ctermfg=243

" 行尾空格
highlight whitespace_HOF ctermbg=0
highlight whitespace_EOF ctermbg=238                  
let g:mymatch001 = matchadd("whitespace_HOF", "^\\s\\+")
let g:mymatch002 = matchadd("whitespace_EOF", "\\s\\+$")
" 若使用match命令，RE有所不同
" match whitespace_all /\(^\s\+\)\|\(\s\+$\)/

" TAB显示为>- 行尾多余空白显示为-
set list
" set listchars=tab:>-,trail:-
set listchars=tab:>\ ,trail:-,
" set listchars=tab:>\ ,trail:-,precedes:<,extends:>,nbsp:%

" 设置是否显示IndentLines(IndentLines插件) (?)
let g:indentLine_enabled = 0
" map <leader>il :IndentLinesToggle<CR>
" let g:indentLine_fileType = ['c', 'cpp', 'python', 'java', 'shell', 'vim']
" let g:indentLine_char = '|'  " 使用unicode字符有对齐问题，用ANSI字符
" let g:indentLine_color_term = 240

" set keymodel=startsel,stopsel "使用shift+方向键 选择文本

" ===== Default TAB Setting =====

" 代码折叠－以缩进为依据
set foldmethod=indent
" 折叠所有 =n 展开n层 n很大时全部展开
set foldlevel=99
" set foldcolumn=1

" ===== Default TAB Setting =====

set et              "expandtab 输入tab时用空格代替，新的文件读进来以后可以:retab以转换tab
set sta             "smarttab 智能tab
set sw=4            "shiftwidth 自动缩进
set ts=4            "tabstop tab宽度

" ===== bison & flex =====

" .y文件自动识别为yacc, .lex为lex，但.flex不在其中
au BufNewFile,BufRead *.flex    setf lex

" 映射快捷键，生成.c文件
" autocmd BufRead *.flex nmap <F12> :!flex -d -o %:t.c %<CR>

" ===== C & C++ =====

" hilight function name 匹配函数名，定义颜色
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
hi cfunctions ctermfg=117

" autocmd FileType c,cpp,make setlocal shiftwidth=8 tabstop=8 noexpandtab

" cindent c/c++风格自动缩进
" [粘帖时:set paste关闭自动缩进，之后:set nopaste再打开缩进]
autocmd FileType c,cpp set cin
autocmd FileType c,cpp nmap <F12> :!rm -f %:r.exe; gcc % -o %:r.exe; ./%:r.exe<CR>
autocmd FileType c,cpp nmap <S-F12> :!rm -f %:r.exe; g++ % -o %:r.exe; ./%:r.exe<CR>


" ===== Build taglist & cscope Indexing File =====

" 0. cygwin下cscope初始化命令，为处理目录中的空格，加上双引号
"    find . -iregex '^.*\.\(h\|cpp\|c\|java\)$' -printf '"%p"\n' > cscope.files
"    cscope -bq
" 1. 注：不同命令调用方式需不同的escape，如
"    map中 :!find ... 则"\."不需要再次escape 但"|"需要escape
"    另注意%的escape，%在vim中有特殊含义
"    execute调用时 "\."需escape成"\\." 但"|"不需要escape

" bug: 未指定regextype时 如下写法cc文件不能匹配
"    \"find -L . -iregex '.*\\.(h\\|cpp\\|c\\|cc\\y\\|java)' -printf '\"\\%p\"\\n' > cscope.files; ".
"    \"find -L . -regextype egrep -iregex '.*\\.(h|cpp|c|cc|java)' -printf '\"\\%p\"\\n' > cscope.files; ".

fun!  Do_make_ctags_n_cscope()
    let l:zzcmd = "ctags -R --c-kinds=+p --fields=+iS; ".
                \"find -L . -regextype egrep -iregex '.*\\.(h|cpp|c|cc|java|aps|lex|flex)' -printf '\\%p\\n' > cscope.files; ".
                \"cscope -bq; ".
                \"echo [ctags and cscope] done. ; "
    execute "!" . l:zzcmd
    set nocsverb
    cs kill cscope.out
    cs add cscope.out
    set csverb
endf
autocmd FileType c,cpp,yacc,lex map <C-F12> :call Do_make_ctags_n_cscope() <CR>

" ===== Taglist =====

filetype on
let Tlist_Show_Menu = 1
" Tlist用F3开关(=TlistToggle)，默认C-w-w或C-w-<方向键>切换
" TlistUpdate可以更新tags
map <F3> :silent! Tlist<CR>         "按下F3就可以呼出Taglist
let Tlist_Ctags_Cmd='ctags'         "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=0        "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=1           "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
let Tlist_File_Fold_Auto_Close=1    "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1         "当taglist是最后一个分割窗口时，自动退出vim
let Tlist_Process_File_Always=0     "是否一直处理tags.1:处理;0:不处理
" let Tlist_Inc_Winwidth=


" ===== cscope =====

fun! Do_cscope()
    if has("cscope")
        set csprg=/usr/bin/cscope
        set cst     "cscopetag 同时使用cscope和tags
        set csto=0  "优先搜索 0:cscope 1:tags
        set nocsverb
        " add any database in current directory
        if filereadable("cscope.out")
            cs add cscope.out
        endif
        cs add ~/.vim/mytags/sys.cs
        cs add ~/.vim/mytags/vc.cs
        cs add ~/.vim/mytags/winsdk.cs
        " cs add ~/.vim/mytags/w32api.cs
        set csverb
        set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif

    "scs开新窗口 vert scs新垂直窗口
    nmap <C-\>\ :cstag <C-R>=expand("<cword>")<CR><CR>            "cstag,def
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>        "call
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>        "symbol
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    "tags, 暂不需要c++stl
    "set tags+=~/.vim/mytags/stl3.3.tags
    set tags+=~/.vim/mytags/sys.tags
    set tags+=~/.vim/mytags/vc.tags
    set path+=./include,./includes,/usr/vcinclude,/usr/vcinclude/sys,/usr/winsdkinclude
endf
autocmd FileType c,cpp,yacc,lex call Do_cscope()

" ===== Java =====

" autocmd FileType html,php,vim,javascript setlocal shiftwidth=2 tabstop=2 expandtab
au BufNewFile,BufRead *.scala setf scala

" autocmd FileType java,scala setlocal shiftwidth=4 tabstop=4 expandtab
" set softtabstop=4 shiftwidth=4 expandtab "Java etc.

autocmd BufRead *.java nmap <F12> :!jc %<CR>
autocmd BufRead *.java nmap <S-F12> :!j %:r<CR>


" ===== Python =====

" autocmd FileType python setlocal shiftwidth=4 tabstop=4 expandtab

" pydiction python代码补全，使用Tab
" 因打开非python filetype的代码也会覆盖tab功能，所以修改python_pydiction.vim
" 在两个inoremap命令前加上autocmd FileType python 即可
autocmd FileType python let g:pydiction_location = '~/.vim/plugin/pydiction/complete-dict'
" default menu height is 15
autocmd FileType python let g:pydiction_menu_height = 20

" pythoncomplete python代码补全，C+x/C+o打开，C+n/C+p翻页
autocmd FileType python set omnifunc=pythoncomplete#Complete

" 编译、运行环境设置
autocmd FileType python nmap <F12> :!python %<CR>
autocmd FileType python nmap <S-F12> :!python3 %<CR>

" 某处copy来，尚未研究
" autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
" autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
" autocmd BufRead *.py nmap <F11> :make<CR>
" autocmd BufRead *.py copen         "如果是py文件，则同时打开编译信息窗口

" ===== map =====

" 关闭Ex模式-- gq? -- 退出时q!很容易按成Q
map Q gq

" 调用notepad++进行编辑
nmap <C-n><C-n> :!/c/Program\ Files/Notepad++/notepad++.exe %<CR>

" 调用中文帮助文档 - 但调用后必须关闭pdf才能退回
nmap <C-n><C-h> :!/c/Program\ Files/SumatraPDF/SumatraPDF.exe "E:\Documents\IT&硬件\Shell\vim\vim74cdoc_reference-1.9.0.pdf &"<CR>

" 设置C-j/C-k使当前行下移/上移一行
nmap <C-j> :.m.+1<CR>
nmap <C-k> :.m.-2<CR>

" 设置python文档的注释字串，使用gc/gcc注释，gcu取消(commentary插件)
autocmd FileType python,shell set commentstring=#\ %s
autocmd FileType c,cpp,java set commentstring=//\ %s
" nmp <M-m><M-m> gcc<CR>

" ===== Test Area =====

" 切换tabstop = 2/4/8
fun! Do_tabshift()
    if &tabstop == 4
        setlocal shiftwidth=8 tabstop=8 noexpandtab
    elseif &tabstop == 8
        setlocal shiftwidth=2 tabstop=2 noexpandtab
    else
        setlocal shiftwidth=4 tabstop=4 noexpandtab
    endif
endf
nmap ttt :call Do_tabshift() <CR>

" 修改.vimrc配置后即时生效，编译测试效果
autocmd! bufwritepost .vimrc source %

" 标签页
nmap <C-H><C-T> :browse tabnew<CR>
nmap <C-H><C-W> :tabclose<CR>
nmap <C-H><C-F> :tabprevious<CR>
nmap <C-H><C-G> :tabnext<CR>
" buffers
nmap <C-H><C-V> :bprevious<CR>
nmap <C-H><C-B> :bnext<CR>

" tag & search 29.6
map <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" NerdTree
" open NerdTree if no files specified
autocmd vimenter * if !argc() | NERDTree | endif
" Close NerdTree is only NerdTree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <F2> :NERDTreeToggle<CR>

"这句会影响之前的hi cfunctions，无法高亮,原因不明
"execute pathogen#infect()
