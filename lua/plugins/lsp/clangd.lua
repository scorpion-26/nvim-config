local fix_ref_and_ptr = function(in_str)
    -- foo_t *foo -> foo_t* foo, etc.
    -- This is horribly slow. But it only needs to operate
    -- on small amounts of */&'s, so it should be fine

    local count = 0
    -- Fix * and &
    repeat
        in_str, count = in_str:gsub(" ([%*%&])", "%1 ")
    until count == 0

    -- Fix extra much whitespace ("[*&] [,>)]" to "[*&][,>)]", or at the end of string)
    -- This can happen, in templates, functions, so check for ,>)
    in_str = in_str:gsub("([%&%*]) ([,>)])", "%1%2")
    local trimmed, _ = in_str:gsub(" +$", "")
    return trimmed
end

local get_first_line = function(str)
    local first_newline = str:find("\n")
    if first_newline == nil then
        first_newline = str:len()
    else
        -- No newline found, there is only one line
        first_newline = first_newline - 1
    end

    if first_newline ~= nil and first_newline > 0 then
        return str:sub(1, first_newline)
    end
    return ""
end

local shorten_signature = function(sig, max_width)
    if #sig <= max_width then
        return sig
    end

    local count = 1
    while #sig > max_width and count ~= 0 do
        -- Replace last argument. Note that this doesn't work for the first arg
        sig, count = sig:gsub(",.*%)$", ")")
    end
    local all_args_replaced = false
    if #sig > max_width then
        -- Still not shortened enough, shorten also the first arg
        sig = sig:gsub("%(.*%)$", "()")
        all_args_replaced = true
    end

    -- Put ellipses
    if all_args_replaced then
        sig = sig:gsub("%)$", "...)")
    else
        sig = sig:gsub("%)$", ", ...)")
    end
    return sig
end

return {
    completion_format = function(entry, vim_item)
        local is_method = entry.completion_item.kind == 2
        local is_function = entry.completion_item.kind == 3
        local is_function_like = is_method or is_function;
        local should_add_return_type = is_function_like and entry.completion_item.detail ~= nil

        if should_add_return_type then
            -- Function like.
            -- Instead of the following format
            --     <funName>      (<arg1>, <arg2>, ...)
            -- I want:
            --     <funName>      <returnType> (<arg1>, <arg2>, ...)
            -- The return type is always the first line of the description

            -- Get the first line of
            local ret_type = ""
            local first_line = get_first_line(entry.completion_item.detail)
            if first_line ~= "" then
                -- If detail is [<x> overloads], then we have an overloaded function and
                -- clangd doesn't give us any more details other than the name of the function.
                if not first_line:find("%[%d+ overloads%]") then
                    ret_type = first_line
                else
                    -- Replace the detail, so we also have the function definition
                    entry.completion_item.detail = entry.completion_item.detail:gsub("^" .. first_line, vim_item.menu, 1)
                end
            end
            if ret_type ~= "" then
                ret_type = fix_ref_and_ptr(ret_type)
                local args = fix_ref_and_ptr(entry.completion_item.labelDetails.detail)
                vim_item.menu = shorten_signature(ret_type .. " " .. args, 50)
            end
        end

        -- ptr.prop => ptr->prop, filterText doesn't contain the ->, so add it manually
        local insertArrow = vim_item.word:find("^->") ~= nil
        local arrow = insertArrow and "->" or ""

        -- The thing that is inserted on tab
        vim_item.word = arrow .. entry.completion_item.filterText or vim_item.word

        -- trim spaces in front of the label (clangd gives us sometimes: " foo")
        vim_item.abbr, _ = vim_item.abbr:gsub("^ +", "")

        return vim_item
    end,
}
