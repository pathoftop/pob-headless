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

local function gemName(gem)
	if gem["gemData"] and gem["gemData"]["name"] then
		return gem["gemData"]["name"]
	end
	return gem["grantedEffect"]["baseTypeName"]
end

-- Return an table containing all gems.
function headless.getAllGems(build)
	local gems = {}
	local socketGroupList = build.skillsTab.socketGroupList
	for i, socketGroup in ipairs(socketGroupList) do
		-- skip gems in the inactive weapon set
		if not socketGroup.slotEnabled then
			goto continue
		end
		local gemList = socketGroup["gemList"]
		if gemList then
			for j, gem in ipairs(gemList) do
				if gem["nameSpec"] and gem["nameSpec"] ~= "" then
					-- vaal gems contain two gems
					if gem.gemData and gem.gemData.vaalGem then
						table.insert(gems, gem.gemData.grantedEffectList[1].name)
						table.insert(gems, gem.gemData.grantedEffectList[2].name)
					else
						table.insert(gems, gem["nameSpec"])
					end
				end
			end
		end
		-- support gems may contain gems from items
		local displaySkillList = socketGroup["displaySkillList"]
		if displaySkillList then
			for j, displaySkill in ipairs(displaySkillList) do
				if displaySkill["supportList"] then
					for k, support in ipairs(displaySkill["supportList"]) do
						table.insert(gems, gemName(support))
					end
				end
			end
		end
		::continue::
	end

	-- remove repeats
	local uniques = {}
	local skillSet = {}
	for i, skill in ipairs(gems) do
		if not skillSet[skill] then
			table.insert(uniques, skill)
			skillSet[skill] = true
		end
	end

	return uniques
end

-- Return an table containing all main skills.
-- Argument mainLinks specifies the minimum number of links.
--
-- A sample:
-- [{"skill":"Elemental Hit of the Spectrum", "supports":["Increased Critical Damage","Inspiration"], "dps":"380207.49440228"}]
function headless.getAllMainSkills(build, minLinks)
	local mainSkills = {}
	local socketGroupList = build.skillsTab.socketGroupList

	for i, socketGroup in ipairs(socketGroupList) do
		headless.setMainSkillGroup(build, i)
		local displaySkillList = socketGroup["displaySkillList"]
		if displaySkillList then
			for j, displaySkill in ipairs(displaySkillList) do
				headless.setMainSkill(build, j)

				local effectList = displaySkill["effectList"]
				local links = #effectList
				if links >= minLinks then
					local mainSkill = {}

					mainSkill["skill"] = effectList[1].grantedEffect.name

					local supports = {}
					for k = 2, links do
						table.insert(supports, effectList[k].grantedEffect.name)
					end
					mainSkill["supports"] = supports

					mainSkill["dps"] = headless.getMainSkillDPS(build)

					table.insert(mainSkills, mainSkill)
				end
			end
		end
	end

	return mainSkills
end

return headless
