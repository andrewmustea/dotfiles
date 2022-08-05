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
set ignorecase
set incsearch
set noshowmode
set number
set ruler
set shiftwidth=4
set showcmd
set showmatch
set smartcase
set smartindent
set splitright
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
    if &binary || &filetype =~# 'ruby\|javascript\|perl\|diff'
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

    " linting
    Plug 'dense-analysis/ale'
    " Plug 'folke/trouble.nvim'

    " vimwiki
    Plug 'vimwiki/vimwiki'
endif

call plug#end()


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


" vscode keybindings and finish
"
if exists('g:vscode')
    nnoremap <C-w>J <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
    xnoremap <C-w>J <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
    nnoremap <C-w>K <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
    xnoremap <C-w>K <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
    nnoremap <C-w>H <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
    xnoremap <C-w>H <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
    nnoremap <C-w>L <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
    xnoremap <C-w>L <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

    finish
endif


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
let g:coc_global_extensions = ['coc-clangd', 'coc-clang-format-style-options', 'coc-cmake', 'coc-css',
                          \    'coc-diagnostic', 'coc-eslint', 'coc-explorer', 'coc-fzf-preview', 'coc-git',
                          \    'coc-go', 'coc-golines', 'coc-highlight', 'coc-html', 'coc-htmlhint',
                          \    'coc-html-css-support', 'coc-java', 'coc-jedi', 'coc-json', 'coc-lists',
                          \    'coc-markdownlint', 'coc-markdown-preview-enhanced', 'coc-markmap', 'coc-perl',
                          \    'coc-prettier', 'coc-pydocstring', 'coc-pyright', 'coc-python', 'coc-rls',
                          \    'coc-rome', 'coc-rust-analyzer', 'coc-sh', 'coc-stylelintplus', 'coc-stylelint',
                          \    'coc-snippets', 'coc-sql', 'coc-tsserver', 'coc-vimlsp', 'coc-xml', 'coc-yaml',
                          \    'coc-yank']

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" <c-space> triggers completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction


" ale
"
let g:ale_disable_lsp = 1
let g:ale_lint_on_text_changes = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_lint_on_enter =1

