local InitialCharacterStats = {}

function InitialCharacterStats:new()
	local newObj = {}
	setmetatable(newObj, self)
	self.__index = self
	return newObj
end

function InitialCharacterStats:loadPlayerStats(player)
	-- Implementation for loading player stats
end

function InitialCharacterStats:applyRaceStats()
	-- Implementation for applying race stats
end

function InitialCharacterStats:updateStat(stat, value)
	-- Implementation for updating a stat
end

return InitialCharacterStats