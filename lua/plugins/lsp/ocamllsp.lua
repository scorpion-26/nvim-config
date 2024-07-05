local is_function_like = function(completion_item)
    -- ocamllsp puts the signature in 'detail' (And nothing else as it seems)
    -- If a signature contains "->", treat it as a function instead of a plain value
    local sig = completion_item.detail
    local found_arrow = sig:find("->") ~= nil
    return found_arrow
end

local ocaml_icons = {
    Function = "󰘧",
    Value = "󰀫"
}

return {
    completion_format = function(entry, vim_item)
        local is_value = entry.completion_item.kind == 12
        if is_value then
            -- Update icon (Unfortunately there doesn't seem to be a way to change the highlight group :()
            if is_function_like(entry.completion_item) then
                vim_item.kind = ocaml_icons.Function
            else
                vim_item.kind = ocaml_icons.Value
            end
        end
        return vim_item
    end,
}
