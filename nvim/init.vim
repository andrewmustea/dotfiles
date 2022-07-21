" nvim.init
"
# arch or debian runtime
#runtime! arch.vim
#runtime! debian.vim

" vim settings, keybindings, and functions
"
let g:is_bash = 1
filetype plugin indent off
set belloff=all
set cursorline
set diffopt=internal,filler,closeoff,vertical,hiddenoff
set expandtab
set history=1000
set hlsearch
set incsearch
set noshowmode
set number
set ruler
set shiftwidth=4
set showcmd
set showmatch
set smartcase
set smartindent
set spr
set tabstop=4
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set wildmenu
set wildmode=list:longest
set wrapscan

" python3 provider
let g:python3_host_prog = '/usr/bin/python3'

" split helpfiles vertically
augroup vert_help
    autocmd!
    autocmd BufEnter *.txt if &buftype == 'help' | wincmd H | endif
augroup END

" remove trailing whitepsace on save
function! StripTrailingWhitespace()
    if &binary || &ft =~# 'ruby\|javascript\|perl\|diff'
        return
    endif
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfunction

augroup strip_whitespace
    autocmd!
    autocmd BufWritePre * call StripTrailingWhitespace()
augroup end

" windows wsl clipboard
if has('wsl')
    let s:clip = '/mnt/c/Windows/System32/clip.exe'
    if executable(s:clip)
        augroup wsl_yank
            autocmd!
            autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        augroup END
    endif
endif

" search for visual selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>


" vim plug
"
call plug#begin(stdpath('data') . '/plugged')

" libraries
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
Plug 'kyazdani42/nvim-web-devicons'

" vim info
Plug 'dstein64/vim-startuptime'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/vim-peekaboo'
Plug 'nathom/filetype.nvim'

" text manipulation
Plug 'junegunn/vim-easy-align'
Plug 'matze/vim-move'
Plug 'numToStr/Comment.nvim'
Plug 'rstacruz/vim-closer'
Plug 'svermeulen/vim-subversive'
Plug 'svermeulen/vim-yoink'
Plug 'tpope/vim-unimpaired'

" movement and targets
Plug 'AndrewRadev/switch.vim'
Plug 'ggandor/leap.nvim'
Plug 'junegunn/vim-after-object'
Plug 'mg979/vim-visual-multi'
Plug 'phaazon/hop.nvim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'

" non-vscode plugins
if !exists('g:vscode')
    " file explorer
    Plug 'kyazdani42/nvim-tree.lua'

    " syntax higlighting
    Plug 'andrewmustea/black_sun'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
    Plug 'RRethy/nvim-treesitter-endwise'
    Plug 'pangloss/vim-javascript'
    Plug 'preservim/vim-markdown'
    Plug 'rust-lang/rust.vim'

    " status lines
    Plug 'akinsho/bufferline.nvim'
    Plug 'nvim-lualine/lualine.nvim'

    " git
    Plug 'tpope/vim-fugitive' " prerequisite
    Plug 'junegunn/gv.vim'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'samoshkin/vim-mergetool'

    " lsp
    Plug 'neovim/nvim-lspconfig'

    " code completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " fuzzy find
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'junegunn/fzf',
    Plug 'junegunn/fzf.vim'
    Plug 'ibhagwan/fzf-lua', {'branch': 'main'}

    " syntastic and linters
    Plug 'Kuniwak/vint'
    Plug 'folke/trouble.nvim'
    Plug 'scrooloose/syntastic'
    Plug 'syngan/vim-vimlint'
    Plug 'ynkdir/vim-vimlparser'

    " vimwiki
    Plug 'vimwiki/vimwiki'
endif

call plug#end()


" vim-after-object
"
augroup vim_after_object
    autocmd!
    autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')
augroup end


" vim-easy-align
"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" vim-yoink
"
let g:yoinkIncludeDeleteOperations = 1
let g:yoinkMaxItems = 50
let g:yoinkSavePersistently = 1


" lua init
"
lua require('init')


" non-vscode plugin settings
"
if !exists('g:vscode')
    " syntax highlighting
    "
    syntax on
    set termguicolors
    colorscheme black_sun
    command! ShowHighlights silent runtime syntax/hitest.vim
    command! HighlightGroup echo synIDattr(synID(line("."),col("."),1),"name")


    " bufferline.nvim
    "
    " These commands will navigate through buffers in order regardless of which mode you are using
    " e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
    nnoremap <silent>[b :BufferLineCycleNext<CR>
    nnoremap <silent>]b :BufferLineCyclePrev<CR>

    " These commands will move the current buffer backwards or forwards in the bufferline
    nnoremap <silent><mymap> :BufferLineMoveNext<CR>
    nnoremap <silent><mymap> :BufferLineMovePrev<CR>

    " These commands will sort buffers by directory, language, or a custom criteria
    " nnoremap <silent>be :BufferLineSortByExtension<CR>
    " nnoremap <silent>bd :BufferLineSortByDirectory<CR>
    " nnoremap <silent><mymap> :lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>

    " Buffer selection
    nnoremap <silent> gb :BufferLinePick<CR>

    nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
    nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
    nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
    nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
    nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
    nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
    nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
    nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
    nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>


    " coc.nvim
    "
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~? '\s'
    endfunction

    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()

    inoremap <silent><expr> <c-space> coc#refresh()

    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


    " syntastic
    "
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0
    let g:syntastic_aggregate_errors = 1
    let g:syntastic_id_checkers = 1

    let g:syntastic_asm_checkers = ['gcc']
    let g:syntastic_c_checkers = ['cppcheck', 'cppclean', 'flawfinder', 'gcc', 'make', 'oclint', 'sparse', 'splint']
    "cs
    let g:syntastic_cmake_checkers=['cmakelint']
    let g:syntastic_cpp_checkers = ['cppcheck', 'cppclean', 'cpplint', 'flawfinder', 'gcc', 'oclint']
    let g:syntastic_css_checkers = ['csslint', 'mixedindentlint', 'prettycss', 'stylelint']
    let g:syntastic_cuda_checkers = ['nvcc']
    let g:syntastic_go_checkers = ['go', 'gofmt']
    let g:syntastic_haskell_checkers = ['hlint', 'scan']
    let g:syntastic_html_checkers = ['eslint', 'tidy', 'htmlhint', 'jshint', 'proselint', 'stylelint', 'textlint', 'validator', 'w3']
    "java
    "javascript
    "json
    "less
    "llvm
    let g:syntastic_lua_checkers = ['luac', 'luacheck']
    let g:syntastic_markdown_checkers = ['mdl', 'proselint', 'remark_lint']
    "perl
    let g:syntastic_python_checkers = ['bandit', 'flake8', 'mypy', 'prospector', 'py3kwarn', 'pycodestyle', 'pydocstyle', 'pyflakes', 'pylama', 'pylint', 'python']
    "ruby
    let g:syntastic_sh_checkers = ['bashate', 'sh', 'shellcheck']
    "text
    "typescript
    "verilog
    "vhdl
    let g:syntastic_help_checkers=['proselint']
    let g:syntastic_vim_checkers=['vimlint', 'vint']
    let g:syntastic_vue_checkers=['eslint', 'stylelint']
    "xml
    "yaml
    "zsh

    let g:syntastic_mode_map = {
        \ 'mode': 'passive',
        \ 'active_filetypes': [],
        \ 'passive_filetypes': [] }

    let g:syntastic_cpp_cpplint_exec = 'cpplint'

    let g:syntastic_css_stylelint_args = '--config /usr/lib/node_modules/stylelint-config-standard/'
    let g:syntastic_html_stylelint_args = '--config ~/.config/stylelint/syntastic_html.json'
    let g:syntastic_vue_stylelint_args = '--config ~/.config/stylelint/syntastic_vue.json'

    "let g:syntastic_debug = 3
    let g:syntastic_debug_file = '~/.cache/syntastic/syntastic.log'

    function! LuacheckConfig()
        let s:luacheckrc = expand('%:p:h') . '/.luacheckrc'
        if filereadable(s:luacheckrc)
            let g:syntastic_lua_luacheck_args = '--config ' . s:luacheckrc
        endif
    endfunction

    augroup syntastic_settings
        autocmd!
        autocmd FileType lua call LuacheckConfig()
    augroup end
endif

