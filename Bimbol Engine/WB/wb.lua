--[[

	Module: wb.lua
	Author: Bimbol
	
	World Builder

]]--

local Help = {
	CreateDraw(6000, 1000, "Управление:", "Font_Old_20_White_Hi.TGA", 255, 255, 255),
	CreateDraw(6000, 1250, "7-1: Вращать по оси Х", "Font_Old_10_White_Hi.TGA", 255, 255, 255),
	CreateDraw(6000, 1450, "Q-E: Вращать по оси У", "Font_Old_10_White_Hi.TGA", 255, 255, 255),
	CreateDraw(6000, 1650, "9-3: Вращать по оси Z", "Font_Old_10_White_Hi.TGA", 255, 255, 255),
	CreateDraw(6000, 1850, "8-2: Замена высоты", "Font_Old_10_White_Hi.TGA", 255, 255, 255),
	CreateDraw(6000, 2050, "W-S-A-D: Двидение вперед/назад/влево/вправа", "Font_Old_10_White_Hi.TGA", 255, 255, 255),
	CreateDraw(6000, 2250, "< - >: Замена воба", "Font_Old_10_White_Hi.TGA", 255, 255, 255),
	CreateDraw(6000, 2450, "/\\ - \\/: Изменение скорости передвижения", "Font_Old_10_White_Hi.TGA", 255, 255, 255),
	CreateDraw(6000, 2650, "Z: Уничтожить последний поставленный воб", "Font_Old_10_White_Hi.TGA", 255, 255, 255),
};

local TERRAIN_POINT_WB = 30;
local MAX_SPEED = 80;
local PATH_FILE = "Database/wb.save";
local PATH_WB_ADMIN = "Database/wbadmin.save";

local Vobs = {};
local Player = {};

function InitWB()
	SetTimer("UpdateWB", 200, 1);
	for i = 0, GetMaxPlayers() do
		Player[i] = {};
		Player[i].VobSpeed = 1;
		Player[i].gVobID = -1;
		Player[i].gVob = nil;
		Player[i].lastVobs = {};
		Player[i].mapVobs = {};
		Player[i].Key = {};
		Player[i].Key["W"] = false;
		Player[i].Key["A"] = false;
		Player[i].Key["S"] = false;
		Player[i].Key["D"] = false;
		Player[i].Key["Q"] = false;
		Player[i].Key["E"] = false;
		Player[i].Key["8"] = false;
		Player[i].Key["2"] = false;
		Player[i].Key["7"] = false;
		Player[i].Key["1"] = false;
		Player[i].Key["9"] = false;
		Player[i].Key["3"] = false;
	end
end

function UnPushKey(playerid, key)
	Player[playerid].Key[key] = false;
end

function PushKey(playerid, key)
	Player[playerid].Key[key] = true;
end

function SaveWB()
	if openFile(PATH_FILE, "w+") then
		for i in pairs(Vobs) do
			local x, y, z = Vobs[i].id:GetPosition();
			local xr, yr, zr = Vobs[i].id:GetRotation();
			writeFileText(PATH_FILE, x.." "..y.." "..z.." "..Vobs[i].vob.." "..xr.." "..yr.." "..zr.." "..Vobs[i].world, true);
		end
		closeFile(PATH_FILE);
	else
		LogString("save_error.txt", "Can't update or create file: "..PATH_FILE);
	end
end

function LoadWB()
	if openFile(PATH_FILE, "r+") then
		local vobs = readFileLines(PATH_FILE, "dddsddds");
		for i in pairs(vobs) do
			local id = Vob.Create(vobs[i][4], vobs[i][8], vobs[i][1], vobs[i][2], vobs[i][3]);
			id:SetRotation(vobs[i][5], vobs[i][6], vobs[i][7]);
			table.insert(Vobs, { id = id, vob = vobs[i][4], world = vobs[i][8] });
		end
		closeFile(PATH_FILE);
		if openFile(PATH_WB_ADMIN, "r+") then
			local vobs_adm = readFileLines(PATH_WB_ADMIN, "dddsddds");
			for i in pairs(vobs_adm) do
				local id = Vob.Create(vobs_adm[i][4], vobs_adm[i][8], vobs_adm[i][1], vobs_adm[i][2], vobs_adm[i][3]);
				id:SetRotation(vobs_adm[i][5], vobs_adm[i][6], vobs_adm[i][7]);
			end
			closeFile(PATH_WB_ADMIN);
			print("LOADED!!!!");
		end
	else
		LogString("save_error.txt", "Can't open file: "..PATH_FILE);
	end
end

function RestartPlayerWB(playerid)
	if getEnableWB(playerid) then
		stopWB(playerid);
	end
	for i = 1, #Player[playerid].mapVobs do
		Player[playerid].mapVobs[1]:Destroy();
		table.remove(Player[playerid].mapVobs, 1);
	end
	Player[playerid].VobSpeed = 1;
end

function getEnableWB(playerid)
	if Player[playerid].gVob then
		return true;
	end
		return false;
end
		
function switchWB(playerid)
		if Player[playerid].gVob then
			stopWB(playerid);
		else
			startWB(playerid);
		end
	end

function startWB(playerid)
	local x, y, z = GetPlayerPos(playerid);
		ShowHelp(playerid);
		Player[playerid].gVobID = 1;
		Player[playerid].gVob = Vob.Create(getVobByID(1), GetPlayerWorld(playerid), x, y, z);
		SetCameraBehindVob(playerid, Player[playerid].gVob);reezePlayer(playerid, 1);
end

function stopWB(playerid)
	local amount_vob = #Player[playerid].lastVobs;
	for i = 1, amount_vob do
		table.insert(Vobs, { id = Player[playerid].lastVobs[1].id, vob = Player[playerid].lastVobs[1].vob, world = Player[playerid].lastVobs[1].world });
		table.remove(Player[playerid].lastVobs, 1);
	end
	Player[playerid].gVob:Destroy();
	Player[playerid].gVob = nil;
	Player[playerid].gVobID = -1;
	Player[playerid].Key["W"] = false;
	Player[playerid].Key["A"] = false;
	Player[playerid].Key["S"] = false;
	Player[playerid].Key["D"] = false;
	Player[playerid].Key["Q"] = false;
	Player[playerid].Key["E"] = false;
	Player[playerid].Key["8"] = false;
	Player[playerid].Key["2"] = false;
	Player[playerid].Key["7"] = false;
	Player[playerid].Key["1"] = false;
	Player[playerid].Key["9"] = false;
	Player[playerid].Key["3"] = false;
	HideHelp(playerid);
	SaveWB();
	SetDefaultCamera(playerid);
	FreezePlayer(playerid, 0);
end

function changeVob(playerid, value)
	local x, y, z = Player[playerid].gVob:GetPosition();
	local rx, ry, rz = Player[playerid].gVob:GetRotation();
	Player[playerid].gVobID = Player[playerid].gVobID + value;
	if Player[playerid].gVobID == 0 then
		Player[playerid].gVobID = 838;
	elseif Player[playerid].gVobID > 838 then
		Player[playerid].gVobID = 1;
	end
	Player[playerid].gVob:Destroy();
	Player[playerid].gVob = Vob.Create(getVobByID(Player[playerid].gVobID), GetPlayerWorld(playerid), x, y, z);
	Player[playerid].gVob:SetRotation(rx, ry, rz);
	SetCameraBehindVob(playerid, Player[playerid].gVob);
end

function changeSpeed(playerid, speed)
	Player[playerid].VobSpeed = Player[playerid].VobSpeed + speed;
	if Player[playerid].VobSpeed <= 0 then
		Player[playerid].VobSpeed = 1;
	elseif Player[playerid].VobSpeed > MAX_SPEED then
		Player[playerid].VobSpeed = MAX_SPEED;
	end
end

function changeVobRotationY(playerid, rot)
	local rx, ry, rz = Player[playerid].gVob:GetRotation();
	Player[playerid].gVob:SetRotation(rx, ry + (rot*(Player[playerid].VobSpeed/2)), rz);
end

function changeVobRotationX(playerid, rot)
	local rx, ry, rz = Player[playerid].gVob:GetRotation();
	Player[playerid].gVob:SetRotation(rx + (rot*(Player[playerid].VobSpeed/2)), ry, rz);
end

function changeVobRotationZ(playerid, rot)
	local rx, ry, rz = Player[playerid].gVob:GetRotation();
	Player[playerid].gVob:SetRotation(rx, ry, rz + (rot*(Player[playerid].VobSpeed/2)));
end

function changeVobHeight(playerid, width)
	local x, y, z = Player[playerid].gVob:GetPosition();
	Player[playerid].gVob:SetPosition(x, y+(width*Player[playerid].VobSpeed), z);
end

function changeVobPos(playerid, angle)
	local x, y, z = Player[playerid].gVob:GetPosition();
	local rx, ry, rz = Player[playerid].gVob:GetRotation();
	local dis = Player[playerid].VobSpeed * 2;
	if ry < 0 then 
		ry = ry + ((math.ceil(math.abs(ry) / 360)) * 360);
	else 
		ry = ry - ((math.floor(ry / 360)) * 360);
	end
	local rot = ry + angle;
	rot = rot - math.floor(rot / 360) * 360;

	if rot % 90 == 0 then
		if rot == 0 then 
			Player[playerid].gVob:SetPosition(x,y,z+dis);
		elseif rot == 90 then  
			Player[playerid].gVob:SetPosition(x+dis,y,z);
		elseif rot == 180 then 
			Player[playerid].gVob:SetPosition(x,y,z-dis);
		elseif rot == 270 then 
			Player[playerid].gVob:SetPosition(x-dis,y,z);
		end
	else
		local mrot = (math.floor(rot / 90)) * 90;
		local a = math.cos(math.rad(rot - mrot)) * dis;
		local b = math.sin(math.rad(rot - mrot)) * dis;
		if rot > 0 and rot < 90 then Player[playerid].gVob:SetPosition(x + b, y,z + a);
		elseif rot > 90 and rot < 180 then 
			Player[playerid].gVob:SetPosition(x + a, y,z - b);
		elseif rot > 180 and rot < 270 then 
			Player[playerid].gVob:SetPosition(x - b, y, z - a);
		elseif rot > 270 then 
			Player[playerid].gVob:SetPosition(x - a, y, z + b);
		end
	end
end

function createVob(playerid)
		local x, y, z = Player[playerid].gVob:GetPosition();
		local rx, ry, rz = Player[playerid].gVob:GetRotation();
		local world = GetPlayerWorld(playerid);
		table.insert(Player[playerid].lastVobs, { id = Player[playerid].gVob, vob = getVobByID(Player[playerid].gVobID), world = GetPlayerWorld(playerid) });
		Player[playerid].gVob = Vob.Create(getVobByID(Player[playerid].gVobID), world, x, y, z);
		Player[playerid].gVob:SetRotation(rx, ry, rz);
		SetCameraBehindVob(playerid, Player[playerid].gVob);
end

function destroyLastVob(playerid)
	if #Player[playerid].lastVobs > 0 then
		Player[playerid].lastVobs[#Player[playerid].lastVobs].id:Destroy();
		table.remove(Player[playerid].lastVobs, #Player[playerid].lastVobs);
	end
end

function UpdateWB()
	for i = 0, GetMaxPlayers() - 1 do
		if IsPlayerConnected(i) == 1 and Player[i].gVob then
			if Player[i].Key["W"] then
				changeVobPos(i, 0);
			end
			if Player[i].Key["A"] then
				changeVobPos(i, 270);
			end
			if Player[i].Key["S"] then
				changeVobPos(i, 180);
			end
			if Player[i].Key["D"] then
				changeVobPos(i, 90);
			end
			if Player[i].Key["Q"] then
				changeVobRotationY(i, -1);
			end
			if Player[i].Key["E"] then
				changeVobRotationY(i, 1);
			end
			if Player[i].Key["8"] then
				changeVobHeight(i, 1);
			elseif Player[i].Key["2"] then
				changeVobHeight(i, -1);
			end
			if Player[i].Key["7"] then
				changeVobRotationX(i, 1);
			elseif Player[i].Key["1"] then
				changeVobRotationX(i, -1);
			end
			if Player[i].Key["9"] then
				changeVobRotationZ(i, 1);
			elseif Player[i].Key["3"] then
				changeVobRotationZ(i, -1);
			end
		end
	end
end

function ShowHelp(playerid)
	for i in pairs(Help) do
		ShowDraw(playerid, Help[i]);
	end
end

function HideHelp(playerid)
	for i in pairs(Help) do
		HideDraw(playerid, Help[i]);
	end
end

function PutScaffolding(playerid)
		local x, y, z = GetPlayerPos(playerid);
		local angle = GetPlayerAngle(playerid);
		local world = GetPlayerWorld(playerid);
		y = y + 150;
		local vob = Vob.Create(getVobByID(2), world, x, y, z);
		table.insert(Player[playerid].mapVobs, vob);
		local dis = 100;
		if angle < 0 then 
			angle = angle + ((math.ceil(math.abs(angle) / 360)) * 360);
		else 
			angle = angle - ((math.floor(angle / 360)) * 360);
		end
		local rot = angle;
		rot = rot - math.floor(rot / 360) * 360;

		if rot % 90 == 0 then
			if rot == 0 then 
				vob:SetPosition(x, y, z + dis);
			elseif rot == 90 then  
				vob:SetPosition(x + dis, y, z);
			elseif rot == 180 then 
				vob:SetPosition(x, y, z - dis);
			elseif rot == 270 then 
				vob:SetPosition(x - dis, y, z);
			end
		else
			local mrot = (math.floor(rot / 90)) * 90;
			local a = math.cos(math.rad(rot - mrot)) * dis;
			local b = math.sin(math.rad(rot - mrot)) * dis;
			if rot > 0 and rot < 90 then vob:SetPosition(x + b, y, z + a);
			elseif rot > 90 and rot < 180 then 
				vob:SetPosition(x + a, y, z - b);
			elseif rot > 180 and rot < 270 then 
				vob:SetPosition(x - b, y, z - a);
			elseif rot > 270 then 
				vob:SetPosition(x - a, y, z + b);
			end
		end
end

-- Loaded
print(debug.getinfo(1).source.." has been loaded.");