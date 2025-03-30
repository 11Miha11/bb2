local AES = require(game.ServerScriptService:WaitForChild("AES"))

local Util = {}

local EncryptionKey = "your-encryption-key-here"
local aes = AES.new(EncryptionKey)

-- Function to encrypt data using AES
function Util.encryptData(data)
	return aes:encrypt(data)
end

-- Function to decrypt data using AES
function Util.decryptData(data)
	return aes:decrypt(data)
end

return Util