" My neovim config file

" === Plugins ===
call plug#begin('~/.vim/plugged')

" === brains ===
Plug 'neoclide/coc.nvim', { 'branch': 'release' }           " Intellisense engine for vim8 & neovim
Plug 'junegunn/fzf', { 'do': {-> fzf#install()} }           " Fuzzy text completion
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Nvim Treesitter configs and abstraction layers
Plug 'ludovicchabant/vim-gutentags'                         " A Vim plugin that manages your tag files

" === language specific ===
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}           " Go development plugin for vim
Plug 'HerringtonDarkholme/yats.vim'                         " TypeScript Syntax
Plug 'jackguo380/vim-lsp-cxx-highlight'                     " C++ syntax highlighting
Plug 'rhysd/vim-clang-format'                               " Vim plugin for clang-format
Plug 'kevinoid/vim-jsonc'                                   " Syntax highlighting for JSON w/ C-style comments
Plug 'Vimjas/vim-python-pep8-indent'

" === shortcuts ===
Plug 'christoomey/vim-tmux-navigator'                       " Navigation between tmux panes and vim splits
Plug 'tpope/vim-surround'                                   " Quoting / parenthesizing made simple
Plug 'tpope/vim-commentary'                                 " Comment out stuff: gcc to comment a line
Plug 'tpope/vim-fugitive'                                   " A Git wrapper 'so awesome, it should be illegal'
Plug 'junegunn/vim-easy-align'                              " A Vim alignment plugin
Plug 'jiangmiao/auto-pairs'

" === editor extensions ===
Plug 'ryanoasis/vim-devicons'                               " Add file-type icons to vim plugins
Plug 'lambdalisue/nerdfont.vim'                             " Handle Nerd fonts in Vim
Plug 'itchyny/lightline.vim'                                " Lightweight statusline
Plug 'mengelbrecht/lightline-bufferline'                    " Display buffers in lightline
Plug 'josa42/vim-lightline-coc'                             " Coc diagnostics indicator for lightline

" === themes ===
Plug 'Mofiqul/vscode.nvim', { 'branch': 'main' }            " Dark+ and Light+ theme as in Visual Studio Code
Plug 'joshdick/onedark.vim'                                 " Inspired by Atom's one dark syntax theme
Plug 'haishanh/night-owl.vim'                               " Night-owl theme by Sarah Drasner
Plug 'morhetz/gruvbox'                                      " Retro groove color scheme for vim
Plug 'patstockwell/vim-monokai-tasty'                       " Inspired by Sublime Text's interpretation of monokai

call plug#end()


" === general ===
let g:python3_host_prog = '/usr/local/bin/python3' " python for neovim
set encoding=utf-8
set splitbelow                                     " open horizontal splits at bottom
set splitright                                     " open vertical splits at right
" https://stackoverflow.com/a/30691754
set clipboard^=unnamed,unnamedplus
" https://github.com/neoclide/coc.nvim/issues/2063#issuecomment-642183675
set pumheight=10


" === visuals ===
if (has('termguicolors'))
  set termguicolors
endif
syntax enable  " enable syntax highlighting
set cursorline " highlighting that moves with the cursor
if !has('gui_running')
  set t_co=256
endif

" Setup colors based on iTerm2 profile
if $ITERM_PROFILE ==# 'Gruvbox'
  " https://github.com/morhetz/gruvbox/wiki/configuration
  let g:gruvbox_contrast_dark='medium'
  colorscheme gruvbox
  let LIGHTLINE_COLORSCHEME='seoul256'
elseif $ITERM_PROFILE ==# 'Monokai' || $ITERM_PROFILE ==# 'Iosevka Monokai'
  colorscheme vim-monokai-tasty
  let LIGHTLINE_COLORSCHEME='monokai_tasty'
elseif $ITERM_PROFILE ==# 'Iosevka'
  let g:vscode_style = 'dark'
  colorscheme vscode 
  let LIGHTLINE_COLORSCHEME='wombat'
elseif $ITERM_PROFILE ==# 'Iosevka Light'
  let g:vscode_style = 'light'
  colorscheme vscode
  let LIGHTLINE_COLORSCHEME='ayu_light'
else 
  colorscheme onedark
  let LIGHTLINE_COLORSCHEME='onedark'
endif


" === spacing & indentation ===
" adapted from https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
" enable filetype plugins
filetype plugin indent on

" configure backspace so it acts as it should act
set backspace=indent,eol,start confirm
set whichwrap+=<,>,h,l

set lbr          " linebreak on 500 characters
set tw=250
set ai           " auto indent
set si           " smart indent
set wrap         " wrap lines
set expandtab    " use spaces instead of tab
set smarttab     " be smart when using tabs :)


" === Language specific settings ===
" Use JSON with comments instead of JSON
" autocmd BufRead,BufNewFile *.json set filetype=jsonc

" https://joshtronic.com/2016/08/21/set-vim-tab-spacing-based-on-the-type-of-file/
autocmd FileType go setlocal tabstop=4 shiftwidth=4

" Google .clang-format
autocmd FileType c setlocal ts=2 sw=2 sts=2

autocmd FileType java setlocal ts=2 sw=2 sts=2

" https://www.reddit.com/r/golang/comments/unc7a/comment/c4ww8p8
" au BufNewFile,BufRead *.go  setlocal noet ts=4 sw=4 sts=4
" au BufNewFile,BufRead *.rs  setlocal noet ts=4 sw=4 sts=4


" === line numbering ===
set number


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
set wildignore=*.o,*.obj                                                     
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
      \ echohl warningmsg | echo 'file changed on disk. buffer reloaded.' | echohl none


" === scrolling ===
set scrolloff=8 " start scrolling when we're 8 lines away from margins


" === performance ===
set lazyredraw " fix slow scrolling that occurs when using mouse and relative numbers


" === major keyboard bindings ===
let mapleader = " "
let maplocalleader = ","  " https://github.com/jalvesaq/nvim-r/issues/101#issuecomment-242395913 
:nmap <space> :

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


" === fix annoyances ===
" to auto-close the method-preview window
autocmd insertleave,completedone * if pumvisible() == 0 | pclose | endif
" diable auto-comment
" https://vim.fandom.com/wiki/disable_automatic_comment_insertion
autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" === misc ===
" open this file: vim-options 
nnoremap <leader>vo :e ~/.config/nvim/init.vim<cr>
" reload config file 
nnoremap <c-s> :w<cr>:source ~/.config/nvim/init.vim<cr>

" === plugin settings ===

" === tmux ===
" write all buffers before navigating from vim to tmux pane
let g:tmux_navigator_save_on_switch = 2


" === vim-go ===
" disable vim-go's :GoDef short cut
" This is done by CoC's gd
let g:go_def_mapping_enabled = 0

" see - https://tpaschalis.github.io/vim-go-setup/
let g:go_fmt_command = 'goimports'    " run goimports along gofmt on each save
let g:go_fmt_autosave = 1
let g:go_auto_type_info = 1           " automatically get signature/type info for object under cursor

" https://github.com/golang/tools/blob/master/gopls/doc/vim.md#cocnvim
" autocmd BufWritePre *.go :call CocActionAsync('runCommand', 'editor.action.organizeImport')


" === Lightline ===
set laststatus=2
set noshowmode
set showtabline=2

let g:lightline = {
  \ 'colorscheme': LIGHTLINE_COLORSCHEME,
  \ 'active': {
    \ 'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ], ['coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], [ 'coc_status'  ]],
    \ 'right': [ ['percent'], ['lineinfo'], ['filetypewithicon'], ['gutentags'], ],
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
    \ 'right': [[]], 
  \ },
  \ 'component_function': {
    \ 'gitbranch': 'GitBranch',
    \ 'gutentags': 'gutentags#statusline',
    \ 'filename': 'LightlineTruncatedFileName',
    \ 'filetypewithicon': 'FileTypeWithIcon',
  \},
  \ 'component_expand':{
    \ 'buffers': 'lightline#bufferline#buffers',
  \},
  \ 'component_type': {
    \ 'buffers': 'tabsel',
  \},
\}

" https://github.com/itchyny/lightline.vim/issues/416
function! FileTypeWithIcon() 
  let filetype_with_icon = &filetype !=# '' ? &filetype : 'no ft'
  return winwidth(0) > 70 ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : ' '
endfunction

" https://github.com/itchyny/lightline.vim/issues/594
function! GitBranch() 
  let head=FugitiveHead()

  if head ==# ""
    return head
  else
    return " " . FugitiveHead()
  endif
endfunction

" https://github.com/itchyny/lightline.vim/issues/532
function! LightlineTruncatedFileName()
  let l:filePath = expand('%')
  if winwidth(0) > 100
    return l:filePath
  else
    return pathshorten(l:filePath)
  endif
endfunction

" Register components
call lightline#coc#register()

autocmd VimEnter * call SetupLightlineColors()
function SetupLightlineColors() abort
  " transparent background in statusbar
  let l:palette = lightline#palette()

  let l:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:palette.inactive.middle = l:palette.normal.middle
  let l:palette.tabline.middle = l:palette.normal.middle

  call lightline#colorscheme()
endfunction

" if you're adding the buffers to the bottom status bar, the `modified` 
" indicator will not be updated immediately. to work around this ->
autocmd bufwritepost,textchanged,textchangedi * call lightline#update()

" === lightline-bufferline ===
let g:lightline#bufferline#unnamed = '[no name]'
let g:lightline#bufferline#show_number = 2 
let g:lightline#bufferline#shorten_path = 1 
let g:lightline#bufferline#smart_path = 0
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#enable_nerdfont = 1
let g:lightline#bufferline#unicode_symbols = 1

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


" === Easy Align ===
" https://github.com/junegunn/vim-easy-align#quick-start-guide
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" === Tree-sitter === 
" https://github.com/nvim-treesitter/nvim-treesitter
" All modules are disabled by default and need to be activated explicitly in your init.vim
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = 'maintained',
  ignore_install = { },
  -- "Consistent sytax highlighting"
  highlight = {
    -- false will disable the whole extension
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false
  },
  -- Incremental Selection
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
}
EOF


" === GutenTags ===
" From https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
" Configure what a 'new project' means for gutentags
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git', 'Makefile']

" To avoid adding tags and tags.lock to the .gitignore every single project configure it outside
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')

" Exclude certain files that are temporary
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']

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

" Gutentags + Lightline 
augroup mygutentagsstatuslinerefresher
  autocmd!
  autocmd user gutentagsupdating call lightline#update()
  autocmd user gutentagsupdated call lightline#update()
augroup end


" === fzf.vim ===
" Layout
" Default is a floating window. Uncomment to change. ~ https://stackoverflow.com/a/63912546
" let g:fzf_layout = { 'down': '~30%' }

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

" Since I'm used to ctrl-p
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>fi :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-f> :Rg<CR>

" options
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1


" === vim-commentary ===
" https://github.com/tpope/vim-commentary/issues/15#issuecomment-23127749
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s


" === coc.vim ===
" coc config
let g:coc_global_extensions = [
      \ 'coc-snippets',
      \ 'coc-pairs',
      \ 'coc-tsserver',
      \ 'coc-eslint', 
      \ 'coc-prettier', 
      \ 'coc-json', 
      \ 'coc-rust-analyzer',
      \ 'coc-pyright',
      \ ]

" Setup Prettier
" https://github.com/neoclide/coc-prettier#usage
" Use :Prettier to format buffer
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Settings
" https://ianding.io/2019/07/29/configure-coc-nvim-for-c-c++-development/
" if hidden is not set, TextEdit might fail
set hidden
set cmdheight=1
" Having longer update times lead to poor UX
set updatetime=300
" Don't pass messages to |ins-completion-menu|
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
set signcolumn=yes

" Use <CR> to confirm completion
" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-cr-to-confirm-completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <Tab> to trigger completion
" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-tab-or-custom-key-for-trigger-completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Use <C-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

let g:coc_snippet_next = '<tab>'

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)

" Remap keys for gotos
" Open definition in new tab
nmap <silent> gd <Plug>(coc-definition)
" https://github.com/neoclide/coc.nvim/issues/1249
" Open definition in new vertical split
nmap <silent> gs :vsp<CR><Plug>(coc-definition)

nmap <silent> gr <Plug>(coc-references)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)

" Show documentation in preview window
nnoremap <silent> gw :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap cr <Plug>(coc-rename)

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


" === vim-lsp-cxx-highlight ===
" refer https://chmanie.com/post/2020/07/17/modern-c-development-in-neovim/
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

