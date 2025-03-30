local AES = {}
AES.__index = AES

local function createKey(key)
	local keyBytes = {}
	for i = 1, #key do
		keyBytes[i] = string.byte(key, i)
	end
	return keyBytes
end

function AES.new(key)
	local self = setmetatable({}, AES)
	self.key = createKey(key)
	return self
end

function AES:encrypt(data)
	local encryptedData = {}
	for i = 1, #data do
		local keyByte = self.key[(i - 1) % #self.key + 1]
		local dataByte = string.byte(data, i)
		table.insert(encryptedData, string.char(bit32.bxor(dataByte, keyByte)))
	end
	return table.concat(encryptedData)
end

function AES:decrypt(data)
	local decryptedData = {}
	for i = 1, #data do
		local keyByte = self.key[(i - 1) % #self.key + 1]
		local dataByte = string.byte(data, i)
		table.insert(decryptedData, string.char(bit32.bxor(dataByte, keyByte)))
	end
	return table.concat(decryptedData)
end

return AES