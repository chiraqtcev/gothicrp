--[[
	Anty-Cheat - Callbacks
	License: Giftware
	Author: Profesores
	Version: 1.0 for B-Engine users
]]

function BE_OnPlayerChangeStrength(playerid, currStrength, oldStrength)
	if IsNPC(playerid) == 0 then
		CheckValue(playerid, "STR", currStrength);
	end
	K_OnPlayerChangeStrength(playerid, currStrength, oldStrength);
end

function OnPlayerChangeMaxHealth(playerid, currMaxHealth, oldMaxHealth)
	if IsNPC(playerid) == 0 then
		CheckValue(playerid, "MAXHP", currMaxHealth);
	end
	K_OnPlayerChangeMaxHealth(playerid, currMaxHealth, oldMaxHealth);
end

function OnPlayerChangeMaxMana(playerid, currMaxMana, oldMaxMana)
	if IsNPC(playerid) == 0 then
		CheckValue(playerid, "MAXMANA", currMaxMana);
	end
	K_OnPlayerChangeMaxMana(playerid, currMaxMana, oldMaxMana);
end

function BE_OnPlayerChangeDexterity(playerid, currDexterity, oldDexterity)
	if IsNPC(playerid) == 0 then
		CheckValue(playerid, "DEX", currDexterity);
	end
	K_OnPlayerChangeDexterity(playerid, currDexterity, oldDexterity);
end

function BE_OnPlayerChangeLearnPoints(playerid, currLP, oldLP)
	if IsNPC(playerid) == 0 then
		CheckValue(playerid, "LP", currLP);
	end
	K_OnPlayerChangeLearnPoints(playerid, currLP, oldLP);
end

--New callbacks to use in your gamemode
function K_OnPlayerChangeStrength(playerid, currStrength, oldStrength)
end

function K_OnPlayerChangeMaxHealth(playerid, currMaxHealth, oldMaxHealth)
end

function K_OnPlayerChangeMaxMana(playerid, currMaxMana, oldMaxMana)
end

function K_OnPlayerChangeDexterity(playerid, currDexterity, oldDexterity)
end

function K_OnPlayerChangeLearnPoints(playerid, currLP, oldLP)
end

print(debug.getinfo(1).source.." has been loaded.");