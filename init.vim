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

Plug 'voldikss/vim-floaterm'

Plug 'ThePrimeagen/vim-be-good'

Plug 'onsails/lspkind-nvim'

" tree
Plug 'kyazdani42/nvim-web-devicons'

Plug 'mattn/emmet-vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}

Plug 'ayu-theme/ayu-vim'

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

nmap <leader>py <Plug>(prettier)

vnoremap <leader>p "_dP

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d


let g:airline#extension#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline_theme='gruvbox'

let g:user_emmet_leader_key='<C-Z>'
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

let cpwd = getcwd()

nnoremap <leader>tn :FloatermNew --height=0.6 --width=0.5 --name=FileManager nnn `cpwd` <CR>
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

autocmd VimEnter * FloatermNew! --silent
augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
augroup END
