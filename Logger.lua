local Logger = {}

function Logger:log(message)
	print(message)
	-- Дополнительно можно отправлять логи на внешний сервер для мониторинга
end

function Logger:warn(message)
	warn(message)
	-- Дополнительно можно отправлять предупреждения на внешний сервер для мониторинга
end

function Logger:error(message)
	error(message)
	-- Дополнительно можно отправлять ошибки на внешний сервер для мониторинга
end

return Logger