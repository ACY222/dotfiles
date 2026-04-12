local split = function()
    vim.cmd("sp")
    vim.cmd("resize -10")
end

vim.api.nvim_create_user_command("CompileAndRun", function()
    vim.cmd("w") -- save current file first
    -- check file type
    local fileType = vim.bo.filetype
    if fileType == "c" then
        split()
        vim.cmd("term gcc % -o %< && ./%< && rm %<")
    elseif fileType == "cpp" then
        split()
        vim.cmd("term g++ -std=c++23 -Wall % -o %< && ./%< && rm %<")
    elseif fileType == "python" then
        split()
        vim.cmd("term python3 %")
    -- elseif fileType == 'lua' then
    --     split()
    --     vim.cmd("term luajit %")        -- I don't have this tool now
    elseif fileType == "markdown" then
        -- vim.cmd(":InstantMarkdownPreview")
        vim.cmd(":MarkdownPreview")
    elseif fileType == "rust" then
        split()
        vim.cmd("term cargo run -q")
    elseif fileType == "typst" then
        vim.cmd(":TypstPreview")
    end
end, {
    desc = "Compile and run",
})
vim.api.nvim_create_user_command("CompileToDebug", function()
    vim.cmd("w") -- save current file first
    local fileType = vim.bo.filetype
    if fileType == "c" then
        split()
        vim.cmd("term gcc -g % -o %<")
    elseif fileType == "cpp" then
        split()
        vim.cmd("term g++ -g % -o %<")
    end
end, {
    desc = "Compile current file with -g to debug",
})
