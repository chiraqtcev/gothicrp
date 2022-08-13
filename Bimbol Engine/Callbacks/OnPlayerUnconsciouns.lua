--[[
	
	Module: OnPlayerUnconsciouns.lua
	Autor: DocNight
	
	OnPlayerUnconscious
	
]]--

function OnPlayerUnconscious(playerid, p_classid, killerid, k_classid)
    if IsNPC(playerid) == 1 then
		DEATH_AI(playerid, killerid);
		SetPlayerHealth(playerid, 0)
	end
	-- BE Callback --
	BE_OnPlayerUnconscious(playerid, p_classid, killerid, k_classid)
end

function BE_OnPlayerUnconscious(playerid, p_classid, killerid, k_classid)
end

-- Loaded
print(debug.getinfo(1).source.." has been loaded.");