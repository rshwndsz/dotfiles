" My neovim config file
call plug#begin('~/.vim/plugged')
" === Brains ===
Plug 'neoclide/coc.nvim', { 'branch': 'release' }  " Intellisense engine form vim8 & neovim, full lsp as vscode
Plug 'junegunn/fzf', { 'do': {-> fzf#install()} }  " Fuzzy text completion 
Plug 'junegunn/fzf.vim'
" Plug 'ludovicchabant/vim-gutentags'              " A Vim plugin that manages your tag files
                                                   " Uncomment after vim-treesitter becomes more stable

" === Language-specific ===
Plug 'sheerun/vim-polyglot'                        " A solid language pack for vim
Plug 'Vimjas/vim-python-pep8-indent'               " A nicer python indentation style for Vim
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Go Development Plugin for Vim
Plug 'HerringtonDarkholme/yats.vim'                " TS Syntax

" === Shortcuts ===
Plug 'tpope/vim-fugitive'                          " A Git wrapper 'so awesome, it should be illegal'
Plug 'tpope/vim-surround'                          " Quoting / parenthesizing made simple
Plug 'tpope/vim-commentary'                        " Comment out stuff: gcc to comment a line; gc<motion> for magic
Plug 'junegunn/vim-easy-align'                     " Simple, easy-to-ubse vim-alignment plugin
Plug 'christoomey/vim-tmux-navigator'              " Seamless navigation between tmux panes and vim splits

" === Editor visuals ===
Plug 'ap/vim-css-color'                            " Preview colours in source code while editing
Plug 'itchyny/lightline.vim'                       " Lightweight statusline
Plug 'mengelbrecht/lightline-bufferline'           " ...display the list of buffers in the lightline vim plugin
Plug 'preservim/nerdtree'                          " A tree explorer plugin for vim
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'

" === Themes ===
Plug 'sickill/vim-monokai'                         " Refined Monokai color scheme for Vim, inspired by Sublime text
Plug 'haishanh/night-owl.vim'                      " Awesome Night-owl theme by Sarah Drasner
Plug 'morhetz/gruvbox'                             " Retro groove color scheme for vim
Plug 'joshdick/onedark.vim'                        " A dark (n)vim color scheme inspired by Atom's one dark syntax theme
call plug#end()

" === General settings ===
let g:python3_host_prog = '/usr/local/bin/python3' " python for neovim
set encoding=utf-8
set splitbelow                                     " open horizontal splits at bottom
set splitright                                     " open vertical splits at right

" === visuals ===
if (has("termguicolors"))
  set termguicolors
endif
syntax enable  " enable syntax highlighting
set cursorline " highlighting that moves with the cursor

" === colorscheme ===
" onedark
" colorscheme onedark

" gruvbox
" configuration from https://github.com/morhetz/gruvbox/wiki/configuration
colorscheme gruvbox
let g:gruvbox_contrast_dark="medium"

" monokai
" colorscheme monokai

" === spacing & indentation ===
" adapted from https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
" enable filetype plugins
filetype plugin on
filetype indent on
" configure backspace so it acts as it should act
set backspace=indent,eol,start confirm
set whichwrap+=<,>,h,l

" linebreak on 500 characters
set lbr
set tw=250
" auto indent
set ai
" smart indent
set si
" wrap lines
set wrap
" height of the command bar
set cmdheight=1
" use spaces instead of tab
set expandtab
" be smart when using tabs :)
set smarttab
" 1 tab <-> 2 spaces
set shiftwidth=2
set tabstop=2

" === line numbering ===
set number
" toggle relative numbering, and set to absolute on loss of focus or insert mode
autocmd insertenter * :set nornu
autocmd insertleave * :set rnu
" disable relative numbering while debugging - when source window loses focus
autocmd bufleave * :set nornu
autocmd bufenter * cal SetRNU()
function! SetRNU()
  if(mode() != 'i')
    set rnu
  endif 
endfunction 

" === folds ===
set foldmethod=indent   " fold based on indent
set foldnestmax=3       " deepest fold is 3 levels
set nofoldenable        " don't fold by default

" === search & replace ===
" ignorecase when searching
set ignorecase
" incremental search - vim starts searching when we start typing
set incsearch
" when searching try to be smart about cases
set smartcase
" highlight search results
set hlsearch
" live feedback while replacing text
" https://dev.to/waylonwalker/live-substitution-in-neovim-5e34
set inccommand=nosplit

" stuff to ignore when tab completing
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
set wildignore+=*ds_store*
set wildignore+=*.gem

" === file management ===
set noswapfile
set nobackup
set nowritebackup " some servers (coc.vim) have issues with backup files
set nowb
set autoread
" triger `autoread` when files changes on disk
autocmd focusgained,bufenter,cursorhold,cursorholdi * if mode() != 'c' | checktime | endif
" notification after file change
autocmd filechangedshellpost *
      \ echohl warningmsg | echo "file changed on disk. buffer reloaded." | echohl none

" === scrolling ===
set scrolloff=8 " start scrolling when we're 8 lines away from margins

" === performance ===
set lazyredraw " fix slow scrolling that occurs when using mouse and relative numbers

" === fix annoyances ===
" to auto-close the method-preview window
autocmd insertleave,completedone * if pumvisible() == 0 | pclose | endif
" diable auto-comment
" https://vim.fandom.com/wiki/disable_automatic_comment_insertion
autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" === keyboard bindings ===
let mapleader = " "
let maplocalleader = ","  " https://github.com/jalvesaq/nvim-r/issues/101#issuecomment-242395913 
:nmap <space> :

" === vim-easy-align ===
" start interactive easyalign in visual mode (e.g. vipga): easy-aligned
xmap ga <plug>(easyalign)
" start interactive easyalign for a motion/text object (e.g. gaip)
nmap ga <plug>(easyalign)


" === some of my fav spacemacs bindings ===
" close buffer in focus
" bd - buffer-delete
nnoremap <leader>bd <c-w>q
nnoremap <leader>bn :w<cr>:bn<cr> 
" splits
" vs - vertical-split
nnoremap <leader>vs :vsplit<cr>
" hs - horizontal-split
nnoremap <leader>hs :split<cr>

" move between buffers
nnoremap <leader>wh <c-w>h 
nnoremap <leader>wj <c-w>j
nnoremap <leader>wk <c-w>k
nnoremap <leader>wl <c-w>l

" === tmux ===
" write all buffers before navigating from vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

" === c++ ===
" compile current file: compile
autocmd filetype cpp,c,objc nmap <buffer> <leader>cm :w <cr> :!g++ -std=c++17 % -o %<.exe && ./%<.exe <cr>

" === go ===
" see - https://tpaschalis.github.io/vim-go-setup/
let g:go_fmt_command = "goimports"    " run goimports along gofmt on each save
let g:go_auto_type_info = 1           " automatically get signature/type info for object under cursor

" === misc ===
" open this file: vim-options 
nnoremap <leader>vo :e ~/.config/nvim/init.vim<cr>
" reload config file 
nnoremap <c-s> :w<cr>:source ~/.config/nvim/init.vim<cr>

" === plugin settings ===
" === lightline ===
if !has('gui_running')
  set t_co=256
endif
set laststatus=2
set noshowmode
set showtabline=2
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
        \ 'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ], ['gitbranch'] ],
        \ 'right': [ ['percent'], ['lineinfo'], ['fileformat', 'fileencoding'], ['gutentags'], ],
      \ },
      \ 'mode_map': {
      \ 'n' : 'N',
      \ 'i' : 'I',
      \ 'r' : 'R',
      \ 'v' : 'V',
      \ 'V' : 'VL',
      \ "\<c-v>": 'VB',
      \ 'c' : 'C',
      \ 's' : 'S',
      \ 'S' : 'SL',
      \ "\<c-s>": 'SB',
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
" if you're adding the buffers to the bottom status bar, the `modified` 
" indicator will not be updated immediately. to work around this ->
autocmd bufwritepost,textchanged,textchangedi * call lightline#update()

augroup mygutentagsstatuslinerefresher
  autocmd!
  autocmd user gutentagsupdating call lightline#update()
  autocmd user gutentagsupdated call lightline#update()
augroup end

let g:lightline#bufferline#unnamed = '[no name]'
" add the buffer number to the buffer name
" shows ordinal number
let g:lightline#bufferline#show_number = 2

" plug mappings to switch to buffers using their ordinal number in the bufferline
nmap <leader>1 <plug>lightline#bufferline#go(1)
nmap <leader>2 <plug>lightline#bufferline#go(2)
nmap <leader>3 <plug>lightline#bufferline#go(3)
nmap <leader>4 <plug>lightline#bufferline#go(4)
nmap <leader>5 <plug>lightline#bufferline#go(5)
nmap <leader>6 <plug>lightline#bufferline#go(6)
nmap <leader>7 <plug>lightline#bufferline#go(7)
nmap <leader>8 <plug>lightline#bufferline#go(8)
nmap <leader>9 <plug>lightline#bufferline#go(9)
nmap <leader>0 <plug>lightline#bufferline#go(10)

" === auto-pairs ===
" don't use <leader> in insert mode and make vim a stuttering mess 
let g:autopairsmapspace = "false"

" " === Tags === 
" " From https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
" " Configure what a 'new project' means for gutentags
" let g:gutentags_add_default_project_roots = 0
" let g:gutentags_project_root = ['package.json', '.git']
" " To avoid adding tags and tags.lock to the .gitignore every single project configure it outside
" let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
" " Exclude certain files that are temporary
" let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
" " Save time instead of manually calling gutentags
" let g:gutentags_generate_on_new = 1
" let g:gutentags_generate_on_missing = 1
" let g:gutentags_generate_on_write = 1
" let g:gutentags_generate_on_empty_buffer = 0
" " Let gutentags generate more info for the tags
" let g:gutentags_ctags_extra_args = [
"       \ '--tag-relative=yes',
"       \ '--fields=+ailmnS',
"       \ ]
" " Make gutentags faster by avoiding certain files
" let g:gutentags_ctags_exclude = [
"       \ '*.git', '*.svg', '*.hg',
"       \ 'dist',
"       \ 'node_modules',
"       \ 'cache',
"       \ '*-lock.json',
"       \ '*.lock',
"       \ '*bundle*.js',
"       \ '*build*.js',
"       \ '*.json',
"       \ '*.min.*',
"       \ '*.map',
"       \ '*.bak',
"       \ '*.zip',
"       \ '*.pyc',
"       \ '*.class',
"       \ '*.csproj',
"       \ '*.tmp',
"       \ '*.csproj.user',
"       \ '*.cache',
"       \ '*.pdb',
"       \ 'tags*',
"       \ 'cscope.*',
"       \ '*.exe', '*.dll',
"       \ '*.mp3', '*.ogg', '*.flac',
"       \ '*.swp', '*.swo',
"       \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
"       \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
"       \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
"       \ ] 

" === fzf.vim ===
" Layout
let g:fzf_layout = { 'down': '~30%' }
" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" Syntax highlighting 
" Internally uses `bat`: Install using `brew install bat`
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Mappings
" Inspired by https://github.com/junegunn/fzf.vim/issues/563#issuecomment-486342795
" By default
" <C-t> tab split
" <C-x> split
" <C-v> vsplit
" Since I'm used to ctrl-p
nnoremap <C-p> :GFiles<CR> 
nnoremap <leader>fi :Files<CR>
nnoremap <C-b> :Buffers<CR>

" === vim-commentary ===
" https://github.com/tpope/vim-commentary/issues/15#issuecomment-23127749
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

" === NerdTree ===
nnoremap <leader>kl :NERDTreeToggle<CR>

" https://github.com/preservim/nerdtree/issues/817#issuecomment-373001775
let g:NERDTreeIgnore = ['^node_modules$', '^__pycache__$', '^.git$']

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" https://github.com/Xuyuanp/nerdtree-git-plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
let g:NERDTreeGitStatusUseNerdFonts = 1 
let g:NERDTreeGitStatusConcealBrackets = 1 

" === coc.vim ===
" coc config
let g:coc_global_extensions = [
      \ 'coc-snippets',
      \ 'coc-pairs',
      \ 'coc-tsserver',
      \ 'coc-eslint', 
      \ 'coc-prettier', 
      \ 'coc-json', 
      \ ]

" Setup Prettier
" https://github.com/neoclide/coc-prettier#usage
" Use :Prettier to format buffer
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Settings
set updatetime=300 " Having longer update times lead to poor UX
set shortmess+=c   " Don't pass messages to |ins-completion-menu|
set signcolumn=yes " Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.

" To make snippet completion work just like VSCode
" https://github.com/neoclide/coc.nvim/wiki/Using-snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <C-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion. 
" <C-g>u means break undo chain at current position
" Coc only does snippet and additional edit on confirm
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-q> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" Was <C-d>:: Conflicted with moving down
" Was <C-r>:: Conflicted with redo
nmap <silent> <C-q> <Plug>(coc-range-select)
xmap <silent> <C-q> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

