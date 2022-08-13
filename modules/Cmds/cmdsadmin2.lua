
-- ������������ �������� ��� ��... ��� ��� �������� � ���?..

function GetAdminsOnline(playerid) 
	SendPlayerMessage(playerid, 41, 155, 45, "������� �������:");
	for i = 0, GetMaxPlayers() do 
		if CheckConnected(i) and Player[i].astatus > 0 and Player[i].ahide == false then
			if Player[i].aduty then
				SendPlayerMessage(playerid, 41, 155, 45, "* "..GetPlayerName(i).." (�������: "..Player[i].astatus..") - �� ���������");
			else
				SendPlayerMessage(playerid, 158, 158, 158, "* "..GetPlayerName(i).." (�������: "..Player[i].astatus..") - �� �� ���������");
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
			SendPlayerMessage(pid,249,106,106,"(SERVER): �������� ������� ����!");
		end
	else
		SendPlayerMessage(pid,249,106,106,"(SERVER): ������� ������ ���� � ����!");
	end	
	for i = 0, GetMaxPlayers() do
		if IsPlayerConnected(i) == 1 then
			if Player[i].astatus > 2 and Player[i].loggedIn == true then
				SendPlayerMessage(i, 175,245,187,"(SERVER): "..GetAdminLevel(pid).." "..Player[pid].nickname.." ����� ����� '"..GetAdminLevel(id).."' ������ "..Player[id].nickname.."("..id..")");
			end
		end
	end
	SendPlayerMessage(id,175,245,187,"(SERVER): ��� ������ ����� '"..GetAdminLevel(id).."'.");
	SavePlayer(id);
end
function GetAdminLevel(pid)
	local lvl;
		if Player[pid].astatus == 1 then
			lvl = "��������"
		elseif Player[pid].astatus == 2 then
			lvl = "������"
		elseif Player[pid].astatus == 3 then
			lvl = "������� ������"
		elseif Player[pid].astatus == 4 then	
			lvl = "�����������"
		elseif Player[pid].astatus == 5 then	
			lvl = "�.�"
		end
	return lvl;
end
function CMD_GIVEADM(playerid, params) --// ������ ���� ��������������.
	local result, a_level, id_player = sscanf(params,"dd");
	if result == 1 then
		if Player[playerid].astatus > 2 then
			SetAdminLevel(playerid, a_level, id_player);
		else
			SendPlayerMessage(playerid,176,221,247,"(SERVER): ������������ ����!");
		end
	else
		SendPlayerMessage(playerid,249,106,106,"(SERVER): ������! ��������� /������� (������� ����) (id).");
	end
end
addCommandHandler({"/�������","/adminka"}, CMD_GIVEADM)

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
					SendPlayerMessage(playerid, 255, 255, 255, "������ ������� �� � ������ � �������������.")
					Player[playerid].warns = Player[playerid].warns + 1;
					SendPlayerMessage(playerid, 255, 255, 255, "��� ������ �������������� �� �������: ������� ������� �2.2");
					SendPlayerMessage(playerid, 255, 255, 255, "��� ���������� 3� �������������� �� ������ ��������. ������� ���-��: "..Player[playerid].warns);
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
			GameTextForPlayer(playerid, 3000, 3500, "��������� ����������!","Font_Old_20_White_Hi.TGA", 255, 154, 0, 2400);
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
		SendPlayerMessage(playerid, 255, 255, 255 ,"/������ (�����).");
	end
end
addCommandHandler({"/������","/report"}, CMD_REPORT)

function CMD_ASKREPORT(playerid,params)
	local result,id,text = sscanf(params,"ds");
	if Player[playerid].astatus > 1 then
		if result == 1 then
			if IsPlayerConnected(id) == 1 then
				SendPlayerMessage(id,255,68,0,GetAdminLevel(playerid).." "..Player[playerid].nickname..": "..text);
				SendPlayerMessage(playerid,255,68,0,"�� �������� ������ "..Player[id].nickname..": "..text);
				for i = 0, GetMaxPlayers() do
					if IsPlayerConnected(i) == 1 then
						if Player[i].astatus > 1 then
							if i ~= playerid then
								SendPlayerMessage(i,255,68,0,"(REPORT) "..Player[playerid].nickname.." �������� "..Player[id].nickname.." (ID:"..id.."): "..text);
							end
						end
					end
				end
				LogString("Logs/Admins/report_answer",GetAdminLevel(playerid).." "..Player[playerid].nickname.." ������� ������ "..Player[id].nickname..": "..text);
			else
				SendPlayerMessage(playerid,255,0,0,"������ � ����� ID ��� �� �������.");
			end
		else
			SendPlayerMessage(playerid,255,0,0,"������! ��������� /����� (ID ������) (�����).");
		end
	else
		GameTextForPlayer(playerid, 50, 6000, "(SERVER): ������������ ����!","Font_Old_10_White_Hi.TGA", 230, 50, 50, 3000);
	end
end
addCommandHandler({"/�����","/ask"}, CMD_ASKREPORT)

