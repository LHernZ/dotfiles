local has_telescope, telescope = pcall(require, "telescope")

-- TODO: make dependency errors occur in a better way
if not has_telescope then
  error("This plugin requires telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)")
end

local utils = require('telescope.utils')
local defaulter = utils.make_default_callable
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local conf = require('telescope.config').values

local M = {}



local filetypes = {}
local find_cmd = " viu"

M.base_directory="/home/apex/dotfiles/Terminal/"
M.media_preview = defaulter(function(opts)
    return previewers.new_termopen_previewer {
        get_command = opts.get_command or function(entry)
            local tmp_table = vim.split(entry.value,"\t");
            local preview = opts.get_preview_window()
            if vim.tbl_isempty(tmp_table) then
                return {"echo", ""}
            end
            return {
                'viu' ,
                string.format([[%s]],tmp_table[1])
            }
        end
    }
end, {})

function M.image_files(opts)
    local find_command = {
        rg = {
          'rg',
          '--files',
          '--glob',
          [[*.{]]..table.concat(filetypes,",") .. [[}]],
          M.base_directory 
        }
    }

    local sourced_file = require('plenary.debug_utils').sourced_filepath()
    --M.base_directory = vim.fn.fnamemodify(sourced_file, ":h:h:h:h")
    print(M.base_directory)
    opts = opts or {}
    opts.attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
            local entry = action_state.get_selected_entry(prompt_bufnr)
            actions.close(prompt_bufnr)
            if entry[1] then
                local filename = entry[1]
                local cmd = "call setreg(v:register,'"..filename.."')";
                vim.cmd(cmd)
                print("The image path has been copied!")
            end
        end)
        return true
    end
    opts.shorten_path = true

    local popup_opts={}
    opts.get_preview_window = function ()
        return popup_opts.preview
    end

    local picker = pickers.new(opts, {
        prompt_title = 'Images',
        finder = finders.new_oneshot_job(
            find_command[find_cmd],
            opts
        ),
        previewer = M.media_preview.new(opts),
        sorter = conf.file_sorter(opts),
    })

    local line_count = vim.o.lines - vim.o.cmdheight
    if vim.o.laststatus ~= 0 then
        line_count = line_count -1
    end
    popup_opts = picker:get_window_options(vim.o.columns, line_count)
    picker:find()
end

return require('telescope').register_extension {
    setup = function(ext_config)
        filetypes = ext_config.filetypes or {"png", "jpg"}
        find_cmd = ext_config.find_cmd or "rg"
    end,
    exports = {
        nvim_image_previewer = M.image_files
    },
}
