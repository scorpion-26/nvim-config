return {
    completion_format = function(entry, vim_item)
        vim.print(entry.completion_item)
        local is_method = entry.completion_item.kind == 2
        local is_function = entry.completion_item.kind == 3
        local is_function_like = is_method or is_function;

        if is_function_like then
            vim_item.menu = entry.completion_item.labelDetails.detail ..
            " -> " .. entry.completion_item.labelDetails.description
        end
        return vim_item
    end
}
