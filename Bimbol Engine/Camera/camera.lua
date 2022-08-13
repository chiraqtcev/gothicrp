--[[
	
	Module: camera.lua
	Autor: Bimbol
	
	Camera function
	
]]--

local CameraVob = {};

function freezeCameraTimer(id)
	FreezeCamera(id, 1);
end

function camTimer(id)
	_newSetCameraBeforePlayer(id, 50);
end

function _newSetCameraBeforePlayer_f(playerid)

	local r_y = GetPlayerAngle(playerid);
	local x, y, z = GetPlayerPos(playerid);
	local _sin = math.sin(math.rad(r_y));
	local _cos = math.cos(math.rad(r_y));
	x = x + 100 * _sin;
	z = z + 100 * _cos;
	CameraVob[playerid] = Vob.Create("", GetPlayerWorld(playerid), x-300, y+50, z)
	CameraVob[playerid]:SetRotation (0, r_y-180-45, 0)
	SetCameraBehindVob(playerid, CameraVob[playerid]);

end

function _newSetCameraBeforePlayer(playerid, distance)

	local r_y = GetPlayerAngle(playerid);
	local x, y, z = GetPlayerPos(playerid);
	local _sin = math.sin(math.rad(r_y));
	local _cos = math.cos(math.rad(r_y));
	x = x + 100 * _sin;
	z = z + 100 * _cos;
	CameraVob[playerid] = Vob.Create("", GetPlayerWorld(playerid), x, y-60, z+100)
	CameraVob[playerid]:SetRotation (0, r_y-180+45, 0)
	SetCameraBehindVob(playerid, CameraVob[playerid]);

end

function setCameraBeforePlayer(playerid, distance)
	if CameraVob[playerid] then CameraVob[playerid]:Destroy(); end
	local x, y, z = GetPlayerPos(playerid);
	local angle = GetPlayerAngle(playerid);
	CameraVob[playerid] = Vob.Create("", GetPlayerWorld(playerid), x, y, z);
	CameraVob[playerid]:SetRotation(0, angle, 0);
	
	x = x + (math.sin(angle * 3.14 / 180.0) * distance);
	z = z + (math.cos(angle * 3.14 / 180.0) * distance);
	
	CameraVob[playerid]:SetPosition(x, y-50, z-50);
	CameraVob[playerid]:SetRotation(0, angle + 160, 0);
	SetCameraBehindVob(playerid, CameraVob[playerid]);
end

function SetDefaultCamera(playerid)
	_SetDefaultCamera(playerid);
	restartCamera(playerid);
end

function restartCamera(playerid)
	if CameraVob[playerid] then
		CameraVob[playerid]:Destroy();
		CameraVob[playerid] = nil;
	end
end


-- Loaded
print(debug.getinfo(1).source.." has been loaded.");


