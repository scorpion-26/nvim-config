local builtin = require 'statuscol.builtin'
require("statuscol").setup {
    --    segments = {
    --        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
    --        {
    --            sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
    --            click = "v:lua.ScSa",
    --        },
    --        { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
    --        {
    --            sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true },
    --            click = "v:lua.ScSa"
    --        },
    --        --   {
    --        --     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
    --        --     click = "v:lua.ScSa"
    --        --   },
    --    }
    relculright = true,
    segments = {
        {
            sign = {
                name = { "^Diagnostic", "^Dap" }
            },
            maxwidth = 2,
            colwidth = 1,
            auto = true,
        },
        {
            text = { builtin.lnumfunc },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
        },
        {
            -- Gitsigns
            sign = {
                namespace = { "^gitsigns_" }
            }
        }
    },
}
