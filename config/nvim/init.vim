" My neovim config file
call plug#begin('~/.vim/plugged')
" === Brains ===
    Plug 'dense-analysis/ale'                          " Asynchronous linting and syntax checking
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }  " Intellisense engine form vim8 & neovim, full lsp as vscode
                                                       " Also install coc-snippets, coc-jedi using :CocInstall <package>
    Plug 'ctrlpvim/ctrlp.vim'                          " Fuzzy file, buffer, mru, tag, etc. finder
    Plug 'ludovicchabant/vim-gutentags'                " A Vim plugin that manages your tag files

" === Language-specific ===
    Plug 'sheerun/vim-polyglot'                        " A solid language pack for vim
    Plug 'Vimjas/vim-python-pep8-indent'               " A nicer python indentation style for Vim
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Go Development Plugin for Vim

" === Shortcuts ===
    Plug 'tpope/vim-fugitive'                          " A Git wrapper awesome, it should be illegal
    Plug 'tpope/vim-surround'                          " Quoting / parenthesizing made simple
    Plug 'tpope/vim-commentary'                        " Comment out stuff: gcc to comment a line; gc<motion> for magic
    Plug 'jiangmiao/auto-pairs'                        " Vim plugin to insert or delete brackets, parens, quotes in air
    Plug 'junegunn/vim-easy-align'                     " Simple, easy-to-use vim-alignment plugin

" === Visuals ===
    Plug 'christoomey/vim-tmux-navigator'              " Seamless navigation between tmux panes and vim splits
    Plug 'itchyny/lightline.vim'                       " Lightweight statusline
    Plug 'mengelbrecht/lightline-bufferline'           " ...display the list of buffers in the lightline vim plugin
    Plug 'ap/vim-css-color'                            " Preview colours in source code while editing
    Plug 'sickill/vim-monokai'                         " Refined Monokai color scheme for Vim, inspired by Sublime text
    Plug 'haishanh/night-owl.vim'                      " Awesome Night-owl theme by Sarah Drasner
    Plug 'morhetz/gruvbox'                             " Retro groove color scheme for vim
    Plug 'joshdick/onedark.vim'                        " A dark (n)vim color scheme inspired by Atom's one dark syntax theme
    " Plug 'ryanoasis/vim-devicons'                      " Adds filetype icons to vim plugins
call plug#end()

" === General settings ===
    let g:python3_host_prog = '/usr/local/bin/python3' " Python for neovim
    set encoding=UTF-8
    set splitbelow                                     " Open horizontal splits at bottom
    set splitright                                     " Open vertical splits at right

" === Visuals ===
    if (has("termguicolors"))
        set termguicolors
    endif
    syntax enable  " Enable syntax highlighting
    set cursorline " Highlighting that moves with the cursor

    " === Colorscheme ===
    " ONEDARK
    colorscheme onedark

    " GRUVBOX
    " Configuration from https://github.com/morhetz/gruvbox/wiki/Configuration
    " colorscheme gruvbox
    " let g:gruvbox_contrast_dark="medium"

    " MONOKAI
    " colorscheme monokai

" === Spacing & Indentation ===
    " Adapted from https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
    " Enable filetype plugins
    filetype plugin on
    filetype indent on
    " Configure backspace so it acts as it should act
    set backspace=indent,eol,start confirm
    set whichwrap+=<,>,h,l

    " Linebreak on 500 characters
    set lbr
    set tw=250
    " Auto indent
    set ai
    " Smart indent
    set si
    " Wrap lines
    set wrap
    " Height of the command bar
    set cmdheight=1
    " Use spaces instead of tab
    set expandtab
    " Be smart when using tabs :)
    set smarttab
    " 1 tab <-> 4 spaces
    set shiftwidth=4
    set tabstop=4
    " === Language-specific ===
    " TODO: Find a better way
    " 1 tab <-> 2 spaces for JavaScript
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=3

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

" === Search & Replace ===
    " Ignorecase when searching
    set ignorecase
    " Incremental search - Vim starts searching when we start typing
    set incsearch
    " When searching try to be smart about cases
    set smartcase
    " Highlight search results
    set hlsearch
    " Remove highlighting after search: highlighting-off
    nnoremap <leader>ho :nohlsearch<CR>
    " Live feedback while replacing text
    " https://dev.to/waylonwalker/live-substitution-in-neovim-5e34
    set inccommand=nosplit

    " Stuff to ignore when tab completing
    set wildoptions=pum
    set wildignore=*.o,*.obj,*~                                                     
    set wildignore+=*.exe
    set wildignore+=*.git*
    set wildignore+=*.meteor*
    set wildignore+=*vim/backups*
    set wildignore+=*sass-cache*
    set wildignore+=*mypy_cache*
    set wildignore+=*__pycache__*
    set wildignore+=*cache*
    set wildignore+=*node_modules*
    set wildignore+=**/node_modules/**
    set wildignore+=*DS_Store*
    set wildignore+=*.gem

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

" === Performance ===
    set lazyredraw " Fix slow scrolling that occurs when using mouse and relative numbers

" === Fix annoyances ===
    " To auto-close the method-preview window
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    " Diable auto-comment
    " https://vim.fandom.com/wiki/Disable_automatic_comment_insertion
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" === Keyboard bindings ===
    let mapleader = " "
    let maplocalleader = ","  " https://github.com/jalvesaq/Nvim-R/issues/101#issuecomment-242395913 
    :nmap <Space> :
    
    " === vim-easy-align ===
    " Start interactive EasyAlign in visual mode (e.g. vipga): get-aligned
    xmap ga <Plug>(EasyAlign)
    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)
    

    " === Some of my fav spacemacs bindings ===
    " Close buffer in focus
    " bd - buffer-delete
    nnoremap <leader>bd <C-w>q
    nnoremap <leader>bn :w<CR>:bn<CR> 
    " Splits
    " vs - vertical-split
    nnoremap <leader>vs :vsplit<CR>
    " hs - horizontal-split
    nnoremap <leader>hs :split<CR>

    " Move between buffers
    nnoremap <leader>wh <C-w>h 
    nnoremap <leader>wj <C-w>j
    nnoremap <leader>wk <C-w>k
    nnoremap <leader>wl <C-w>l

    " === tmux ===
    " Write all buffers before navigating from Vim to tmux pane
    let g:tmux_navigator_save_on_switch = 2

    " === C++ ===
    " Compile current file: compile
    autocmd FileType cpp,c,objc nmap <buffer> <leader>cm :w <CR> :!g++ -std=c++17 % -o %<.exe && ./%<.exe <CR>
    
    " === Go ===
    " See - https://tpaschalis.github.io/vim-go-setup/
    let g:go_fmt_command = "goimports"    " Run goimports along gofmt on each save
    let g:go_auto_type_info = 1           " Automatically get signature/type info for object under cursor

    " === Misc ===
    " Open this file: vim-options 
    nnoremap <leader>vo :e ~/.config/nvim/init.vim<CR>
    " Reload config file 
    nnoremap <C-s> :w<CR>:source ~/.config/nvim/init.vim<CR>

" === Plugin Settings ===
    " === lightline ===
    if !has('gui_running')
        set t_Co=256
    endif
    set laststatus=2
    set noshowmode
    set showtabline=2
    let g:lightline = {
                \ 'colorscheme': 'onedark',
                \ 'active': {
                    \ 'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ], ['gitbranch'] ],
                    \ 'right': [ ['percent'], ['lineinfo'], ['fileformat', 'fileencoding'], ['gutentags'], ],
                \ },
                \ 'mode_map': {
                    \ 'n' : 'N',
                    \ 'i' : 'I',
                    \ 'R' : 'R',
                    \ 'v' : 'V',
                    \ 'V' : 'VL',
                    \ "\<C-v>": 'VB',
                    \ 'c' : 'C',
                    \ 's' : 'S',
                    \ 'S' : 'SL',
                    \ "\<C-s>": 'SB',
                    \ 't': 'T',
                \ },
                \ 'tabline': {
                    \ 'left': [['buffers']],
                    \ 'right': [['close']],
                \ },
                \ 'component_function': {
                    \ 'gitbranch': 'fugitive#head',
                    \ 'gutentags': 'gutentags#statusline',
                \},
                \ 'component_expand':{
                    \ 'buffers': 'lightline#bufferline#buffers',
                \},
                \ 'component_type': {
                    \ 'buffers': 'tabsel',
                \},
                \}
    " If you're adding the buffers to the bottom status bar, the `modified` 
    " indicator will not be updated immediately. To work around this ->
    autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

    augroup MyGutentagsStatusLineRefresher
        autocmd!
        autocmd User GutentagsUpdating call lightline#update()
        autocmd User GutentagsUpdated call lightline#update()
    augroup END

    let g:lightline#bufferline#unnamed      = '[No Name]'
    " Add the buffer number to the buffer name
    " Shows ordinal number
    let g:lightline#bufferline#show_number = 2
    " let g:lightline#bufferline#enable_devicons = 1
    " let g:lightline#bufferline#icon_position = 'right'
    " let g:lightline#bufferline#enable_nerdfont = 1
    " let g:lightline#bufferline#unicode_symbols = 1

    " Plug mappings to switch to buffers using their ordinal number in the bufferline
    nmap <Leader>1 <Plug>lightline#bufferline#go(1)
    nmap <Leader>2 <Plug>lightline#bufferline#go(2)
    nmap <Leader>3 <Plug>lightline#bufferline#go(3)
    nmap <Leader>4 <Plug>lightline#bufferline#go(4)
    nmap <Leader>5 <Plug>lightline#bufferline#go(5)
    nmap <Leader>6 <Plug>lightline#bufferline#go(6)
    nmap <Leader>7 <Plug>lightline#bufferline#go(7)
    nmap <Leader>8 <Plug>lightline#bufferline#go(8)
    nmap <Leader>9 <Plug>lightline#bufferline#go(9)
    nmap <Leader>0 <Plug>lightline#bufferline#go(10)

    " === auto-pairs ===
    " Don't use <leader> in insert mode and make vim a stuttering mess 
    let g:AutoPairsMapSpace = "false"

    " === ale ===
    " C++
    let g:ale_cpp_gcc_executable='gcc-9'
    let g:ale_cpp_gcc_options='-std=c++17 -Wextra -Wall'
    let g:ale_cpp_clang_executable='clang++'
    let g:ale_cpp_clang_options='-std=c++17 -Wextra -Wall'
    
    let g:ale_linters = {
                \ 'python': ['flake8', 'pylint'],
                \ 'go': ['gometalinter', 'gofmt'],
                \ 'c': ['cc'],
                \ 'cpp': ['gcc', 'clang-tidy'],
                \ 'javascript': ['eslint'],
                \}
    let g:ale_fixers = {
                \ 'python': ['yapf'],
                \ 'go': ['gofmt'],
                \ 'javascript': ['prettier'],
                \}
    nmap <F10> :ALEFix<CR>
    let g:ale_fix_on_save = 1

    " === treesitter ===
    " Explicitly activate modules
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
"   highlight = {
"     enable = true,              -- false will disable the whole extension
"     disable = { },  -- list of language that will be disabled
"   },
" }
" EOF

    " === Tags === 
    " From https://stackoverflow.com/questions/11975316/vim-ctags-tag-not-found
    " set tags=./tags,tags;$HOME

    " From https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
    " Configure what a "new project" means for gutentags
    let g:gutentags_add_default_project_roots = 0
    let g:gutentags_project_root = ['package.json', '.git']
    " To avoid adding tags and tags.lock to the .gitignore every single project configure it outside
    let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
    " Save time instead of manually calling gutentags
    let g:gutentags_generate_on_new = 1
    let g:gutentags_generate_on_missing = 1
    let g:gutentags_generate_on_write = 1
    let g:gutentags_generate_on_empty_buffer = 0
    " Let gutentags generate more info for the tags
    let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
    " Make gutentags faster by avoiding certain files
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ 'dist',
      \ 'node_modules',
      \ 'cache',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ] 

    " === coc.vim ===
    " Settings
    set updatetime=300 " Having longer update times lead to poor UX
    set shortmess+=c   " Don't pass messages to |ins-completion-menu|
    set signcolumn=yes " Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
    set clipboard=unnamedplus " Map system keyboard to vim's paste buffer

    " To make snippet completion work just like VSCode
    " https://github.com/neoclide/coc.nvim/wiki/Using-snippets
    " <<< NOTE: Use <C-n> & <C-p> to move to next suggestion for tab-complete
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? coc#_select_confirm() :
          \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    let g:coc_snippet_next = '<tab>'

    " Close preview window when completion is done
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    " Show documentation in a floating window
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    function! s:show_documentation()
      if &filetype == 'vim'
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " gd - go to definition of word under cursor
    nmap <silent> gd <Plug>(coc-definition)
    " gy - go to type definition
    nmap <silent> gy <Plug>(coc-type-definition)
    " gi - go to implementation
    nmap <silent> gi <Plug>(coc-implementation)
    " gr - find references
    nmap <silent> gr <Plug>(coc-references)
    " gh - get hint on whatever's under the cursor
    nnoremap <silent> gh :call <SID>show_documentation()<CR>
    " cr - Rename the current word in the cursor (Renames the exports across all files)
    nmap <leader>cn  <Plug>(coc-rename)
    " cf - format selected string
    nmap <leader>cf  <Plug>(coc-format-selected)
    " cf - format selected string in visual mode
    vmap <leader>cf  <Plug>(coc-format-selected)

    " === netrw ===
    " let g:netrw_banner = 0    " Hide annoying 'help' banner
    " let g:netrw_liststyle = 3 " Use tree view
    " let g:netrw_winsize = 25  " Smaller default window size
    " let g:netrw_browse_split = 4
    " let g:netrw_altv = 1
    " augroup ProjectDrawer
    "     autocmd!
    "     autocmd VimEnter * :Vexplore
    " augroup END

