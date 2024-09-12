local LaLaLog = {
    logpath = vim.fn.stdpath("state") .. "/lala_tracing.log"
}

local function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

LaLaLog.log = function(...)
    local args = { ... }
    if #args == 0 then
        return
    end
    local loginfo = os.date("%Y-%m-%d %H:%M:%S: ", os.time())
    for _, value in pairs(args) do
        loginfo = loginfo .. dump(value)
    end
    loginfo = loginfo .. "\n"
    local logfile = io.open(LaLaLog.logpath, "a")
    if logfile then
        logfile:write(loginfo)
    end

    io.close(logfile)
end

return LaLaLog
