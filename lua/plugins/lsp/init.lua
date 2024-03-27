---@diagnostic disable: missing-fields
-- Set up nvim-cmp.
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

-- Icons, most are from codicons, just personal preference
local icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰆧",
    Constructor = "",
    Field = "",
    Variable = "󰀫",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "", -- ? What is this even
    Value = "󰎠", -- ?
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "", -- ?
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "",
}

local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- preselect is effectively an endorsement by the lsp. So use it.
local compare_preselect = function(e1, e2)
    if e1.completion_item.preselect ~= e2.completion_item.preselect then
        return e1.completion_item.preselect
    end
    return nil
end

cmp.setup({
    window = {
        completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
        },
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            cmp.config.compare.score,
            cmp.config.compare.exact,
            --compare_preselect,
            cmp.config.compare.recently_used,
            --cmp.config.compare.length,
            cmp.config.compare.locality,
            cmp.config.compare.offset,
            cmp.config.compare.order,
            cmp.config.compare.kind,
        },
    },

    preselect = cmp.PreselectMode.None,
    formatting = {
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },

        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- The icon
            local icon = require("lspkind").cmp_format({ mode = "symbol", maxwidth = 50, symbol_map = icons })(entry,
                vim_item).kind
            vim_item.kind = icon

            -- The label
            vim_item.abbr = entry.completion_item.label

            local client_name = ""
            if entry.source.source ~= nil and entry.source.source.client ~= nil then
                client_name = entry.source.source.client.name
            end

            if client_name == "rust_analyzer" then
                vim_item = require 'plugins.lsp.rust_analyzer'.completion_format(entry, vim_item)
            elseif client_name == "clangd" then
                vim_item = require 'plugins.lsp.clangd'.completion_format(entry, vim_item)
            end


            -- Some java stuff
            --if entry.source.name == "jdtls" then
            --    if strings[2] == "Constructor" then
            --        kind.abbr = entry.completion_item.label .. entry.completion_item.labelDetails.detail;
            --    else
            --        kind.abbr = entry.completion_item.filterText or kind.abbr  -- lspconfig jdtls
            --    end
            --end

            --kind.menu = ({
            --    buffer = "[Buffer]",
            --    nvim_lsp = "[LSP]",
            --    luasnip = "[LuaSnip]",
            --    nvim_lua = "[Lua]",
            --    latex_symbols = "[LaTeX]",
            --})[entry.source.name]

            --vim.print(vim_item)
            --vim.print(entry.completion_item)
            --vim.print(entry.source.name)
            --vim.print(entry.source.source.client)

            return vim_item
        end,
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping(function(fallback)
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        --['<BS>'] = cmp.mapping(function(fallback)
        --    fallback()
        --    -- Manually update cmp when backspacing to avoid only showing filtered results
        --    -- This doesn't completely fix the issue though...
        --    if cmp.visible() then
        --        -- Manual (default ContextReason) seems to be very laggy.
        --        cmp.complete({ reason = cmp.ContextReason.Auto })
        --    end
        --end, { "i" })
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
        { name = 'buffer' },
    })
})

local home = os.getenv('HOME')
local mason_install_dir = home .. '/.local/share/nvim/mason/'

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Not required for nvim-jdtls
--require('lspconfig')['jdtls'].setup {
--    capabilities = capabilities,
--    settings = {
--        java = {
--            init_options = {
--                bundles = { java_debug }
--            },
--            signatureHelp = {
--                enabled = true
--            },
--        }
--    }
--}

require('lspconfig')['lua_ls'].setup {
    capabilities = capabilities
}

require('lspconfig')['clangd'].setup {
    cmd = { "clangd", "--background-index" },
    capabilities = capabilities
}
require('lspconfig')['jedi_language_server'].setup {
    capabilities = capabilities
}

require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
}

require('lspconfig')['omnisharp'].setup {
    cmd = { mason_install_dir .. "bin/omnisharp" },
    capabilities = capabilities
}

-- nvim-jdtls
local setup_jdtls = function()
    local jdtls = mason_install_dir .. 'bin/jdtls'
    local java_debug = vim.fn.glob(mason_install_dir .. 'packages/java-debug-adapter/extension/server/*.jar', 1)
    local config = {
        capabilities = capabilities,
        cmd = { jdtls },
        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
        init_options = {
            bundles = { java_debug }
        },

        on_attach = function(client, bufnr)
            require('jdtls').setup_dap({ hotcodereplace = 'auto' })
            require('jdtls.dap').setup_dap_main_class_configs()
        end,
    }
    require('jdtls').start_or_attach(config)
end

vim.api.nvim_create_autocmd({
        "BufNewFile",
        "BufRead",
    },
    {
        pattern = "*.java",
        callback = setup_jdtls
    }
)
