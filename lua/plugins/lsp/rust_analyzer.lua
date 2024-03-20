return {
    completion_format = function(entry, vim_item)
        -- The extra annotations (rust_analyzer: <type> (<extra_package>))
        if entry.completion_item.labelDetails ~= nil then
            local menu_description = ""
            if entry.completion_item.labelDetails.description ~= nil then
                menu_description = entry.completion_item.labelDetails.description .. " "
            end
            local menu_detail = entry.completion_item.labelDetails.detail or ""
            vim_item.menu = menu_description .. menu_detail
        end
        -- The thing that is inserted on tab
        vim_item.word = entry.completion_item.filterText or vim_item.word
        return vim_item
    end
}
