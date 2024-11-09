 "  __  __        __     _____ __  __ ____   ____
 " |  \/  |_   _  \ \   / /_ _|  \/  |  _ \ / ___|
 " | |\/| | | | |  \ \ / / | || |\/| | |_) | |
 " | |  | | |_| |   \ V /  | || |  | |  _ <| |___
 " |_|  |_|\__, |    \_/  |___|_|  |_|_| \_\\____|
 "         |___/
 "
 " easymotion: s<char> can be done!
 let mapleader=" "
 set background=dark
 " set guifont=JetBrainsMono\ Nerd\ Font\ Mono:h14
 " set guifont=FiraMono\ Nerd\ Font:h14
 " set guifont=BPmono:h14
 " set guifont=Monaco:h14 anti
 " set guifont=Microsoft\ YaHei\ Mono:h14
 set guioptions+=d
 winpos 100 100
 set lines=45
 set columns=80
 let guifontpp_size_increment=1
 let guifontpp_smaller_font_map="<S-F10>"
 let guifontpp_larger_font_map="<F10>"
 let guifontpp_original_font_map="<C-F10>"

 set langmenu=en_US.UTF-8
 language en

 syntax on
 set nu
 " set wrap
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
 set termguicolors
 " set noerrorbells visualbell t_vb= 禁用错误铃声提醒，打开视觉错误提醒
 set belloff=all
 " colorscheme less
 " colorscheme paramount
 " let my_dark_colorschemes = ['less', 'paramount', 'molokai', 'strange']
 " execute 'colorscheme' my_dark_colorschemes[rand() % (len(my_dark_colorschemes) - 1 ) ]
" colorscheme slate
 " highlight Comment ctermfg=Green
 " colorscheme snazzy
 colorscheme 256_noir
 " hi Normal ctermfg=252 ctermbg=none
 " set background&
 hi Comment guifg=#538e1f guibg=NONE gui=NONE cterm=NONE


 " =========== tokyonight
 " set termguicolors

 " let g:tokyonight_style = 'night' " available: night, storm
 " let g:tokyonight_enable_italic = 1
 " let g:airline_theme = "tokyonight"
 " " let g:tokyonight_transparent_background = 1
 " colorscheme tokyonight


 " tab
 set expandtab
 set ts=4
 set shiftwidth=4
 set softtabstop=4

 filetype on
 filetype indent on
 filetype plugin on
 filetype plugin indent on
 set encoding=utf-8
 "autocmd FileType java silent :set encoding=cp936 fileencoding=cp936
 let &t_SI = "\<Esc>[1 q"
 let &t_EI = "\<Esc>[1 q"
 let &t_ut=''

 set backspace=indent,eol,start

 " set laststatus=2
 set autochdir
 set smartindent

 noremap n nzz
 noremap N Nzz
 noremap <space><CR> :nohlsearch<CR>

 " use D/U to move some lines in visual mode.
 vnoremap D :m '>+1<CR>gv=gv
 vnoremap U :m '<-2<CR>gv=gv
 " easy to comment
 autocmd FileType c,java vmap C :normal I// <CR>

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

 nmap to :browse oldfiles<CR>

 " map sp :set spell<CR>
 " map sb :set spell!<CR>


 " Uncomment the following to have Vim jump to the last position when
 " " reopening a file
 au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

 noremap <C-D> Hzz
 noremap <C-F> Lzz

 noremap <F1> <nop>
 noremap s <nop>
 noremap <leader>w :w<CR>
 noremap <leader>q :q<CR>
 noremap <leader>v <c-v>
 noremap L $
 noremap H ^
 noremap j gj
 noremap k gk
 noremap K 5gk
 noremap J 5gj
 " Press space twice to jump to the next '<++>' and edit it
 " noremap <space><space> <Esc>/<++><CR>:nohlsearch<CR>"_c4l


 "change default terminal to powershell
 " set shell=powershell shellcmdflag=-c shellquote=\" shellxquote="
 " let g:terminal_height=15


 call plug#begin('d:\Software\Vim\vim90\plugged')
 " give you a sense of rhythm when typing code
 " Plug 'skywind3000/vim-keysound'
 
 " Plug 'dracula/vim', { 'as': 'dracula' }

 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'

 " === complete code
 Plug 'neoclide/coc.nvim', {'branch': 'release'}

 " === motion
 Plug 'easymotion/vim-easymotion'  " <space>ss<char> to motion on speed!

 " Plug 'millermedeiros/vim-statline'
 " Plug 'preservim/nerdtree'

 " Other visual enhancement
 Plug 'nathanaelkane/vim-indent-guides'
 " Plug 'itchyny/vim-cursorword'
 Plug 'machakann/vim-highlightedyank'

 " Python
 " Plug 'vim-scripts/indentpython.vim'

 Plug 'tpope/vim-surround' " type ysks' to wrap the word with '' or type cs'`to change 'word' to `word` or use S to add surroundings in visual mode
 Plug 'junegunn/vim-peekaboo' " a nice plugin for pasting

 Plug 'gcmt/wildfire.vim' " <Enter> to select a code block

 " Bookmarks
 Plug 'kshenoy/vim-signature'
 call plug#end()

 " ================== {{
 " folder tree
 nmap tt :Vexplore<CR>
 
 let g:netrw_banner=0 " 禁用没用的横幅
 let g:netrw_winsize=20 " 初始窗口大小为25%
 let g:netrw_liststyle=3 " 使用树状模式
 let g:netrw_altv=1 " 分割窗口时默认在右边
 let g:netrw_browse_split=4 " enter时在上一个窗口打开
 " howto: help netrw
 " }}

 " ========= vim-table-mode
 map <space>tm :TableModeToggle<CR>

 " ========= Python-syntax
 " let g:python_highlight_all = 1

 " ========= vim-indent-guide
 let g:indent_guides_guide_size = 1
 let g:indent_guides_start_level = 2
 let g:indent_guides_enable_on_vim_startup = 1
 let g:indent_guides_color_change_percent = 1
 silent! unmap <LEADER>ig
 autocmd WinEnter * silent! unmap <LEADER>ig

 " auto complete
 " === === === === === === coc === === === === === === ===
 " === === === === === === coc === === === === === === ===
 " === === === === === === coc === === === === === === ===
  let g:coc_global_extensions = ['coc-json','coc-vimlsp','coc-python','coc-marketplace','coc-tsserver','coc-snippets','coc-java','coc-clangd']
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
 " === === === === === === coc === === === === === === ===
 " === === === === === === coc === === === === === === ===
 " === === === === === === coc === === === === === === ===
 set completeopt=menu,menuone,noselect

 " Easymotion
 let g:EasyMotion_smartcase = 1
 map <space>s <Plug>(easymotion-prefix)
 map s <space>ss

 " snippets
 let g:UltiSnipsExpandTrigger="<C-E>"
 let g:UltiSnipsJumpForwardTrigger="<c-b>"
 let g:UltiSnipsJumpBackwardTrigger="<c-z>"

 " run java
 autocmd Filetype java map <space>rc :w<CR>:!java %<CR>
 " run python
 autocmd Filetype python map <space>rc :w<CR>:!python %<CR>
 " run c
 autocmd FileType c map <space>rc :w<CR>:!gcc % -o %< && %<<CR>

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

 " auto complete "([
 " autocmd Filetype java,python,c inoremap " ""<Esc>i
 " autocmd Filetype java,python,c inoremap ' ''<Esc>i
 " autocmd Filetype java,python,c inoremap ( ()<Esc>i
 " autocmd Filetype java,python,c inoremap [ []<Esc>i
 " autocmd Filetype java,python,c inoremap { {}<Esc>i

" configuration for vim-keysound
" let g:keysound_enable = 1
" let g:keysound_theme = 'default'  " don't try anything else except 'default' and 'typewriter'
" let g:keysound_volume = 1000

 "
 "" MarkdownPreview Default
 """ ###let g:mkdp_auto_start = 0
 """ ###let g:mkdp_auto_close = 1
 """ ###let g:mkdp_refresh_slow = 0
 """ ###let g:mkdp_command_for_global = 0
 """ ###let g:mkdp_open_to_the_world = 0
 """ ###let g:mkdp_open_ip = ''
 """ ###let g:mkdp_browser = 'C:\Users\haywood\AppData\Local\Google\Chrome\Application\chrome.exe'
 """ ###let g:mkdp_echo_preview_url = 0
 """ ###let g:mkdp_title = '「${name}」'

 """ ###" Markdown Short Key
 """ ###autocmd Filetype markdown map <leader>w yiWi[<esc>Ea](<esc>pa)
 """ ###autocmd Filetype markdown inoremap ++ <++>
 """ ###autocmd Filetype markdown inoremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
 """ ###autocmd Filetype markdown inoremap ,n ---<Enter><Enter>
 """ ###autocmd Filetype markdown inoremap ,b **** <++><Esc>F*hi
 """ ###autocmd Filetype markdown inoremap ,s ~~~~ <++><Esc>F~hi
 """ ###autocmd Filetype markdown inoremap ,i ** <++><Esc>F*i
 """ ###autocmd Filetype markdown inoremap ,d `` <++><Esc>F`i
 """ ###autocmd Filetype markdown inoremap ,c <Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
 """ ###autocmd Filetype markdown inoremap ,h ====<Space><++><Esc>F=hi
 """ ###autocmd Filetype markdown inoremap ,p ![](<++>) <++><Esc>F[a
 """ ###autocmd Filetype markdown inoremap ,a [](<++>) <++><Esc>F[a
 """ ###autocmd Filetype markdown inoremap ,1 #<Space><Enter><++><Esc>kA
 """ ###autocmd Filetype markdown inoremap ,2 ##<Space><Enter><++><Esc>kA
 """ ###autocmd Filetype markdown inoremap ,3 ###<Space><Enter><++><Esc>kA
 """ ###autocmd Filetype markdown inoremap ,4 ####<Space><Enter><++><Esc>kA
 """ ###autocmd Filetype markdown inoremap ,l --------<Enter>
