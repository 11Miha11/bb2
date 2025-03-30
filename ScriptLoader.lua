local LoaderConfig = require(script.Parent.LoaderConfig)

local ScriptLoader = {}

function ScriptLoader.loadScripts()
	for _, scriptPath in ipairs(LoaderConfig.Scripts) do
		local success, result = pcall(function()
			return require(scriptPath)
		end)
		if not success then
			warn("Failed to load script:", scriptPath, result)
		end
	end
end

return ScriptLoader