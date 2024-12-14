return {
    cli_split = function(inputstr)
        local spat, epat = [=[^(['"])]=], [=[(['"])$]=]
        local buf, quoted = nil, nil
        local args = {}

        for str in inputstr:gmatch("%S+") do
            local squoted = str:match(spat)
            local equoted = str:match(epat)
            local escaped = str:match([=[(\*)['"]$]=])

            if squoted and not quoted and not equoted then
                buf, quoted = str, squoted
            elseif buf and equoted == quoted and #escaped % 2 == 0 then
                str, buf, quoted = buf .. " " .. str, nil, nil
            elseif buf then
                buf = buf .. " " .. str
            end

            if not buf then
                table.insert(args, (str:gsub(spat, ""):gsub(epat, "")))
            end
        end

        return args
    end,
    available_concurrency = function()
        local user = os.getenv("USER")

        -- default value for `concurrency` in lazy.nvim
        local concurrency = jit.os:find("Windows") and (vim.uv.available_parallelism() * 2) or nil

        -- make less agressive concurrency while on practicum server
        if user and string.match(user, "s022[0-9][0-9][0-9][0-9][0-9]") then
            concurrency = 8
        end

        return concurrency
    end,
}
