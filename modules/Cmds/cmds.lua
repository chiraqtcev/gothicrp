
function _findByName(id, sets)

	local result, name = sscanf(sets, "s");
	if result == 1 then
		for i = 0, GetMaxPlayers() do
			if GetPlayerName(i) == name then
				SendPlayerMessage(id, 255, 255, 255, "���� ������ � ��������� "..name..": "..i);
				break
			end
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "/�� (�������)");
	end

end
addCommandHandler({"/��", "/id"}, _findByName);

function _doAfk(id)

	if Player[id].loggedIn == true then
		if Player[id].afk == false then
			Player[id].afk = true;
			SendPlayerMessage(id, 255, 255, 255, "AFK-������ �����������.")
			FreezeCamera(id, 1);
			Freeze(id);
			LogString("Logs/PlayersAll/AFK", GetPlayerName(id).." ����������� ������ ���");
		else
			Player[id].afk = false;
			SendPlayerMessage(id, 255, 255, 255, "AFK-������ �������������.")
			FreezeCamera(id, 0);
			UnFreeze(id);
			SetDefaultCamera(id);
			LogString("Logs/PlayersAll/AFK", GetPlayerName(id).." ������������� ������ ���");
		end
	end

end
addCommandHandler({"/���", "/afk"}, _doAfk);

function _getMaskDB(id)

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
	if file then
		for line in file:lines() do
			local result, mask, d = sscanf(line, "sd");
			if result == 1 then
				if mask == "WINUPP_ITHE_MASK_06" then
					file:close();
					return true;
				end
			end
		end
	end
	return false;
end

function Masked(playerid)
	
	if Player[playerid].loggedIn == true then
		if Player[playerid].masked == false then

			if _getMaskDB(playerid) == true then
				Player[playerid].masked = true;
				EnablePlayerNickname(playerid, 0);
				SendPlayerMessage(playerid, 255, 255, 255, "�� ������ �����.");
			else
				SendPlayerMessage(playerid, 255, 255, 255, "� ��� ��� �����.")
			end
		else
			Player[playerid].masked = false;
			EnablePlayerNickname(playerid, 1);
			SendPlayerMessage(playerid, 255, 255, 255, "�� ����� �����.");
		end
	end

end
addCommandHandler({"/�����", "/mask"}, Masked);

function CMD_Roll(playerid, params)
	local result, dice, face = sscanf(params,"dd");
	local random_roll = 0;
	local summ = 0;
	if result~=1 then
		dice = 1;
		face= 100;
	end
	if dice > 10 or dice == 0 then
		SSendPlayerMessage(playerid,250,0,0,"�� ������� ������� ��������!");
	else
		if face > 100 or face == 0 then
			SSendPlayerMessage(playerid,250,0,0,"�� ������� ������� ��������!");
		else
			if (dice == tonumber(dice)) and (face == tonumber(face)) then
				for i = 1, dice do
					random_roll = math.random(face) + 0;
					summ = summ + random_roll
				end
				if IsPlayerConnected(playerid) == 1 then
					for i = 0, MAX_PLAYERS - 1 do
						if GetDistancePlayers(playerid,i) <= 1500 then
							--SendPlayerMessage(i,CHAT_RP_COLOR.r, CHAT_RP_COLOR.g, CHAT_RP_COLOR.b,string.format("%s%s%s","(",wep,") ")..Player[playerid].nick.." �������� �� ������ �����: "..summ.." ("..dice.."d"..face..").");
							SendPlayerMessage(i,255,255,0,Player[playerid].nickname.." �������� �� ������ "..summ.." ("..dice.."d"..face..")");			
						end
					end
				end
			else
				SSendPlayerMessage(playerid,255,154,100,string.format("�������� �������� ������ ���� ���������."));
			end
		end
	end
end
addCommandHandler({"/����","/roll"}, CMD_Roll)

function CMD_WALK(playerid,params)
	local result,page = sscanf(params,"d");
	if result == 1 then
		if page == 1 then
			RemovePlayerOverlay(playerid, GetPlayerWalk(playerid));
			SetPlayerWalk(playerid,"HUMANS_G1STANDARD.mds");
			Player[playerid].overlay = "HUMANS_G1STANDARD.mds"
			SendPlayerMessage(playerid,245,243,200,"(INFO): ����������� ������� ��!");
		elseif page == 2 then
			RemovePlayerOverlay(playerid, GetPlayerWalk(playerid));
			SetPlayerWalk(playerid,"HUMANS_G1MAGE.mds");
			Player[playerid].overlay = "HUMANS_G1MAGE.mds"
			SendPlayerMessage(playerid,245,243,200,"(INFO): ����������� ������� ����!");
		elseif page == 3 then
			RemovePlayerOverlay(playerid, GetPlayerWalk(playerid));
			SetPlayerWalk(playerid,"HUMANS_G1MILITIA.mds");
			Player[playerid].overlay = "HUMANS_G1MILITIA.mds"
			SendPlayerMessage(playerid,245,243,200,"(INFO): ����������� ������� ������!");
		elseif page == 4 then
			RemovePlayerOverlay(playerid, GetPlayerWalk(playerid));
			SetPlayerWalk(playerid,"HUMANS_G1RELAXED.mds");
			Player[playerid].overlay = "HUMANS_G1RELAXED.mds"
			SendPlayerMessage(playerid,245,243,200,"(INFO): ����������� ������������ �������!");
		elseif page == 5 then
			RemovePlayerOverlay(playerid, GetPlayerWalk(playerid));
			SetPlayerWalk(playerid,"HUMANS_G1TIRED.mds");
			Player[playerid].overlay = "HUMANS_G1TIRED.mds"
			SendPlayerMessage(playerid,245,243,200,"(INFO): ����������� �������� �������!");
		elseif page == 6 then
			RemovePlayerOverlay(playerid, GetPlayerWalk(playerid));
			SetPlayerWalk(playerid,"HUMANS_G1ARROGANCE.mds");
			Player[playerid].overlay = "HUMANS_G1ARROGANCE.mds"
			SendPlayerMessage(playerid,245,243,200,"(INFO): ����������� ������ �������!");
		elseif page == 7 then
			RemovePlayerOverlay(playerid, GetPlayerWalk(playerid));
			SetPlayerWalk(playerid,"HUMANS_BABE.mds");
			Player[playerid].overlay = "HUMANS_BABE.mds"
			SendPlayerMessage(playerid,245,243,200,"(INFO): ����������� ������� �������!");
		elseif page == 8 then
			RemovePlayerOverlay(playerid, GetPlayerWalk(playerid));
			SetPlayerWalk(playerid,"HUMANS_WALK_B.mds");
			Player[playerid].overlay = "HUMANS_WALK_B.mds"
			SendPlayerMessage(playerid,245,243,200,"(INFO): ����������� ������� ����������!");
		elseif page == 9 then
			RemovePlayerOverlay(playerid, GetPlayerWalk(playerid));
			SetPlayerWalk(playerid,"HUMANS_G1DRUNKEN.mds");
			Player[playerid].overlay = "HUMANS_G1DRUNKEN.mds"
			SendPlayerMessage(playerid,245,243,200,"(INFO): ����������� ������� �������!");
		elseif page == 10 then
			RemovePlayerOverlay(playerid, GetPlayerWalk(playerid));
			SetPlayerWalk(playerid,"Humans_Mage.mds");
			Player[playerid].overlay = "Humans_Mage.mds"
			SendPlayerMessage(playerid,245,243,200,"(INFO): ����������� ������� ���� �� G2!");
			
		elseif page == 11 then
			RemovePlayerOverlay(playerid, GetPlayerWalk(playerid));
			SetPlayerWalk(playerid,"HUMANS_POCKETWALK.mds");
			Player[playerid].overlay = "HUMANS_POCKETWALK.mds"
			SendPlayerMessage(playerid,245,243,200,"(INFO): ����������� ������� � ������ � ��������!");
			
		elseif page == 12 then
			RemovePlayerOverlay(playerid, GetPlayerWalk(playerid));
			SetPlayerWalk(playerid,"humans_leader.mds");
			Player[playerid].overlay = "humans_leader.mds"
			SendPlayerMessage(playerid,245,243,200,"(INFO): ����������� ������� � ������ �� ������!");

		elseif page == 13 then
			RemovePlayerOverlay(playerid, GetPlayerWalk(playerid));
			SetPlayerWalk(playerid,"humans_hurt.mds");
			Player[playerid].overlay = "humans_hurt.mds"
			SendPlayerMessage(playerid,245,243,200,"(INFO): ����������� ������� ����� ��������!");

		elseif page == 14 then
			RemovePlayerOverlay(playerid, GetPlayerWalk(playerid));
			SetPlayerWalk(playerid,"humans_wounded.mds");
			Player[playerid].overlay = "humans_wounded.mds"
			SendPlayerMessage(playerid,245,243,200,"(INFO): ����������� ������� ������ ��������!");
			
		else
			SendPlayerMessage(playerid,249,106,106,"(INFO): ������! ��������� /������� (1-14).");
		end
	else
		SendPlayerMessage(playerid,249,106,106,"(INFO): ������! ��������� /������� (1-14).");
	end
end
addCommandHandler({"/�������","/walk"}, CMD_WALK)



addCommandHandler({"/���","/adm","/�������"}, function(playerid, param)
	GetAdminsOnline(playerid)
end);

local pm_sound = CreateSound("OWL_03.WAV");
function _sendMessage(id, sets)

	time = os.date('*t');
	local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local result, pid, text = sscanf(sets, "ds");
	if result == 1 then
		if Player[pid].blockpm == false then
			if IsNPC(pid) == 0 then
				if Player[pid].loggedIn == true then

					--[[local status = false;
					local text_find = string.lower(text);

					if Player[id].astatus < 1 and Player[pid].astatus > 0 then
						for _, v in pairs(bad_words_heal) do
							local find = string.find(text_find, v);
							if find then
								SendPlayerMessage(id, 255, 255, 255, "������ ������� �� � ������ ��������� � �������������.")
								Player[id].warns = Player[id].warns + 1;
								SendPlayerMessage(id, 255, 255, 255, "��� ������ �������������� �� �������: ������� ������� �2.2");
								SendPlayerMessage(id, 255, 255, 255, "��� ���������� 3� �������������� �� ������ ��������. ������� ���-��: "..Player[id].warns);
								_saveWarn(id);

								if _getWarns(id) == 3 then
									Player[id].warns = 0;
									_saveWarn(id);
									Ban(id);
								end

								status = true;
								break
							end
						end
					end]]

					--if status == false then
						SendPlayerMessage(pid, 208, 217, 33, "��������� �� "..GetPlayerName(id).." ("..id.."): "..text);
						SendPlayerMessage(id, 208, 217, 33, "��������� ��� "..GetPlayerName(pid).." ("..pid.."): "..text);
						PlayPlayerSound(pid, pm_sound);
						
						LogString("Logs/PlayersAll/PM",""..GetPlayerName(id).." > "..GetPlayerName(pid)..": "..text.." / ����: "..rday.."."..rmonth.."."..ryear.." "..rhour..":"..rminute);
						
						for i = 0, GetMaxPlayers() do
							if Player[i].astatus > 0 then
								if Player[i].stalkerpm == true then
									SendPlayerMessage(i, 208, 217, 33, GetPlayerName(id).." >> "..GetPlayerName(pid)..": "..text);
								end
							end
						end
					--end
				else
					SendPlayerMessage(id, 255, 255, 255, "����� �� �������������.");
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "��� ���.");
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "����� �������� ��������� ��.");
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "/�� (��) (����� ���������)");
	end
end
addCommandHandler({"/��", "/pm"}, _sendMessage);

function _blockPM(id)

	if Player[id].blockpm == false then
		Player[id].blockpm = true;
		SendPlayerMessage(id, 255, 255, 255, "�� ������� ������ ���������.")
	elseif Player[id].blockpm == true then
		Player[id].blockpm = false;
		SendPlayerMessage(id, 255, 255, 255, "�� ������� ������ ���������.")
	end

end
addCommandHandler({"/������", "/pmblock"}, _blockPM);

function _stalkerPM(id)

	if Player[id].astatus > 1 then
		if Player[id].stalkerpm == false then
			Player[id].stalkerpm = true;
			SendPlayerMessage(id, 255, 255, 255, "�� ������ ������������ ��.")
		else
			Player[id].stalkerpm = false;
			SendPlayerMessage(id, 255, 255, 255, "�� ��������� ������������ ��.")
		end
	end

end
addCommandHandler({"/���������", "/pmstalker"}, _stalkerPM);

function CMD_DROPITEM(playerid,params)
	local result,slot,amountdrop = sscanf(params,"dd");
	if result == 1 then	
		if amountdrop > 0 then
			Player[playerid].drop = true;
			Player[playerid].amounts = amountdrop;
			GetPlayerItem(playerid, slot);
			--SaveAccount(playerid);
		else
			SendPlayerMessage(playerid,249,106,106,"(INFO): ������! ���������� �� ����� ���� ������ ��� ����� 0!");
		end
	else
		SendPlayerMessage(playerid,249,106,106,"(INFO): ������! ��������� /� (����) (���-��). ����� ���������� � ����!");
	end
end
addCommandHandler({"/�","/drop"}, CMD_DROPITEM)
function CMD_SavePosition(playerid, params)

	if Player[playerid].astatus > 2 then
		local x, y, z = GetPlayerPos( playerid )
		local angle = GetPlayerAngle( playerid )
		SendPlayerMessage(playerid,255,250,0,"(����): ������� ����������: "..x.." | "..y.." | "..z);
		local result, name = sscanf( params, "s" )
		if result == 1 then
			local message = string.format("%s, %s, %s, %s", x, y, z, angle)
			plik = io.open("Database/_Coord/".. name .. ".txt", "w+")
			plik:write(message)
			plik:close()
			SendPlayerMessage(playerid,255,255,0,"��������� � ���� "..name..".txt")
		else
			SendPlayerMessage(playerid,255,255,0,"(����): /����� <��������>")
		end
	end
end
addCommandHandler({"/�����","/coord"}, CMD_SavePosition)

local SOUND = CreateSound("GELDBEUTEL.WAV")
---------------------------------------------------------------
function _giveMyRudeTo(id, sets)

	if Player[id].loggedIn == true then
		local result, pid, value = sscanf(sets, "dd");
		if result == 1 then
			if Player[id].rude >= value then
				if Player[pid].loggedIn == true and IsPlayerConnected(pid) == 1 then
					if IsNPC(pid) == 0 then
						if GetDistancePlayers(id, pid) < 600 then
							Player[pid].rude = Player[pid].rude + value;
							Player[id].rude = Player[id].rude - value;
							SavePlayer(id);
							SavePlayer(pid);
							PlayPlayerSound(id, SOUND);
							PlayPlayerSound(pid, SOUND);
							SendPlayerMessage(id, 255, 255, 255, "�� �������� "..value.." ���� ������ "..GetPlayerName(pid)..".");
							SendPlayerMessage(pid, 255, 255, 255, "����� "..GetPlayerName(id).." ������� ��� "..value.." ����.")
						else
							SendPlayerMessage(id, 255, 255, 255, "����� ������� ������.")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "������ ���������� ���.");
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "����� �� ������������� ��� ������� ������ ����.");
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "� ��� ��� ������� ����");
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/����� (��) (���-��)");
		end
	end
end
addCommandHandler({"/�����"}, _giveMyRudeTo);

function _giveMyCoinsTo(id, sets)

	if Player[id].loggedIn == true then
		local result, pid, value = sscanf(sets, "dd");
		if result == 1 then
			if Player[id].rude_coins >= value then
				if Player[pid].loggedIn == true and IsPlayerConnected(pid) == 1 then
					if IsNPC(pid) == 0 then
						if GetDistancePlayers(id, pid) < 600 then
							Player[pid].rude_coins = Player[pid].rude_coins + value;
							Player[id].rude_coins = Player[id].rude_coins - value;
							SavePlayer(id);
							SavePlayer(pid);
							PlayPlayerSound(id, SOUND);
							PlayPlayerSound(pid, SOUND);
							SendPlayerMessage(id, 255, 255, 255, "�� �������� "..value.." ����� ������ "..GetPlayerName(pid)..".");
							SendPlayerMessage(pid, 255, 255, 255, "����� "..GetPlayerName(id).." ������� ��� "..value.." �����.")
						else
							SendPlayerMessage(id, 255, 255, 255, "����� ������� ������.")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "������ ���������� ���.");
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "����� �� ������������� ��� ������� ������ ����.");
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "� ��� ��� ������� �����");
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/������ (��) (���-��)");
		end
	end
end
addCommandHandler({"/������"}, _giveMyCoinsTo);
---------------------------------------------------------------

function _conversionRude(id, sets)

	if Player[id].loggedIn == true then
		local result, value = sscanf(sets, "d");
		if result == 1 then

			local iValue = nil;

			local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
			for line in file:lines() do
				local result, code, amount = sscanf(line, "sd");
				if code == "OOLTYB_ITMI_NUGGET" then
					if amount >= value then
						iValue = amount;
						break
					end
				end
			end

			if iValue ~= nil then
				RemoveItem(id, "OOLTYB_ITMI_NUGGET", iValue);
				Player[id].rude = Player[id].rude + value;
				local check = iValue - value;
				if check > 0 then
					GiveItem(id, "OOLTYB_ITMI_NUGGET", iValue - value);
				end
				SaveItems(id); SavePlayer(id);
				SendPlayerMessage(id, 255, 255, 255, "�� ��������������� "..value.." ����.");
			else
				SendPlayerMessage(id, 255, 255, 255, "� ��� ��� ������� ���� � ���������.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/����� (���-��).")
		end
	end

end
addCommandHandler({"/�����", "/crude"}, _conversionRude);

function _conversionRudeCoins(id, sets)

	if Player[id].loggedIn == true then
		local result, value = sscanf(sets, "d");
		if result == 1 then

			local iValue = nil;

			local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
			for line in file:lines() do
				local result, code, amount = sscanf(line, "sd");
				if code == "OOLTYB_ITMI_RUDECOIN" then
					if amount >= value then
						iValue = amount;
						break
					end
				end
			end

			if iValue ~= nil then
				RemoveItem(id, "OOLTYB_ITMI_RUDECOIN", iValue);
				Player[id].rude_coins = Player[id].rude_coins + value;
				local check = iValue - value;
				if check > 0 then
					GiveItem(id, "OOLTYB_ITMI_RUDECOIN", iValue - value);
				end
				SaveItems(id); SavePlayer(id);
				SendPlayerMessage(id, 255, 255, 255, "�� ��������������� "..value.." �����.");
			else
				SendPlayerMessage(id, 255, 255, 255, "� ��� ��� ������� ����� � ���������.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/������ (���-��).")
		end
	end

end
addCommandHandler({"/������", "/kcoins"}, _conversionRudeCoins);
---------------------------------------------------------------

function _conversionRudeCoinsToItem(id, sets)

	if Player[id].loggedIn == true then
		local result, value = sscanf(sets, "d");
		if result == 1 then
			if Player[id].rude_coins >= value then
				Player[id].rude_coins = Player[id].rude_coins - value;
				GiveItem(id, "OOLTYB_ITMI_RUDECOIN", value);
				SaveItems(id);
				SavePlayer(id);
				SendPlayerMessage(id, 255, 255, 255, "�� ��������������� "..value.." �����.");
			else
				SendPlayerMessage(id, 255, 255, 255, "� ��� ��� ������� �����.");
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/������ (���-��).")
		end
	end

end
addCommandHandler({"/������", "/scoins"}, _conversionRudeCoinsToItem);

function _conversionRudeToItem(id, sets)

	if Player[id].loggedIn == true then
		local result, value = sscanf(sets, "d");
		if result == 1 then
			if Player[id].rude >= value then
				Player[id].rude = Player[id].rude - value;
				GiveItem(id, "OOLTYB_ITMI_NUGGET", value);
				SaveItems(id);
				SavePlayer(id);
				SendPlayerMessage(id, 255, 255, 255, "�� ��������������� "..value.." ����.");
			else
				SendPlayerMessage(id, 255, 255, 255, "� ��� ��� ������� ����.");
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/����� (���-��).")
		end
	end

end
addCommandHandler({"/�����", "/srude"}, _conversionRudeToItem);

function _setTag(id, sets)

	if Player[id].loggedIn == true then
		local result, text = sscanf(sets, "s");
		if result == 1 then
			if string.len(text) < 10 then
				if text ~= "--" then
					Player[id].zvanie = text;
					SavePlayer(id);
					SendPlayerMessage(id, 255, 255, 255, "�� ���������� ���: "..text);
				elseif text == "--" then
					Player[id].zvanie = "";
					SavePlayer(id);
					SendPlayerMessage(id, 255, 255, 255, "��� �������");
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "������������ ����� ���� - 10 ��������.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/��� (�����)")
		end
	end

end
addCommandHandler({"/���"}, _setTag);

----------------------------------------------------------------------

function _saveFat(id)
	local file = io.open("Database/Players/Fat/"..Player[id].nickname..".txt", "w");
	file:write(Player[id].fatness.."\n");
	if Player[id].meinfo ~= " " then
		file:write(Player[id].meinfo.."\n")
	else
		file:write("NULL");
	end
	file:close();
end

function _readFat(id)
	local file = io.open("Database/Players/Fat/"..Player[id].nickname..".txt", "r");
	if file then

		line = file:read("*l");
		local result, fat = sscanf(line, "f");
		if result == 1 then
			Player[id].fatness = fat;
			SetPlayerFatness(id, Player[id].fatness);
		end

		line = file:read("*l");
		local result, text = sscanf(line, "s");
		if result == 1 then
			if text == "NULL" or text == " " then
				Player[id].meinfo = " ";
			else
				Player[id].meinfo = text;
			end
		end

		file:close();
	else
		_saveFat(id);
	end
end

function _setFat(id, sets)

	if Player[id].loggedIn == true then
		local result, level = sscanf(sets, "f");
		if result == 1 then
			if level > -1.1 and level < 2.6 then
				SetPlayerFatness(id, level);
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� ��� � "..level);
				Player[id].fatness = level;
				_saveFat(id);
			else
				SendPlayerMessage(id, 255, 255, 255, "���������� ������: -1.0 > 2.5");
				SendPlayerMessage(id, 255, 255, 255, "������ ����� �����.");
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/��� (-1.0 > 2.5)")
		end
	end

end
addCommandHandler({"/���"}, _setFat);

function _setInfoMe(id, sets)

	if Player[id].loggedIn == true then
		local result, text = sscanf(sets, "s");
		if result == 1 then
			if string.len(text) < 71 then
				if text ~= "--" then
					Player[id].meinfo = text;
					SendPlayerMessage(id, 255, 255, 255, "�������� ��������� ���������.")
					SendPlayerMessage(id, 255, 255, 255, "�����: "..text);
					_saveFat(id);
				elseif text == "--" then
					SendPlayerMessage(id, 255, 255, 255, "�������� ��������� ���������, ����� �������.")
					Player[id].meinfo = " ";
					_saveFat(id);
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "�������� ����� �������� (�� ����� 50)")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/����� (�����)")
			if Player[id].meinfo ~= nil then
				SendPlayerMessage(id, 255, 255, 255, "������� ��������: "..Player[id].meinfo);
			end
		end
	end

end
addCommandHandler({"/�����"}, _setInfoMe);