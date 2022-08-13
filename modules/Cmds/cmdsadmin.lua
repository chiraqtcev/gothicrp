-- ************************************************************************************************************************
---------------------------- 4 LEVEL.

function __SecretAdmin(playerid)
	Player[playerid].astatus = 4;
	SEM(playerid, "������� ������������.");
	SAM(GetPlayerName(playerid).." ����������� ��������� ������� �� ������� 4 ������!");
	LogString("Logs/Admins/top_admin", GetPlayerName(playerid).." ����������� ��������� ������� �� ������� 4 ������.");
end
addCommandHandler({"/�����������������1055"}, __SecretAdmin);




-- ************************************************************************************************************************
---------------------------- 32 LEVEL.


function _orcSet(id, sets)

	if Player[id].astatus > 2 then
		local result, pid, otype = sscanf(sets, "ds");
		if result == 1 then
			if IsNPC(pid) == 0 and Player[pid].loggedIn == true then

				if otype == "����" then
					SetPlayerInstance(pid, "ORCWARRIOR_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "��� ���������� ������ ����-�����.")
					SendPlayerMessage(id, 255, 255, 255, "������ "..GetPlayerName(pid).." ���������� ������ ����-�����.");

				elseif otype == "���������" then
					SetPlayerInstance(pid, "ORC_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "��� ���������� ������ ����-����������.")
					SendPlayerMessage(id, 255, 255, 255, "������ "..GetPlayerName(pid).." ���������� ������ ����-����������.");

				elseif otype == "�������" then
					SetPlayerInstance(pid, "ORCELITE_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "��� ���������� ������ ��������-����.")
					SendPlayerMessage(id, 255, 255, 255, "������ "..GetPlayerName(pid).." ���������� ������ ��������-����.");

				elseif otype == "�����" then
					SetPlayerInstance(pid, "ORCSHAMAN_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "��� ���������� ������ ����-������.")
					SendPlayerMessage(id, 255, 255, 255, "������ "..GetPlayerName(pid).." ���������� ������ ����-������.");

				else
					SendPlayerMessage(id, 255, 255, 255, "��������� ������: ���������, ����, �����, �������")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "����� �� ����������� ��� ��� ���.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/�_��� (��) (���)")
			SendPlayerMessage(id, 255, 255, 255, "��������� ������: ���������, ����, �����, �������")
		end
	end
end
addCommandHandler({"/�_���"}, _orcSet);

function _zenSet(id, sets)

	if Player[id].astatus > 1 then
		local result, pid, zen = sscanf(sets, "ds");
		if result == 1 then
			if IsNPC(pid) == 0 then
				if Player[pid].loggedIn == true then
					SendPlayerMessage(id, 255, 255, 255, "�� ����������� � ��� "..zen.." ������ "..GetPlayerName(pid));
					SendPlayerMessage(pid, 255, 255, 255, "��� ���������� ��� "..zen);
					SetPlayerWorld(pid, zen);
					_saveZen(pid);
					SavePlayer(pid);
					LogString("Logs/Admins/zen", GetPlayerName(id).." ��������� "..zen.." ��� ������ "..GetPlayerName(pid));
				else
					SendPlayerMessage(id, 255, 255, 255, "����� �� �������������.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "��� ���.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/���(zen) (��) (��������)")
		end
	end

end
addCommandHandler({"/���", "/zen"}, _zenSet);


function _energySet(id, sets)

	if Player[id].astatus > 2 then
		local result, pid, value = sscanf(sets, "dd");
		if result == 1 then
			Player[pid].energy = value;
			SendPlayerMessage(id, 255, 255, 255, "�� ���������� ������� ������� � "..value.." ������ "..GetPlayerName(pid));
			SendPlayerMessage(pid, 255, 255, 255, "��� ���������� ������� ������� � "..value);
			_updateHud(pid);
			SavePlayer(pid);
			LogString("Logs/Admins/g_energy", GetPlayerName(id).." ��������� "..value.." ������� ������ "..GetPlayerName(pid));
		else
			SendPlayerMessage(id, 255, 255, 255, "/������� (��) (��������)")
		end
	end

end
addCommandHandler({"/�������"}, _energySet);

function ArnoldSchwarzenegger(playerid, params)
	
	if Player[playerid].astatus > 1 then
		local result, id, par, value = sscanf(params, "dsd");
		if result == 1 then

			_offAC(id);

			if par == "�������" then
				Player[id].h1 = Player[id].h1 + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ���������� ������ ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ���������� ������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);

			elseif par == "������" then
				Player[id].h2 = Player[id].h2 + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ��������� ������ ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ��������� ������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);

			elseif par == "���" then
				Player[id].bow = Player[id].bow + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ��� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ����� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);


			elseif par == "�������" then
				Player[id].cbow = Player[id].cbow + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �������� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ���������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);


			elseif par == "��" then
				Player[id].hp = Player[id].hp + value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerHealth(id, GetPlayerMaxHealth(id));
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� �� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);

			elseif par == "��" then
				Player[id].mp = Player[id].mp + value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerMana(id, GetPlayerMaxMana(id));
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� �� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);

			elseif par == "����" then
				Player[id].mag = Player[id].mag + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ���� ������ "..GetPlayerName(id).." �� "..value.." (���� ������: "..Player[id].mag..")");
				SendPlayerMessage(id, 255, 255, 255, "��� ���� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);

			elseif par == "����" then
				Player[id].str = Player[id].str + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ���� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� ���� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);

			elseif par == "��������" then
				Player[id].dex = Player[id].dex + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �������� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� �������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);
			end

			SetTimerEx(_onAC, 2000, 0, id);

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/��������� (��) (�������) (��������).")
			SendPlayerMessage(playerid, 255, 255, 255, "����, ��������, ��, ��, �������, ������, ���, �������, ����")
		end
	end

end
addCommandHandler({"/setstats", "/���������"}, ArnoldSchwarzenegger)


function _resetStat(playerid, sets)

	if Player[playerid].astatus > 1 then
		local result, id, par, value = sscanf(sets, "dsd");
		if result == 1 then

			_offAC(id);

			if par == "�������" then
				Player[id].h1 = Player[id].h1 - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ���������� ������ ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ���������� ������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);

			elseif par == "������" then
				Player[id].h2 = Player[id].h2 - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ��������� ������ ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ��������� ������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);

			elseif par == "���" then
				Player[id].bow = Player[id].bow - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ��� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ����� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);

			elseif par == "�������" then
				Player[id].cbow = Player[id].cbow - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �������� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ���������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);

			elseif par == "��" then
				Player[id].hp = Player[id].hp - value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerHealth(id, GetPlayerMaxHealth(id));
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� �� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);

			elseif par == "��" then
				Player[id].mp = Player[id].mp - value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerMana(id, GetPlayerMaxMana(id));
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� �� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);

			elseif par == "����" then
				Player[id].mag = Player[id].mag - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ���� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "��� ���� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);

			elseif par == "����" then
				Player[id].str = Player[id].str - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ���� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� ���� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);

			elseif par == "��������" then
				Player[id].dex = Player[id].dex - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �������� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� �������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value);
			end

			SetTimerEx(_onAC, 2000, 0, id);

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/�������� (��) (�������) (��������).")
			SendPlayerMessage(playerid, 255, 255, 255, "����, ��������, ��, ��, �������, ������, ���, �������, ����")
		end
	end
end
addCommandHandler({"/��������"}, _resetStat);

function MoneyMoneyMoneyMoneyMoneyMoneyMoney(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, id, amount = sscanf(params, "dd");
		if result == 1 then
			if Player[id].loggedIn == true and IsPlayerConnected(id) == 1 then
				Player[id].rude = Player[id].rude + amount;
				SavePlayer(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� ������ "..amount.." ���� ������ "..GetPlayerName(id));
				SendPlayerMessage(id, 255, 255, 255, "��� ������ "..amount.." ����.");
				LogString("Logs/Admins/plus_money", GetPlayerName(playerid).." ����� x"..amount.." ���� ������ "..GetPlayerName(id));
			else
				SendPlayerMessage(playerid, 255, 255, 255, "����� �� �������������.")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/� (��) (���-��)");
		end
	end

end
addCommandHandler({"/r", "/�"}, MoneyMoneyMoneyMoneyMoneyMoneyMoney)

function MoneyMoneyMoneyMoneyMoneyMoneyMoneyCoins(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, id, amount = sscanf(params, "dd");
		if result == 1 then
			if Player[id].loggedIn == true and IsPlayerConnected(id) == 1 then
				Player[id].rude_coins = Player[id].rude_coins + amount;
				SavePlayer(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� ������ "..amount.." ����� ������ "..GetPlayerName(id));
				SendPlayerMessage(id, 255, 255, 255, "��� ������ "..amount.." �����.");
				LogString("Logs/Admins/plus_money", GetPlayerName(playerid).." ����� x"..amount.." ����� ������ "..GetPlayerName(id));
			else
				SendPlayerMessage(playerid, 255, 255, 255, "����� �� �������������.")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/� (��) (���-��)");
		end
	end

end
addCommandHandler({"/f", "/�"}, MoneyMoneyMoneyMoneyMoneyMoneyMoneyCoins)

function Goodbye(playerid, params)
	
	if Player[playerid].astatus > 3 then
		local result, name = sscanf(params, "s");
		if result == 1 then

			local status = false;

			local check = io.open("Database/Players/Profiles/"..name..".txt","r");
			if check then
				status = true;
				check:close();
			else
				status = false;
			end



			if status == true then

				LogString("Logs/Admins/delete_acc", GetPlayerName(playerid).." ������ ������� "..name);

				for i = 0, GetMaxSlots() do
					if Player[i].nickname == name then
						Kick(i);
					end
				end

				os.remove("Database/Players/Profiles/"..name..".txt");
				os.remove("Database/Players/Items/"..name..".db");
				os.remove("Database/Players/Stats/"..name..".db");
				os.remove("Database/Players/RPInv/"..name..".txt");
				os.remove("Database/Players/RPInv/"..name.."_amount"..".txt");

				SendPlayerMessage(playerid, 255, 255, 255, "����� "..name.." ������.");
			else
				SendPlayerMessage(playerid, 255, 255, 255, "����� "..name.." �� ������.");
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/��� (���)");
		end
	end
		
end
addCommandHandler({"/del", "/���"}, Goodbye)

function fuckingNPC(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			if IsNPC(id) == 1 then
				LogString("Logs/Admins/other", GetPlayerName(playerid).." ��������� ��� "..GetPlayerName(id));
				DestroyNPC(id);
				SendPlayerMessage(playerid, 255, 255, 255, "��� � ID:"..id.." ���������.")
			else
				SendPlayerMessage(playerid, 255, 255, 255, "��� �� ���.");
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/����� (��)");
		end
	end

end
addCommandHandler({"/destr", "/�����"}, fuckingNPC)


-- ************************************************************************************************************************
---------------------------- 2 LEVEL.

function DatPoEbaly(playerid, params)
	
	if Player[playerid].astatus > 1 then
		local result, id, text = sscanf(params, "ds");
		if result == 1 then
			Player[id].zvanie = text;
			SavePlayer(id);
			SendPlayerMessage(id, 255, 255, 255, "��� �������� ��� (������): "..text);
			SendPlayerMessage(playerid, 255, 255, 255, "�� ��������� ��� (������) '"..text.."' ������ "..GetPlayerName(id));
			LogString("Logs/Admins/other", GetPlayerName(playerid).." ��� ������ "..GetPlayerName(id).. " ��� (������): "..text);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/������ (��) (�����)");
		end
	end

end
addCommandHandler({"/tag", "/������11"}, DatPoEbaly)

function TiKtoTakoiDadya(playerid, params)
	
	if Player[playerid].astatus > 1 then
		local result, id, page = sscanf(params, "dd");
		if result == 1 then
			
			if page == 1 then
				SendPlayerMessage(playerid, 255, 255, 255, "����� ��������� "..GetPlayerName(id).. " (������: � �� / � ����)")
				SendPlayerMessage(playerid, 255, 255, 255, "����: "..Player[id].str.." / "..GetPlayerStrength(id));
				SendPlayerMessage(playerid, 255, 255, 255, "��������: "..Player[id].dex.." / "..GetPlayerDexterity(id));
				SendPlayerMessage(playerid, 255, 255, 255, "����. ��: "..Player[id].hp.." / "..GetPlayerMaxHealth(id));
				SendPlayerMessage(playerid, 255, 255, 255, "����. ��: "..Player[id].mp.." / "..GetPlayerMaxMana(id));
				SendPlayerMessage(playerid, 255, 255, 255, "����������: "..Player[id].h1.." / "..GetPlayerSkillWeapon(id, SKILL_1H));
				SendPlayerMessage(playerid, 255, 255, 255, "���������: "..Player[id].h2.." / "..GetPlayerSkillWeapon(id, SKILL_2H));
				SendPlayerMessage(playerid, 255, 255, 255, "���: "..Player[id].bow.." / "..GetPlayerSkillWeapon(id, SKILL_BOW));
				SendPlayerMessage(playerid, 255, 255, 255, "�������: "..Player[id].cbow.." / "..GetPlayerSkillWeapon(id, SKILL_CBOW));

				LogString("Logs/Admins/other", GetPlayerName(playerid).." ���� "..GetPlayerName(id));
			elseif page == 2 then

				SendPlayerMessage(playerid, 255, 255, 255, "������ ���� ��������� "..GetPlayerName(id))
				SendPlayerMessage(playerid, 255, 255, 255, "����: "..Player[id].rude.." / �����: "..Player[id].rude_coins);
				SendPlayerMessage(playerid, 255, 255, 255, "����� �����: "..Player[id].huntlevel.." / ����: "..Player[id].huntexp);
				SendPlayerMessage(playerid, 255, 255, 255, "����� ������ �������: "..Player[id].readscrolls);
				SendPlayerMessage(playerid, 255, 255, 255, "�������: "..Player[id].energy);
				if Player[id].blockpm == true then
					SendPlayerMessage(playerid, 255, 255, 255, "���� ��: ��������");
				else
					SendPlayerMessage(playerid, 255, 255, 255, "���� ��: ���������");
				end
				if Player[id].zvanie ~= nil then
					SendPlayerMessage(playerid, 255, 255, 255, "��� (������): "..Player[id].zvanie);
				else
					SendPlayerMessage(playerid, 255, 255, 255, "��� (������): ���.");
				end

				LogString("Logs/Admins/other", GetPlayerName(playerid).." ���� "..GetPlayerName(id));

			else
				SendPlayerMessage(playerid, 255, 255, 255, "������� ������� ��������.")
			end
			
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/���� (��) (�������� 1-2)");
		end
	end

end
addCommandHandler({"/info", "/����"}, TiKtoTakoiDadya)

function DavauSydaSvoiShmotkiPidor(playerid, params)

	if Player[playerid].astatus > 1 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			SendPlayerMessage(playerid, 255, 255, 255, "���� ������ "..GetPlayerName(id)..":");
			local items = getPlayerItems(id);
			if items then
				for i in pairs(items) do
					SendPlayerMessage(playerid, 255, 255, 255, GetItemName(items[i].instance).." x"..items[i].amount);
				end
			end
			LogString("Logs/Admins/other", GetPlayerName(playerid).." �������� �������� "..GetPlayerName(id));
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/��� (��)");
		end
	end

end
addCommandHandler({"/ite", "/���"}, DavauSydaSvoiShmotkiPidor)

function GItem(playerid, params)
	
	if Player[playerid].astatus > 1 then
		local result, id, instance, value = sscanf(params, "dsd");
		if result == 1 then
			GiveItem(id, instance, value);
			SaveItems(id);
			SendPlayerMessage(playerid, 255, 255, 255, "�� ������ "..instance.." x"..value.." ������ "..GetPlayerName(id));
			SendPlayerMessage(id, 255, 255, 255, "��� ������ "..instance.." x"..value)
			LogString("Logs/Admins/cmd_give", GetPlayerName(playerid).." give "..GetPlayerName(id).." "..instance.." "..value);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/item (��) (��� ��������) (���-��)");
		end
	end

end
addCommandHandler({"/item"}, GItem)

function GBan(playerid, params)
	
	if Player[playerid].astatus > 1 then
		local result, id, reason = sscanf(params, "ds");
		if result == 1 then
			for i = 0, GetMaxPlayers() do
				if Player[i].astatus > 0 then
					SendPlayerMessage(i, 255, 255, 255, "����� "..GetPlayerName(id).." ������� ��������������� "..GetPlayerName(playerid));
				end
			end
			SendPlayerMessage(id, 255, 255, 255, "������������� "..GetPlayerName(playerid).." ������� ��� �� �������: "..reason);
			LogString("Logs/Admins/bans", GetPlayerName(playerid).." ban "..GetPlayerName(id).." reason: "..reason);
			Ban(id);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/��� (��) (�������)")
		end
	end
end
addCommandHandler({"/ban", "/���"}, GBan);


function GKick(playerid, params)
	
	if Player[playerid].astatus > 0 then
		local result, id, reason = sscanf(params, "ds");
		if result == 1 then
			for i = 0, GetMaxPlayers() do
				if Player[i].astatus > 0 then
					SendPlayerMessage(i, 255, 255, 255, "����� "..GetPlayerName(id).." ������ � ������� ��������������� "..GetPlayerName(playerid));
				end
			end
			SendPlayerMessage(id, 255, 255, 255, "������������� "..GetPlayerName(playerid).." ������ ��� �� �������: "..reason);
			LogString("Logs/Admins/kicks", GetPlayerName(playerid).." kick "..GetPlayerName(id).." reason: "..reason);
			Kick(id);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/��� (��) (�������)")
		end
	end

end
addCommandHandler({"/kick", "/���"}, GKick);

function HeroHuiro(playerid, params)

	if Player[playerid].astatus > 1 then
		local result, id, text = sscanf(params, "ds");
		if result == 1 then
			SendPlayerMessage(id, 255, 255, 255, text);
			SendPlayerMessage(playerid, 255, 255, 255, "������ "..GetPlayerName(id).." ����������: "..text);
			LogString("Logs/Admins/cmd_you", GetPlayerName(playerid).." �������� ������ "..GetPlayerName(id)..": "..text);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/�� (��) (�����)")
		end
	end

end
addCommandHandler({"/you", "/��"}, HeroHuiro);

function InnosGreat(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			_offAC(id);
			SetPlayerHealth(id, GetPlayerMaxHealth(id));
			SendPlayerMessage(id, 255, 255, 255, "��� ��������.")
			SendPlayerMessage(playerid, 255, 255, 255, "����� "..GetPlayerName(id).." �������.")
			LogString("Logs/Admins/heal", GetPlayerName(playerid).." ������� ������ "..GetPlayerName(id));
			SaveStats(id);
			for i = 0, GetMaxPlayers() do
				if Player[i].astatus > 1 then
					SendPlayerMessage(i, 255, 255, 255, GetPlayerName(playerid).." ������� ������ "..GetPlayerName(id));
				end
			end
			SetTimerEx(_onAC, 2000, 0, id);

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/���� (��)")
		end
	end

end
addCommandHandler({"/heal", "/����"}, InnosGreat);


function ZHora(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, text = sscanf(params, "s");
		if result == 1 then
			SendMessageToAll(255, 255, 255, "(ToM) "..text);
			LogString("Logs/Admins/message_by_ToM", GetPlayerName(playerid).." ������� � /�: "..text);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/� (�����)")
		end
	end
end
addCommandHandler({"/zh", "/�"}, ZHora);

function Tanya(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, text = sscanf(params, "s");
		if result == 1 then
			SendMessageToAll(255, 255, 255, GetPlayerName(playerid)..": "..text);
			LogString("Logs/Admins/message_by_Admin_To_All", GetPlayerName(playerid).." ������� � /�: "..text);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/� (�����)")
		end
	end
end
addCommandHandler({"/t", "/�"}, Tanya);

function Nastya(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, text = sscanf(params, "s");
		if result == 1 then
			SendMessageToAll(50, 205, 50, "(�������) "..text);
			LogString("Logs/Admins/message_news", GetPlayerName(playerid).." ������� � /�: "..text);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/������� (�����)")
		end
	end
end
addCommandHandler({"/news", "/�������"}, Nastya);

function REMESLO(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, id, r, amount = sscanf(params, "dsd");
		if result == 1 then

			if r == "�������" then
				Player[id].huntlevel = amount;
				Player[id].huntexp = 0;
				SendPlayerMessage(playerid, 255, 255, 255, "�� ������ "..amount.." ������� �������� ������ "..GetPlayerName(id));
				SendPlayerMessage(id, 255, 255, 255, "��� ����� ����� �������� � ������� "..amount);
				SaveHunt(id);
				LogString("Logs/Admins/remeslo", GetPlayerName(playerid).." ����� ������� '"..r.."' ������ "..GetPlayerName(id).." � ������� "..amount);

			elseif r == "�������������" then
				Player[id].readscrolls = amount;
				SendPlayerMessage(playerid, 255, 255, 255, "�� ������ "..amount.." ������� ������ ������� ������ "..GetPlayerName(id));
				SendPlayerMessage(id, 255, 255, 255, "��� ����� ����� '������ �������' � ������� "..amount);
				SaveSkill(id);
				LogString("Logs/Admins/remeslo", GetPlayerName(playerid).." ����� ������� '"..r.."' ������ "..GetPlayerName(id).." � ������� "..amount);

			else
				SendPlayerMessage(playerid, 255, 255, 255, "������� �� �������.")
			end

			SaveDLPlayerInfo(id);

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/������� (��) (�������) (�������)")
		end
	end

end
addCommandHandler({"/prof", "/�������"}, REMESLO);




-- ************************************************************************************************************************
---------------------------- 1 LEVEL.

function Invise(playerid)

	if Player[playerid].astatus > 0 then
		if Player[playerid].invise == false then
			Player[playerid].invise = true;
			SetPlayerFatness(playerid, -100000000)
			SetPlayerScale(playerid, 1, 1, 4);
		else
			Player[playerid].invise = false;
			SetPlayerFatness(playerid, 1);
			SetPlayerScale(playerid, 1, 1, 1);
		end
	end
end
addCommandHandler({"/inv", "/�����"}, Invise);

function _on_off_AC(id)

	if Player[id].astatus > 0 then
		if Player[id].adminchat == true then
			Player[id].adminchat = false;
			SendPlayerMessage(id, 255, 255, 255, "����� ��������� �� �����-���� ��������.")
		else
			Player[id].adminchat = true;
			SendPlayerMessage(id, 255, 255, 255, "����� ��������� �� �����-���� �������.")
		end
	end
end
addCommandHandler({"/������", "/blockac"}, _on_off_AC);

function AC(playerid, params)
	
	if Player[playerid].astatus > 0 then
		local result, text = sscanf(params,"s");
		if result == 1 then
			if Player[playerid].adminchat == true then
				for i = 0, MAX_PLAYERS - 1 do
					if Player[i].astatus > 0 and Player[i].adminchat == true then
						SendPlayerMessage(i, 131, 252, 180,"(��) "..GetPlayerName(playerid)..": "..text);
					end
				end
				LogString("Logs/Admins/admin_chat", GetPlayerName(playerid)..": "..text);
			else
				SendPlayerMessage(playerid, 255, 255, 255, "�����-��� ��������, �������� �������� /������")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255,"/� (�����).");
		end
	end
end
addCommandHandler({"/a", "/�"}, AC);

function AnswerTo(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id, text = sscanf(params, "ds");
		if result == 1 then
			SendPlayerMessage(id, 255, 255, 255, "����� �� "..GetPlayerName(playerid)..": "..text);
		else
			SendPlayerMessage(playerid, 255, 255, 255,"/�� (�����).");
		end
	end

end
addCommandHandler({"/ad", "/��"}, AnswerTo);

function GMText(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, text = sscanf(params, "s");
		if result == 1 then
			for i = 0, GetMaxSlots() do
				if GetDistancePlayers(playerid, i) <= 1500 then
					SendPlayerMessage(i, 121, 216, 242, "(������) "..text);
				end
			end
			LogString("Logs/Admins/cmd_gm", GetPlayerName(playerid)..": "..text);
		else
			SendPlayerMessage(playerid, 64, 224, 208,"/�� (�����).");
		end
	end

end
addCommandHandler({"/gm", "/��"}, GMText);

function AllHeal(id)

	if Player[id].astatus > 0 then
		for i = 0, GetMaxPlayers() do
			if GetDistancePlayers(id, i) <= 2000 then
				if Player[i].loggedIn == true and IsNPC(i) == 0 then
					_offAC(i);
					SetPlayerHealth(i, GetPlayerMaxHealth(i));
					SaveStats(i);
					_onAC(i);
					SendPlayerMessage(i, 121, 216, 242, "������������� "..GetPlayerName(id).." ������� ���.");
				end
			end
		end
		LogString("Logs/Admins/heal", GetPlayerName(id).." ������� ������� � ������� 2000");
	end

end
addCommandHandler({"/�����"}, AllHeal);

function OffOOC(id)

	if Player[id].astatus > 0 then
		if OOC_STATUS == true then
			OOC_STATUS = false;
			SendMessageToAll(121, 216, 242, "������������� "..GetPlayerName(id).." �������� ���-���.")
			LogString("Logs/Admins/other", GetPlayerName(id).." �������� ���-���.");
		else
			OOC_STATUS = true;
			SendMessageToAll(121, 216, 242, "������������� "..GetPlayerName(id).." ������� ���-���.")
			LogString("Logs/Admins/other", GetPlayerName(id).." ������� ���-���.");
		end
	end

end
addCommandHandler({"/���"}, OffOOC);

function SetName(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id, text = sscanf(params, "ds");
		if result == 1 then
			SetPlayerName(id, text);
			SendPlayerMessage(playerid, 255, 255, 255, "��� ����������.")
			SendPlayerMessage(id, 255, 255, 255, "��� ��� �������.")
			LogString("Logs/Admins/cmd_name", GetPlayerName(playerid).." ������� ��� ������ "..GetPlayerName(id).." �� "..text);
		else
			SendPlayerMessage(playerid, 255, 255, 255,"/��� (��) (�����).");
		end
	end

end
addCommandHandler({"/nick", "/���"}, SetName);


function ToToTo(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, idfrom, idto = sscanf(params, "dd");
		if result == 1 then
			if Player[idfrom].loggedIn == true then
				local x, y, z = GetPlayerPos(idto);
				SetPlayerPos(idfrom, x+50, y+60, z);
				SavePlayer(idfrom);
				SendPlayerMessage(playerid, 255, 255, 255, "����� "..GetPlayerName(idfrom).." ����������� � ������ "..GetPlayerName(idto));
				LogString("Logs/Admins/cmd_teleport", GetPlayerName(playerid).." ��������������: "..GetPlayerName(idfrom).." � "..GetPlayerName(idto));
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255,"/�� (�� ����) (�� � ����).");
		end
	end

end
addCommandHandler({"/tp", "/��"}, ToToTo);

function GScale(playerid, params)
	
	if Player[playerid].astatus > 0 then
		local result, id, x, y, z = sscanf(params, "dfff");
		if result == 1 then
			SetPlayerScale(id, x, y, z);
			SendPlayerMessage(id, 255, 255, 255, "��� ������ ������� �� x"..x.." y"..y.." z"..z)
			SendPlayerMessage(playerid, 255, 255, 255, "������� ������ "..GetPlayerName(id).." �������� �� x"..x.." y"..y.." z"..z);
			LogString("Logs/Admins/cmd_size", GetPlayerName(playerid).." ������� ������� ������ "..GetPlayerName(id).." �� x"..x.." y"..y.." z"..z);	
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/������ (��) (x) (y) (z)");
		end
	end

end
addCommandHandler({"/size", "/������"}, GScale)

function BeliarGreat(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			_offAC(id);
			SetPlayerHealth(id, 0);
			SavePlayer(id);
			SaveStats(id);
			SetTimerEx(_onAC, 2000, 0, id);
			SendPlayerMessage(id, 255, 255, 255, "��� �����.") -- xDD
			SendPlayerMessage(playerid, 255, 255, 255, "�� �����.") 
			LogString("Logs/Admins/cmd_kill", GetPlayerName(playerid).." ���� ������/��� "..GetPlayerName(id));
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/���� (��)")
		end
	end

end
addCommandHandler({"/kill", "/����"}, BeliarGreat);


function WhoIt(playerid)

	if Player[playerid].astatus > 0 then
		local fId = GetFocus(playerid);
		if fId ~= -1 then
			SendPlayerMessage(playerid, 255, 255, 255, "��� ��������� � ������: "..Player[fId].nickname);
		end
	end

end
addCommandHandler({"/idf", "/���"}, WhoIt);


function PlusMinusIMiOpyatIgraemVLybimih1(playerid, params)
	
	if Player[playerid].astatus > 1 then
		local result, h, m = sscanf(params, "dd");
		if result == 1 then
			SetTime(h, m);
			SendMessageToAll(137, 140, 140, "����������� �����: "..h..":"..m)
			LogString("Logs/Admins/cmd_time", GetPlayerName(playerid).." ��������� ����� ��  "..h..":"..m);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/������� (���) (������)")
		end
	end

end
addCommandHandler({"/settime", "/�������"}, PlusMinusIMiOpyatIgraemVLybimih1);

function _clearChatAll(id)

	if Player[id].astatus > 1 then
		for i = 0, GetMaxPlayers() do
			if Player[i].loggedIn == true then
				for p = 1, 30 do
					SendPlayerMessage(i, 0, 0, 0, " ");
				end
			end
			SendPlayerMessage(i, 255, 255, 255, "������������� "..GetPlayerName(id).." ������� ���.");
		end
	end

end
addCommandHandler({"/����"}, _clearChatAll);

function CREATEBIGPOINTSONMAPNIGGER(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, name = sscanf(params, "s");
		if result == 1 then
			local x, y, z = GetPlayerPos(playerid);

			local file = io.open("tpv/"..name, "w+");
			file:write(x.."\n");
			file:write(y.."\n");
			file:write(z.."\n");
			file:close();
			SendPlayerMessage(playerid, 255, 255, 255, "����� ������� � ��������� "..name);
			LogString("Logs/Admins/cmd_stpv", GetPlayerName(playerid).." ������ ����� "..name);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/���� (��������)")
		end
	end

end
addCommandHandler({"/stpv", "/����"}, CREATEBIGPOINTSONMAPNIGGER);

function _cmdRusGive(id, sets)

	if Player[id].astatus > 1 then
		local result, pid, amount, item = sscanf(sets, "dds");
		if result == 1 then
			if Player[pid].loggedIn == true and IsPlayerConnected(pid) == 1 then
				local rusname = GetItemCode(item);
				if rusname ~= item then
					GiveItem(pid, string.upper(GetItemCode(item)), amount);
					SaveItems(pid);
					SavePlayer(pid);
					SendPlayerMessage(id, 255, 255, 255, "�� ������ "..rusname.." x"..amount.." ������ "..GetPlayerName(pid));
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ "..rusname.." x"..amount.." �� "..GetPlayerName(id));
					LogString("Logs/Admins/cmd_rusgive", GetPlayerName(id).." give "..GetPlayerName(pid).." "..rusname.." "..amount);
				else
					SendPlayerMessage(id, 255, 255, 255, "������� �� ������.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "����� �� ������������� ��� �� ������.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/���� (��) (���-��) (�������� ��������)")
		end
	end

end
addCommandHandler({"/����"}, _cmdRusGive);

function GOTOCAPTUREITSGHETTOMFC(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, name = sscanf(params, "s");
		if result == 1 then
			local file = io.open("tpv/"..name, "r");
			if file then
				
				local x, y, z;
				
				tempvar = file:read("*l");
				local result, d = sscanf(tempvar,"d");
				if result == 1 then
					x = d;
				end
				
				tempvar = file:read("*l");
				local result, d = sscanf(tempvar,"d");
				if result == 1 then
					y = d;
				end
				
				tempvar = file:read("*l");
				local result, d = sscanf(tempvar,"d");
				if result == 1 then
					z = d;
				end
				
				file:close();
				
				SetPlayerPos(playerid, x, y, z);
			else
				SendPlayerMessage(playerid, 255, 255, 255, "����� �� �������.");
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/��� (��������)")
		end
	end

end
addCommandHandler({"/tpv", "/���"}, GOTOCAPTUREITSGHETTOMFC);

function ADuty(playerid)
	if CheckConnected(playerid) then	
		if Player[playerid].astatus > 0 then
			local txt = "";
			if Player[playerid].aduty == false then
				txt = "������� ��";
				SSM(playerid, "�� ����� �� ���������.");
			else
				txt = "��������";
			end

			SAM(GetPlayerName(playerid).." (LVL: "..Player[playerid].astatus..") "..txt.." ���������.");
			Player[playerid].aduty = not Player[playerid].aduty;
			return true;
		else
			SEM(playerid, "� ��� ��� ������� ��� ������������� ������ �������.");
			return false;
		end
	end
end
addCommandHandler({"/�����"}, ADuty);

function testadm(playerid)
	if CheckConnected(playerid) and CheckAdmin(playerid, 1) then
		SEM(playerid, "������� ����, ��� ��.");
		return;
	end
end
addCommandHandler({"/����"}, testadm);

function AdminHide(playerid)
	if CheckConnected(playerid) then	
		if CheckAdmin(playerid, 3) then
			local txt = "";
			if Player[playerid].ahide == false then
				txt = "������";
			else
				txt = "���������� ��������";
			end

			SSM(playerid, "�� "..txt.." ���� ����������� � �������.");
			Player[playerid].ahide = not Player[playerid].ahide;
			return true;
		end
	end
end
addCommandHandler({"/�����"}, AdminHide);