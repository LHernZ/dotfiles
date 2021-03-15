" Sets
set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set signcolumn=yes
set isfname+=@-@
set cmdheight=1
set updatetime=50
set shortmess+=c
set colorcolumn=80
set noshowmode

set clipboard=unnamed
set clipboard=unnamedplus

" Plugins
call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
" Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'

" CS
Plug 'morhetz/gruvbox'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'sbdchd/neoformat'
Plug 'mbbill/undotree'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ebkolev/tmuxline.vim'
call plug#end()

" Color Set
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'
set background=dark
colorscheme gruvbox

highlight ColorColumn ctermbg=0 guibg=grey
highlight Normal guibg=none
highlight LineNr guifg=#5eacd3
highlight netrwDir guifg=#5eacd3
highlight qfFileName guifg=#aed75f
hi TelescopeBorder guifg=#5eacd1

" SMH
if executable('rg')
    let g:rg_derive_root='true'
endif

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

" Maps
let loaded_matchparen = 1
let mapleader = " "

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>u :UndotreeToggle<CR>


let g:airline#extension#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline_theme='gruvbox'

augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
augroup END
