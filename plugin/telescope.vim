lua require("apex")

nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>

nnoremap <leader>vrc :lua require('apex.telescope').search_dotfiles()<CR>
nnoremap <leader>bg :lua require('apex.telescope').set_bg()<CR>
nnoremap <leader>be :lua require('apex.telescope').custom()<CR>
nnoremap <leader>te :lua require('telescope').extensions.nvim_image_previewer.nvim_image_previewer()<CR>
