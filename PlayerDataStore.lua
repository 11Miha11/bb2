local DataStoreService = game:GetService("DataStoreService")
local PlayerStatsStore = DataStoreService:GetDataStore("PlayerStatsStore")
local HttpService = game:GetService("HttpService")
local Util = require(game.ServerScriptService.PlayerDatabase.Util)

local PlayerDataStore = {}

local dataCache = {}

local highPriorityQueue = {}
local mediumPriorityQueue = {}
local lowPriorityQueue = {}
local isProcessing = false

local function retryRequest(func, maxRetries)
	local retries = 0
	while retries < maxRetries do
		local success, result = pcall(func)
		if success then
			return true, result
		else
			retries = retries + 1
			wait(1) -- Wait 1 second before retrying
		end
	end
	return false, nil
end

local function processQueue()
	if isProcessing then return end
	isProcessing = true

	while #highPriorityQueue > 0 or #mediumPriorityQueue > 0 or #lowPriorityQueue > 0 do
		local request
		if #highPriorityQueue > 0 then
			request = table.remove(highPriorityQueue, 1)
		elseif #mediumPriorityQueue > 0 then
			request = table.remove(mediumPriorityQueue, 1)
		else
			request = table.remove(lowPriorityQueue, 1)
		end

		local success, result = retryRequest(request.func, 3)
		if not success then
			warn("Error processing request: " .. tostring(result))
		end

		wait(1) -- Wait 1 second before processing the next request to avoid hitting rate limits
	end

	isProcessing = false
end

local function addToQueue(func, priority)
	local request = {func = func, timestamp = tick()}
	if priority == "high" then
		table.insert(highPriorityQueue, request)
	elseif priority == "medium" then
		table.insert(mediumPriorityQueue, request)
	else
		table.insert(lowPriorityQueue, request)
	end
	processQueue()
end

function PlayerDataStore:savePlayerStats(player, priority)
	local stats = {}
	for _, attribute in ipairs(player:GetAttributes()) do
		stats[attribute] = player:GetAttribute(attribute)
	end

	-- Cache data before saving
	dataCache[player.UserId] = stats

	addToQueue(function()
		local encryptedData = Util.encryptData(HttpService:JSONEncode(stats))
		PlayerStatsStore:SetAsync(player.UserId, encryptedData)
	end, priority)
end

function PlayerDataStore:loadPlayerStats(player, priority)
	-- Check cache before loading
	if dataCache[player.UserId] then
		local stats = dataCache[player.UserId]
		for stat, value in pairs(stats) do
			player:SetAttribute(stat, value)
		end
		return
	end

	addToQueue(function()
		local encryptedData = PlayerStatsStore:GetAsync(player.UserId)
		if encryptedData then
			local decryptedData = Util.decryptData(encryptedData)
			if decryptedData then
				local success, stats = pcall(HttpService.JSONDecode, HttpService, decryptedData)
				if success and stats then
					for stat, value in pairs(stats) do
						player:SetAttribute(stat, value)
					end
					-- Cache loaded data
					dataCache[player.UserId] = stats
				else
					warn("Failed to decode JSON for " .. player.Name .. ": " .. tostring(stats))
				end
			else
				warn("Failed to decrypt data for " .. player.Name)
			end
		end
	end, priority)
end

return PlayerDataStore