local split = function()
    vim.cmd("set splitbelow")
    vim.cmd("sp")
    vim.cmd("res -5")
end

local compileRun = function()
    vim.cmd("w")            -- save current file first
    -- check file type
    local fileType = vim.bo.filetype
    if fileType == 'c' then
        split()
        vim.cmd("term gcc % -o %< && ./%< && rm %<")
    elseif fileType == 'cpp' then
        split()
        vim.cmd("term g++ -std=c++23 -Wall % -o %< && ./%< && rm %<")
    elseif fileType == 'python' then
        split()
        vim.cmd("term python3 %")
    -- elseif fileType == 'lua' then
    --     split()
    --     vim.cmd("term luajit %")        -- I don't have this tool now
    elseif fileType == 'markdown' then
        -- vim.cmd(":InstantMarkdownPreview")
        vim.cmd(":MarkdownPreview")
    end
end

vim.keymap.set('n', 'R', compileRun, { silent = true })
