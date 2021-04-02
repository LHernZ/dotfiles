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
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'sbdchd/neoformat'
Plug 'mbbill/undotree'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

Plug 'vim-utils/vim-man'
Plug 'vuciv/vim-bujo'

Plug 'ThePrimeagen/vim-be-good'

Plug 'onsails/lspkind-nvim'

" tree
Plug 'kyazdani42/nvim-web-devicons'

" WIP
Plug '~/dotfiles/nvim-image-previewer/'
call plug#end()

lua require("apex")

" Color Set
set pastetoggle=<F3>

" SMH
if executable('rg')
    let g:rg_derive_root='true'
endif

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

" Maps
let loaded_matchparen = 1
let mapleader = " "

nnoremap <leader>pv :Ex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>rp :resize 100<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>u :UndotreeShow<CR>

vnoremap <leader>p "_dP

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d


let g:airline#extension#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline_theme='gruvbox'

" vim TODO
nmap <Leader>tu <Plug>BujoCheckNormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

" to fix cursor shape in WSL bash add 
" echo -ne "\e[2 q"
" to .bashrc
if &term =~ "xterm"
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[2 q"
endif

augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
augroup END
