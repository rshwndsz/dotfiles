" My neovim config file

call plug#begin('~/.vim/plugged')

  Plug 'vim-airline/vim-airline'                    " Lean & mean status/tabline for vim that's light as air
  Plug 'vim-airline/vim-airline-themes'             " Themes for vim-airline
  Plug 'crusoexia/vim-monokai'                      " Monokai colorscheme
  Plug 'junegunn/goyo.vim'                          " Distraction free writing in vim
  Plug 'vifm/vifm'                                  " A file manager with curses interface

  Plug 'neoclide/coc.nvim', { 'branch': 'release' } " Intellisense engine form vim8 & neovim, full lsp as vscode
  Plug 'ctrlpvim/ctrlp.vim'                         " Fuzzy file, buffer, mru, tag, etc. finder
  Plug 'junegunn/vim-easy-align'                    " Simple, easy-to-use vim-alignment plugin
  Plug 'tpope/vim-surround'                         " quoting / parenthesizing made simple
  Plug 'terryma/vim-multiple-cursors'               " Multiple cursor editing
  Plug 'preservim/nerdcommenter'                    " Vim plugin for intensely nerdy commenting powers

call plug#end()

" === General settings ===
    let g:python3_host_prog = '/usr/local/bin/python3' " Python for neovim
    set encoding=UTF-8
    set splitbelow                                     " Open horizontal splits at bottom
    set splitright                                     " Open vertical splits at right
    " For coc.vim
    set updatetime=300                                 " Having longer update times lead to poor UX
    set shortmess+=c                                   " Don't pass messages to |ins=completion-menu|
    set signcolumn=yes                                 " Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.

" === Colorscheme ===
    syntax on
    colorscheme monokai
    set cursorline " Highlighting that moves with the cursor

" === Spacing & Indentation ===
    filetype plugin indent on
    set backspace=indent,eol,start confirm
    set shiftwidth=4 autoindent smartindent tabstop=4 softtabstop=4 expandtab
    set cmdheight=2 " More height for displaying messages

" === Line Numbering ===
    set number
    " Toggle relative numbering, and set to absolute on loss of focus or insert mode
    autocmd InsertEnter * :set nornu
    autocmd InsertLeave * :set rnu
    " Disable relative numbering while debugging - when source window loses focus
    autocmd BufLeave * :set nornu
    autocmd BufEnter * cal SetRNU()
    function! SetRNU()
      if(mode() != 'i')
          set rnu
      endif 
    endfunction 

" === Folds ===
    set foldmethod=indent   " Fold based on indent
    set foldnestmax=3       " Deepest fold is 3 levels
    set nofoldenable        " Don't fold by default

" === Fix annoyances ===
    " To auto-close the method-preview window
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    " Diable auto-comment
    " https://vim.fandom.com/wiki/Disable_automatic_comment_insertion
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" === Searching ===
    " Ignorecase when searching
    set ignorecase
    " Incremental search - Vim starts searching when we start typing
    set incsearch
    " When searching try to be smart about cases
    set smartcase
    " Highlight search results
    set hlsearch

" === Performance ===
    set lazyredraw " Fix slow scrolling that occurs when using mouse and relative numbers

" === File Management ===
    set noswapfile
    set nobackup
    set nowritebackup " Some servers (coc.vim) have issues with backup files
    set nowb
    set autoread
    " Triger `autoread` when files changes on disk
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
    " Notification after file change
    autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" === Scrolling ===
    set scrolloff=8 " Start scrolling when we're 8 lines away from margins

" === Keyboard bindings ===
    let mapleader = " "
    :nmap <Space> :

    " Reload config file 
    nnoremap <C-s> :source ~/.config/nvim/init.vim<CR>

    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)
    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)
    
    " === For coc.vim ===
    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command `:verbose imap <tab>` to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh() 

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    " === Some of my fav spacemacs bindings ===
    " Close buffer in focus
    nnoremap <leader>bd <C-w>q
    " Splits
    nnoremap <leader>vs :vsplit<CR>
    nnoremap <leader>hs :split<CR>

    " Move between buffers
    nnoremap <leader>wl <C-w>l 
    nnoremap <leader>wh <C-w>h
    nnoremap <leader>wj <C-w>j
    nnoremap <leader>wk <C-w>k

    " Open a terminal 
    nnoremap <leader>' :let $VIM_DIR=expand('%:p:h')<CR> :8sp term://fish<CR>cd $VIM_DIR<CR>
    " Move to normal mode in terminal
    tnoremap <ESC> <C-\><C-n>

    " === C++ ===
    autocmd FileType cpp,c,objc nmap <buffer> <leader>cm :w <CR> :!g++ -std=c++17 % -o %<.exe && ./%< <CR>

    " === Goyo ===
    nnoremap <leader>df :Goyo<CR>

    " === Misc ===
    " Remove highlighting after search
    nnoremap <leader>ho :noh<CR>

" === Plugin Settings ===

    " === vim-airline ===
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1

    " === vim-airline-themes ===
    let g:airline_theme = 'base16_monokai' 

    " === nerd-commenter ===
    let g:nerdspacedelims = 1                                             " add spaces after comment delimiters by default
    let g:nerdcompactsexycoms = 1                                         " use compact syntax for prettified multi-line comments
    let g:nerddefaultalign = 'left'                                       " align line-wise comment delimiters flush left instead of following code indentation
    let g:nerdaltdelims_java = 1                                          " set a language to use its alternate delimiters by default
    let g:nerdcustomdelimiters = { 'c': { 'left': '/**','right': '*/' } } " add your own custom formats or override the defaults
    let g:nerdcommentemptylines = 1                                       " allow commenting and inverting empty lines (useful when commenting a region)
    let g:nerdtrimtrailingwhitespace = 1                                  " enable trimming of trailing whitespace when uncommenting
    let g:nerdtogglecheckalllines = 1                                     " enable nerdcommentertoggle to check all selected lines is commented or not

    " === goyo ===
    let g:goyo_width='96%'
    let g:goyo_height='96%'

