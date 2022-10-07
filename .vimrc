" =========================================================================
"
" .vimrc - Vim configuration file.
"
" Copyright (c) 2022 Wang Weiye. All Rights Reserved.
" =========================================================================

" GENERAL SETTINGS:
" To use VIM settings, out of VI compatible mode.
set nocompatible
" Enable file type detection.
filetype plugin indent on
" Syntax highlighting.
syntax on

"插件安装 添加Plug 并执行vim命令PlugInstall    server: https://vimawesome.com/
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/c.vim'
Plug 'rust-lang/rust.vim'
Plug 'vim-scripts/vcscommand.vim'
Plug 'skywind3000/vim-auto-popmenu'
Plug 'skywind3000/vim-dict'
call plug#end()

" Setting colorscheme
" color evening
" colorscheme
" Config for vim73
if v:version >= 703
set   autoindent "自动缩进
set   autoread   "文件自动加载
set   autowrite  "缓冲区自动保存
set   background=dark "告诉vim背景颜色 不会更改背景颜色
set   backspace=indent,eol,start "insert模式下  退格删除
set   nobackup   "取消文件备份
"set   cindent    "c语言风格缩进
"set   cinoptions=:0
set   smartindent "智能缩进
set   cursorline "配置vim下划线
set   encoding=utf-8
set   tabstop=4
set   noexpandtab
"set   expandtab "使用空格缩进
set   fileencodings=utf-8,gb2312,gbk,gb18030,chinese
set   fileformat=unix
set   foldenable "折叠功能
set   foldmethod=marker "使用标志{}折叠 zf%创建折叠  za 打开/关闭折叠
set   helpheight=10
set   helplang=cn
set   hidden
set   history=100
set   hlsearch
set   ignorecase
set   incsearch
set   laststatus=2
set   mouse=v
set   number
set   pumheight=10
set   ruler
set   scrolloff=5
set   shiftwidth=4 "自动缩进长度
set   showcmd
set   smartcase    "大小写敏感查找
set   termencoding=utf-8
set   textwidth=280 "文本宽度
set   colorcolumn=+1 "换行提示线
set   whichwrap=h,l
set   wildignore=*.bak,*.o,*.e,*~
set   wildmenu
set   wildmode=list:longest,full
set   wrap  "自动换行
set   vb t_vb= "去掉提示音

"let   g:apc_enable_ft = {'text':1, 'markdown':1, 'php':1} "设定vim内建补全需要生效的文件类型
let   b:apc_enable = 1 "对全部文件生效
let   g:apc_cr_confirm = 1  "回车选定
set   cpt=.,k,w,b "设定从字典文件以及当前打开的文件里收集补全单词，详情看 ':help cpt'
set   completeopt=menu,menuone,noselect "不要自动选中第一个选项
set   shortmess+=c "禁止在下方显示一些啰嗦的提示
endif

" AUTO COMMANDS:
" auto expand tab to blanks
" autocmd FileType c,cpp set expandtab
" Restore the last quit position when open file.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal g'\"" |
    \ endif

" SHORTCUT SETTINGS:
" Set mapleader
let mapleader=";" "设置快捷键触发<leader>为';'
" Space to command mode.
nnoremap <space> :
vnoremap <space> :

"窗口间移动光标
nnoremap <C-left> <C-W>h
nnoremap <C-down> <C-W>j
nnoremap <C-up> <C-W>k
nnoremap <C-right> <C-W>l
inoremap <C-left> <Esc><C-W>h
inoremap <C-down> <Esc><C-W>j
inoremap <C-right> <Esc><C-W>k
inoremap <C-l> <Esc><C-W>l

" PLUGIN SETTINGS:
" taglist.vim
let g:Tlist_Auto_Update=1
let g:Tlist_Process_File_Always=1
let g:Tlist_Exit_OnlyWindow=1
let g:Tlist_Show_One_File=1
let g:Tlist_WinWidth=27 "索引栏宽度
let g:Tlist_Enable_Fold_Column=0
let g:Tlist_Auto_Highlight_Tag=1
let g:Tlist_Auto_Open=1

" NERDTree.vim
let g:NERDTreeWinPos="right"
let g:NERDTreeWinSize=27 "目录栏宽度
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeQuitOnOpen=0 "文件打开后自动关闭
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Close the tab if NERDTree or (NERDTree + taglist) is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if winnr('$') == 2 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | quit | endif

" cscope.vim
if has("cscope")
    set csto=1
    set cst
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
endif

" plugin shortcuts
function! RunShell(Msg, Shell)
	echo a:Msg . '...'
	call system(a:Shell)
	echon 'done'
endfunction

nmap  <F2> :TlistToggle<cr>
nmap  <F3> :set nu<cr>
nmap  <F4> :set nonu<cr>
nmap  <F5> :NERDTreeToggle<cr>
nmap  <F6> :vimgrep /<C-R>=expand("<cword>")<cr>/ **/*.c **/*.h<cr><C-o>:cw<cr>
nmap  <F7> :terminal<cr>
nmap  <F9> :call RunShell("Generate tags", "ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .")<cr>
nmap <F12> :call RunShell("Generate cscope", "cscope -Rb")<cr>:cs add cscope.out<cr>

nmap <leader>sa :cs add cscope.out<cr>
nmap <leader>ss :cs find s <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sc :cs find c <C-R>=expand("<cword>")<cr><cr>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<cr><cr>
nmap <leader>se :cs find e <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>si :cs find i <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>sd :cs find d <C-R>=expand("<cword>")<cr><cr>
nmap <leader>zz <C-w>o
nmap <leader>gs :GetScripts<cr>

"This tip provides the same autoloading functionality for Cscope
function! LoadCscope()
	let db = findfile("cscope.out", ".;")
	if (!empty(db))
		let path = strpart(db, 0, match(db, "/cscope.out$"))
		set nocscopeverbose " suppress 'duplicate connection' error
		exe "cs add " . db . " " . path
		set cscopeverbose
	endif
endfunction
au BufEnter /* call LoadCscope()

"noremap <Leader>ga    :VCSAdd<CR>
"noremap <Leader>gn    :VCSAnnotate<CR>
"noremap <Leader>gN    :VCSAnnotate!<CR>
"noremap <Leader>gc    :VCSCommit<CR>
"noremap <Leader>gD    :VCSDelete<CR>
noremap <Leader>gd    :VCSDiff<CR>
"noremap <Leader>gg    :VCSGotoOriginal<CR>
"noremap <Leader>gG    :VCSGotoOriginal!<CR>
"noremap <Leader>gi    :VCSInfo<CR>
noremap <Leader>gl    :VCSLog<CR>
"noremap <Leader>gL    :VCSLock<CR>
"noremap <Leader>gr    :VCSReview<CR>
"noremap <Leader>gs    :VCSStatus<CR>
"noremap <Leader>gu    :VCSUpdate<CR>
"noremap <Leader>gU    :VCSUnlock<CR>

noremap <Leader>git    :VCSVimDiff<CR><C-H>
noremap <Leader>gv    :VCSVimDiff
noremap <Leader>gb    :VCSBlame<CR><C-H>
"noremap <Leader>gr    :VCSRevert<CR>

let VCSCommandEnableBufferSetup=0            "slow if set 1

" %s/\r//g  去掉vim中的 ^M
