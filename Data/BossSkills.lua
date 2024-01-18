-- This file is automatically generated, do not edit!
-- Path of Building
--
-- Boss Skill Presets
-- Boss Skill data (c) Grinding Gear Games
--
return {
	["Atziri Flameblast"] = {
		DamageType = "Spell",
		DamageMultipliers = {
			Fire = { 51.086684344463, 0.25543342172232 }
		},
		UberDamageMultiplier = 1.26,
		DamagePenetrations = {
			FirePen = 8
		},
		UberDamagePenetrations = {
			FirePen = 10
		},
		speed = 25000,
		critChance = 0,
		earlierUber = true,
		tooltip = "The Uber variant has 10 ^xB97123Fire^7 penetration (Applied on Pinnacle And Uber)"
	},
	["Shaper Ball"] = {
		DamageType = "SpellProjectile",
		DamageMultipliers = {
			Cold = { 11.668066430448, 0.058340332152239 }
		},
		DamagePenetrations = {
			ColdPen = 25
		},
		UberDamagePenetrations = {
			ColdPen = 40
		},
		speed = 1400,
		tooltip = "Allocating Cosmic Wounds increases the penetration to 40% (Applied on Uber) and adds 2 projectiles"
	},
	["Shaper Slam"] = {
		DamageType = "Melee",
		DamageMultipliers = {
			Physical = { 12.358683281257, 0.061793416406285 }
		},
		UberDamageMultiplier = 1.6666666666667,
		speed = 3510,
		UberSpeed = 1755,
		critChance = 0,
		additionalStats = {
			uber = {
				reduceEnemyBlock = 1000,
				CannotBeEvaded = "flag",
				reduceEnemyDodge = 1000
			}
		},
		tooltip = "Cannot be Evaded.  Allocating Cosmic Wounds increases Damage by a further 100% (Applied on Uber) and cannot be blocked or dodged"
	},
	["Sirus Meteor"] = {
		DamageType = "Spell",
		DamageMultipliers = {
			Physical = { 45.087560245599, 0.22541711316695 }
		},
		UberDamageMultiplier = 1.52,
		speed = 1500,
		additionalStats = {
			base = {
				PhysicalDamageSkillConvertToFire = 25,
				PhysicalDamageSkillConvertToLightning = 25,
				PhysicalDamageSkillConvertToChaos = 25
			},
			uber = {
				PhysicalDamageSkillConvertToFire = 25,
				PhysicalDamageSkillConvertToLightning = 25,
				PhysicalDamageSkillConvertToChaos = 25
			}
		},
		tooltip = "Earlier ones with less walls do less damage. Allocating The Perfect Storm increases Damage by a further 50% (Applied on Uber)"
	},
	["Exarch Ball"] = {
		DamageType = "SpellProjectile",
		DamageMultipliers = {
			Fire = { 14.924946784635, 0.074624733923175 }
		},
		speed = 1000,
		critChance = 0,
		additionalStats = {
			base = {
				CannotBeBlocked = "flag",
				CannotBeSuppressed = "flag",
				CannotBeDodged = "flag"
			},
			uber = {
				CannotBeBlocked = "flag",
				CannotBeSuppressed = "flag",
				CannotBeDodged = "flag"
			}
		},
		tooltip = "Spawns 8-18 waves of balls depending on which fight and which ball phase, Cannot be Blocked, Dodged, or Suppressed"
	},
	["Eater Beam"] = {
		DamageType = "Spell",
		DamageMultipliers = {
			Lightning = { 12.164923902598, 0.24329847805197 }
		},
		speed = 2500,
		tooltip = "Allocating Insatiable Appetite causes the beam to always shock for at least 30%"
	},
	["Maven Fireball"] = {
		DamageType = "SpellProjectile",
		DamageMultipliers = {
			Fire = { 14.977416270256, 0.074887081351278 }
		},
		UberDamageMultiplier = 2.0273275862069,
		DamagePenetrations = {
			FirePen = ""
		},
		UberDamagePenetrations = {
			FirePen = 30
		},
		speed = 3000,
		tooltip = "Allocating Throw the Gauntlet increases Damage by a further 100% (Applied on Uber) and causes the fireball to have 30 ^xB97123Fire^7 penetration (Applied on Uber)"
	},
	["Maven Memory Game"] = {
		DamageType = "Spell",
		DamageMultipliers = {
			Physical = { 104.29090544842, 0.52145452724208 }
		},
		UberDamageMultiplier = 1.0086206896552,
		speed = 7500,
		additionalStats = {
			base = {
				CannotBeBlocked = "flag",
				PhysicalDamageSkillConvertToLightning = 100,
				PhysicalDamageSkillConvertToCold = 100,
				PhysicalDamageSkillConvertToFire = 100,
				CannotBeSuppressed = "flag",
				CannotBeDodged = "flag"
			},
			uber = {
				CannotBeBlocked = "flag",
				PhysicalDamageSkillConvertToLightning = 100,
				PhysicalDamageSkillConvertToCold = 100,
				PhysicalDamageSkillConvertToFire = 100,
				CannotBeSuppressed = "flag",
				CannotBeDodged = "flag"
			}
		},
		tooltip = "Cannot be Blocked, Dodged, or Suppressed. \n	It is three separate hits, and has a large DoT effect.  Neither is taken into account here.  \n		i.e. Hits before death should be more than 3 to survive"
	},
},{
    { val = "None", label = "None" },
    { val = "Atziri Flameblast", label = "Atziri Flameblast" },
    { val = "Shaper Ball", label = "Shaper Ball" },
    { val = "Shaper Slam", label = "Shaper Slam" },
    { val = "Sirus Meteor", label = "Sirus Meteor" },
    { val = "Exarch Ball", label = "Exarch Ball" },
    { val = "Eater Beam", label = "Eater Beam" },
    { val = "Maven Fireball", label = "Maven Fireball" },
    { val = "Maven Memory Game", label = "Maven Memory Game" }
}