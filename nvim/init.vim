" nvim.init
"
# arch or debian runtime
#runtime! arch.vim
#runtime! debian.vim

" settings
"
filetype plugin indent on
set belloff=all
set cursorline
set expandtab
set diffopt=internal,filler,closeoff,vertical,hiddenoff
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


" vim plug
"
call plug#begin(stdpath('data') . '/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'andrewmustea/black_sun'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/syntastic'
Plug 'godlygeek/tabular'
Plug 'pangloss/vim-javascript'
Plug 'preservim/vim-markdown'
Plug 'valloric/youcompleteme'
Plug 'syngan/vim-vimlint'
Plug 'ynkdir/vim-vimlparser'
Plug 'Kuniwak/vint'
Plug 'bfrg/vim-cpp-modern'
Plug 'samoshkin/vim-mergetool'
Plug 'editorconfig/editorconfig-vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nathom/filetype.nvim'
call plug#end()


" lua
"
lua require('init')


" syntax colors
"
syntax on
set termguicolors
colorscheme black_sun


" python3
"
let g:python3_host_prog = '/usr/bin/python3'


" functions
"
" remove whitepsace on save
function! StripTrailingWhitespace()
    if &binary || &ft =~# 'ruby\|javascript\|perl\|diff'
        return
    endif
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfunction

augroup amustea
    autocmd!
    autocmd BufWritePre * call StripTrailingWhitespace()
augroup end

" windows wsl clipboard
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif


" airline
"
let g:airline_theme='black_sun'


" syntastic
"
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_id_checkers = 1

"let g:syntastic_debug = 3
"let g:syntastic_debug_file = '~/.vim/syntastic.log'

let g:syntastic_asm_checkers = ['gcc']
let g:syntastic_c_checkers = ['cppcheck', 'cppclean', 'flawfinder', 'gcc', 'make', 'oclint', 'sparse', 'splint']
let g:syntastic_cmake_checkers=['cmakelint']
let g:syntastic_cpp_checkers = ['cppcheck', 'cppclean', 'cpplint', 'flawfinder', 'gcc', 'oclint']
let g:syntastic_cuda_checkers = ['nvcc']
let g:syntastic_go_checkers = ['go', 'gofmt']
"haskell
"HTML
"Java
"JavaScript
"JSON
let g:syntastic_lua_checkers = ['luac', 'luacheck']
let g:syntastic_markdown_checkers=['mdl', 'proselint', 'remark_lint']
let g:syntastic_python_checkers = ['bandit', 'flake8', 'mypy', 'prospector', 'py3kwarn', 'pycodestyle', 'pydocstyle', 'pyflakes', 'pylama', 'pylint', 'python']
let g:syntastic_sh_checkers=['bashate', 'sh', 'shellcheck', 'shfmt']
"text
"TypeScript
let g:syntastic_help_checkers=['proselint']
let g:syntastic_vim_checkers=['vimlint', 'vint']
"xml
"yaml
"zsh

let g:syntastic_mode_map = {
    \ 'mode': 'passive',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': [] }

let g:syntastic_cpp_cpplint_exec = "cpplint"


" vim-cpp-modern
"
" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 1

