
-- говноскрипты дикнайта что ли... или это дерьмище с орс?..

function GetAdminsOnline(playerid) 
	SendPlayerMessage(playerid, 41, 155, 45, "Игровые мастера:");
	for i = 0, GetMaxPlayers() do 
		if CheckConnected(i) and Player[i].astatus > 0 and Player[i].ahide == false then
			if Player[i].aduty then
				SendPlayerMessage(playerid, 41, 155, 45, "* "..GetPlayerName(i).." (Уровень: "..Player[i].astatus..") - на дежурстве");
			else
				SendPlayerMessage(playerid, 158, 158, 158, "* "..GetPlayerName(i).." (Уровень: "..Player[i].astatus..") - не на дежурстве");
			end
		end
	end
end

function SetAdminLevel(pid, lvl, id)
	if IsPlayerConnected(id) == 1 then
		if lvl == 0 then
			Player[id].astatus = 0
		elseif lvl == 1 then
			Player[id].astatus = 1
		elseif lvl == 2 then
			Player[id].astatus = 2
		elseif lvl == 3 then
			Player[id].astatus = 3
		elseif lvl == 4 then	
			Player[id].astatus = 4
		elseif lvl == 5 then	
			Player[id].astatus = 5
		else 
			SendPlayerMessage(pid,249,106,106,"(SERVER): Неверный уровень прав!");
		end
	else
		SendPlayerMessage(pid,249,106,106,"(SERVER): Данного игрока нету в сети!");
	end	
	for i = 0, GetMaxPlayers() do
		if IsPlayerConnected(i) == 1 then
			if Player[i].astatus > 2 and Player[i].loggedIn == true then
				SendPlayerMessage(i, 175,245,187,"(SERVER): "..GetAdminLevel(pid).." "..Player[pid].nickname.." выдал права '"..GetAdminLevel(id).."' игроку "..Player[id].nickname.."("..id..")");
			end
		end
	end
	SendPlayerMessage(id,175,245,187,"(SERVER): Вам выданы права '"..GetAdminLevel(id).."'.");
	SavePlayer(id);
end
function GetAdminLevel(pid)
	local lvl;
		if Player[pid].astatus == 1 then
			lvl = "Помощник"
		elseif Player[pid].astatus == 2 then
			lvl = "Мастер"
		elseif Player[pid].astatus == 3 then
			lvl = "Ведущий мастер"
		elseif Player[pid].astatus == 4 then	
			lvl = "Координатор"
		elseif Player[pid].astatus == 5 then	
			lvl = "Т.А"
		end
	return lvl;
end
function CMD_GIVEADM(playerid, params) --// Выдача прав администратора.
	local result, a_level, id_player = sscanf(params,"dd");
	if result == 1 then
		if Player[playerid].astatus > 2 then
			SetAdminLevel(playerid, a_level, id_player);
		else
			SendPlayerMessage(playerid,176,221,247,"(SERVER): Недостаточно прав!");
		end
	else
		SendPlayerMessage(playerid,249,106,106,"(SERVER): Ошибка! Используй /админка (уровень прав) (id).");
	end
end
addCommandHandler({"/админка","/adminka"}, CMD_GIVEADM)

local pm_sound = CreateSound("OWL_03.WAV");
function CMD_REPORT(playerid,params)
	local result,message = sscanf(params,"s");
	if result == 1 then

		--[[local status = false;
		local text_find = string.lower(message);

		if Player[playerid].astatus < 1 then
			for _, v in pairs(bad_words_heal) do
				local find = string.find(text_find, v);
				if find then
					SendPlayerMessage(playerid, 255, 255, 255, "Нельзя просить ХП в репорт у администрации.")
					Player[playerid].warns = Player[playerid].warns + 1;
					SendPlayerMessage(playerid, 255, 255, 255, "Вам выдано предупреждение по причине: правила сервера п2.2");
					SendPlayerMessage(playerid, 255, 255, 255, "При достижении 3х предупреждений вы будете забанены. Текущее кол-во: "..Player[playerid].warns);
					_saveWarn(playerid);

					if _getWarns(playerid) == 3 then
						Player[playerid].warns = 0;
						_saveWarn(playerid);
						Ban(playerid);
					end

					status = true;
					break
				end
			end
		end

		if status == false then]]
			SendPlayerMessage(playerid,255,68,0,"(REPORT): "..Player[playerid].nickname..": "..message);
			GameTextForPlayer(playerid, 3000, 3500, "Сообщение отправлено!","Font_Old_20_White_Hi.TGA", 255, 154, 0, 2400);
			LogString("Logs/PlayersAll/Reports","(REPORT) "..Player[playerid].nickname..": "..message);
	

			for i = 0, GetMaxPlayers() do
				if IsPlayerConnected(i) == 1 then
					if Player[i].astatus > 1 then
						PlayPlayerSound(i, pm_sound);
						SendPlayerMessage(i,255,68,0,"(REPORT) "..Player[playerid].nickname.." (ID:"..playerid.."): "..message);
					end
				end
			end
		--end

	else
		SendPlayerMessage(playerid, 255, 255, 255 ,"/репорт (текст).");
	end
end
addCommandHandler({"/репорт","/report"}, CMD_REPORT)

function CMD_ASKREPORT(playerid,params)
	local result,id,text = sscanf(params,"ds");
	if Player[playerid].astatus > 1 then
		if result == 1 then
			if IsPlayerConnected(id) == 1 then
				SendPlayerMessage(id,255,68,0,GetAdminLevel(playerid).." "..Player[playerid].nickname..": "..text);
				SendPlayerMessage(playerid,255,68,0,"Вы ответили игроку "..Player[id].nickname..": "..text);
				for i = 0, GetMaxPlayers() do
					if IsPlayerConnected(i) == 1 then
						if Player[i].astatus > 1 then
							if i ~= playerid then
								SendPlayerMessage(i,255,68,0,"(REPORT) "..Player[playerid].nickname.." отвечает "..Player[id].nickname.." (ID:"..id.."): "..text);
							end
						end
					end
				end
				LogString("Logs/Admins/report_answer",GetAdminLevel(playerid).." "..Player[playerid].nickname.." ответил игроку "..Player[id].nickname..": "..text);
			else
				SendPlayerMessage(playerid,255,0,0,"Игрока с таким ID нет на сервере.");
			end
		else
			SendPlayerMessage(playerid,255,0,0,"Ошибка! Используй /ответ (ID игрока) (текст).");
		end
	else
		GameTextForPlayer(playerid, 50, 6000, "(SERVER): Недостаточно прав!","Font_Old_10_White_Hi.TGA", 230, 50, 50, 3000);
	end
end
addCommandHandler({"/ответ","/ask"}, CMD_ASKREPORT)

