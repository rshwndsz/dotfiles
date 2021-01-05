" My neovim config file

call plug#begin('~/.vim/plugged')

" === Editor visuals ===
    Plug 'vim-airline/vim-airline'                     " Lean & mean status/tabline for vim that's light as air
    Plug 'vim-airline/vim-airline-themes'              " Themes for vim-airline

" === Themes ===
    Plug 'crusoexia/vim-monokai'                       " Refined Monokai color scheme for Vim, inspired by Sublime text
    Plug 'haishanh/night-owl.vim'                      " Awesome Night-owl theme by Sarah Drasner
    Plug 'morhetz/gruvbox'                             " Retro groove color scheme for vim
    Plug 'joshdick/onedark.vim'                        " A dark (n)vim color scheme inspired by Atom's one dark syntax theme

" === Brains ===
    Plug 'ctrlpvim/ctrlp.vim'                          " Fuzzy file, buffer, mru, tag, etc. finder
    Plug 'dense-analysis/ale'                          " Asynchronous linting and syntax checking
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }  " Intellisense engine form vim8 & neovim, full lsp as vscode

" === Language-specific ===
    " Plug 'lervag/vimtex'                               " A modern vim plugin for editing tex files
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Go Development Plugin for Vim
    Plug 'sheerun/vim-polyglot'                        " A solid language pack for vim

" === Tmux ===
    Plug 'christoomey/vim-tmux-navigator'              " Seamless navigation between tmux panes and vim splits

" === Tags ===
    "Plug 'ludovicchabant/vim-gutentags'               " A vim plugin that manages your tag files
    "Plug 'xolox/vim-easytags'                         " Syntax highlighting and tag generation 
    "Plug 'xolox/vim-misc'                             " Required by vim-easytags
  
" === Shortcuts for common stuff ===
    Plug 'tpope/vim-surround'                         " Quoting / parenthesizing made simple
    Plug 'jiangmiao/auto-pairs'                       " Vim plugin to insert or delete brackets, parens, quotes in air
    Plug 'preservim/nerdcommenter'                    " Vim plugin for intensely nerdy commenting powers
    Plug 'junegunn/vim-easy-align'                    " Simple, easy-to-use vim-alignment plugin

" === Nice to haves ===
    Plug 'junegunn/goyo.vim'                          " Distraction free writing in vim
    Plug 'ap/vim-css-color'                           " Preview colours in source code while editing

call plug#end()


" === General settings ===
    let g:python3_host_prog = '/usr/local/bin/python3' " Python for neovim
    set encoding=UTF-8
    set splitbelow     " Open horizontal splits at bottom
    set splitright     " Open vertical splits at right


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
    " colorscheme gruvbox
    " " Configuration from https://github.com/morhetz/gruvbox/wiki/Configuration
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
    set wildignore+=*logs*
    set wildignore+=*node_modules*
    set wildignore+=**/node_modules/**
    set wildignore+=*DS_Store*
    set wildignore+=*.gem
    set wildignore+=log/**
    set wildignore+=tmp/**
    set wildignore+=*.png,*.jpg,*.gif


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
    let maplocalleader = ","  " https://github.com/jalvesaq/Nvim-R/issues/101#issuecomment-242395913 
    :nmap <Space> :
    

    " === vim-easy-align ===
    " Start interactive EasyAlign in visual mode (e.g. vipga): get-aligned
    xmap ga <Plug>(EasyAlign)
    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)
    

    " === coc.vim ===
    " Settings
    set updatetime=300        " Having longer update times lead to poor UX
    set shortmess+=c          " Don't pass messages to |ins-completion-menu|
    set signcolumn=yes        " Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
    set clipboard=unnamedplus " Map system keyboard to vim's paste buffer

    " To make snippet completion work just like VSCode
    " https://github.com/neoclide/coc.nvim/wiki/Using-snippets
    " <<< NOTE: Install coc-snippets with `:CocInstall coc-snippets` for this to work
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? coc#_select_confirm() :
          \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " <<< NOTE: Use <C-n> & <C-p> to move to next suggestion for tab-complete
    let g:coc_snippet_next = '<tab>'

    " Close preview window when completion is done
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    " https://github.com/rstacruz/vim-coc-settings/blob/master/after/plugin/coc.vim
    " gd - go to definition of word under cursor
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    " gi - go to implementation
    nmap <silent> gi <Plug>(coc-implementation)
    " gr - find references
    nmap <silent> gr <Plug>(coc-references)
    " gh - get hint on whatever's under the cursor
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    nnoremap <silent> gh :call <SID>show_documentation()<CR>
    function! s:show_documentation()
      if &filetype == 'vim'
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Rename the current word in the cursor
    nmap <leader>cr  <Plug>(coc-rename)
    nmap <leader>cf  <Plug>(coc-format-selected)
    vmap <leader>cf  <Plug>(coc-format-selected)


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


    " " === Nerd Tree ===
    " " Toggle NERDTree ON or OFF
    " " ft - file-tree
    " nnoremap <leader>ft :NERDTreeToggle<CR>
    " " Close vim if only window left is NERDTree
    " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


    " === Goyo ===
    " Toggle Goyo ON or OFF
    " df - distraction-free
    nnoremap <leader>df :Goyo<CR> 


    " " === Vim terminal emulator ===
    " " <<< NOTE: Use `tmux` with `tmuxinator` for best terminal + vim experience
    " " Open a terminal
    " nnoremap <leader>' :let $VIM_DIR=expand('%:p:h')<CR> :8sp term://zsh<CR>cd $VIM_DIR<CR>
    " " Move to normal mode in terminal
    " tnoremap <ESC> <C-\><C-n>


    " === C++ ===
    " Compile current file: compile
    autocmd FileType cpp,c,objc nmap <buffer> <leader>cm :w <CR> :!g++ -std=c++17 % -o %<.exe && ./%<.exe <CR>
    

    " " === Go ===
    " See - https://tpaschalis.github.io/vim-go-setup/
    let g:go_fmt_command = "goimports"    " Run goimports along gofmt on each save
    let g:go_auto_type_info = 1           " Automatically get signature/type info for object under cursor


    " === Misc ===
    " Remove highlighting after search: highlighting-off
    nnoremap <leader>ho :noh<CR>
    " Open this file: vim-options 
    nnoremap <leader>vo :e ~/.config/nvim/init.vim<CR>
    " Reload config file 
    nnoremap <C-s> :w<CR>:source ~/.config/nvim/init.vim<CR>


" === Plugin Settings ===
    " === vim-airline ===
    let g:airline#extensions#tabline#enabled = 1
    " Use fancy fonts
    let g:airline_powerline_fonts = 1
    " Move statusline to the top - Good for Tmux as it has it's own line
    let g:airline_statusline_ontop=1
    let g:airline#extensions#whitespace#enabled = 0
    " Airline + Ale
    let g:airline#extensions#ale#enabled = 1 
    " Remove file encoding
    let g:airline_section_y='' 
    " Remove line column number and simplify last section
    let g:airline_section_z = airline#section#create(['%3l:%3v'])
    " Remove separators for empty sections
    let g:airline_skip_empty_sections = 1

    " Remove vim's default ugly statusline that remains at the bottom
    " https://unix.stackexchange.com/questions/140898/vim-hide-status-line-in-the-bottom
    let s:hidden_all = 0
    function! TogglehiddenAll()
        if s:hidden_all == 0
            let s:hidden_all = 1
            set noshowmode
            set noruler
            set laststatus=0
            set noshowcmd
        else
            let s:hidden_all = 0
            set showmode
            set ruler
            set laststatus=2
            set showcmd
        endif
    endfunction
    " sh - statusline-hide
    nnoremap <leader>sh :call TogglehiddenAll()<CR>
    " TODO: If hidden_all == 0 call TogglehiddenAll() on startup & GoyoEnter/Leave

    " === vim-airline-themes ===
    let g:airline_theme = 'minimalist' 


    " === nerd-commenter ===
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1
    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'
    " Set a language to use its alternate delimiters by default
    let g:NERDAltDelims_java = 1
    " Add your own custom formats or override the defaults
    let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1
    " Enable NERDCommenterToggle to check all selected lines is commented or not 
    let g:NERDToggleCheckAllLines = 1


    " === nerd-tree ===
    " Don't show line numbers in file tree - Doesn't work sometimes though
    let NERDTreeShowLineNumbers=0


    " === goyo ===
    let g:goyo_width='96%'
    let g:goyo_height='96%'
    function! s:goyo_enter()
        set scrolloff=999
    endfunction

    function! s:goyo_leave()
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set scrolloff=5
    endfunction

    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()


    " === auto-pairs ===
    " This uses <leader> in insert mode making vim a stuttering mess 
    let g:AutoPairsMapSpace = "false"


    "" === vim-easytags ===
    "let g:easytags_async = 1
    "let g:easytags_file = '~/.vim/tags'
    "" Project specific tag files
    "set tags=./tags;
    "let g:easytags_dynamic_files=0


    " === ale ===
    " C++
    let g:ale_cpp_gcc_executable='gcc-9'
    let g:ale_cpp_gcc_options='-std=c++17 -Wextra -Wall'

    let g:ale_cpp_clang_executable='clang++'
    let g:ale_cpp_clang_options='-std=c++17 -Wextra -Wall'
    
    let g:ale_linters = {
                \'cpp': ['gcc', 'clang-tidy'],
                \}


    " === coc-snippets ===
    " Install using `:CocInstall coc-snippets`
    " https://github.com/neoclide/coc-snippets/issues/15#issuecomment-475891282
    " <<< NOTE: Use `:CocCommand snippets.ediSnippets` to open the snippet file for the current filetype
    " <<<       All snippets for the current filetype live there


    " " === vim-tex ===
    " " Since neovim doesn't support the `--servername` option yet
    " " Install neovim-remote using `pip3 install neovim-remote`
    " " https://github.com/lervag/vimtex/wiki/introduction#neovim
    " let g:vimtex_compiler_progname = 'nvr'
    " let g:vimtex_view_general_viewer
    "         \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
    " let g:vimtex_view_general_options = '-r @line @pdf @tex'
    "
    " " This adds a callback hook that updates Skim after compilation
    " let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
    "
    " function! UpdateSkim(status)
    "     if !a:status | return | endif
    "
    "     let l:out = b:vimtex.out()
    "     let l:tex = expand('%:p')
    "     let l:cmd = [g:vimtex_view_general_viewer, '-r']
    "
    "     if !empty(system('pgrep Skim'))
    "         call extend(l:cmd, ['-g'])
    "     endif
    "
    "     if has('nvim')
    "         call jobstart(l:cmd + [line('.'), l:out, l:tex])
    "     elseif has('job')
    "         call job_start(l:cmd + [line('.'), l:out, l:tex])
    "     else
    "         call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
    "     endif
    " endfunction
    "
    " " Ignore certain warnings
    " let g:Tex_IgnoredWarnings =
    "     \'Underfull'."\n".
    "     \'Overfull'."\n".
    "     \'specifier changed to'."\n".
    "     \'You have requested'."\n".
    "     \'Missing number, treated as zero.'."\n".
    "     \'There were undefined references'."\n".
    "     \'Citation %.%# undefined'."\n".
    "     \'Double space found.'."\n".
    "     \'Possible unwanted space'."\n".
    "     \'Wrong length of dash may have been used. (8)'."\n"
    " let g:Tex_IgnoreLevel = 8
    "
    " let g:vimtex_quickfix_latexlog = {
    "   \ 'overfull' : 0,
    "   \ 'underfull' : 0,
    "   \ 'packages' : {
    "   \   'default' : 0,
    "   \ },
    "   \}
    "
    " " XeLateX
    " " https://tex.stackexchange.com/a/510684
    " let g:vimtex_compiler_latexmk = {
    "             \ 'executable' : 'latexmk',
    "             \ 'options' : [
    "             \   '-xelatex',
    "             \   '-file-line-error',
    "             \   '-synctex=1',
    "             \   '-interaction=nonstopmode',
    "             \ ],
    "             \}
    "
