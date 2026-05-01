set t_Co=256
let mapleader=" "
set termguicolors
colo 256_noir
autocmd FileType cpp colorscheme distill
" autocmd FileType cpp colorscheme codedark
" highlight Comment ctermfg=green
" hi Comment guifg=#D47962 guibg=NONE gui=NONE cterm=NONE
hi VertSplit ctermbg=black ctermfg=Red guibg=#000000 guifg=#FF00FF

filetype on
filetype indent on
filetype plugin indent on
set encoding=utf-8
let &t_ut=''

set ls=2

syntax on
set nu
set wrap
set showcmd
set wildmenu
set ignorecase
set smartcase
set hlsearch
set incsearch
set scrolloff=8
set mouse=
set path+=**
set ruler
set backspace=indent,eol,start
set autochdir
set smartindent

" tab
set expandtab
set ts=4
set shiftwidth=4
set softtabstop=4
autocmd FileType c,cpp set ts=8 shiftwidth=8 softtabstop=8

" Keymap {{{
  nmap <leader>w :w<CR>
  nmap <leader>q :q<CR>
  noremap n nzz
  noremap N Nzz
  noremap <leader><CR> :nohlsearch<CR>
  map zl :set splitright<CR>:vsplit<CR>
  map zh :set nosplitright<CR>:vsplit<CR>
  map zk :set nosplitbelow<CR>:split<CR>
  map zj :set splitbelow<CR>:split<CR>

  map <space>l <C-W>l
  map <space>k <C-W>k
  map <space>h <C-W>h
  map <space>j <C-W>j

  map <up> :res +5<CR>
  map <down> :res -5<CR>
  map <left> :vertical resize-5<CR>
  map <right> :vertical resize+5<CR>

  map tn :tabe<CR>
  nmap <tab> gt
  nmap <s-tab> gT

  noremap <leader>v <c-v>
  noremap L $
  noremap H ^
  noremap j gj
  noremap k gk
  noremap K 5gk
  noremap J 5gj
  " auto complete ')]}"
  inoremap ( ()<esc>i
  inoremap ) <c-r>=ClosePair(')')<CR>
  inoremap { {}<esc>i
  inoremap } <c-r>=ClosePair('}')<CR>
  inoremap [ []<esc>i
  inoremap ] <c-r>=ClosePair(']')<CR>
  ""inoremap " ""<esc>i
  ""inoremap ' ''<esc>i
  function! ClosePair(char)
      if getline('.')[col('.') - 1] == a:char
          return "\<Right>"
      else
          return a:char
      endif
  endfunction

" }}}

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
vnoremap D :m '>+1<CR>gv=gv
vnoremap U :m '<-2<CR>gv=gv
autocmd FileType c,java vmap C :normal I// <CR>
nmap to :browse oldfiles<CR>
" run java
autocmd Filetype java map <space>rc :!java %<CR>
" run python
autocmd Filetype python map <space>rc :!python %<CR>
" run c
autocmd FileType c map <space>rc :!gcc % -o %< && ./%<<CR>
" run c++
autocmd FileType cpp map <space>rc :!g++ % -o %< && ./%<<CR>
" run go
autocmd FileType go map <space>rc :w<CR>:!go run %<CR>

" file tree
nmap tt :Vexplore<CR>
" terminal


let g:netrw_banner=0 " 禁用没用的横幅
let g:netrw_winsize=20 " 初始窗口大小为25%
let g:netrw_liststyle=3 " 使用树状模式
let g:netrw_altv=1 " 分割窗口时默认在右边
let g:netrw_browse_split=4 " enter时在上一个窗口打开

" auto complete
" === === === === === === coc === === === === === === ===
" === === === === === === coc === === === === === === ===
" === === === === === === coc === === === === === === ===
let g:coc_global_extensions = ['coc-json','coc-vimlsp','coc-python','coc-marketplace','coc-tsserver','coc-snippets','coc-java','coc-clangd','coc-go']
set updatetime=100
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <C-E> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"
" Use <space>w to show documentation in preview window
nnoremap <silent> gh :call ShowDocumentation()<CR>
function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" Symbol renaming
nmap <space>rn <Plug>(coc-rename)

" format
nmap <space>fm :call CocActionAsync('format')<CR>

inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ CheckBackspace() ? "\<TAB>" :
            \ coc#refresh()

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" coclist
nmap <leader>ol :CocList outline<CR>

""""""""""""""""
""" VIM PLUG """
""""""""""""""""
call plug#begin('~/.vim/plugged')

" auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'easymotion/vim-easymotion'  " <space>ss<char> to motion on speed!
Plug 'gcmt/wildfire.vim' " <Enter> to select a code block
Plug 'machakann/vim-highlightedyank'
" Bookmarks
Plug 'kshenoy/vim-signature'
Plug 'junegunn/vim-peekaboo' " a nice plugin for pasting


call plug#end()

" Easymotion
let g:EasyMotion_smartcase = 1
map <space>s <Plug>(easymotion-prefix)
map s <space>ss

" addition
set signcolumn=yes
