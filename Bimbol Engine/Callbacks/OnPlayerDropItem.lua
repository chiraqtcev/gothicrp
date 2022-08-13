--[[
	
	Module: OnPlayerDropItem.lua
	Autor: Bimbol
	
	OnPlayerDropItem
	
]]--

function OnPlayerDropItem(playerid, itemid, instance, amount, posX, posY, posZ, world, rotX, rotY, rotZ)
	removeItem(playerid, instance, amount);
	-- BE Callback --
	BE_OnPlayerDropItem(playerid, itemid, instance, amount, posX, posY, posZ, world, rotX, rotY, rotZ);
end

function BE_OnPlayerDropItem(playerid, itemid, instance, amount, posX, posY, posZ, world, rotX, rotY, rotZ)
end

-- Loaded
print(debug.getinfo(1).source.." has been loaded.");