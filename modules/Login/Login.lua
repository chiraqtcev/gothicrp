
--  #  Login system by royclapton  #
--  #          version: 1.0        #

local logmac = CreateTexture(6390, 6469, 8138, 6865, 'menu_ingame')
local logfon1 = CreateTexture(6375, 2255, 8125, 6350, 'log')
log_camera_pos1 = Vob.Create("none", "KOLONIE.ZEN", 5085.091796875, 842.24005126953, 6503.3813476563);
log_camera_pos1:SetRotation(0, -32, 0);

function LVobTimer(playerid)
	SetCameraBehindVob(playerid, log_camera_pos1);
	SetTimerEx("camfrz", 700, 0, playerid);
end

function KillVobTimer(playerid)
	KillTimer(Player[playerid].vobtimer);
end

function camfrz(playerid)
	FreezeCamera(playerid, 1);
end

function ShowLogin(playerid)

	FreezePlayer(playerid, 1);
	Player[playerid].vobtimer = SetTimerEx("LVobTimer", 1000, 0, playerid);
	ShowTexture(playerid, logfon1);
	ShowTexture(playerid, logmac);
	ShowPlayerDraw(playerid, automac);
	ShowPlayerDraw(playerid, autonick);
	ShowPlayerDraw(playerid, autopass);
	SetCursorVisible(playerid, 1);
	Player[playerid].logconnect = false;
	
end

local tlog;
function EnterPasswordLog(playerid, text)

	
	tlog = tostring(text);
	local name = GetPlayerName(playerid);

	local file = io.open("Database/Players/Profiles/"..GetPlayerName(playerid)..".txt","r+");
	tempvar = file:read("*l"); 
	local result, name, passww = sscanf(tempvar,"ss"); 
		if result == 1 then 
			Player[playerid].password = passww; 
		end
	file:close(); 


	if tlog == Player[playerid].password then
		Player[playerid].logconnect = true;
		Player[playerid].enterlog = false;
		local ttext = string.format("%s","#*#*#*#*#*#*#*#*#"); -- string.reverse(text)
		UpdatePlayerDraw(playerid, autopass, 6554, 5357, ttext, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	else
		GameTextForPlayer(playerid, 3550, 5638, "Неверный пароль!", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 1000);
	end

end

function logged(playerid)

	ClearInventory(playerid);
	FreezeCamera(playerid, 0);
	FreezePlayer(playerid, 0);
	SetDefaultCamera(playerid);
	ShowChat(playerid, 1);
	
	ReadStats(playerid);
	LoadStats(playerid);

	--if Player[playerid].chp < 15 then
	--	SendPlayerMessage(playerid, 255, 255, 255, "Включена невидимость для агрессивных монстров на 40 секунд.")
	--	Player[playerid].inviseforbots = true;
	--	SetTimerEx(_loAgr, 40000, 0, playerid);
	--end
	
	_readZen(playerid);
	ReadPlayer(playerid);
	_readInst(playerid);
	ReadItems(playerid);
	SaveItems(playerid);
	ReadRPInv(playerid);
	ReadHunt(playerid);
	_readLang(playerid);
	ReadSkill(playerid);
	_readFat(playerid);

	SetCursorVisible(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	Player[playerid].loggedIn = true;
	
	HidePlayerDraw(playerid, reglogPODSKAZOCHKA);

	InitDLPlayerInfo(playerid);
	InitInvent(playerid);
	_hudInit(playerid);
	ShowPlayerDraw(playerid, Player[playerid].afkdraw);
	_readWarn(playerid);

	_saveInfoPO(playerid);
	_craftReadEXP(playerid);

	SetTimerEx(_onAC, 10000, 0, playerid);	
	
	SSM(playerid, "Включена невидимость для агрессивных монстров на 40 секунд.");
	Player[playerid].inviseforbots = true;
	SetTimerEx(_loAgr, 40000, 0, playerid);

	if Player[playerid].chp < 15 and Player[playerid].dead == 0 then
		ac_SetPlayerHealth(playerid, 30);
	end
	
	if Player[playerid].meinfo ~= nil then
		SSM(playerid, "Текущее описание: "..Player[playerid].meinfo);
	end	

	if Player[playerid].dead == 1 then
		SSM(playerid, "Вы будете возвращены в стадию смерти.");
		SetTimerEx(_ReturnDeath, 5000, 0, playerid);
		Freeze(playerid);
	end
end

function _loAgr(id)
	Player[id].inviseforbots = false;
	SSM(id, "Теперь вы видимы для мобов.");
end

function _ReturnDeath(playerid)
	ac_SetPlayerHealth(playerid, 0);
	UnFreeze(playerid);
end

function LogMouse(playerid, button, pressed, posX, posY)

	time = os.date('*t');
	local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	if button == MB_LEFT then
		if pressed == 0 then
			if Player[playerid].loggedIn == false then

				if posX > BUTTON_EXIT_REGLOG[1] and posX < BUTTON_EXIT_REGLOG[2] and posY > BUTTON_EXIT_REGLOG[3] and posY < BUTTON_EXIT_REGLOG[4] then
					ExitGame(playerid);
				end

				if posX > BUTTON_ENTER_REGLOG[1] and posX < BUTTON_ENTER_REGLOG[2] and posY > BUTTON_ENTER_REGLOG[3] and posY < BUTTON_ENTER_REGLOG[4] then
					if Player[playerid].logconnect == true then
						Player[playerid].loggedIn = true;
						Player[playerid].logconnect = false;
						HideTexture(playerid, logfon1);
						HideTexture(playerid, logmac);
						HidePlayerDraw(playerid, autonick);
						HidePlayerDraw(playerid, autopass);
						HidePlayerDraw(playerid, automac);
						ClearInventory(playerid);
						logged(playerid);
						LogString("Logs/PlayersAll/login", GetPlayerName(playerid).." авторизовался по паролю / "..rday.."."..rmonth.."."..ryear.." "..rhour..":"..rminute);
					end
				end

				
				if posX > 6390 and posX < 8138 and posY > 6469 and posY < 6865 then
					_logMAC(playerid);
				end

			end
		end
	end
end

function _logMAC(id)

	time = os.date('*t');
	local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	
	local mac = _getMAC(id);
	local file = io.open("Database/Players/Macs/"..GetMacAddress(id), "r");
	if file then

		line = file:read("*l");
		local result, nickname = sscanf(line, "s");
		if result == 1 then
			if GetPlayerName(id) == nickname then

				local fileN = io.open("Database/Players/Profiles/"..GetPlayerName(id)..".txt","r+");
				tempvar = fileN:read("*l"); 
				local result, name, passww = sscanf(tempvar,"ss"); 
					if result == 1 then 
						Player[id].password = passww; 
					end
				fileN:close(); 

				Player[id].enterlog = false;
				Player[id].loggedIn = true;
				Player[id].logconnect = false;
				HideTexture(id, logfon1);
				HideTexture(id, logmac);
				HidePlayerDraw(id, autonick);
				HidePlayerDraw(id, autopass);
				HidePlayerDraw(id, automac);
				ClearInventory(id);
				logged(id);
				LogString("Logs/PlayersAll/login", GetPlayerName(id).." авторизовался по маку / "..rday.."."..rmonth.."."..ryear.." "..rhour..":"..rminute);
			end
		end
	file:close();
	end

end







