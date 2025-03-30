local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local InitialCharacterStats = require(game.ServerScriptService.PlayerStats.InitialCharacterStats)
local PlayerDataStore = require(game.ServerScriptService.PlayerStats.PlayerDataStore)
local ScriptLoader = require(game.ServerScriptService.Loader.ScriptLoader)

Players.PlayerRemoving:Connect(function(player)
	local statsJson = player:GetAttribute("Stats")
	if statsJson then
		local playerStats = InitialCharacterStats:new()
		local statsTable = HttpService:JSONDecode(statsJson)
		if statsTable then
			for stat, value in pairs(statsTable) do
				playerStats:updateStat(stat, value)
			end
			playerStats:savePlayerStats(player)
		else
			warn("Failed to decode stats for player " .. player.Name)
		end
	end
	local success, errorMessage = pcall(function()
		PlayerDataStore:savePlayerStats(player, "high")
	end)
	if success then
		print("Player stats saved successfully for " .. player.Name)
	else
		warn("Error saving player stats for " .. player.Name .. ": " .. errorMessage)
	end
end)

-- Notify ScriptLoader that this script has loaded successfully
pcall(function()
	ScriptLoader.scriptLoaded("ServerScriptService.PlayerDatabase.Save")
end)