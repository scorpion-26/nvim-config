require("dapui").setup()

local dap = require"dap"

-- Setup lua debug
dap.configurations.lua = {
    {
        type = 'nlua',
        request = 'attach',
        name = "Attach to running Neovim instance",
    }
}

dap.adapters.nlua = function(callback, config)
    callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
end

-- Setup icons
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#FFFFFF"})
vim.fn.sign_define('DapBreakpoint', {text='', texthl='DapBreakpoint'})
