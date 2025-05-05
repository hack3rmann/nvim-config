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
}
