function _saveInst(id)
	local file = io.open("Database/Players/Inst/"..Player[id].nickname..".txt", "w+");
	
	if Player[id].areorc == 1 then
		file:write(Player[id].areorc.."\n");
		file:write(GetPlayerInstance(id).."\n")
	else
		file:write("0".."\n".."0");
	end

	file:close();
end

function _readInst(id)
	local file = io.open("Database/Players/Inst/"..Player[id].nickname..".txt", "r");
	if file then

		line = file:read("*l");
		local result, status = sscanf(line, "d");
		if result == 1 then
			Player[id].areorc = status; 
		end

		line = file:read("*l");
		local result, inst = sscanf(line, "s");
		if result == 1 then
			if Player[id].areorc == 1 then
				SetPlayerInstance(id, inst);
				SendPlayerMessage(id, 255, 255, 255, "”становлен класс: "..inst);
			end
		end

		file:close();
	else
		_saveInst(id);
	end
end


----------------------------------------------------------------
function _saveZen(id)
	local file = io.open("Database/Players/Zens/"..Player[id].nickname..".txt", "w+");
	file:write(GetPlayerWorld(id).."\n");
	local x, y, z = GetPlayerPos(id);
	file:write(x.." "..y.." "..z);
	file:close();
end

function _readZen(id)
	local file = io.open("Database/Players/Zens/"..Player[id].nickname..".txt", "r");
	if file then

		line = file:read("*l");
		local result, world = sscanf(line, "s");
		if result == 1 then
			SetPlayerWorld(id, world);
		end

		line = file:read("*l");
		local result, x, y, z = sscanf(line, "ddd");
		if result == 1 then
			if GetPlayerWorld(id) ~= "RPCORNER_KHORINIS.ZEN" then
				SetPlayerPos(id, x, y, z);
			end
		end

		file:close();
	else
		_saveZen(id);
	end
end

function SavePlayer(playerid)
	local fileWrite = io.open("Database/Players/Profiles/"..Player[playerid].nickname..".txt", "w+");
	SavePlayerMySQL(playerid);

	local x, y, z = GetPlayerPos(playerid);
	Player[playerid].skin[1], Player[playerid].skin[2], Player[playerid].skin[3], Player[playerid].skin[4] = GetPlayerAdditionalVisual(playerid);

	fileWrite:write(Player[playerid].nickname.." " ..Player[playerid].password.."\n"); -- ник - пароль
	fileWrite:write(Player[playerid].astatus.."\n"); -- уровень прав 
	fileWrite:write(Player[playerid].skin[1]," ",Player[playerid].skin[2]," ",Player[playerid].skin[3]," ",Player[playerid].skin[4].."\n"); -- внешность
	fileWrite:write(x.." "..y.." "..z.."\n"); -- координаты выхода
	fileWrite:write(Player[playerid].rude.."\n"); -- руда
	fileWrite:write(Player[playerid].rude_coins.."\n"); -- рудные фишки
	fileWrite:write(GetPlayerWalk(playerid).."\n"); -- походка
	fileWrite:write(Player[playerid].food.."\n"); -- golod
	fileWrite:write(Player[playerid].energy.." "..Player[playerid].energyblock.."\n"); -- energy
	if Player[playerid].zvanie ~= nil then
		fileWrite:write(Player[playerid].zvanie.."\n");
	else
		fileWrite:write("NULL\n");
	end

	time = os.date('*t');
	local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	local txt = ""..rday.."."..rmonth.."."..ryear.."_"..rhour..":"..rminute;
	Player[playerid].lastplay_data = txt;

	fileWrite:write(tostring(Player[playerid].lastplay_data).."\n"); -- последн€€ игра
	fileWrite:write(Player[playerid].dead.."\n"); -- смерть

	fileWrite:close();
	_saveZen(playerid);
end

function ReadPlayer(playerid)

	local fileRead = io.open("Database/Players/Profiles/"..Player[playerid].nickname..".txt", "r+");
	tempvar = fileRead:read("*l"); -- ?мЯ/Џароль
	tempvar = fileRead:read("*l");
		local result, admin = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].astatus = admin;
		end
	

	tempvar = fileRead:read("*l");
		local result, wyg_1, wyg_2, wyg_3, wyg_4 = sscanf(tempvar,"sdsd");
		if result == 1 then
			SetPlayerAdditionalVisual(playerid, wyg_1, wyg_2, wyg_3, wyg_4);
		end

	tempvar = fileRead:read("*l");
		local result, x, y, z = sscanf(tempvar,"ddd");
		if result == 1 then
			SetPlayerPos(playerid, x, y, z);
		end
	

	tempvar = fileRead:read("*l");
		local result, ore = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].rude = ore;
		end
			

	tempvar = fileRead:read("*l");
		local result, level = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].rude_coins = level;
		end


	tempvar = fileRead:read("*l");
		local result, profID = sscanf(tempvar,"s");
		if result == 1 then
			SetPlayerWalk(playerid, profID);
		end

	tempvar = fileRead:read("*l");
		local result, profID = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].food = profID;
		end

	tempvar = fileRead:read("*l");
		local result, profID, profID2 = sscanf(tempvar,"dd");
		if result == 1 then
			Player[playerid].energy = profID;
			Player[playerid].energyblock = profID2;

			local status = false;
			if _checkBlock(playerid, "energy", Player[playerid].nickname) == true then
				status = true;
			end
			
			if status == false then
				if _checkPreEnergy(playerid) == false then
					Player[playerid].energyblock = 0;
					SetTimerEx(_loHeal, 2000, 0, playerid);
				end
			end
		end

	tempvar = fileRead:read("*l");
		local result, profID = sscanf(tempvar,"s");
		if result == 1 then
			if profID ~= "NULL" then
				Player[playerid].zvanie = profID;
			else
				Player[playerid].zvanie = nil;
			end
		end

	tempvar = fileRead:read("*l"); -- пропускаем lastplay_data

	tempvar = fileRead:read("*l");
	local result, tempdead = sscanf(tempvar,"d");
	if result == 1 then
		Player[playerid].dead = tempdead;
	end

	fileRead:close()
	
end

function _loHeal(id)
	SetPlayerHealth(id, GetPlayerMaxHealth(id));
	SaveStats(id);
end
