dofile("git/shared.lua")

UPDATE_PORT = channel.new("UPDATE_PORT")

local info = http.get(string.format("https://raw.githubusercontent.com/%s/%s/master/version", APP_REPO, APP_PROJECT)) 

if info then
    info /= "|"
	local version = info[1]
	if version and tonumber(version) then
		version = tonumber(version)
		local major = (version >> 0x18) & 0xFF;
		local minor = (version >> 0x10) & 0xFF;
		if version > APP_VERSION then
			UPDATE_PORT:push({version, tostring(info[2] or "")})
		end
	end
end
