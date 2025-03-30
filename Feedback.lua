local HttpService = game:GetService("HttpService")

local Feedback = {}

function Feedback:sendFeedback(player, message)
	local feedbackData = {
		playerId = player.UserId,
		playerName = player.Name,
		message = message,
		timestamp = os.time()
	}
	-- Отправляем данные на внешний сервер
	local feedbackJson = HttpService:JSONEncode(feedbackData)
	HttpService:PostAsync("https://your-feedback-server.com/api/feedback", feedbackJson)
end

return Feedback