local actions = require('telescope.actions')

local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local previewers = require('telescope.previewers')
require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case'
        },
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' >',
        color_devicons = true,
        set_env = { ['COLORTERM'] = 'truecolor' },

        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep_new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist_new,

        mappings = {
            i = {
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
    print(vim.fn.system("python3 ~/dotfiles/bg_changer.py " .. content))
end

function M.custom(opts)
    function select_background2(prompt_bufnr, map)
        function set_the_background(close)
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
    local filetypes = {"png", "jpg", "jpeg"}
    local find_command = {
        rg = {
            'rg',
            '--files',
            '--glob',
            [[*.{]]..table.concat(filetypes,",") .. [[}]],
            '/home/apex/dotfiles/Terminal/'
        }
    }
    pickers.new {
        prompt_title = 'Custom',
        finder = finders.new_oneshot_job(
            find_command["rg"],
            opts
        ),
        sorter = sorters.get_fuzzy_file(),
        attach_mappings = function(prompt_bufnr, map)
            select_background2(prompt_bufnr, map)
            return true
        end,
        previewer = previewers.new_termopen_previewer {
            get_command = function(entry)
                local tmp_table = vim.split(entry.value,"\t");
                return {
                    'viu',
                    string.format([[%s]],tmp_table[1])
                }
            end
        }
    }:find()
end

--M.set_bg = image_selector("< Webs > ", "~/dotfiles/Terminal")

return M
