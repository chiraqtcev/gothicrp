--[[
	
	Module: CheckPlayerInWater.lua
	Autor: Bimbol
	
	Check if Player is in Water.
	
]]--

function InWater(playerid)
	local anim = GetPlayerAnimationName(playerid)
	if anim == "T_FALLDN_2_DIVE" or
	    anim == "S_SWIM" or
	    anim == "S_SWIMF" or
		anim == "T_DIVE_2_DIVEF" or
		anim == "T_SWIM_2_SWIMF" or
	    anim == "T_SWIM_2_SWIMB" or
	    anim == "T_SWIMF_2_SWIMF" or
		anim == "T_SWIMF_2_SWIMB" or
		anim == "T_WALKWTURNR" or
		anim == "T_WALKWTURNL" or
		anim == "S_WALKWL" or
		anim == "T_WALK_2_WALKWL" or
		anim == "S_WALKW"
		
	then
		
		return true;
	else 
		
		return false;
	end
end

-- Loaded
print(debug.getinfo(1).source.." has been loaded.");