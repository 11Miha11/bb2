local Players = game:GetService("Players")
local Feedback = require(game.ServerScriptService:WaitForChild("Feedback"))
local ScriptLoader = require(game.ServerScriptService.Loader.ScriptLoader)

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message)
		if message:sub(1, 9) == "!feedback" then
			local feedbackMessage = message:sub(11)
			Feedback:sendFeedback(player, feedbackMessage)
			player:SendNotification("Thank you for your feedback!")
		end
	end)
end)

-- Notify ScriptLoader that this script has loaded successfully
pcall(function()
	ScriptLoader.scriptLoaded("ServerScriptService.FeedbackHandler")
end)