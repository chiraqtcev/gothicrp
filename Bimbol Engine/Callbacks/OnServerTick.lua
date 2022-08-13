--[[

	Module: OnServerTick.lua
	Author: DocNight
	
	OnTick

]]--

function render_Init(value)
	if value then
		SetTimer("TickUpdate", 1, 1);
		SetTimer("StaminaRegen", 360*1000, 1);
		SetTimer("TexUpdate", 16*1000, 1);
		SetTimer("RespawnItemOnGrund", 3*1000, 1);
	else
		print("Error: Missing argument on function: render_Init");
	end
end

function TickUpdate()
	for i = 0, GetMaxPlayers() - 1 do
		if IsPlayerConnected(i) == 1 then
			if IsNPC(i) == 0 then
				OnTickUpdate(i)
				OnStartTick(i)
				OnStaminaUpdate(i)
				OnZoneCheck(i)
			end
		end
	end
	UpdateMap()
	OnMovementUpdate()
end

-- Callback
function OnTickUpdate(playerid)
end

-- Loaded
print(": Onservtick has been loaded.");

