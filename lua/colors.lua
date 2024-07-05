-- Custom colors
local hl = function(hl, val)
	vim.api.nvim_set_hl(0, hl, val)
end
-- LSP
hl("PmenuSel", { bg = "#282C34", fg = "NONE" })
hl("Pmenu", { fg = "#C5CDD9", bg = "#22252A" })
hl("CmpItemAbbrDeprecated", { fg = "NONE", bg = "NONE", strikethrough = true })
hl("CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
hl("CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
hl("CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })
hl("CmpItemKindField", { link = "@lsp.type.property"})
hl("CmpItemKindProperty", { link = "@lsp.type.property" })
hl("CmpItemKindEvent", { link = "@lsp.type.property" }) -- Don't care
hl("CmpItemKindText", { link = "@text" })
hl("CmpItemKindEnum", { link = "@lsp.type.enum" })
hl("CmpItemKindKeyword", { link = "@keyword" })
hl("CmpItemKindConstant", { link = "@constant" })
hl("CmpItemKindConstructor", { link = "@lsp.type.type" })
hl("CmpItemKindReference", { link = "@type" }) -- ??
hl("CmpItemKindFunction", { link = "@lsp.type.function" })
hl("CmpItemKindStruct", { link = "@lsp.type.struct" })
hl("CmpItemKindClass", { link = "@lsp.type.class" })
hl("CmpItemKindModule", { link = "@lsp.type.namespace" })
hl("CmpItemKindOperator", { link = "@operator" })
hl("CmpItemKindVariable", { link = "@lsp.type.variable" })
hl("CmpItemKindFile", { link = "@string" })
hl("CmpItemKindUnit", { link = "@type" })
hl("CmpItemKindSnippet", { link = "@character.special" })
hl("CmpItemKindFolder", { link = "@string" })
hl("CmpItemKindMethod", { link = "@lsp.type.method" })
hl("CmpItemKindValue", { link = "@lsp.type.character" })
hl("CmpItemKindEnumMember", { link = "@lsp.type.enumMember" })
hl("CmpItemKindInterface", { link = "@lsp.type.interface" })
hl("CmpItemKindColor", { link = "@text" })
hl("CmpItemKindTypeParameter", { link = "@lsp.type.parameter" })


-- Java: modifiers should be keywords
hl("@type.qualifier", { link = "@keyword" })

-- LaTeX: Math and envs should be hl'ed 
hl("@text.math", { link = "@property"})
hl("@markup.math", { link = "@text.math"})
hl("@operator.latex", { link = "@punctuation.bracket"})
hl("@text.environment", { link = "@namespace"})
hl("@text.environment.name", { link = "@text.title"})

-- CPP:
-- Macros shouldn't be the same as member variables
-- TODO: Find a better color
--hl("@lsp.type.macro.cpp", { fg = "#8785ed"})
hl("@lsp.type.macro.cpp", { fg = "#7977ed"})
-- labels are keywords
hl("@label.cpp", { link = "@keyword.cpp"})

-- Rust: self should be a parameter
hl("@lsp.type.selfKeyword.rust", {link = "@lsp.type.parameter.rust"})

-- Onedark: Set locals with members
--hl("@lsp.type.variable", { link = "@property" })

-- Onedark: More vibrant inline diagnostics
hl("DiagnosticVirtualTextError", { link = "DiagnosticError" })
hl("DiagnosticVirtualTextWarn", { link = "DiagnosticWarn" })
hl("DiagnosticVirtualTextInfo", { link = "DiagnosticInfo" })
hl("DiagnosticVirtualTextHint", { link = "DiagnosticHint" })
hl("DiagnosticVirtualTextOk", { link = "DiagnosticOk" })

-- Extra whitespace. https://stackoverflow.com/questions/4617059/showing-trailing-spaces-in-vim
-- Activated manually
hl("ExtraWhitespace", { fg="#FF0000", undercurl=true})
