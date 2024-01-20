#@
-- This wrapper allows the program to run headless on any OS (in theory)
-- It can be run using a standard lua interpreter, although LuaJIT is preferable


-- Callbacks
local callbackTable = {}
local mainObject
function runCallback(name, ...)
	if callbackTable[name] then
		return callbackTable[name](...)
	elseif mainObject and mainObject[name] then
		return mainObject[name](mainObject, ...)
	end
end

function SetCallback(name, func)
	callbackTable[name] = func
end

function GetCallback(name)
	return callbackTable[name]
end

function SetMainObject(obj)
	mainObject = obj
end

-- Image Handles
local imageHandleClass = {}
imageHandleClass.__index = imageHandleClass
function NewImageHandle()
	return setmetatable({}, imageHandleClass)
end

function imageHandleClass:Load(fileName, ...)
	self.valid = true
end

function imageHandleClass:Unload()
	self.valid = false
end

function imageHandleClass:IsValid()
	return self.valid
end

function imageHandleClass:SetLoadingPriority(pri) end

function imageHandleClass:ImageSize()
	return 1, 1
end

-- Rendering
function RenderInit() end

function GetScreenSize()
	return 1920, 1080
end

function SetClearColor(r, g, b, a) end

function SetDrawLayer(layer, subLayer) end

function SetViewport(x, y, width, height) end

function SetDrawColor(r, g, b, a) end

function DrawImage(imgHandle, left, top, width, height, tcLeft, tcTop, tcRight, tcBottom) end

function DrawImageQuad(imageHandle, x1, y1, x2, y2, x3, y3, x4, y4, s1, t1, s2, t2, s3, t3, s4, t4) end

function DrawString(left, top, align, height, font, text) end

function DrawStringWidth(height, font, text)
	return 1
end

function DrawStringCursorIndex(height, font, text, cursorX, cursorY)
	return 0
end

function StripEscapes(text)
	return text:gsub("%^%d", ""):gsub("%^x%x%x%x%x%x%x", "")
end

function GetAsyncCount()
	return 0
end

-- Search Handles
local filesearch = require("filesearch")
NewFileSearch = filesearch.NewFileSearch

-- General Functions
function SetWindowTitle(title) end

function GetCursorPos()
	return 0, 0
end

function SetCursorPos(x, y) end

function ShowCursor(doShow) end

function IsKeyDown(keyName) end

function Copy(text) end

function Paste() end

local zlib = require('zlib.ffi-zlib')

function Deflate(data)
	local finish = 0
	local len = #data
	local input = function(bufsize)
		if finish >= len then
			return nil
		end
		finish = finish + bufsize
		return string.sub(data, finish - bufsize + 1, finish)
	end
	local output_table = {}
	local output = function(d)
		table.insert(output_table, d)
	end

	local options = {}
	-- use zlib header
	-- https://stackoverflow.com/questions/54663140/how-to-change-deflate-stream-output-formatraw-zlib-gzip-when-use-zlib
	options.windowBits = 15
	local ok, err = zlib.deflateGzip(input, output, nil, options)
	if not ok then
		ConPrintf(err)
	end

	return table.concat(output_table, '')
end

function Inflate(data)
	local count = 0
	local input = function(bufsize)
		local start = count > 0 and bufsize * count or 1
		local finish = (bufsize * (count + 1) - 1)
		count = count + 1
		if bufsize == 1 then
			start = count
			finish = count
		end
		return data:sub(start, finish)
	end

	local output_table = {}
	local output = function(d)
		table.insert(output_table, d)
	end

	-- Decompress the data
	local ok, err = zlib.inflateGzip(input, output)
	if not ok then
		ConPrintf(err)
		return
	end

	return table.concat(output_table, '')
end

function GetTime()
	return 0
end

function GetScriptPath()
	return "."
end

function GetRuntimePath()
	return ""
end

function GetUserPath()
	return ""
end

function MakeDir(path) end

function RemoveDir(path) end

function SetWorkDir(path) end

function GetWorkDir()
	return ""
end

function LaunchSubScript(scriptText, funcList, subList, ...) end

function AbortSubScript(ssID) end

function IsSubScriptRunning(ssID) end

function LoadModule(fileName, ...)
	if not fileName:match("%.lua") then
		fileName = fileName .. ".lua"
	end
	local func, err = loadfile(fileName)
	if func then
		return func(...)
	else
		error("LoadModule() error loading '" .. fileName .. "': " .. err)
	end
end

function PLoadModule(fileName, ...)
	if not fileName:match("%.lua") then
		fileName = fileName .. ".lua"
	end
	local func, err = loadfile(fileName)
	if func then
		return PCall(func, ...)
	else
		error("PLoadModule() error loading '" .. fileName .. "': " .. err)
	end
end

function PCall(func, ...)
	local ret = { pcall(func, ...) }
	if ret[1] then
		table.remove(ret, 1)
		return nil, unpack(ret)
	else
		return ret[2]
	end
end

function ConPrintf(fmt, ...)
	-- Optional
	print(string.format(fmt, ...))
end

function ConPrintTable(tbl, noRecurse) end

function ConExecute(cmd) end

function ConClear() end

function SpawnProcess(cmdName, args) end

function OpenURL(url) end

function SetProfiling(isEnabled) end

function Restart() end

function Exit() end

local l_require = require
function require(name)
	-- Hack to stop it looking for lcurl, which we don't really need
	if name == "lcurl.safe" then
		return
	end
	return l_require(name)
end

dofile("Launch.lua")

-- Prevents loading of ModCache
-- Allows running mod parsing related tests without pushing ModCache
-- The CI env var will be true when run from github workflows but should be false for other tools using the headless wrapper
mainObject.continuousIntegrationMode = os.getenv("CI")

runCallback("OnInit")
runCallback("OnFrame") -- Need at least one frame for everything to initialise

if mainObject.promptMsg then
	-- Something went wrong during startup
	print(mainObject.promptMsg)
	io.read("*l")
	return
end

-- The build module; once a build is loaded, you can find all the good stuff in here
build = mainObject.main.modes["BUILD"]

-- Here's some helpful helper functions to help you get started
function newBuild()
	mainObject.main:SetMode("BUILD", false, "Help, I'm stuck in Path of Building!")
	runCallback("OnFrame")
end

function loadBuildFromXML(xmlText, name)
	mainObject.main:SetMode("BUILD", false, name or "", xmlText)
	runCallback("OnFrame")
end

function loadBuildFromJSON(getItemsJSON, getPassiveSkillsJSON)
	mainObject.main:SetMode("BUILD", false, "")
	runCallback("OnFrame")
	local charData = build.importTab:ImportItemsAndSkills(getItemsJSON)
	build.importTab:ImportPassiveTreeAndJewels(getPassiveSkillsJSON, charData)
	-- You now have a build without a correct main skill selected, or any configuration options set
	-- Good luck!
end
