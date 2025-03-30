local RaceStats = {}

local races = {
	Human = {},
	Cyclops = {
		RacePhysicalPower = 10,
		RaceMagicalPower = -2,
		RaceTechPower = -10,
		RaceMentalDamage = 0,
		RacePhysicalDefense = 8,
		RaceMagicalDefense = 4,
		RaceHpRegeneration = 2
	},
	Cyborg = {
		RacePhysicalPower = 3,
		RaceMagicalPower = -6,
		RaceTechPower = 15,
		RaceMentalDamage = -5,
		RacePhysicalDefense = 12,
		RaceMagicalDefense = 2,
		RaceHpRegeneration = -2
	},
	Zombie = {
		RacePhysicalPower = 20,
		RaceMagicalPower = -15,
		RaceTechPower = -15,
		RaceMentalDamage = 10,
		RacePhysicalDefense = 8,
		RaceMagicalDefense = 4,
		RaceHpRegeneration = -3
	},
	Slime = {
		RacePhysicalPower = -5,
		RaceMagicalPower = 8,
		RaceTechPower = -5,
		RaceMentalDamage = 0,
		RacePhysicalDefense = 12,
		RaceMagicalDefense = 6,
		RaceHpRegeneration = 12
	},
	Beastman = {
		RacePhysicalPower = 10,
		RaceMagicalPower = -2,
		RaceTechPower = -10,
		RaceMentalDamage = 0,
		RacePhysicalDefense = 8,
		RaceMagicalDefense = 4,
		RaceHpRegeneration = 6
	},
	["Stone golem"] = {
		RacePhysicalPower = 15,
		RaceMagicalPower = -5,
		RaceTechPower = -2,
		RaceMentalDamage = 0,
		RacePhysicalDefense = 15,
		RaceMagicalDefense = 2,
		RaceHpRegeneration = -3.2
	},
	Demon = {
		RacePhysicalPower = 10,
		RaceMagicalPower = 15,
		RaceTechPower = -2,
		RaceMentalDamage = 10,
		RacePhysicalDefense = 8,
		RaceMagicalDefense = 8,
		RaceHpRegeneration = 5
	},
	Vampire = {
		RacePhysicalPower = 7,
		RaceMagicalPower = 10,
		RaceTechPower = -6,
		RaceMentalDamage = 5,
		RacePhysicalDefense = 8,
		RaceMagicalDefense = -4,
		RaceHpRegeneration = 10
	},
	Elemental = {
		RacePhysicalPower = -15,
		RaceMagicalPower = 25,
		RaceTechPower = -15,
		RaceMentalDamage = 2,
		RacePhysicalDefense = -4,
		RaceMagicalDefense = 15,
		RaceHpRegeneration = -3.45
	}
}

function RaceStats:applyRaceStats(playerStats)
	local race = playerStats.Stats.Race
	if races[race] then
		for stat, value in pairs(races[race]) do
			playerStats.Stats[stat] = value
		end
	else
		warn("Race " .. race .. " not found!")
	end
end

return RaceStats