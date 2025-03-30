local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local InitialCharacterStats = require(game.ServerScriptService.PlayerStats.InitialCharacterStats)
local PlayerDataStore = require(game.ServerScriptService.PlayerStats.PlayerDataStore)

local PlayerEntryHelper = {}

function PlayerEntryHelper.initializePlayerStats(player)
	local playerStats = InitialCharacterStats:new()
	PlayerDataStore:loadPlayerStats(player, "high")
	playerStats:loadPlayerStats(player)
	playerStats:applyRaceStats()
	player:SetAttribute("Stats", HttpService:JSONEncode(playerStats.Stats))
	print("Initialized stats for player " .. player.Name)
end

function PlayerEntryHelper.onPlayerAdded(player)
	PlayerEntryHelper.initializePlayerStats(player)
end

Players.PlayerAdded:Connect(PlayerEntryHelper.onPlayerAdded)

return PlayerEntryHelper