
--  # Workers system by royclapton #
--  #         version: 1.0         #


DIR_WORKERS = "modules/Workers/"
DIR_WORKERS_BASE = "modules/Workers/WorkersBase/Workers.txt"

WORKERS = {};
WORKERS_COUNT = 0;
WORKERS_COUNT_LIST = {};

function _saveCountList()

	local file = io.open(DIR_WORKERS_BASE, "w+");
	for i, v in pairs(WORKERS_COUNT_LIST) do
		file:write(WORKERS_COUNT_LIST[i].."\n");
	end
	file:close();

end

function _initWorkers()
	
	print("");
	print(" ######################");
	print("     Workers system   ");

	local file = io.open(DIR_WORKERS_BASE, "r");
	if file then
		for line in file:lines() do
			local worker, name = sscanf(line, "s");
			if worker == 1 then
				table.insert(WORKERS_COUNT_LIST, name);
			end
		end
	end
	WORKERS_COUNT = table.getn(WORKERS_COUNT_LIST);

	if WORKERS_COUNT > 0 then
		
		for i = 1, WORKERS_COUNT do
			WORKERS[i] = {};
			WORKERS[i].worker_bot = nil;
			WORKERS[i].worker_busy = false;
			WORKERS[i].worker_name = nil;
			WORKERS[i].worker_id = nil;
			WORKERS[i].worker_owner = nil;
			WORKERS[i].worker_price = 0;
			WORKERS[i].worker_type = nil;
			WORKERS[i].worker_pos = {0, 0 ,0};
			WORKERS[i].worker_angle = nil;
			WORKERS[i].worker_visual = {nil, nil, nil, nil};
			WORKERS[i].worker_armor = nil;
			WORKERS[i].worker_mweapon = nil;
			WORKERS[i].worker_rweapon = nil;
		end

		for i = 1, WORKERS_COUNT do
			local file = io.open(DIR_WORKERS.."/WorkersBase/"..WORKERS_COUNT_LIST[i]..".txt", "r");
			if file then
				WORKERS[i].worker_bot = CreateNPC(WORKERS_COUNT_LIST[i]);

				line = file:read("*l");
				local bot, owner, type, price, x, y, z, angle, v1, v2, v3, v4, armor, mweapon, rweapon = sscanf(line, "ssdddddsdsdsss");
				if bot then
					WORKERS[i].worker_owner = owner;
					WORKERS[i].worker_type = type; 
					WORKERS[i].worker_price = price;
					WORKERS[i].worker_pos = {x, y, z}; 
					WORKERS[i].worker_angle = angle;
					WORKERS[i].worker_visual = {v1, v2, v3, v4};
					WORKERS[i].worker_armor = armor;
					WORKERS[i].worker_mweapon = mweapon;
					WORKERS[i].worker_rweapon = rweapon;
					WORKERS[i].worker_name = WORKERS_COUNT_LIST[i];

					SpawnPlayer(WORKERS[i].worker_bot);
					for c = 0, GetMaxSlots() do
						if GetPlayerName(c) == WORKERS[i].worker_name then
							WORKERS[i].worker_id = c;
							break
						end
					end
					SetPlayerWorld(WORKERS[i].worker_bot, "KOLONIE.ZEN");
					SetPlayerPos(WORKERS[i].worker_bot, x, y, z);
					SetPlayerAngle(WORKERS[i].worker_bot, angle);
					EquipArmor(WORKERS[i].worker_bot, armor);
					EquipMeleeWeapon(WORKERS[i].worker_bot, mweapon);
					EquipRangedWeapon(WORKERS[i].worker_bot, rweapon);
					SetPlayerAdditionalVisual(WORKERS[i].worker_bot, v1, v2, v3, v4);
				end
				file:close();
			end
		end

	end

	print("       "..WORKERS_COUNT.." loaded      ");
	print("                     ");
	print(" ######################");
	
	_saveCountList();
	TRADERS_COUNT = TRADERS_COUNT + 20;

end

workers_focus_tex = CreateTexture(2997, 6223, 5189, 6620, 'menu_ingame')
function _workersConnect(id)

	Player[id]._worker_focus = nil;
	Player[id]._worker_select_id = nil;
	Player[id]._worker_bot = {false, nil};

	Player[id]._worker_focus_draw = CreatePlayerDraw(id, 3230, 6320, "Поговорить с рабочим - CTRL");
	Player[id]._worker_bot = {false, nil};

	Player[id]._worker_menu = false;

end

function _workersFocus(id, bot)

	if bot ~= -1 then
		for _, v in pairs(WORKERS_COUNT_LIST) do
			if GetPlayerName(bot) == v then
				Player[id]._worker_focus = v;
				ShowTexture(id, workers_focus_tex );
				ShowPlayerDraw(id, Player[id]._worker_focus_draw);
			end
		end
	else
		Player[id]._worker_focus = nil;
		HideTexture(id, workers_focus_tex);
		HidePlayerDraw(id, Player[id]._worker_focus_draw);
	end

end

createGUIMenu("WORKER_MENU", {
	{ "1. Оплатить работу" },
	{ "2. Информация о рабочем" },
	{ "3. Закончить разговор" },
    }, 150, 150, 150, 255, 255, 255, 5430, 3500, "Font_Old_20_White_Hi.TGA", CreateTexture(5295, 3365, 8130, 4440, 'menu_ingame'), 3);

createGUIMenu("WORKER_MENU_HERBS", {
	{ "1. Сбор лечебных трав" },
	{ "2. Сбор лесных трав" },
	{ "3. Сбор магических трав" },
	{ "4. Сбор ягод" },
	{ "5. Сбор грибов" },
	{ "6. Сбор болотника" },
	{ "7. Вернуться" },
    }, 150, 150, 150, 255, 255, 255, 5430, 3500, "Font_Old_20_White_Hi.TGA", CreateTexture(5295, 3365, 8130, 5240, 'menu_ingame'), 7);

createGUIMenu("WORKER_MENU_HUNTER", {
	{ "1. Охота на кротокрысов" },
	{ "2. Охота на волков" },
	{ "3. Охота на падальщиков" },
	{ "4. Вернуться" },
    }, 150, 150, 150, 255, 255, 255, 5430, 3500, "Font_Old_20_White_Hi.TGA", CreateTexture(5295, 3365, 8130, 4640, 'menu_ingame'), 4);

createGUIMenu("WORKER_MENU_SHEEPER", {
	{ "1. Дойка молока" },
	{ "2. Пострижка овцы (шерсть)" },
	{ "4. Вернуться" },
    }, 150, 150, 150, 255, 255, 255, 5430, 3500, "Font_Old_20_White_Hi.TGA", CreateTexture(5295, 3365, 8130, 4340, 'menu_ingame'), 3);


function _mGetOnline()
	local on = 0;
	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true and IsPlayerConnected(i) == 1 then
			on = on + 1;
		end
	end
	ONLINE = on;
end

function _workersKey(id, down, up)

	if down == KEY_LCONTROL then
		if Player[id].loggedIn == true then
			if Player[id]._worker_focus ~= nil then
				if Player[id]._worker_bot[1] == false then
					Player[id]._worker_bot[1] = true;

					for i = 0, GetMaxSlots() do
						if GetPlayerName(i) == Player[id]._worker_focus then
							Player[id]._worker_bot[2] = i;
							break
						end
					end

					local b_id = nil;
					for i = 1, WORKERS_COUNT do
						if WORKERS[i].worker_name == GetPlayerName(Player[id]._worker_bot[2]) then
							b_id = i;
							break
						end
					end

					if WORKERS[b_id].worker_busy ~= true then
						HideTexture(id, workers_focus_tex);
						HidePlayerDraw(id, Player[id]._worker_focus_draw);
						Player[id]._worker_focus = nil;

						WORKERS[b_id].worker_busy = true;
						SetPlayerAngle(Player[id]._worker_bot[2], GetAngleToPlayer(Player[id]._worker_bot[2], id));
						showGUIMenu(id, "WORKER_MENU");
						Freeze(id);
						PlayGesticulation(Player[id]._worker_bot[2]);
					else
						SendPlayerMessage(id, 255, 255, 255, "Рабочий сейчас занят.")
						Player[id]._worker_bot = {false, nil};
					end
				end
			end
		end
	end

	if down == KEY_UP then
		switchGUIMenuUp(id, "WORKER_MENU");
		switchGUIMenuUp(id, "WORKER_MENU_HERBS");
		switchGUIMenuUp(id, "WORKER_MENU_HUNTER");
		switchGUIMenuUp(id, "WORKER_MENU_SHEEPER");
	end

	if down == KEY_DOWN then
		switchGUIMenuDown(id, "WORKER_MENU");
		switchGUIMenuDown(id, "WORKER_MENU_HERBS");
		switchGUIMenuDown(id, "WORKER_MENU_HUNTER");
		switchGUIMenuDown(id, "WORKER_MENU_SHEEPER");
	end

	if down == KEY_RETURN then
		if Player[id].loggedIn == true then
			if Player[id]._worker_bot[1] == true then

				-- ###############################################################
				------------------------------------------------------------------
				if getPlayerOptionID(id, "WORKER_MENU") == 1 then

					local b_id = nil;
					for i = 1, TRADERS_COUNT do
						if WORKERS[i].worker_name == GetPlayerName(Player[id]._worker_bot[2]) then
							b_id = i;
							break
						end
					end

					if WORKERS[b_id].worker_owner == Player[id].nickname or Player[id].astatus > 2 then
						_mGetOnline();
						if ONLINE > 9 then
							if _workersCheckBlock(id, GetPlayerName(Player[id]._worker_bot[2])) == false then
								if WORKERS[b_id].worker_type == "травник" then
									hideGUIMenu(id, "WORKER_MENU");
									showGUIMenu(id, "WORKER_MENU_HERBS");

								elseif WORKERS[b_id].worker_type == "охотник" then
									hideGUIMenu(id, "WORKER_MENU");
									showGUIMenu(id, "WORKER_MENU_HUNTER");

								elseif WORKERS[b_id].worker_type == "пастух" then
									hideGUIMenu(id, "WORKER_MENU");
									showGUIMenu(id, "WORKER_MENU_SHEEPER");
								else
									_workerGoWork(id);
								end
							else
								SendPlayerMessage(id, 255, 255, 255, "Рабочий уже работал сегодня.")
							end
						else
							SendPlayerMessage(id, 255, 255, 255, "Отправлять рабочих можно только при онлайне 10+")
						end

					else
						SendPlayerMessage(id, 255, 255, 255, "Вы не можете отправлять рабочего на работу.")
					end


				elseif getPlayerOptionID(id, "WORKER_MENU") == 2 then
					local b_id = nil;
				
					for i = 1, TRADERS_COUNT do
						if WORKERS[i].worker_name == GetPlayerName(Player[id]._worker_bot[2]) then
							b_id = i;
							break
						end
					end
					
					PlayGesticulation(Player[id]._worker_bot[2]);
					SendPlayerMessage(id, 255, 255, 255, " ");
					SendPlayerMessage(id, 255, 255, 255, "Информация о рабочем "..GetPlayerName(Player[id]._worker_bot[2])..":")
					SendPlayerMessage(id, 255, 255, 255, "Управляющий: "..WORKERS[b_id].worker_owner)

					if WORKERS[b_id].worker_owner == Player[id].nickname or Player[id].astatus > 2 then
						SendPlayerMessage(id, 255, 255, 255, "Ставка: "..WORKERS[b_id].worker_price.." руды.")
						SendPlayerMessage(id, 255, 255, 255, "Тип: "..WORKERS[b_id].worker_type)
						if _workersCheckBlock(id, GetPlayerName(Player[id]._worker_bot[2])) == false then
							SendPlayerMessage(id, 255, 255, 255, "Заблокирован: нет");
						else
							SendPlayerMessage(id, 255, 255, 255, "Заблокирован: да");
						end
						SendPlayerMessage(id, 255, 255, 255, " ")
					end

				elseif getPlayerOptionID(id, "WORKER_MENU") == 3 then
					local b_id = nil;

					for i = 1, TRADERS_COUNT do
						if WORKERS[i].worker_name == GetPlayerName(Player[id]._worker_bot[2]) then
							b_id = i;
							break
						end
					end

					WORKERS[b_id].worker_busy = false;
					SetPlayerAngle(Player[id]._worker_bot[2], WORKERS[b_id].worker_angle);
					PlayGesticulation(Player[id]._worker_bot[2]);
					Player[id]._worker_bot[1] = false;
					Player[id]._worker_bot[2] = nil;
					hideGUIMenu(id, "WORKER_MENU");
					UnFreeze(id);

				-- ###############################################################
				------------------------------------------------------------------

				elseif getPlayerOptionID(id, "WORKER_MENU_HERBS") == 1 then
					_workersGoHerbs(id, 1);
					hideGUIMenu(id, "WORKER_MENU_HERBS");
					showGUIMenu(id, "WORKER_MENU");

				elseif getPlayerOptionID(id, "WORKER_MENU_HERBS") == 2 then
					_workersGoHerbs(id, 2);
					hideGUIMenu(id, "WORKER_MENU_HERBS");
					showGUIMenu(id, "WORKER_MENU");

				elseif getPlayerOptionID(id, "WORKER_MENU_HERBS") == 3 then
					_workersGoHerbs(id, 3);
					hideGUIMenu(id, "WORKER_MENU_HERBS");
					showGUIMenu(id, "WORKER_MENU");

				elseif getPlayerOptionID(id, "WORKER_MENU_HERBS") == 4 then
					_workersGoHerbs(id, 4);
					hideGUIMenu(id, "WORKER_MENU_HERBS");
					showGUIMenu(id, "WORKER_MENU");

				elseif getPlayerOptionID(id, "WORKER_MENU_HERBS") == 5 then
					_workersGoHerbs(id, 5);
					hideGUIMenu(id, "WORKER_MENU_HERBS");
					showGUIMenu(id, "WORKER_MENU");

				elseif getPlayerOptionID(id, "WORKER_MENU_HERBS") == 6 then
					_workersGoHerbs(id, 6);
					hideGUIMenu(id, "WORKER_MENU_HERBS");
					showGUIMenu(id, "WORKER_MENU");

				elseif getPlayerOptionID(id, "WORKER_MENU_HERBS") == 7 then
					hideGUIMenu(id, "WORKER_MENU_HERBS");
					showGUIMenu(id, "WORKER_MENU");


				-- ###############################################################
				------------------------------------------------------------------

				elseif getPlayerOptionID(id, "WORKER_MENU_HUNTER") == 1 then
					_workersGoHunt(id, 1);
					hideGUIMenu(id, "WORKER_MENU_HUNTER");
					showGUIMenu(id, "WORKER_MENU");

				elseif getPlayerOptionID(id, "WORKER_MENU_HUNTER") == 2 then
					_workersGoHunt(id, 2);
					hideGUIMenu(id, "WORKER_MENU_HUNTER");
					showGUIMenu(id, "WORKER_MENU");

				elseif getPlayerOptionID(id, "WORKER_MENU_HUNTER") == 3 then
					_workersGoHunt(id, 3);
					hideGUIMenu(id, "WORKER_MENU_HUNTER");
					showGUIMenu(id, "WORKER_MENU");

				elseif getPlayerOptionID(id, "WORKER_MENU_HUNTER") == 4 then
					hideGUIMenu(id, "WORKER_MENU_HUNTER");
					showGUIMenu(id, "WORKER_MENU");


				-- ###############################################################
				------------------------------------------------------------------

				elseif getPlayerOptionID(id, "WORKER_MENU_SHEEPER") == 1 then
					_workersGoSheep(id, 1);
					hideGUIMenu(id, "WORKER_MENU_SHEEPER");
					showGUIMenu(id, "WORKER_MENU");

				elseif getPlayerOptionID(id, "WORKER_MENU_SHEEPER") == 2 then
					_workersGoSheep(id, 2);
					hideGUIMenu(id, "WORKER_MENU_SHEEPER");
					showGUIMenu(id, "WORKER_MENU");

				elseif getPlayerOptionID(id, "WORKER_MENU_SHEEPER") == 3 then
					hideGUIMenu(id, "WORKER_MENU_SHEEPER");
					showGUIMenu(id, "WORKER_MENU");



				-- ###############################################################
				------------------------------------------------------------------
				end

			end
		end
	end
end


function _workerGoWork(id)

	local b_id = nil;
	for i = 1, TRADERS_COUNT do
		if WORKERS[i].worker_name == GetPlayerName(Player[id]._worker_bot[2]) then
			b_id = i;
			break
		end
	end
	
	if WORKERS[b_id].worker_owner == Player[id].nickname or Player[id].astatus > 1 then
		if Player[id].rude >= WORKERS[b_id].worker_price then

			if WORKERS[b_id].worker_type == "шахтер" then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 20 do
					local rnd = math.random (1, 100);
					if rnd <= 48 then
				    	table.insert(drop_list, "OOLTYB_ItMi_Nugget");
				    	table.insert(drop_list, "OOLTYB_ItMi_Nugget");

					elseif rnd > 48 and rnd <= 50 then
			        	table.insert(drop_list, "OOLTYB_ItMi_Rockcrystal");

				   	elseif rnd > 50 and rnd <= 80 then
			        	table.insert(drop_list, "OOLTYB_ItMi_Nugget");
			        	table.insert(drop_list, "OOLTYB_ItMi_Nugget");
			        	table.insert(drop_list, "OOLTYB_ItMi_Nugget");

				   	elseif rnd > 80 and rnd <= 88 then
				   		table.insert(drop_list, "OOLTYB_ITMI_MAGICORE");

				   	elseif rnd > 88 and rnd <= 89 then
				   		table.insert(drop_list, "OOLTYB_ItMi_Quartz");

				   	elseif rnd > 89 and rnd <= 90 then
				   		table.insert(drop_list, "OOLTYB_ITMI_RUBIN");

				   	elseif rnd > 90 and rnd <= 97 then
				   		table.insert(drop_list, "OOLTYB_ItMi_Sulfur");

				   	elseif rnd > 97 and rnd <= 98 then
				   		table.insert(drop_list, "OOLTYB_ItMi_Aquamarine");

				   	elseif rnd > 98 and rnd <= 99 then
				   		table.insert(drop_list, "OOLTYB_ItMi_GoldNugget_Addon");

				   	elseif rnd > 99 and rnd <= 100 then
				   		table.insert(drop_list, "OOLTYB_ItMi_SilverNugget");
				   	end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);

			elseif WORKERS[b_id].worker_type == "дровосек" then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 20 do
					local rnd = math.random (1, 100);
					if rnd <= 45 then
					    table.insert(drop_list, "OOLTYB_ITMI_WOOD");
					    table.insert(drop_list, "OOLTYB_ITMI_WOOD");
					    table.insert(drop_list, "OOLTYB_ITMI_WOOD");

					elseif rnd > 45 and rnd <= 65 then
				    	table.insert(drop_list, "OOLTYB_ITMI_WOOD");
				    	table.insert(drop_list, "OOLTYB_ITMI_WOOD");
				    	table.insert(drop_list, "OOLTYB_ITMI_WOOD");
				    	table.insert(drop_list, "OOLTYB_ITMI_WOOD");

				   	elseif rnd > 65 and rnd <= 75 then
				    	table.insert(drop_list, "JKZTZD_ItMw_1h_Bau_Mace");

				   	elseif rnd > 75 and rnd <= 85 then
				   		table.insert(drop_list, "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01");

				   	elseif rnd > 85 and rnd <= 95 then
				    	table.insert(drop_list, "OOLTYB_ITMI_HONEYCOMB");

				   	elseif rnd > 95 and rnd <= 100 then
						table.insert(drop_list, "OOLTYB_ItMi_Pitch");
				   	end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);

			elseif WORKERS[b_id].worker_type == "фермер" then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 20 do
					local rnd = math.random(1, 100);
					if rnd <= 50 then
						table.insert(drop_list, "ZDPWLA_ITFO_RICE");
						table.insert(drop_list, "ZDPWLA_ITFO_RICE");

					elseif rnd > 50 and rnd <= 75 then
				    	table.insert(drop_list, "ZDPWLA_ITFO_RICE");
				    	table.insert(drop_list, "ZDPWLA_ITFO_RICE");
				    	table.insert(drop_list, "ZDPWLA_ITFO_RICE");

				    elseif rnd > 75 and rnd <= 90 then
				    	table.insert(drop_list, "ZDPWLA_ITFO_RICE");
				    	table.insert(drop_list, "ZDPWLA_ITFO_RICE");
				    	table.insert(drop_list, "ZDPWLA_ITFO_RICE");
				    	table.insert(drop_list, "ZDPWLA_ITFO_RICE");

				    elseif rnd > 90 and rnd <= 100 then
				    	table.insert(drop_list,  "ZDPWLA_ITPL_WEED");	
				    end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);

			elseif WORKERS[b_id].worker_type == "рыбак" then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 20 do
					local rnd = math.random(1, 100);
					if rnd <= 45 then
					elseif rnd == 46 then
						table.insert(drop_list, "OOLTYB_ITMI_FLASK");

					elseif rnd == 47 then
						table.insert(drop_list, "JKZTZD_ITMW_1H_BAU_MACE");

					elseif rnd == 48 then
						table.insert(drop_list, "JKZTZD_ITRW_ARROW");

					elseif rnd == 49 then
						table.insert(drop_list, "YVNZMZ_ITMI_BIZHA");

					elseif rnd == 50 then
						table.insert(drop_list, "OOLTYB_ITAT_GOBLINBONE");

					elseif rnd > 50 and rnd <= 80 then
						table.insert(drop_list, "ZDPWLA_ITFO_FISH");

					elseif rnd > 80 then
						table.insert(drop_list, "ZDPWLA_ITFO_FISH");
						table.insert(drop_list, "ZDPWLA_ITFO_FISH");
					end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "У вас недостаточно руды для оплаты труда рабочего.")
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "Вы не являетесь управляющим рабочего.")
	end
end

function _workersGoSheep(id, hid)

	local b_id = nil;
	for i = 1, TRADERS_COUNT do
		if WORKERS[i].worker_name == GetPlayerName(Player[id]._worker_bot[2]) then
			b_id = i;
			break
		end
	end
	
	if WORKERS[b_id].worker_owner == Player[id].nickname or Player[id].astatus > 1 then
		if Player[id].rude >= WORKERS[b_id].worker_price then

			if hid == 1 then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 20 do
					local rnd = math.random(1, 100);
					if rnd <= 40 then
						-- 

					elseif rnd > 40 and rnd < 90 then
						table.insert(drop_list, "ZDPWLA_ITFO_MILK");

					elseif rnd >= 90 and rnd <= 100 then
						table.insert(drop_list, "ZDPWLA_ITFO_MILK");
						table.insert(drop_list, "ZDPWLA_ITFO_MILK");

					end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);

			elseif hid == 2 then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 20 do
					local rnd = math.random(1, 100);
					if rnd <= 80 then
						table.insert(drop_list, "OOLTYB_ITMI_SHEEP");

					elseif rnd > 80 then
						table.insert(drop_list, "OOLTYB_ITMI_SHEEP");
						table.insert(drop_list, "OOLTYB_ITMI_SHEEP");
					end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);

			end
		else
			SendPlayerMessage(id, 255, 255, 255, "У вас недостаточно руды для оплаты труда рабочего.")
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "Вы не являетесь управляющим рабочего.")
	end
end

function _workersGoHunt(id, hid)

	local b_id = nil;
	for i = 1, TRADERS_COUNT do
		if WORKERS[i].worker_name == GetPlayerName(Player[id]._worker_bot[2]) then
			b_id = i;
			break
		end
	end
	
	if WORKERS[b_id].worker_owner == Player[id].nickname or Player[id].astatus > 1 then
		if Player[id].rude >= WORKERS[b_id].worker_price then

			if hid == 1 then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 4 do
					local drop = math.random(1, 10);
					if drop <= 4 then
					else
						table.insert(drop_list, MOLERAT_DROPLIST_1[1]);
						table.insert(drop_list, MOLERAT_DROPLIST_1[1]);
						table.insert(drop_list, MOLERAT_DROPLIST_1[1]);
						table.insert(drop_list, MOLERAT_DROPLIST_1[1]);
						table.insert(drop_list, MOLERAT_DROPLIST_1[2]);
					end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);

			elseif hid == 2 then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 4 do
					local drop = math.random(1, 10);
					if drop <= 4 then
					else
						table.insert(drop_list, WOLF_DROPLIST_1[1]);
						table.insert(drop_list, WOLF_DROPLIST_1[1]);
						table.insert(drop_list, WOLF_DROPLIST_1[1]);
						table.insert(drop_list, WOLF_DROPLIST_1[2]);
					end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);

			elseif hid == 3 then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 4 do
					local drop = math.random(1, 10);
					if drop <= 4 then
					else
						table.insert(drop_list, SCAVENGER_DROPLIST_1[1]);
						table.insert(drop_list, SCAVENGER_DROPLIST_1[1]);
						table.insert(drop_list, SCAVENGER_DROPLIST_1[1]);
						table.insert(drop_list, SCAVENGER_DROPLIST_1[1]);
						table.insert(drop_list, SCAVENGER_DROPLIST_1[2]);
					end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "У вас недостаточно руды для оплаты труда рабочего.")
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "Вы не являетесь управляющим рабочего.")
	end
end


function _workersGoHerbs(id, hid)

	local b_id = nil;
	for i = 1, TRADERS_COUNT do
		if WORKERS[i].worker_name == GetPlayerName(Player[id]._worker_bot[2]) then
			b_id = i;
			break
		end
	end
	
	if WORKERS[b_id].worker_owner == Player[id].nickname or Player[id].astatus > 1 then
		if Player[id].rude >= WORKERS[b_id].worker_price then

			if hid == 1 then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 20 do
					local rnd = math.random(1, 100);
					if rnd <= 40 then
						table.insert(drop_list, "ZDPWLA_ItPl_Temp_Herb");

				    elseif rnd > 40 and rnd <= 55 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Temp_Herb");
				    	table.insert(drop_list, "ZDPWLA_ItPl_Temp_Herb");

				    elseif rnd > 55 and rnd <= 65 then
				    	table.insert(drop_list, "ZDPWLA_ITFO_PLANTS_SERAPHIS_01");
				    	table.insert(drop_list, "ZDPWLA_ITFO_PLANTS_SERAPHIS_01");

				    elseif rnd > 65 and rnd <= 85 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Health_Herb_01");

				    elseif rnd > 85 and rnd <= 95 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Health_Herb_02");

					elseif rnd > 95 and rnd <= 100 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Health_Herb_03");
				    end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);

			elseif hid == 2 then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 20 do
					local rnd = math.random(1, 100);
					if rnd <= 40 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Temp_Herb");

				    elseif rnd > 40 and rnd <= 60 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Temp_Herb");
				    	table.insert(drop_list, "ZDPWLA_ItPl_Temp_Herb");

				    elseif rnd > 60 and rnd <= 80 then
				    	table.insert(drop_list, "ZDPWLA_ITFO_PLANTS_SERAPHIS_01");

				    elseif rnd > 80 and rnd <= 90 then
				    	table.insert(drop_list, "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01");

				    elseif rnd > 90 and rnd <= 98 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Strength_Herb_01");

					elseif rnd > 98 and rnd <= 100 then
				    	table.insert(drop_list, "ZDPWLA_ITFO_PLANTS_MOUNTAINMOSS_01");
				    end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);

			elseif hid == 3 then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 20 do
					local rnd = math.random(1, 100);
					if rnd <= 40 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Temp_Herb");

				    elseif rnd > 40 and rnd <= 55 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Temp_Herb");
				    	table.insert(drop_list, "ZDPWLA_ItPl_Temp_Herb");

				    elseif rnd > 55 and rnd <= 65 then
				    	table.insert(drop_list, "ZDPWLA_ITFO_PLANTS_SERAPHIS_01");
				    	table.insert(drop_list, "ZDPWLA_ITFO_PLANTS_SERAPHIS_01");

				    elseif rnd > 65 and rnd <= 85 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Mana_Herb_01");

				    elseif rnd > 85 and rnd <= 95 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Mana_Herb_02");

					elseif rnd > 95 and rnd <= 100 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Mana_Herb_03");
				    end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);

			elseif hid == 4 then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 20 do
					local rnd = math.random(1, 100);
					if rnd <= 40 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Forestberry");

				    elseif rnd > 40 and rnd <= 60 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Forestberry");
				    	table.insert(drop_list, "ZDPWLA_ItPl_Forestberry");

				    elseif rnd > 60 and rnd <= 70 then
				    	table.insert(drop_list, "ZDPWLA_ITFO_WINEBERRYS2");

				    elseif rnd > 70 and rnd <= 80 then
				    	table.insert(drop_list, "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_01");

				    elseif rnd > 80 and rnd <= 90 then
				    	table.insert(drop_list, "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_02");

					elseif rnd > 90 and rnd <= 95 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Dex_Herb_01");

					elseif rnd > 95 and rnd <= 100 then
				    	table.insert(drop_list, "ZDPWLA_ITFO_Plants_Trollberrys_01");
				    end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);

			elseif hid == 5 then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 20 do
					local rnd = math.random(1, 100);
					if rnd <= 40 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Mushroom_01");

				    elseif rnd > 40 and rnd <= 60 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Mushroom_01");
				    	table.insert(drop_list, "ZDPWLA_ItPl_Mushroom_01");

				    elseif rnd > 60 and rnd <= 80 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Mushroom_02");

				    elseif rnd > 80 and rnd <= 90 then
				    	table.insert(drop_list, "ZDPWLA_ITFO_PLANTS_MOUNTAINMOSS_01");

				    elseif rnd > 90 and rnd <= 95 then
				    	table.insert(drop_list, "ZDPWLA_ITFO_PLANTS_STONEROOT_01");

					elseif rnd > 98 and rnd <= 100 then
				    	table.insert(drop_list, "ZDPWLA_ItPl_Mushroom_04");
				    end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);

			elseif hid == 6 then

				Player[id].rude = Player[id].rude - WORKERS[b_id].worker_price;

				local drop_list = {};

				for i = 1, 20 do
					local rnd1 = math.random(1, 100);
					if rnd1 <= 40 then
				    	table.insert(drop_list, "ZDPWLA_ITPL_SWAMPHERB");

				    elseif rnd1 > 40 and rnd1 <= 60 then
				    	table.insert(drop_list, "ZDPWLA_ITPL_SWAMPHERB");
				    	table.insert(drop_list, "ZDPWLA_ITPL_SWAMPHERB");

				    elseif rnd1 > 60 and rnd1 <= 75 then
				    	table.insert(drop_list, "OOLTYB_ITMI_REMI");

				    elseif rnd1 > 75 and rnd1 <= 90 then
				    	table.insert(drop_list, "OOLTYB_ITMI_REMI1");

				    elseif rnd1 > 90 and rnd1 <= 98 then
				    	table.insert(drop_list, "OOLTYB_ITMI_REMI2");

					elseif rnd1 > 98 and rnd1 <= 100 then
				   		table.insert(drop_list, "OOLTYB_ITMI_ADDON_WHITEPEARL");
				    end
				end

				SendPlayerMessage(id, 255, 255, 255, "Рабочий завершил работу и принес вам:")
				for i = 1, table.getn(drop_list) do
					SendPlayerMessage(id, 255, 255, 255, GetItemName(drop_list[i]).." x1");
					GiveItem(id, string.upper(drop_list[i]), 1);
				end

				SavePlayer(id);
				SaveItems(id);
				_workersBlock(id);
				_workersLog(id);
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "У вас недостаточно руды для оплаты труда рабочего.")
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "Вы не являетесь управляющим рабочего.")
	end
end




function _workersCheckBlock(id, bname)

	local file = io.open("Blocks/Workers.txt", "r");
	if file then
		for line in file:lines() do
			local result, name = sscanf(line, "s");
			if result == 1 then
				if name == bname then
					file:close();
					return true;
				end
			end
		end
	file:close();
	end
	return false;

end

function _workersBlock(id)

	local file = io.open("Blocks/Workers.txt", "a+");
	file:write(GetPlayerName(Player[id]._worker_bot[2]).."\n");
	file:close();

end

function _workersLog(id)

	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	LogString("Logs/Workers/All", Player[id].nickname.." воспользовался рабочим "..GetPlayerName(Player[id]._worker_bot[2]).." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);

end


function _createWorker(id, sets)

	if Player[id].astatus > 0 then

		local result, bname = sscanf(sets, "s");
		if result == 1 then

			local x, y, z = GetPlayerPos(id);
			local v1, v2, v3, v4 = GetPlayerAdditionalVisual(id);
			local armor = GetEquippedArmor(id);
			local mweapon = GetEquippedMeleeWeapon(id);
			local rweapon = GetEquippedRangedWeapon(id);
			local angle = GetPlayerAngle(id);
			SendPlayerMessage(id, 255, 255, 255, "Болванка создана в базу данных.")

			local file = io.open("Database/_Coord/Workers/"..bname..".txt", "w");
			file:write("Владелец".." ".."тип".." ".."ставка".." "..x.." "..y.." "..z.." "..angle.." "..v1.." "..v2.." "..v3.." "..v4.." "..armor.." "..mweapon.." "..rweapon)
			file:close();
		else
			SendPlayerMessage(id, 255, 255, 255, "/сраб (имя)")
		end
	end
end
addCommandHandler({"/сраб"}, _createWorker);

--[[function _createWorker(id, sets)

	if Player[id].astatus > 2 then

		local cmd, bot_name, bot_type, bot_owner, bot_price = sscanf(sets, "sssd");
		if cmd == 1 then

			local status = false;

			for i, v in pairs(WORKERS_COUNT_LIST) do
				if v == bot_name then
					status = true;
					SendPlayerMessage(id, 255, 255, 255, "Рабочий с таким именем уже создан.")
				end
			end

			if status == false then

				if bot_type == "дровосек" or bot_type == "шахтер" or bot_type == "фермер" or bot_type == "охотник" or bot_type == "пастух" or bot_type == "рыбак" or bot_type == "травник" then
					
					table.insert(WORKERS_COUNT_LIST, bot_name);
					_saveCountList();
					
					local x, y, z = GetPlayerPos(id);
					local v1, v2, v3, v4 = GetPlayerAdditionalVisual(id);
					local armor = GetEquippedArmor(id);
					local angle = GetPlayerAngle(id);

					local file = io.open(DIR_WORKERS.."/WorkersBase/"..bot_name..".txt", "w+");
					file:write(bot_owner.." "..bot_type.." "..bot_price.." "..x.." "..y.." "..z.." "..angle.." "..v1.." "..v2.." "..v3.." "..v4.." "..armor);
					file:close();

					SendPlayerMessage(id, 255, 255, 255, "Рабочий "..bot_name.." ("..bot_type.." / "..bot_price..") создан.")
				else
					SendPlayerMessage(id, 255, 255, 255, "Указан неправильный тип бота.")
				end
			end

		else
			SendPlayerMessage(id, 255, 255, 255, "/сраб (имя) (тип) (владелец) (ставка)")
			SendPlayerMessage(id, 255, 255, 255, "Доступные типы: дровосек, шахтер, фермер, охотник, пастух, рыбак, травник")
		end
	end
end
addCommandHandler({"/сраб"}, _createWorker);]]