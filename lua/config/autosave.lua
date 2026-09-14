-- Can be enabled with
--
-- ```vim
-- let g:auto_save = 1
-- ```

local timer = vim.uv.new_timer()
if timer == nil then
    return
end

timer:start(1000, 1000, vim.schedule_wrap(function()
    if vim.g.auto_save and vim.bo.modified and vim.bo.buftype == "" then
        vim.cmd("silent update")
    end
end))
