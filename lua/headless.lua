local headless = {}

function headless.setMainSkillGroup(build, index)
	-- see Build.lua: self.controls.mainSocketGroup =
	build.mainSocketGroup = index
end

function headless.setMainSkill(build, index)
	-- see Build.lua: self.controls.mainSkill =
	local mainSocketGroup = build.skillsTab.socketGroupList[build.mainSocketGroup]
	mainSocketGroup.mainActiveSkill = index
end

function headless.setMainSkillPart(build, index)
	local mainSocketGroup = build.skillsTab.socketGroupList[build.mainSocketGroup]
	local srcInstance = mainSocketGroup.displaySkillList[mainSocketGroup.mainActiveSkill].activeEffect.srcInstance
	srcInstance.skillPart = index
end

function headless.getMainSkillDPS(build)
	-- see function buildMode:OnFrame(inputEvents)
	build.calcsTab:BuildOutput()
	-- see Build.lua: for index, statData in ipairs(self.displayStats) do
	return build.calcsTab.mainOutput["CombinedDPS"]
end

-- Return a string contains all skills separated by ",". 
-- 
-- There may be tailed ",".
function headless.getAllSkills(build)
	local data = ""

	local socketGroupList = build.skillsTab.socketGroupList
	for i = 1, #socketGroupList do
		local gemList = socketGroupList[i]["gemList"]
		if gemList then
			for j = 1, #gemList do
				data = data .. gemList[j]["nameSpec"] .. ","
			end
		end
	end

	return data
end

-- Return a string contains all main skills.
-- Each main skill data is separated by "|", and there may be tailed "|".
-- Main skill data starts with skill names, ends with DPS, each part is separated by ",".
--
-- A sample: 
-- "Elemental Hit of the Spectrum,Increased Critical Damage,Inspiration,380207.49440228|"
function headless.getAllMainSkills(build, minLinks)
	local skillGroupList = build.skillsTab.socketGroupList
	local data = ""
	local dataSize = 0

	for i = 1, #skillGroupList do
		headless.setMainSkillGroup(build, i)
		local displaySkillList = skillGroupList[i]["displaySkillList"]
		if displaySkillList then
			for j = 1, #displaySkillList do
				headless.setMainSkill(build, j)
				local gems = displaySkillList[j]["effectList"]
				local links = #gems
				if links >= minLinks then
					for k = 1, links do
						data = data .. gems[k]["gemData"]["name"] .. ","
					end
					data = data .. headless.getMainSkillDPS(build) .. "|"
				end
			end
		end
	end

	return data
end

return headless