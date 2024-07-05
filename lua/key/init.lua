-- NOTE: cmp also defines some keys!
local keymaps = {
    normal = {
        -- Telescope --
        ["<leader>ff"] = {
            exec = function()
                require('telescope.builtin').find_files()
            end
        },
        ["<leader>fg"] = {
            exec = function()
                require('telescope.builtin').live_grep()
            end
        },
        ["<leader>fb"] = {
            exec = function()
                require('telescope.builtin').buffers()
            end
        },

        -- LSP
        ["gd"] = {
            exec = function()
                vim.lsp.buf.definition()
            end
        },
        ["gr"] = {
            exec = function()
                vim.cmd("Telescope lsp_references")
            end
        },
        ["<leader>lr"] = {
            exec = function()
                vim.lsp.buf.rename()
            end
        },
        ["<leader>lf"] = {
            exec = function()
                vim.lsp.buf.format()
            end,
        },
        ["<leader>le"] = {
            exec = function()
                vim.diagnostic.open_float()
            end
        },
        ["<leader>la"] = {
            exec = function()
                vim.lsp.buf.code_action()
            end
        },
        ["<leader>ls"] = {
            exec = function()
                vim.lsp.buf.hover()
            end
        },
        ["<leader>lt"] = {
            exec = function()
                vim.cmd("ClangdSwitchSourceHeader")
            end
        },
        ["gn"] = {
            exec = function()
                vim.diagnostic.goto_next()
            end
        },
        ["gN"] = {
            exec = function()
                vim.diagnostic.goto_prev()
            end
        },

        -- Toggleterm
        ["<leader>tf"] = {
            exec = function()
                vim.cmd("ToggleTerm direction=float")
            end,
        },
        ["<leader>tv"] = {
            exec = function()
                vim.cmd("ToggleTerm direction=vertical")
            end,
        },
        ["<leader>th"] = {
            exec = function()
                vim.cmd("ToggleTerm direction=horizontal")
            end,
        },
        ["<leader>tt"] = {
            exec = function()
                vim.cmd("ToggleTermToggleAll")
            end,
        },

        -- Buffers
        ["gl"] = {
            exec = function()
                vim.cmd("BufferLineCycleNext")
            end,
        },
        ["gh"] = {
            exec = function()
                vim.cmd("BufferLineCyclePrev")
            end,
        },
        ["<bc"] = {
            exec = function()
                vim.cmd("bd")
            end,
        },
        ["<bC"] = {
            exec = function()
                vim.cmd("BufferLinePickClose")
            end,
        },
        ["<bo"] = {
            exec = function()
                vim.cmd("BufferLineCloseOthers")
            end,
        },

        -- Netrw shortcuts
        ["<ee"] = {
            exec = function()
                vim.cmd("e .")
            end,
        },
        ["<ef"] = {
            exec = function()
                -- Open netrw in current buffer dir
                vim.cmd("e %:h")
            end,
        },

        -- DAP
        ["<F5>"] = {
            -- F5: Launch/Continue
            exec = function()
                -- Launch dapui (This does nothing if it is already open)
                require 'dapui'.open()
                vim.cmd("DapContinue")
            end
        },
        ["<F17>"] = {
            -- Shift F5: Terminate
            exec = function()
                -- Close dapui
                require 'dapui'.close()
                vim.cmd("DapTerminate")
            end
        },
        ["<F9>"] = {
            -- F9: Toggle breakpoint
            exec = function()
                vim.cmd("DapToggleBreakpoint")
            end
        },
        ["<F10>"] = {
            -- F10: Step over
            exec = function()
                vim.cmd("DapStepOver")
            end
        },
        ["<F11>"] = {
            -- F11: Step into
            exec = function()
                vim.cmd("DapStepInto")
            end
        },
        ["<F23>"] = {
            -- Shift F11: Step out
            exec = function()
                vim.cmd("DapStepOut")
            end
        },

        -- LaTeX
        ["<leader>bl"] = {
            exec = function()
                vim.cmd("!pdflatex -shell-escape %")
            end,
        },

        -- Color highlight
        ["<leader>cw"] = {
            exec = function()
                -- https://vim.fandom.com/wiki/Highlight_unwanted_spaces
                vim.cmd('au InsertEnter * match ExtraWhitespace /\\s\\+\\%#\\@<!$/')
                vim.cmd('au InsertLeave * match ExtraWhitespace /\\s\\+$/')
            end,
        }
    },
}


-- helper for mapping
local keymaps_bind = function(mode, maps)
    for bind, config in pairs(maps) do
        local exec = config.exec
        vim.keymap.set(mode, bind, exec, {})
    end
end

-- Set keymaps
keymaps_bind('n', keymaps.normal)

-- Move selection from ThePrimeagen's config
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('n', "<C-H>", "<C-W>h")
vim.keymap.set('n', "<C-L>", "<C-W>l")
vim.keymap.set('n', "<C-J>", "<C-W>j")
vim.keymap.set('n', "<C-K>", "<C-W>k")
