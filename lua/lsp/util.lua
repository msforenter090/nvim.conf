M = {
    install_tools = function(packages)
        local mr = require("mason-registry")
        for _, tool in ipairs(packages) do
            local ok, package = pcall(mr.get_package, tool)
            if ok and not package:is_installed() then
                package:install()
            end
        end
    end,

    load_config = function(configs)
        for _, config in ipairs(configs) do
            require("lsp." .. config .. ".config").config()
        end
    end
}

return M
