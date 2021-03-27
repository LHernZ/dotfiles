local sumneko_root_path = '/home/apex/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"

local on_attach = require'completion'.on_attach
require'lspconfig'.tsserver.setup{ on_attach = on_attach }

require'lspconfig'.pyls.setup{ on_attach = on_attach }

require'lspconfig'.sumneko_lua.setup{
    on_attach = on_attach,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                version = "Lua 5.3",
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
}

