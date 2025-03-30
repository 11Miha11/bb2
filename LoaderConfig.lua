local LoaderConfig = {}

LoaderConfig.Scripts = {
	game.ServerScriptService.AES,
	game.ServerScriptService.Logger,
	game.ServerScriptService.Feedback,
	game.ServerScriptService.PlayerEntryHelper,
	game.ServerScriptService.InGameHelper,
	game.ServerScriptService.PlayerExitHelper,
	game.ServerScriptService.PlayerStats.PlayerStatsInitializer,
	game.ServerScriptService.PlayerStats.InitialCharacterStats,
	game.ServerScriptService.PlayerStats.PlayerDataStore,
	game.ServerScriptService.PlayerStats.RaceStats,
}

return LoaderConfig