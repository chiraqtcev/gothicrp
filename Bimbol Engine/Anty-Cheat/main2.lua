--[[
	Anty-Cheat
	License: Giftware
	Author: Profesores
	Version: 1.1 for B-Engine users
]]

local Player = {};
local STATUS = false;

function init_AC(bool)
	if (bool == true) then
		STATUS = bool;
		
		print("Anty-Cheat has been successfully loaded");
		print("#Version of AC: 1.1 for B-Engine Users");
	end
end

local values =
{
	{ what = "MAXHP", func = GetPlayerMaxHealth, func_check = _GetPlayerMaxHealth },
	{ what = "MAXMANA", func = GetPlayerMaxMana, func_check = _GetPlayerMaxMana },
	{ what = "STR", func = GetPlayerStrength, func_check = _GetPlayerStrength },
	{ what = "DEX", func = GetPlayerDexterity, func_check = _GetPlayerDexterity },
	{ what = "LP", func = GetPlayerLearnPoints, func_check = _GetPlayerLearnPoints },
	{ what = "GOLD", func = GetPlayerGold, func_check = _GetPlayerGold },
}

function CheckValue(playerid, block, value)
	if ( (playerid and block and value) and (IsNPC(playerid) == 0) and (STATUS == true) ) then
		if block == "GOLD" then
			return;
		end
		
		for i = 1, #values do
			if (values[i].what == block) then
				if (value <= values[i].func(playerid) or value == 0 or value == 10) then
					return;
				end
				
				OnPlayerCheats(playerid, block, values[i].func(playerid), values[i].func_check(playerid));
			end
		end
	end
end

function CheckAllValues(playerid)
	if (IsNPC(playerid) == 0) then
		for i = 1, #values do
			if not(values[i].func_check(playerid) <= values[i].func(playerid) or values[i].func_check(playerid) == 10 or values[i].func_check == nil or values[i].func_check == 0) then
				if (values[i].what ~= "GOLD") then
					OnPlayerCheats(playerid, values[i].what, values[i].func(playerid), values[i].func_check(playerid));
				end
			end
		end
	end
end

-- Callback
function OnPlayerCheats(playerid, block, oldVALUE, newVALUE)
end

print(debug.getinfo(1).source.." has been loaded.");