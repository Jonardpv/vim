filetype off
set nocompatible
" set the runtime path to include Vundle and initialize
set rtp+=$HOME/vimfiles/bundle/Vundle.vim
let path='$HOME/vimfiles/bundle'
call vundle#rc(path)
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'fugitive.vim'
Plugin 'vim-perl/vim-perl'
Plugin 'mbudde/mojo.vim'
Plugin 'molokai'
Plugin 'zefei/vim-wintabs'
Plugin 'tabular'
Plugin 'tagbar'
Plugin 'Indent-Guides'
Plugin 'surround.vim'
Plugin 'vim-latex/vim-latex'
Plugin 'unimpaired.vim'
Plugin 'Syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'honza/vim-snippets'
Plugin 'justinmk/vim-sneak'
Plugin 'rodjek/vim-puppet'
Plugin 'ingydotnet/yaml-vim'
Plugin 'The-NERD-tree'
Plugin 'PProvost/vim-ps1'
Plugin 'ludovicchabant/vim-gutentags'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on
set background=dark
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

au FileType xhtml set filetype=html
au BufReadPost '*.ezt' set filetype=html
au BufReadPost '*.html.ep' set filetype=html

if !has("gui_running")
    colorscheme kraihlight
    set t_Co=256
elseif has("gui_running")
    colorscheme kraihlight
    highlight Pmenu guibg=brown gui=bold
    set lines=24 columns=85
    set guioptions-=T
    set mousemodel=popup
    set guifont=Consolas:h12:cANSI:qDRAFT
end

if &term == "xterm-color"
    set t_kb=
    fixdel
endif

hi Pmenu ctermfg=white ctermbg=darkgrey guifg=white guibg=grey60
hi PmenuSel ctermfg=black ctermbg=lightgrey guifg=grey60 guibg=white
" Tabstops are 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
set autoindent

set ofu=syntaxcomplete#Complete
set completeopt=longest,menuone
set formatoptions=rq
set list
set listchars=tab:▸\ ,eol:¬,trail:·,extends:»,precedes:«,nbsp:×

" Printing options
set printoptions=header:0,duplex:long,paper:A4

" set the search scan to wrap lines
set wrapscan

" if there are caps, go case-sensitive
set smartcase

" Make command line two lines high
set ch=1

" No visual bell, no beeping
set novisualbell " don't blink

" Allow backspacing over indent, eol, and the start of an insert
set backspace=indent,eol,start

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2
" Set the status line the way i like it
"set stl=%{HasPaste()}%f%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set statusline=%{HasPaste()}%t%y%m%r%h\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]\ %{fugitive#statusline()}\ Buf:#%n%=Line:%l/%L[%p%%]\ Col:%v\ [%b][0x%B]

function! HasPaste()
    if &paste
        return 'PASTE MODE '
    else
        return ''
    endif
endfunction

set mouse=a
set mousehide

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" Make the command-line completion better
set wildmenu
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
set wildmode=list:longest,full

" Set the textwidth to be 80 chars
set textwidth=80

" leave my cursor where it was
set nostartofline

set number
set relativenumber

:au FocusLost * :set number
:au FocusGained * :set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" We are good up to 99999 lines
set numberwidth=5

set ruler " Always show current positions along the bottom
set scrolloff=2 " Keep 2 lines at the top/bottom
set sidescrolloff=2 " Keep 2 lines at the size

" get rid of the silly characters in separators
set fillchars = ""

" Add ignorance of whitespace to diff
set diffopt+=iwhite

" Disable search highlighting
set nohlsearch

" Incrementally match the search
set incsearch

" Add the unnamed register to the clipboard
set clipboard+=unnamed

" Automatically read a file that has changed on disk
set autoread

set shortmess=aOstT " shortens messages to avoid 'press a key' prompt
set showcmd " show the command being typed
set showmatch " show matchingbrackets
set ignorecase " case insensitive by default

set noautochdir

" Setting up the directories
function! InitializeDirectories()
    let separator = "."
    let parent = $HOME
    let prefix = '.vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    for [dirname, settingname] in items(dir_list)
        let directory = parent . '/' . prefix . dirname . "/"
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()
set backup

" paste mode - this will avoid unexpected effects when you
" cut or copy some text from one window and paste it in Vim.
set pastetoggle=<F10>
map <F9> ToggleMouse

map <MouseMiddle> <esc>"*p
" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

"map ; :
"nnoremap ;; ;

let mapleader = ","
let g:mapleader = ","

nmap <leader>w :w!<CR><esc>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" line tracking
"set numberwidth=5
"set cursorline
"set cursorcolumn

" Underline the current line with '='
nmap <silent> ,u= :t.\|s/./=/g\|:nohls<CR>
nmap <silent> ,u- :t.\|s/./-/g\|:nohls<CR>

" Underline the current line with dashes in normal mode
nnoremap <F5> yyp<c-v>$r-

" Underline the current line with dashes in insert mode
inoremap <F5> <Esc>yyp<c-v>$r-A


" If I write vimrc then reload
au! BufWritePost vimrc source %
map <leader>e :e! ~/vimfiles/vimrc<cr>

map <leader>t2 :setlocal shiftwidth=2<CR>
map <leader>t4 :setlocal shiftwidth=4<CR>
map <leader>t8 :setlocal shiftwidth=8<CR>

" Yank/paste to the OS clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+P

" Tabularize
map <leader>t&  :Tabularize /&<CR>
map <leader>t=  :Tabularize /=<CR>
map <leader>th  :Tabularize /=><CR>
map <leader>t:  :Tabularize /:<CR>
map <leader>t:: :Tabularize /:\zs<CR>
map <leader>t,  :Tabularize /,<CR>
map <leader>t\| :Tabularize /\|<CR>
command! -nargs=1 -range TabFirst exec <line1> . ',' . <line2> . 'Tabularize /^[^' . escape(<q-args>, '\^$.[?*~') . ']*\zs' . escape(<q-args>, '\^$.[?*~')

" Fugitive Shortcuts
map <leader>s :Gstatus<CR>
map <leader>gp :Git push<CR>

" Turn on indent-guides
autocmd VimEnter * IndentGuidesEnable
let g:indent_guides_guide_size=1

" Comment/uncomment blocks of code
map <leader>c :s/^/# /<CR>
map <leader>C :s/^# //<CR>

" Enable bubbling
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Gist options - put code in clipboard
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let gist_show_privates = 1
let gist_post_private = 1

" Mojolicious
let mojo_highlight_data = 1
let mojo_disable_html = 1
"let mojo_no_helpers = 0

" dont use Q for Ex mode
map Q :q

" Tagbar
map <F7> <Esc>:NERDTreeToggle<CR>
map <F8> <Esc>:TagbarToggle<CR>

nmap th :set hls!:set hls?

" Enable indent folding
set nofoldenable
set fdm=indent

" Set space to toggle a fold
nnoremap <space> za

" Python code competion
autocmd FileType python set omnifunc=pythoncomplete#Complete

" check perl code with :make
autocmd FileType perl set makeprg=perl\ -c\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m
autocmd FileType perl set autowrite

" my perl includes pod
let perl_include_pod = 1

" syntax color complex things like @{${"foo"}}
let perl_extended_vars = 1

" Tidy selected lines (or entire file) with _t:
nnoremap <silent> _t :%!perltidy -q<Enter>
vnoremap <silent> _t :!perltidy -q<Enter>
set keywordprg=perldoc\ -f "K

" Reset autocommands
:autocmd!

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite *.cpp,*.c,*.h,*.pl,*.pm,*.py,*.rb,*.txt if ! &bin | silent! %s/\s\+$//ge | endif

function! ToggleMouse()
    if &mouse == 'a'
        set mouse=
        set nonumber
        echo "Mouse usage disabled"
    else
        set mouse=a
        set number
        echo "Mouse usage enabled"
    endif
endfunction

" Vim LaTeX
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:Tex_ViewRule_pdf='xpdf'

" ctrlp
"let g:ctrlp_map = '<leader>cp'
let g:ctrlp_map = '<c-f>'
map <c-b> :CtrlPBuffer<cr>
map <leader>j :CtrlP<cr>
map <leader>cp :CtrlP<CR>
map <leader>cs :CtrlP ~/source<CR>
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_height = 20
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" UltiSnips
" let g:UltiSnipsExpandTrigger="<c-j>"
"let g:UltiSnipsJumpForwardTrigger   = /'<c-j>'
"let g:UltiSnipsJumpBackwardTrigger  = '<c-k>'
"let g:UltiSnipsExpandTrigger       = '<tab>'
"let g:UltiSnipsJumpForwardTrigger  = '<tab>'
"let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"let g:UltiSnipsSnippetDirectories  = ['snips']
"let g:UltiSnipsListSnippets        = '<c-e>'
"let g:UltiSnipsEditSplit           = 'vertical'

" NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <silent> <Leader>f :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 0
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeChDirMode = 2
let NERDTreeMouseMode = 1


"autocmd FileType nerdtree cnoreabbrev <buffer> bd <nop>
" close tab if NERDTree is last window
"autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTreeType') && b:NERDTreeType == 'primary') | q | endif

nmap <leader>to :tabnew<CR>
nmap <leader>tn :tabnext<CR>
nmap <leader>tp :tabprevious<CR>

" Wintabs
noremap <C-right> :WintabsNext<CR>
noremap <C-left> :WintabsPrevious<CR>
nmap <leader>bd :WintabsClose<CR>
nmap <leader>bo :WintabsOnly<CR>
nmap <leader>bwc :WintabsCloseWindow<CR>
nmap <leader>bwo :WintabsOnlyWindow<CR>
nmap <leader>btc :WintabsCloseVimtab<CR>
nmap <leader>bto :WintabsOnlyVimtab<CR>
map <C-H> <Plug>(wintabs_previous)
map <C-L> <Plug>(wintabs_next)
map <C-T>c <Plug>(wintabs_close)
map <C-T>o <Plug>(wintabs_only)
map <C-W>c <Plug>(wintabs_close_window)
map <C-W>o <Plug>(wintabs_only_window)
command! Tabc WintabsCloseVimtab
command! Tabo WintabsOnlyVimtab

