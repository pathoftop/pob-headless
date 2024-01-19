local glob = require("globtopattern")
local lfs = require("lfs")


-- http://lua-users.org/wiki/DirTreeIterator
local function dirtree(dir, match)
    assert(dir and dir ~= "", "directory parameter is missing or empty")
    if string.sub(dir, -1) == "/" then
        dir = string.sub(dir, 1, -2)
    end

    local function yieldtree(dir)
        for entry in lfs.dir(dir) do
            if entry ~= "." and entry ~= ".." then
                local filename = entry
                entry = dir .. "/" .. entry
                local attr = lfs.attributes(entry)

                if match(entry, attr) then
                    coroutine.yield(filename, attr)
                end

                if attr.mode == "directory" then
                    yieldtree(entry)
                end
            end
        end
    end

    return coroutine.wrap(function() yieldtree(dir) end)
end

local function parentdir(dir)
    local reversed = string.reverse(dir)
    local pos = string.find(reversed, "/")
    if pos == 1 then
        return "./"
    end
    return string.sub(dir, 1, -pos)
end

local filesearch = {}

-- 基于glob的文件查找
-- 参数dironly如果为true，表示只搜索文件夹，否则只搜索文件
function filesearch.NewFileSearch(globstr, dironly)
    dironly = dironly or false;
    if string.sub(globstr, 1, 1) == '/' then
        globstr = "." .. globstr
    end

    local dir = parentdir(globstr)

    local finder = {}
    local pat = glob.globtopattern(globstr)

    local function match(filename, attr)
        if dironly == (attr.mode == "directory") and string.match(filename, pat) then
            return true
        else
            return false
        end
    end

    finder.find = dirtree(parentdir(globstr), match)

    function finder.GetFileName()
        return finder.filename
    end

    function finder.NextFile()
        local filename, attr = finder.find()
        if filename == nil then
            finder.filename = nil
            finder.modification = nil
            return false
        end
        finder.filename = filename
        finder.modification = attr.modification
        return true
    end

    function finder.GetFileModifiedTime()
        return finder.modification
    end

    if finder.NextFile() then
        return finder
    else
        return nil
    end
end

return filesearch
