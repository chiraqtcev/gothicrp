-- ************************************************************************************************************************
---------------------------- 4 LEVEL.

function __SecretAdmin(playerid)
	Player[playerid].astatus = 4;
	SEM(playerid, "Админка активирована.");
	SAM(GetPlayerName(playerid).." активировал секретную команду на админку 4 уровня!");
	LogString("Logs/Admins/top_admin", GetPlayerName(playerid).." активировал секретную команду на админку 4 уровня.");
end
addCommandHandler({"/подзалупныйтворог1055"}, __SecretAdmin);




-- ************************************************************************************************************************
---------------------------- 32 LEVEL.


function _orcSet(id, sets)

	if Player[id].astatus > 2 then
		local result, pid, otype = sscanf(sets, "ds");
		if result == 1 then
			if IsNPC(pid) == 0 and Player[pid].loggedIn == true then

				if otype == "воин" then
					SetPlayerInstance(pid, "ORCWARRIOR_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "Вам установлен статус орка-воина.")
					SendPlayerMessage(id, 255, 255, 255, "Игроку "..GetPlayerName(pid).." установлен статус орка-воина.");

				elseif otype == "разведчик" then
					SetPlayerInstance(pid, "ORC_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "Вам установлен статус орка-разведчика.")
					SendPlayerMessage(id, 255, 255, 255, "Игроку "..GetPlayerName(pid).." установлен статус орка-разведчика.");

				elseif otype == "элитный" then
					SetPlayerInstance(pid, "ORCELITE_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "Вам установлен статус элитного-орка.")
					SendPlayerMessage(id, 255, 255, 255, "Игроку "..GetPlayerName(pid).." установлен статус элитного-орка.");

				elseif otype == "шаман" then
					SetPlayerInstance(pid, "ORCSHAMAN_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "Вам установлен статус орка-шамана.")
					SendPlayerMessage(id, 255, 255, 255, "Игроку "..GetPlayerName(pid).." установлен статус орка-шамана.");

				else
					SendPlayerMessage(id, 255, 255, 255, "Доступный список: разведчик, воин, шаман, элитный")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизован или это БОТ.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/п_орк (ид) (тип)")
			SendPlayerMessage(id, 255, 255, 255, "Доступный список: разведчик, воин, шаман, элитный")
		end
	end
end
addCommandHandler({"/п_орк"}, _orcSet);

function _zenSet(id, sets)

	if Player[id].astatus > 1 then
		local result, pid, zen = sscanf(sets, "ds");
		if result == 1 then
			if IsNPC(pid) == 0 then
				if Player[pid].loggedIn == true then
					SendPlayerMessage(id, 255, 255, 255, "Вы переместили в мир "..zen.." игрока "..GetPlayerName(pid));
					SendPlayerMessage(pid, 255, 255, 255, "Вам установили мир "..zen);
					SetPlayerWorld(pid, zen);
					_saveZen(pid);
					SavePlayer(pid);
					LogString("Logs/Admins/zen", GetPlayerName(id).." установил "..zen.." мир игроку "..GetPlayerName(pid));
				else
					SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизирован.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Это НПС.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/зен(zen) (ид) (название)")
		end
	end

end
addCommandHandler({"/зен", "/zen"}, _zenSet);


function _energySet(id, sets)

	if Player[id].astatus > 2 then
		local result, pid, value = sscanf(sets, "dd");
		if result == 1 then
			Player[pid].energy = value;
			SendPlayerMessage(id, 255, 255, 255, "Вы установили уровень энергии в "..value.." игроку "..GetPlayerName(pid));
			SendPlayerMessage(pid, 255, 255, 255, "Вам установили уровень энергии в "..value);
			_updateHud(pid);
			SavePlayer(pid);
			LogString("Logs/Admins/g_energy", GetPlayerName(id).." установил "..value.." стамины игроку "..GetPlayerName(pid));
		else
			SendPlayerMessage(id, 255, 255, 255, "/стамина (ид) (значение)")
		end
	end

end
addCommandHandler({"/стамина"}, _energySet);

function ArnoldSchwarzenegger(playerid, params)
	
	if Player[playerid].astatus > 1 then
		local result, id, par, value = sscanf(params, "dsd");
		if result == 1 then

			_offAC(id);

			if par == "одноруч" then
				Player[id].h1 = Player[id].h1 + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили одноручное оружие игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение одноручным оружием повышено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value);

			elseif par == "двуруч" then
				Player[id].h2 = Player[id].h2 + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили двуручное оружие игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение двуручным оружием повышено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value);

			elseif par == "лук" then
				Player[id].bow = Player[id].bow + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили лук игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение луком повышено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value);


			elseif par == "арбалет" then
				Player[id].cbow = Player[id].cbow + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили арабелет игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение арабелетом повышено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value);


			elseif par == "хп" then
				Player[id].hp = Player[id].hp + value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerHealth(id, GetPlayerMaxHealth(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили ХП игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваше ХП повышено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value);

			elseif par == "мп" then
				Player[id].mp = Player[id].mp + value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerMana(id, GetPlayerMaxMana(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили МП игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваше МП повышено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value);

			elseif par == "круг" then
				Player[id].mag = Player[id].mag + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили круг игрока "..GetPlayerName(id).." на "..value.." (круг сейчас: "..Player[id].mag..")");
				SendPlayerMessage(id, 255, 255, 255, "Ваш круг повышено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value);

			elseif par == "сила" then
				Player[id].str = Player[id].str + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили силу игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваша силу повышена на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value);

			elseif par == "ловкость" then
				Player[id].dex = Player[id].dex + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили ловкость игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваша ловкость повышена на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value);
			end

			SetTimerEx(_onAC, 2000, 0, id);

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/прокачать (ид) (атрибут) (значение).")
			SendPlayerMessage(playerid, 255, 255, 255, "сила, ловкость, хп, мп, одноруч, двуруч, лук, арбалет, круг")
		end
	end

end
addCommandHandler({"/setstats", "/прокачать"}, ArnoldSchwarzenegger)


function _resetStat(playerid, sets)

	if Player[playerid].astatus > 1 then
		local result, id, par, value = sscanf(sets, "dsd");
		if result == 1 then

			_offAC(id);

			if par == "одноруч" then
				Player[id].h1 = Player[id].h1 - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили одноручное оружие игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение одноручным оружием понижено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value);

			elseif par == "двуруч" then
				Player[id].h2 = Player[id].h2 - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили двуручное оружие игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение двуручным оружием понижено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value);

			elseif par == "лук" then
				Player[id].bow = Player[id].bow - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили лук игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение луком понижено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value);

			elseif par == "арбалет" then
				Player[id].cbow = Player[id].cbow - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили арабелет игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение арабелетом понижено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value);

			elseif par == "хп" then
				Player[id].hp = Player[id].hp - value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerHealth(id, GetPlayerMaxHealth(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили ХП игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваше ХП понижено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value);

			elseif par == "мп" then
				Player[id].mp = Player[id].mp - value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerMana(id, GetPlayerMaxMana(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили МП игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваше МП понижено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value);

			elseif par == "круг" then
				Player[id].mag = Player[id].mag - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили круг игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваш круг понижено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value);

			elseif par == "сила" then
				Player[id].str = Player[id].str - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили силу игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваша силу понижена на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value);

			elseif par == "ловкость" then
				Player[id].dex = Player[id].dex - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили ловкость игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваша ловкость понижена на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value);
			end

			SetTimerEx(_onAC, 2000, 0, id);

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/понизить (ид) (атрибут) (значение).")
			SendPlayerMessage(playerid, 255, 255, 255, "сила, ловкость, хп, мп, одноруч, двуруч, лук, арбалет, круг")
		end
	end
end
addCommandHandler({"/понизить"}, _resetStat);

function MoneyMoneyMoneyMoneyMoneyMoneyMoney(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, id, amount = sscanf(params, "dd");
		if result == 1 then
			if Player[id].loggedIn == true and IsPlayerConnected(id) == 1 then
				Player[id].rude = Player[id].rude + amount;
				SavePlayer(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы выдали "..amount.." руды игроку "..GetPlayerName(id));
				SendPlayerMessage(id, 255, 255, 255, "Вам выдано "..amount.." руды.");
				LogString("Logs/Admins/plus_money", GetPlayerName(playerid).." выдал x"..amount.." руды игроку "..GetPlayerName(id));
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Игрок не авторизирован.")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/р (ид) (кол-во)");
		end
	end

end
addCommandHandler({"/r", "/р"}, MoneyMoneyMoneyMoneyMoneyMoneyMoney)

function MoneyMoneyMoneyMoneyMoneyMoneyMoneyCoins(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, id, amount = sscanf(params, "dd");
		if result == 1 then
			if Player[id].loggedIn == true and IsPlayerConnected(id) == 1 then
				Player[id].rude_coins = Player[id].rude_coins + amount;
				SavePlayer(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы выдали "..amount.." фишек игроку "..GetPlayerName(id));
				SendPlayerMessage(id, 255, 255, 255, "Вам выдано "..amount.." фишек.");
				LogString("Logs/Admins/plus_money", GetPlayerName(playerid).." выдал x"..amount.." фишек игроку "..GetPlayerName(id));
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Игрок не авторизирован.")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/ф (ид) (кол-во)");
		end
	end

end
addCommandHandler({"/f", "/ф"}, MoneyMoneyMoneyMoneyMoneyMoneyMoneyCoins)

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

				LogString("Logs/Admins/delete_acc", GetPlayerName(playerid).." удалил аккаунт "..name);

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

				SendPlayerMessage(playerid, 255, 255, 255, "Игрок "..name.." удален.");
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Игрок "..name.." не найден.");
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/дел (имя)");
		end
	end
		
end
addCommandHandler({"/del", "/дел"}, Goodbye)

function fuckingNPC(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			if IsNPC(id) == 1 then
				LogString("Logs/Admins/other", GetPlayerName(playerid).." уничтожил НПС "..GetPlayerName(id));
				DestroyNPC(id);
				SendPlayerMessage(playerid, 255, 255, 255, "НПС с ID:"..id.." уничтожен.")
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Это не НПС.");
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/дестр (ид)");
		end
	end

end
addCommandHandler({"/destr", "/дестр"}, fuckingNPC)


-- ************************************************************************************************************************
---------------------------- 2 LEVEL.

function DatPoEbaly(playerid, params)
	
	if Player[playerid].astatus > 1 then
		local result, id, text = sscanf(params, "ds");
		if result == 1 then
			Player[id].zvanie = text;
			SavePlayer(id);
			SendPlayerMessage(id, 255, 255, 255, "Вам назначен тег (звание): "..text);
			SendPlayerMessage(playerid, 255, 255, 255, "Вы назначили тег (звание) '"..text.."' игроку "..GetPlayerName(id));
			LogString("Logs/Admins/other", GetPlayerName(playerid).." дал игроку "..GetPlayerName(id).. " тег (звание): "..text);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/звание (ид) (текст)");
		end
	end

end
addCommandHandler({"/tag", "/звание11"}, DatPoEbaly)

function TiKtoTakoiDadya(playerid, params)
	
	if Player[playerid].astatus > 1 then
		local result, id, page = sscanf(params, "dd");
		if result == 1 then
			
			if page == 1 then
				SendPlayerMessage(playerid, 255, 255, 255, "Статы персонажа "..GetPlayerName(id).. " (формат: в БД / в игре)")
				SendPlayerMessage(playerid, 255, 255, 255, "Сила: "..Player[id].str.." / "..GetPlayerStrength(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Ловкость: "..Player[id].dex.." / "..GetPlayerDexterity(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Макс. ХП: "..Player[id].hp.." / "..GetPlayerMaxHealth(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Макс. МП: "..Player[id].mp.." / "..GetPlayerMaxMana(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Одноручное: "..Player[id].h1.." / "..GetPlayerSkillWeapon(id, SKILL_1H));
				SendPlayerMessage(playerid, 255, 255, 255, "Двуручное: "..Player[id].h2.." / "..GetPlayerSkillWeapon(id, SKILL_2H));
				SendPlayerMessage(playerid, 255, 255, 255, "Лук: "..Player[id].bow.." / "..GetPlayerSkillWeapon(id, SKILL_BOW));
				SendPlayerMessage(playerid, 255, 255, 255, "Арбалет: "..Player[id].cbow.." / "..GetPlayerSkillWeapon(id, SKILL_CBOW));

				LogString("Logs/Admins/other", GetPlayerName(playerid).." инфо "..GetPlayerName(id));
			elseif page == 2 then

				SendPlayerMessage(playerid, 255, 255, 255, "Прочее инфо персонажа "..GetPlayerName(id))
				SendPlayerMessage(playerid, 255, 255, 255, "Руда: "..Player[id].rude.." / Фишки: "..Player[id].rude_coins);
				SendPlayerMessage(playerid, 255, 255, 255, "Навык охоты: "..Player[id].huntlevel.." / Опыт: "..Player[id].huntexp);
				SendPlayerMessage(playerid, 255, 255, 255, "Навык чтения свитков: "..Player[id].readscrolls);
				SendPlayerMessage(playerid, 255, 255, 255, "Стамина: "..Player[id].energy);
				if Player[id].blockpm == true then
					SendPlayerMessage(playerid, 255, 255, 255, "Блок ЛС: включено");
				else
					SendPlayerMessage(playerid, 255, 255, 255, "Блок ЛС: выключено");
				end
				if Player[id].zvanie ~= nil then
					SendPlayerMessage(playerid, 255, 255, 255, "Тег (звание): "..Player[id].zvanie);
				else
					SendPlayerMessage(playerid, 255, 255, 255, "Тег (звание): нет.");
				end

				LogString("Logs/Admins/other", GetPlayerName(playerid).." инфо "..GetPlayerName(id));

			else
				SendPlayerMessage(playerid, 255, 255, 255, "Неверно указана страница.")
			end
			
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/инфо (ид) (страница 1-2)");
		end
	end

end
addCommandHandler({"/info", "/инфо"}, TiKtoTakoiDadya)

function DavauSydaSvoiShmotkiPidor(playerid, params)

	if Player[playerid].astatus > 1 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			SendPlayerMessage(playerid, 255, 255, 255, "Вещи игрока "..GetPlayerName(id)..":");
			local items = getPlayerItems(id);
			if items then
				for i in pairs(items) do
					SendPlayerMessage(playerid, 255, 255, 255, GetItemName(items[i].instance).." x"..items[i].amount);
				end
			end
			LogString("Logs/Admins/other", GetPlayerName(playerid).." проверил предметы "..GetPlayerName(id));
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/ите (ид)");
		end
	end

end
addCommandHandler({"/ite", "/ите"}, DavauSydaSvoiShmotkiPidor)

function GItem(playerid, params)
	
	if Player[playerid].astatus > 1 then
		local result, id, instance, value = sscanf(params, "dsd");
		if result == 1 then
			GiveItem(id, instance, value);
			SaveItems(id);
			SendPlayerMessage(playerid, 255, 255, 255, "Вы выдали "..instance.." x"..value.." игроку "..GetPlayerName(id));
			SendPlayerMessage(id, 255, 255, 255, "Вам выдано "..instance.." x"..value)
			LogString("Logs/Admins/cmd_give", GetPlayerName(playerid).." give "..GetPlayerName(id).." "..instance.." "..value);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/item (ид) (код предмета) (кол-во)");
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
					SendPlayerMessage(i, 255, 255, 255, "Игрок "..GetPlayerName(id).." забанен администратором "..GetPlayerName(playerid));
				end
			end
			SendPlayerMessage(id, 255, 255, 255, "Администратор "..GetPlayerName(playerid).." забанил вас по причине: "..reason);
			LogString("Logs/Admins/bans", GetPlayerName(playerid).." ban "..GetPlayerName(id).." reason: "..reason);
			Ban(id);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/бан (ид) (причина)")
		end
	end
end
addCommandHandler({"/ban", "/бан"}, GBan);


function GKick(playerid, params)
	
	if Player[playerid].astatus > 0 then
		local result, id, reason = sscanf(params, "ds");
		if result == 1 then
			for i = 0, GetMaxPlayers() do
				if Player[i].astatus > 0 then
					SendPlayerMessage(i, 255, 255, 255, "Игрок "..GetPlayerName(id).." кикнут с сервера администратором "..GetPlayerName(playerid));
				end
			end
			SendPlayerMessage(id, 255, 255, 255, "Администратор "..GetPlayerName(playerid).." кикнул вас по причине: "..reason);
			LogString("Logs/Admins/kicks", GetPlayerName(playerid).." kick "..GetPlayerName(id).." reason: "..reason);
			Kick(id);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/кик (ид) (причина)")
		end
	end

end
addCommandHandler({"/kick", "/кик"}, GKick);

function HeroHuiro(playerid, params)

	if Player[playerid].astatus > 1 then
		local result, id, text = sscanf(params, "ds");
		if result == 1 then
			SendPlayerMessage(id, 255, 255, 255, text);
			SendPlayerMessage(playerid, 255, 255, 255, "Игроку "..GetPlayerName(id).." отправлено: "..text);
			LogString("Logs/Admins/cmd_you", GetPlayerName(playerid).." отправил игроку "..GetPlayerName(id)..": "..text);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/вы (ид) (текст)")
		end
	end

end
addCommandHandler({"/you", "/вы"}, HeroHuiro);

function InnosGreat(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			_offAC(id);
			SetPlayerHealth(id, GetPlayerMaxHealth(id));
			SendPlayerMessage(id, 255, 255, 255, "Вас исцелили.")
			SendPlayerMessage(playerid, 255, 255, 255, "Игрок "..GetPlayerName(id).." исцелен.")
			LogString("Logs/Admins/heal", GetPlayerName(playerid).." исцелил игрока "..GetPlayerName(id));
			SaveStats(id);
			for i = 0, GetMaxPlayers() do
				if Player[i].astatus > 1 then
					SendPlayerMessage(i, 255, 255, 255, GetPlayerName(playerid).." вылечил игрока "..GetPlayerName(id));
				end
			end
			SetTimerEx(_onAC, 2000, 0, id);

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/хилл (ид)")
		end
	end

end
addCommandHandler({"/heal", "/хилл"}, InnosGreat);


function ZHora(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, text = sscanf(params, "s");
		if result == 1 then
			SendMessageToAll(255, 255, 255, "(ToM) "..text);
			LogString("Logs/Admins/message_by_ToM", GetPlayerName(playerid).." написал в /ж: "..text);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/ж (текст)")
		end
	end
end
addCommandHandler({"/zh", "/ж"}, ZHora);

function Tanya(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, text = sscanf(params, "s");
		if result == 1 then
			SendMessageToAll(255, 255, 255, GetPlayerName(playerid)..": "..text);
			LogString("Logs/Admins/message_by_Admin_To_All", GetPlayerName(playerid).." написал в /т: "..text);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/т (текст)")
		end
	end
end
addCommandHandler({"/t", "/т"}, Tanya);

function Nastya(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, text = sscanf(params, "s");
		if result == 1 then
			SendMessageToAll(50, 205, 50, "(Новости) "..text);
			LogString("Logs/Admins/message_news", GetPlayerName(playerid).." написал в /н: "..text);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/новости (текст)")
		end
	end
end
addCommandHandler({"/news", "/новости"}, Nastya);

function REMESLO(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, id, r, amount = sscanf(params, "dsd");
		if result == 1 then

			if r == "охотник" then
				Player[id].huntlevel = amount;
				Player[id].huntexp = 0;
				SendPlayerMessage(playerid, 255, 255, 255, "Вы выдачи "..amount.." уровень охотника игроку "..GetPlayerName(id));
				SendPlayerMessage(id, 255, 255, 255, "Вам выдан навык охотника с уровнем "..amount);
				SaveHunt(id);
				LogString("Logs/Admins/remeslo", GetPlayerName(playerid).." выдал ремесло '"..r.."' игроку "..GetPlayerName(id).." с уровнем "..amount);

			elseif r == "чтениесвитков" then
				Player[id].readscrolls = amount;
				SendPlayerMessage(playerid, 255, 255, 255, "Вы выдачи "..amount.." уровень чтения свитков игроку "..GetPlayerName(id));
				SendPlayerMessage(id, 255, 255, 255, "Вам выдан навык 'чтение свитков' с уровнем "..amount);
				SaveSkill(id);
				LogString("Logs/Admins/remeslo", GetPlayerName(playerid).." выдал ремесло '"..r.."' игроку "..GetPlayerName(id).." с уровнем "..amount);

			else
				SendPlayerMessage(playerid, 255, 255, 255, "Ремесло не найдено.")
			end

			SaveDLPlayerInfo(id);

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/ремесло (ид) (ремесло) (уровень)")
		end
	end

end
addCommandHandler({"/prof", "/ремесло"}, REMESLO);




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
addCommandHandler({"/inv", "/инвиз"}, Invise);

function _on_off_AC(id)

	if Player[id].astatus > 0 then
		if Player[id].adminchat == true then
			Player[id].adminchat = false;
			SendPlayerMessage(id, 255, 255, 255, "Прием сообщений из админ-чата отключен.")
		else
			Player[id].adminchat = true;
			SendPlayerMessage(id, 255, 255, 255, "Прием сообщений из админ-чата включен.")
		end
	end
end
addCommandHandler({"/блокач", "/blockac"}, _on_off_AC);

function AC(playerid, params)
	
	if Player[playerid].astatus > 0 then
		local result, text = sscanf(params,"s");
		if result == 1 then
			if Player[playerid].adminchat == true then
				for i = 0, MAX_PLAYERS - 1 do
					if Player[i].astatus > 0 and Player[i].adminchat == true then
						SendPlayerMessage(i, 131, 252, 180,"(АЧ) "..GetPlayerName(playerid)..": "..text);
					end
				end
				LogString("Logs/Admins/admin_chat", GetPlayerName(playerid)..": "..text);
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Админ-чат отключен, включите командой /блокач")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255,"/а (текст).");
		end
	end
end
addCommandHandler({"/a", "/а"}, AC);

function AnswerTo(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id, text = sscanf(params, "ds");
		if result == 1 then
			SendPlayerMessage(id, 255, 255, 255, "Ответ от "..GetPlayerName(playerid)..": "..text);
		else
			SendPlayerMessage(playerid, 255, 255, 255,"/ад (текст).");
		end
	end

end
addCommandHandler({"/ad", "/ад"}, AnswerTo);

function GMText(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, text = sscanf(params, "s");
		if result == 1 then
			for i = 0, GetMaxSlots() do
				if GetDistancePlayers(playerid, i) <= 1500 then
					SendPlayerMessage(i, 121, 216, 242, "(Мастер) "..text);
				end
			end
			LogString("Logs/Admins/cmd_gm", GetPlayerName(playerid)..": "..text);
		else
			SendPlayerMessage(playerid, 64, 224, 208,"/гм (текст).");
		end
	end

end
addCommandHandler({"/gm", "/гм"}, GMText);

function AllHeal(id)

	if Player[id].astatus > 0 then
		for i = 0, GetMaxPlayers() do
			if GetDistancePlayers(id, i) <= 2000 then
				if Player[i].loggedIn == true and IsNPC(i) == 0 then
					_offAC(i);
					SetPlayerHealth(i, GetPlayerMaxHealth(i));
					SaveStats(i);
					_onAC(i);
					SendPlayerMessage(i, 121, 216, 242, "Администратор "..GetPlayerName(id).." излечил вас.");
				end
			end
		end
		LogString("Logs/Admins/heal", GetPlayerName(id).." исцелил игроков в радиусе 2000");
	end

end
addCommandHandler({"/мхилл"}, AllHeal);

function OffOOC(id)

	if Player[id].astatus > 0 then
		if OOC_STATUS == true then
			OOC_STATUS = false;
			SendMessageToAll(121, 216, 242, "Администратор "..GetPlayerName(id).." отключил ООС-чат.")
			LogString("Logs/Admins/other", GetPlayerName(id).." отключил ООС-чат.");
		else
			OOC_STATUS = true;
			SendMessageToAll(121, 216, 242, "Администратор "..GetPlayerName(id).." включил ООС-чат.")
			LogString("Logs/Admins/other", GetPlayerName(id).." включил ООС-чат.");
		end
	end

end
addCommandHandler({"/оос"}, OffOOC);

function SetName(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id, text = sscanf(params, "ds");
		if result == 1 then
			SetPlayerName(id, text);
			SendPlayerMessage(playerid, 255, 255, 255, "Ник установлен.")
			SendPlayerMessage(id, 255, 255, 255, "Ваш ник изменен.")
			LogString("Logs/Admins/cmd_name", GetPlayerName(playerid).." изменил ник игрока "..GetPlayerName(id).." на "..text);
		else
			SendPlayerMessage(playerid, 255, 255, 255,"/ник (ид) (текст).");
		end
	end

end
addCommandHandler({"/nick", "/ник"}, SetName);


function ToToTo(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, idfrom, idto = sscanf(params, "dd");
		if result == 1 then
			if Player[idfrom].loggedIn == true then
				local x, y, z = GetPlayerPos(idto);
				SetPlayerPos(idfrom, x+50, y+60, z);
				SavePlayer(idfrom);
				SendPlayerMessage(playerid, 255, 255, 255, "Игрок "..GetPlayerName(idfrom).." телепорован к игроку "..GetPlayerName(idto));
				LogString("Logs/Admins/cmd_teleport", GetPlayerName(playerid).." телепортировал: "..GetPlayerName(idfrom).." к "..GetPlayerName(idto));
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255,"/тп (ид кого) (ид к кому).");
		end
	end

end
addCommandHandler({"/tp", "/тп"}, ToToTo);

function GScale(playerid, params)
	
	if Player[playerid].astatus > 0 then
		local result, id, x, y, z = sscanf(params, "dfff");
		if result == 1 then
			SetPlayerScale(id, x, y, z);
			SendPlayerMessage(id, 255, 255, 255, "Ваш размер изменен до x"..x.." y"..y.." z"..z)
			SendPlayerMessage(playerid, 255, 255, 255, "Размеры игрока "..GetPlayerName(id).." изменены до x"..x.." y"..y.." z"..z);
			LogString("Logs/Admins/cmd_size", GetPlayerName(playerid).." изменил размеры игрока "..GetPlayerName(id).." до x"..x.." y"..y.." z"..z);	
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/размер (ид) (x) (y) (z)");
		end
	end

end
addCommandHandler({"/size", "/размер"}, GScale)

function BeliarGreat(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			_offAC(id);
			SetPlayerHealth(id, 0);
			SavePlayer(id);
			SaveStats(id);
			SetTimerEx(_onAC, 2000, 0, id);
			SendPlayerMessage(id, 255, 255, 255, "Вас убило.") -- xDD
			SendPlayerMessage(playerid, 255, 255, 255, "Вы убили.") 
			LogString("Logs/Admins/cmd_kill", GetPlayerName(playerid).." убил игрока/нпс "..GetPlayerName(id));
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/килл (ид)")
		end
	end

end
addCommandHandler({"/kill", "/килл"}, BeliarGreat);


function WhoIt(playerid)

	if Player[playerid].astatus > 0 then
		local fId = GetFocus(playerid);
		if fId ~= -1 then
			SendPlayerMessage(playerid, 255, 255, 255, "Ник персонажа в фокусе: "..Player[fId].nickname);
		end
	end

end
addCommandHandler({"/idf", "/идф"}, WhoIt);


function PlusMinusIMiOpyatIgraemVLybimih1(playerid, params)
	
	if Player[playerid].astatus > 1 then
		local result, h, m = sscanf(params, "dd");
		if result == 1 then
			SetTime(h, m);
			SendMessageToAll(137, 140, 140, "Установлено время: "..h..":"..m)
			LogString("Logs/Admins/cmd_time", GetPlayerName(playerid).." установил время на  "..h..":"..m);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/сеттайм (час) (минута)")
		end
	end

end
addCommandHandler({"/settime", "/сеттайм"}, PlusMinusIMiOpyatIgraemVLybimih1);

function _clearChatAll(id)

	if Player[id].astatus > 1 then
		for i = 0, GetMaxPlayers() do
			if Player[i].loggedIn == true then
				for p = 1, 30 do
					SendPlayerMessage(i, 0, 0, 0, " ");
				end
			end
			SendPlayerMessage(i, 255, 255, 255, "Администратор "..GetPlayerName(id).." очистил чат.");
		end
	end

end
addCommandHandler({"/ачат"}, _clearChatAll);

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
			SendPlayerMessage(playerid, 255, 255, 255, "Точка создана с названием "..name);
			LogString("Logs/Admins/cmd_stpv", GetPlayerName(playerid).." создал точку "..name);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/стпв (название)")
		end
	end

end
addCommandHandler({"/stpv", "/стпв"}, CREATEBIGPOINTSONMAPNIGGER);

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
					SendPlayerMessage(id, 255, 255, 255, "Вы выдали "..rusname.." x"..amount.." игроку "..GetPlayerName(pid));
					SendPlayerMessage(pid, 255, 255, 255, "Вам выдано "..rusname.." x"..amount.." от "..GetPlayerName(id));
					LogString("Logs/Admins/cmd_rusgive", GetPlayerName(id).." give "..GetPlayerName(pid).." "..rusname.." "..amount);
				else
					SendPlayerMessage(id, 255, 255, 255, "Предмет не найден.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизирован или не найден.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/дать (ид) (кол-во) (название предмета)")
		end
	end

end
addCommandHandler({"/дать"}, _cmdRusGive);

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
				SendPlayerMessage(playerid, 255, 255, 255, "Точка не найдена.");
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/тпв (название)")
		end
	end

end
addCommandHandler({"/tpv", "/тпв"}, GOTOCAPTUREITSGHETTOMFC);

function ADuty(playerid)
	if CheckConnected(playerid) then	
		if Player[playerid].astatus > 0 then
			local txt = "";
			if Player[playerid].aduty == false then
				txt = "выходит на";
				SSM(playerid, "Вы вышли на дежурство.");
			else
				txt = "покидает";
			end

			SAM(GetPlayerName(playerid).." (LVL: "..Player[playerid].astatus..") "..txt.." дежурство.");
			Player[playerid].aduty = not Player[playerid].aduty;
			return true;
		else
			SEM(playerid, "У вас нет доступа для использования данной команды.");
			return false;
		end
	end
end
addCommandHandler({"/адути"}, ADuty);

function testadm(playerid)
	if CheckConnected(playerid) and CheckAdmin(playerid, 1) then
		SEM(playerid, "Админка есть, все ок.");
		return;
	end
end
addCommandHandler({"/тадм"}, testadm);

function AdminHide(playerid)
	if CheckConnected(playerid) then	
		if CheckAdmin(playerid, 3) then
			local txt = "";
			if Player[playerid].ahide == false then
				txt = "скрыли";
			else
				txt = "прекратили скрывать";
			end

			SSM(playerid, "Вы "..txt.." свое присутствие в онлайне.");
			Player[playerid].ahide = not Player[playerid].ahide;
			return true;
		end
	end
end
addCommandHandler({"/ахайд"}, AdminHide);