--[[
	
	Module: OnPlayerSpawn.lua
	Autor: Bimbol
	
	OnPlayerSpawn
	
]]--

function OnPlayerSpawn(playerid, classid)
	if IsNPC(playerid) == 0 then
		givePlayerAllItems(playerid);
	end
	-- BE_Callback --
	BE_OnPlayerSpawn(playerid, classid);
end

-- Callback
function BE_OnPlayerSpawn(playerid, classid)
end

-- Loaded
print(debug.getinfo(1).source.." has been loaded.");