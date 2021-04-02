local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' >',
        color_devicons = true,

        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep_new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist_new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = {"png", "webp", "jpg", "jpeg"},
          find_cmd = "rg" -- find command (defaults to `fd`)
        },
        nvim_image_previewer = {
        }
    }
}

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('media_files')
require('telescope').load_extension('nvim_image_previewer')

local M = {}
M.search_dotfiles = function ()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = "$HOME/dotfiles/",
    })
end

function set_background(content)
    --print(vim.fn.system("python3 ~/dotfiles/bg_changer.py " .. content))
    print('Hey')
end

local function select_background(prompt_bufnr, map)
    local function set_the_background(close)
        local content = 
        require('telescope.actions.state').get_selected_entry(prompt_bufnr)
        set_background(content.value)
        if close then
            require('telescope.actions').close(prompt_bufnr)
        end
    end

    map('i', '<C-p>', function()
        set_the_background()
    end)

    map('i', '<CR>', function()
        set_the_background(true)
    end)
end

local function image_selector(prompt, cwd)
    return function()
        require('telescope').extensions.nvim_image_previewer.nvim_image_previewer({
            prompt_title = prompt,
            cwd = cwd,

            attach_mappings = function(prompt_bufnr, map)
                select_background(prompt_bufnr, map)
                return true
            end
        })
    end
end

M.set_bg = image_selector("< Webs > ", "~/dotfiles/Terminal")

return M
