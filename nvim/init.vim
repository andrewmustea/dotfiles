set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

runtime! debian.vim

" python3
let g:python3_host_prog = '/usr/bin/python3'

" Source a global configuration file if available
if filereadable('/etc/vim/vimrc.local')
  source /etc/vim/vimrc.local
endif

filetype plugin indent on
syntax on
set belloff=all
set cursorline
set expandtab
set history=1000
set hlsearch
set incsearch
set number
set ruler
set shiftwidth=4
set showcmd
set showmatch
set showmode
set smartcase
set tabstop=4
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set wildmenu
set wildmode=list:longest
set wrapscan

let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" remove trailing whitespace
fun! StripTrailingWhitespace()
    " Don't strip on these filetypes
    if &ft =~# 'ruby\|javascript\|perl'
        return
    endif
    %s/\s\+$//e
endfun

augroup amustea
    autocmd!
    autocmd BufWritePre * call StripTrailingWhitespace()
augroup end

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has('syntax')
  syntax on
endif

" vim plug
call plug#begin(stdpath('data') . '/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'valloric/youcompleteme'
Plug 'andrewmustea/black_sun'
Plug 'syngan/vim-vimlint'
Plug 'ynkdir/vim-vimlparser'
Plug 'Kuniwak/vint'
" Initialize plugin system
call plug#end()

" colors
set termguicolors
colorscheme black_sun

" airline theme
let g:airline_theme='black_sun'

" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_id_checkers = 1

"let g:syntastic_debug = 3
"let g:syntastic_debug_file = '~/.vim/syntastic.log'

let g:syntastic_sh_checkers=['bashate', 'checkbashisms', 'sh', 'shellcheck', 'shfmt']
let g:syntastic_vim_checkers=['vimlint', 'vint']

let g:syntastic_mode_map = {
    \ 'mode': 'passive',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': [] }

