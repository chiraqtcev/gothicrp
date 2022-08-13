
--  # Chest system by royclapton #
--  #       version: 1.0         #

local chest_window_left = CreateTexture(200, 1673, 3276, 7255, 'chest_gui_v5_chest')
local chest_window_right = CreateTexture(4776, 1673, 7846, 7255, 'chest_gui_v5_player')
local select_amount_block = CreateTexture(3475, 3960, 4635, 4485, 'menu_ingame')

-- админское открывание сундука
-- эксперимент с триггером (типо чтобы каждый сундук не прописывать туда)

CHEST = {};
DIR = "Database/Chests/";
DIRITEMS = "Database/Chests/Items/";
DIRINFO = "Database/Chests/Info/";

function _initChest()

	WORLD = "RPCORNER_KHORINIS.ZEN";
	_chestArr = {};
	
	-- сундук в доме 1 (Боспер)
										
	_chestArr[1] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_1", WORLD, 8294.4921875, 273.60739135742, -2595.1494140625, "chest_1");
	Mob.SetRotation(_chestArr[1], 0, 153, 0)

	-- сундук в доме 2 (Торбен)
										
	_chestArr[2] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_2", WORLD, 7588.19140625, 273.18115234375, -2679.8410644531, "chest_2");
	Mob.SetRotation(_chestArr[2], 0, 330, 0)

	-- сундук в доме 3 (Маттео)
										
	_chestArr[3] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_3", WORLD, 6397.1337890625, 273.8720703125, -5325.6459960938, "chest_3");
	Mob.SetRotation(_chestArr[3], 0, 349, 0)

	-- сундук в доме 4 (Гарад)
										
	_chestArr[4] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_4", WORLD, 6088.51953125, 273.83486938477, -179.17907714844, "chest_4");
	Mob.SetRotation(_chestArr[4], 0, 237, 0)

	-- сундук в доме 5 (Константино)
										
	_chestArr[5] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_5", WORLD, 6651.546875, 126.93116760254, 58.411846160889, "chest_5");
	Mob.SetRotation(_chestArr[5], 0, 142, 0)

	-- сундук в доме 6 (Верхний квартал)
										
	_chestArr[6] = Mob.Create("ChestBig_NW_Rich_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_6", WORLD, 12377.421875, 1303.2808837891, -4551.0419921875, "chest_6");
	Mob.SetRotation(_chestArr[6], 0, 274, 0)

	-- сундук в доме 7 (Верхний квартал)
										
	_chestArr[7] = Mob.Create("ChestBig_NW_Rich_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_7", WORLD, 12839.139648438, 1303.2816162109, -4858.9399414062, "chest_7");
	Mob.SetRotation(_chestArr[7], 0, 358, 0)

	-- сундук в доме 8 (Верхний квартал)
										
	_chestArr[8] = Mob.Create("ChestBig_NW_Rich_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_8", WORLD, 15270.767578125, 903.78149414062, -4158.189453125, "chest_8");
	Mob.SetRotation(_chestArr[8], 0, 297, 0)

	-- сундук в доме 9 (Верхний квартал)
										
	_chestArr[9] = Mob.Create("ChestBig_NW_Rich_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_9", WORLD, 10099.26953125, 1303.3887939453, -3000.3168945312, "chest_9");
	Mob.SetRotation(_chestArr[9], 0, 42, 0)

	-- сундук в доме 10 (Верхний квартал)
										
	_chestArr[10] = Mob.Create("ChestBig_NW_Rich_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_10", WORLD, 16859.7578125, 1303.3405761719, -3122.2102050781, "chest_10");
	Mob.SetRotation(_chestArr[10], 0, 4, 0)

	-- сундук в доме 11 (Верхний квартал)
										
	_chestArr[11] = Mob.Create("ChestBig_NW_Rich_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_11", WORLD, 10402.536132812, 1303.4384765625, 1347.9136962891, "chest_11");
	Mob.SetRotation(_chestArr[11], 0, 76, 0)

	-- сундук в доме 12 (Верхний квартал)
										
	_chestArr[12] = Mob.Create("ChestBig_NW_Rich_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_12", WORLD, 11071.19921875, 903.43316650391, 3615.701171875, "chest_12");
	Mob.SetRotation(_chestArr[12], 0, 147, 0)


	-- -- нл трактир											
	-- _chestArr[1] = Mob.Create("CHESTBIG_OCCHESTMEDIUMLOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY1", WORLD, -53945.66796875, 3099.1923828125, 12425.491210938, "chest_1");
	-- Mob.SetRotation(_chestArr[1], 0, -26, 0)

	-- -- генерал											
	-- _chestArr[2] = Mob.Create("CHESTBIG_OCCHESTMEDIUMLOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY2", WORLD, -60941.0078125, 4021.45703125, 8112.259765625, "chest_2");
	-- Mob.SetRotation(_chestArr[2], 0, -197, 0)

	-- -- маги нл 1											
	-- _chestArr[3] = Mob.Create("CHESTBIG_OCCHESTMEDIUMLOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY3", WORLD, -61084.5546875, 3851.9145507812, 2001.4226074219, "chest_3");
	-- Mob.SetRotation(_chestArr[3], 0, -277, 0)

	-- -- маги нл 2 (руда)											
	-- _chestArr[4] = Mob.Create("CHESTBIG_NW_RICH_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY4", WORLD, -56117.3203125, 933.1787109375, 4293.7578125, "chest_4");
	-- Mob.SetRotation(_chestArr[4], 0, -248, 0)

	-- -- башня призраков											
	-- _chestArr[5] = Mob.Create("CHESTBIG_OCCHESTMEDIUMLOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY5", WORLD, 6192.5209960938, -1422.3319091797, -2951.6960449219, "chest_5");
	-- Mob.SetRotation(_chestArr[5], 0, -84, 0)

	-- -- склад стражи										
	-- _chestArr[6] = Mob.Create("CHESTBIG_OCCHESTMEDIUMLOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY6", WORLD, 3919.2465820312, 146.94262695312, 272.84030151367, "chest_6");
	-- Mob.SetRotation(_chestArr[6], 0, -160, 0)

	-- -- маги огня									
	-- _chestArr[7] = Mob.Create("CHESTBIG_OCCHESTMEDIUMLOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY7", WORLD, 615.27862548828, 797.61578369141, -3497.7795410156, "chest_7");
	-- Mob.SetRotation(_chestArr[7], 0, -356, 0)

	-- -- рудный склад (схрон)										
	-- _chestArr[8] = Mob.Create("CHESTBIG_NW_RICH_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY8", WORLD, -2040.7531738281, -749.36883544922, -2929.357421875, "chest_8");
	-- Mob.SetRotation(_chestArr[8], 0, 216, 0)

	-- -----------------------------------------------------------------

	-- -- Дом НЛ (хз)									
	-- _chestArr[9] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY9", WORLD, -57783.0625, 3101.1977539062, 1289.7855224609, "chest_9");
	-- Mob.SetRotation(_chestArr[9], 0, -64, 0)

	-- -- Дом СЛ (Линдеман)									
	-- _chestArr[10] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY10", WORLD, -5552.4975585938, -978, 4768.8369140625, "chest_10");
	-- Mob.SetRotation(_chestArr[10], 0, -388, 0)

	-- -- Дом НЛ (Вильгельм)									
	-- _chestArr[11] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY11", WORLD, -55831.2578125, 2897.9697265625, 629.7607421875, "chest_11");
	-- Mob.SetRotation(_chestArr[11], 0, 26, 0)

	-- _chestArr[12] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY12", WORLD, -62754.39453125, 3942.9921875, 4477.1767578125, "chest_12");
	-- Mob.SetRotation(_chestArr[12], 0, 77, 0)
	
	-- --Гильдия сл
	-- _chestArr[13] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY13", WORLD, 2443.3405761719, -991.44348144531, -2897.9245605469, "chest_13");
	-- Mob.SetRotation(_chestArr[13], 0, 270, 0)
	
	-- --Сундуки Пост Тимориса
	-- _chestArr[14] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY13", WORLD, -52450.29296875, 2551.0798339844, 22122.4296875, "chest_14");
	-- Mob.SetRotation(_chestArr[14], 0, 352, 0)
	-- _chestArr[15] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY13", WORLD, -50903.62109375, 2587.8703613281, 22583.736328125, "chest_15");
	-- Mob.SetRotation(_chestArr[15], 0, 80, 0)
	-- _chestArr[16] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY13", WORLD, -51972.5625, 2188.7192382813, 22869.6484375, "chest_16");
	-- Mob.SetRotation(_chestArr[16], 0, 350, 0)

	-- _chestArr[17] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_CHEST_KEY15", WORLD, -53541.58984375, 2260.1997070312, 4676.3598632812, "chest_17");
	-- Mob.SetRotation(_chestArr[17], 0, -315, 0)


	print(" ");
	print(table.getn(_chestArr).." chests load")

end

function _useChest(id, sc, chest_id, used)
	
	if sc == "CHESTBIG" then
		if used == 1 then


			if chest_id == "CHEST_1" then
				Player[id].chest_id = 1;
				_chestDraw(id, 1);

			elseif chest_id == "CHEST_2" then
				Player[id].chest_id = 2;
				_chestDraw(id, 2);

			elseif chest_id == "CHEST_3" then
				Player[id].chest_id = 3;
				_chestDraw(id, 3);

			elseif chest_id == "CHEST_4" then
				Player[id].chest_id = 4;
				_chestDraw(id, 4);

			elseif chest_id == "CHEST_5" then
				Player[id].chest_id = 5;
				_chestDraw(id, 5);

			elseif chest_id == "CHEST_6" then
				Player[id].chest_id = 6;
				_chestDraw(id, 6);

			elseif chest_id == "CHEST_7" then
				Player[id].chest_id = 7;
				_chestDraw(id, 7);

			elseif chest_id == "CHEST_8" then
				Player[id].chest_id = 8;
				_chestDraw(id, 8);

			elseif chest_id == "CHEST_9" then
				Player[id].chest_id = 9;
				_chestDraw(id, 9);

			elseif chest_id == "CHEST_10" then
				Player[id].chest_id = 10;
				_chestDraw(id, 10);
				
			elseif chest_id == "CHEST_11" then
				Player[id].chest_id = 11;
				_chestDraw(id, 11);		
				
			elseif chest_id == "CHEST_12" then
				Player[id].chest_id = 12;
				_chestDraw(id, 12);	
				
			elseif chest_id == "CHEST_13" then
				Player[id].chest_id = 13;
				_chestDraw(id, 13);	
				
			elseif chest_id == "CHEST_14" then
				Player[id].chest_id = 14;
				_chestDraw(id, 14);	
				
			elseif chest_id == "CHEST_15" then
				Player[id].chest_id = 15;
				_chestDraw(id, 15);

			elseif chest_id == "CHEST_16" then
				Player[id].chest_id = 16;
				_chestDraw(id, 16);

			elseif chest_id == "CHEST_17" then
				Player[id].chest_id = 17;
				_chestDraw(id, 17);
			
			end

		else

			if Player[id].chest_id ~= 0 then
				_destroyChestDraw(id);
				ShowChat(id, 1);
			end

		end
	end


end

function _chestConnect(id)

	Player[id].chest_id = 0;
	Player[id].chest_select = 0;
	Player[id].chest_return = {0, 0};
	Player[id].chest_amount = {false, 0};
	Player[id].chest_amount_final = "";
	Player[id].chest_amount_pos = {0, 0};
	Player[id].chest_check = false;

	Player[id].chestdraw = {};
	Player[id].chest_pos = {0, 0};
	Player[id].chest_pos_draw = nil;
	Player[id].chest_items = {};
	Player[id].chest_items_ids = 0;

	Player[id].chest_p_draw = {};
	Player[id].chest_p_pos_list = 0;
	Player[id].chest_p_pos = {0, 0}
	Player[id].chest_p_pos_draw = nil;
	Player[id].chest_p_items = {};
	Player[id].chest_p_page = 0;
	Player[id].chest_p_page_current = 0;
	Player[id].chest_p_count = 0;

end

function _chestDraw(id, cid)

	for i = 1, 2 do
		Player[id].chest_items[i] = {};
	end

	local filename = tostring(Player[id].chest_id)..".txt";
	local file = io.open(DIRITEMS..filename, "r");
	if file then

		local count = 0;
		for line in file:lines() do
			local result, item, amount = sscanf(line,"sd");
			if result == 1 then
				count = count + 1;
				Player[id].chest_items[1][#Player[id].chest_items[1] + 1] = item;
				Player[id].chest_items[2][#Player[id].chest_items[2] + 1] = amount;
			end
		end


		Player[id].chest_select = 1;
		Freeze(id);

		_firstOpenChest(id);
		ShowChat(id, 0);

		if count > 0 then
			Player[id].chest_pos = {1, count};
			Player[id].chest_pos_draw = CreatePlayerDraw(id, 330, 2800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			ShowPlayerDraw(id, Player[id].chest_pos_draw);
		else
			Player[id].chest_pos = {0, 0};
		end

		ShowTexture(id, chest_window_left);
		ShowTexture(id, chest_window_right);

		for i = 1, 2 do
			Player[id].chestdraw[i] = {};
		end

		for i = 1, count do
			Player[id].chestdraw[1][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			Player[id].chestdraw[2][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			ShowPlayerDraw(id, Player[id].chestdraw[1][i]);
			ShowPlayerDraw(id, Player[id].chestdraw[2][i]);
		end

		local pos = 2800;
		for i, v in pairs(Player[id].chest_items[1]) do
			local str = string.format("%s", GetItemName(v));
			UpdatePlayerDraw(id, Player[id].chestdraw[1][i], 420, pos, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			pos = pos + 250;
		end

		local pos = 2800;
		for i, v in pairs(Player[id].chest_items[2]) do
			UpdatePlayerDraw(id, Player[id].chestdraw[2][i], 2685, pos, v, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			pos = pos + 250;
		end


	end
end

function _firstOpenChest(id)

	for i = 1, 2 do
		Player[id].chest_p_items[i] = {};
	end

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
	if file then

		Player[id].chest_p_count = 0;
		local items = getPlayerItems(id);
		if items then
			for i in pairs(items) do
				Player[id].chest_p_count = Player[id].chest_p_count + 1;
				table.insert(Player[id].chest_p_items[1], items[i].instance)
				table.insert(Player[id].chest_p_items[2], items[i].amount)
			end
		end

		if Player[id].chest_p_count <= 16 then
			Player[id].chest_p_pos = {1, Player[id].chest_p_count};
			Player[id].chest_p_page = 1;
			Player[id].chest_p_page_current = 1;
			Player[id].chest_items_ids = 1;
		else
			Player[id].chest_p_pos = {1, 16};
			Player[id].chest_p_page_current = 1;
			Player[id].chest_items_ids = 1;

			if Player[id].chest_p_count > 16 and Player[id].chest_p_count <= 32 then
				Player[id].chest_p_page = 2;

			elseif Player[id].chest_p_count > 32 and Player[id].chest_p_count <= 48 then
				Player[id].chest_p_page = 3;

			elseif Player[id].chest_p_count > 48 and Player[id].chest_p_count <= 64 then
				Player[id].chest_p_page = 4;

			elseif Player[id].chest_p_count > 64 and Player[id].chest_p_count <= 80 then
				Player[id].chest_p_page = 5;

			elseif Player[id].chest_p_count > 80 and Player[id].chest_p_count <= 96 then
				Player[id].chest_p_page = 6;

			elseif Player[id].chest_p_count > 96 and Player[id].chest_p_count <= 112 then
				Player[id].chest_p_page = 7;

			elseif Player[id].chest_p_count > 112 and Player[id].chest_p_count <= 128 then
				Player[id].chest_p_page = 8;

			elseif Player[id].chest_p_count > 128 and Player[id].chest_p_count <= 144 then
				Player[id].chest_p_page = 9;
			end
		end

		
		Player[id].chest_p_pos_draw = CreatePlayerDraw(id, 4950, 2800, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		ShowPlayerDraw(id, Player[id].chest_p_pos_draw);

		for i = 1, 2 do
			Player[id].chest_p_draw[i] = {};
		end


		for i = 1, 16 do
			Player[id].chest_p_draw[1][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			Player[id].chest_p_draw[2][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			ShowPlayerDraw(id, Player[id].chest_p_draw[1][i]);
			ShowPlayerDraw(id, Player[id].chest_p_draw[2][i]);
		end

		_updateItemsChest_player(id);

		file:close();
	end
end
----------------------------------------------------------------

function _destroyChestDraw(id)

	local filename = tostring(Player[id].chest_id)..".txt";
	local file = io.open(DIRITEMS..filename, "r");

	local count = 0;
	for line in file:lines() do
		count = count + 1;
	end

	for i = 1, count do
		HidePlayerDraw(id, Player[id].chestdraw[1][i]);
		HidePlayerDraw(id, Player[id].chestdraw[2][i]);
		DestroyPlayerDraw(id, Player[id].chestdraw[1][i]);
		DestroyPlayerDraw(id, Player[id].chestdraw[2][i]);
	end

	----------------------------------

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
	local count = 0;
	for line in file:lines() do
		count = count + 1;
	end

	for i = 1, 16 do
		HidePlayerDraw(id, Player[id].chest_p_draw[1][i]);
		HidePlayerDraw(id, Player[id].chest_p_draw[2][i]);
		DestroyPlayerDraw(id, Player[id].chest_p_draw[1][i]);
		DestroyPlayerDraw(id, Player[id].chest_p_draw[2][i]);
	end

	----------------------------------

	HideTexture(id, chest_window_left);
	HideTexture(id, chest_window_right);

	local cid = Player[id].chest_id;
	Player[id].chest_id = 0;
	Player[id].chest_select = 0;

	Player[id].chest_p_page = 0;
	Player[id].chest_p_page_current = 0;
	Player[id].chest_items = {}
	Player[id].chest_p_items = {};
	Player[id].chest_items_ids = 0;

	if Player[id].chest_pos_draw ~= nil then
		HidePlayerDraw(id, Player[id].chest_pos_draw);
		DestroyPlayerDraw(id, Player[id].chest_pos_draw);
		Player[id].chest_pos_draw = nil;
	end

	if Player[id].chest_p_pos_draw ~= nil then
		HidePlayerDraw(id, Player[id].chest_p_pos_draw);
		DestroyPlayerDraw(id, Player[id].chest_p_pos_draw);
		Player[id].chest_p_pos_draw = nil;
	end



	Player[id].chest_pos = {0, 0};
	Player[id].chest_p_pos = {0, 0};


	if Player[id].chest_amount[1] == true then
		HideTexture(id, select_amount_block);
		HidePlayerDraw(id, chest_amount);
		UpdatePlayerDraw(id, chest_num, 4005, 4040, "", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
		HidePlayerDraw(id, chest_num);
		Player[id].chest_amount_final = "";
		Player[id].chest_amount[1] = false;
		Player[id].chest_amount[2] = 0;
		Player[id].chest_check = false;
	end

	UnFreeze(id);


end

function _destroyAfterDeal(id)

	local count = 0;
	for i, v in pairs(Player[id].chestdraw[1]) do
		count = count + 1;
	end

	for i = 1, count do
		HidePlayerDraw(id, Player[id].chestdraw[1][i]);
		HidePlayerDraw(id, Player[id].chestdraw[2][i]);
		DestroyPlayerDraw(id, Player[id].chestdraw[1][i]);
		DestroyPlayerDraw(id, Player[id].chestdraw[2][i]);
	end

	local count = 0;
	for i, v in pairs(Player[id].chest_p_draw[1]) do
		count = count + 1;
	end

	for i = 1, 16 do
		HidePlayerDraw(id, Player[id].chest_p_draw[1][i]);
		HidePlayerDraw(id, Player[id].chest_p_draw[2][i]);
		DestroyPlayerDraw(id, Player[id].chest_p_draw[1][i]);
		DestroyPlayerDraw(id, Player[id].chest_p_draw[2][i]);
	end

	HideTexture(id, chest_window_left);
	HideTexture(id, chest_window_right);

	local cid = Player[id].chest_id;

	Player[id].chest_items = {}
	Player[id].chest_p_items = {};
	Player[id].chest_items_ids = 0;

	if Player[id].chest_pos_draw ~= nil then
		HidePlayerDraw(id, Player[id].chest_pos_draw);
		DestroyPlayerDraw(id, Player[id].chest_pos_draw);
		Player[id].chest_pos_draw = nil;
	end

	if Player[id].chest_p_pos_draw ~= nil then
		HidePlayerDraw(id, Player[id].chest_p_pos_draw);
		DestroyPlayerDraw(id, Player[id].chest_p_pos_draw);
		Player[id].chest_p_pos_draw = nil;
	end

	Player[id].chest_pos = {0, 0};
	Player[id].chest_p_pos = {0, 0};
	Player[id].chest_return = {0, 0};
	Player[id].chest_p_page = 0;
	Player[id].chest_p_page_current = 0;


	HideTexture(id, select_amount_block);
	HidePlayerDraw(id, chest_amount);
	UpdatePlayerDraw(id, chest_num, 4005, 4040, "", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	HidePlayerDraw(id, chest_num);
	Player[id].chest_amount_final = "";
	Player[id].chest_amount[1] = false;
	Player[id].chest_amount[2] = 0;
	Player[id].chest_check = false;

	_chestDraw(id);

end

function _selectAmount(id)

	if Player[id].chest_amount[1] == false then
		Player[id].chest_amount[2] = 0;
		Player[id].chest_amount_final = "";
		ShowTexture(id, select_amount_block);
		ShowPlayerDraw(id, chest_amount);
		ShowPlayerDraw(id, chest_num);
		Player[id].chest_amount[1] = true;
		Freeze(id);
	end

end

function _cheskLens(id)

	if string.len(Player[id].chest_amount_final) == 1 then
		Player[id].chest_amount_pos = {4005, 4040};

	elseif string.len(Player[id].chest_amount_final) == 2 then
		Player[id].chest_amount_pos = {3990, 4040};

	elseif string.len(Player[id].chest_amount_final) == 3 then
		Player[id].chest_amount_pos = {3960, 4040};

	elseif string.len(Player[id].chest_amount_final) == 4 then
		Player[id].chest_amount_pos = {3920, 4040};

	elseif string.len(Player[id].chest_amount_final) == 5 then
		Player[id].chest_amount_pos = {3880, 4040};

	elseif string.len(Player[id].chest_amount_final) == 6 then
		Player[id].chest_amount_pos = {3840, 4040};

	elseif string.len(Player[id].chest_amount_final) == 7 then
		Player[id].chest_amount_pos = {3800, 4040};
	end


end

function _selectKey(id, down, up)

	if Player[id].chest_amount[1] == true then

		if down == KEY_1 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."1";
				_cheskLens(id);
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_2 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."2";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_3 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."3";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_4 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."4";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_5 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."5";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_6 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."6";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_7 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."7";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_8 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."8";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_9 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."9";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_0 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."0";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_SPACE then
			if Player[id].chest_amount[1] == true then
				local txt = string.sub(Player[id].chest_amount_final, 1, #Player[id].chest_amount_final-1)
				Player[id].chest_amount_final = txt;
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_RETURN then
			if Player[id].chest_select == 2 then
				if string.len(Player[id].chest_amount_final) > 0 then
					Player[id].chest_check = true;
					if Player[id].chest_amount[1] == true and Player[id].chest_check == true then
						local number = tonumber(Player[id].chest_amount_final);
						if number > 0 then
							Player[id].chest_amount[2] = number;

							local key = Player[id].chest_p_pos[1];
							local item = _checkCurrentItem(id, key) -- Player[id].chest_p_items[1][key];
							if item ~= nil then
								local tItem = 0;
								local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
								for line in file:lines() do
									local result, i, a = sscanf(line, "sd");
									if result == 1 then
										if i == item then
											tItem = a;
										end
									end
								end

								if tItem >= Player[id].chest_amount[2] then
									_putInChest(id, item, Player[id].chest_amount[2]);
								else
									GameTextForPlayer(id, 2710, 1055, "У вас нет такого количества.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2000);
									--SendPlayerMessage(id, 255, 255, 255, "У вас нет столько.")
								end
							end
						end
					end
				end

			elseif Player[id].chest_select == 1 then
				if string.len(Player[id].chest_amount_final) > 0 then
					Player[id].chest_check = true;
					if Player[id].chest_amount[1] == true and Player[id].chest_check == true then
						local number = tonumber(Player[id].chest_amount_final);
						if number > 0 then
							Player[id].chest_amount[2] = number;

							local key = Player[id].chest_pos[1];
							local item = Player[id].chest_items[1][key];

							local tItem = 0;
							local file = io.open("Database/Chests/Items/"..Player[id].chest_id..".txt", "r");
							for line in file:lines() do
								local result, i, a = sscanf(line, "sd");
								if result == 1 then
									if i == item then
										tItem = a;
									end
								end
							end

							if tItem >= Player[id].chest_amount[2] then
								_putInPlayer(id, item, Player[id].chest_amount[2]);
							else
								GameTextForPlayer(id, 2710, 1055, "В сундуке нет такого количества.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2000);
								--SendPlayerMessage(id, 255, 255, 255, "В сундуке столько нет.")
							end
						end
					end
				end
			else
			end
		end

	end

end

function _updateItemsChest_player(id)

	if Player[id].chest_p_page_current == 1 then

		local pos = 2800;
		for i = 1, 16 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][i], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][i], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250;
			end
		end

	elseif Player[id].chest_p_page_current == 2 then

		local pos = 2800;
		local c = 1;
		for i = 17, 32 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end


	elseif Player[id].chest_p_page_current == 3 then

		local pos = 2800;
		local c = 1;
		for i = 33, 48 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 4 then

		local pos = 2800;
		local c = 1;
		for i = 49, 64 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 5 then

		local pos = 2800;
		local c = 1;
		for i = 65, 80 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end


	elseif Player[id].chest_p_page_current == 6 then

		local pos = 2800;
		local c = 1;
		for i = 81, 96 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 7 then

		local pos = 2800;
		local c = 1;
		for i = 97, 112 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 8 then

		local pos = 2800;
		local c = 1;
		for i = 113, 128 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 9 then

		local pos = 2800;
		local c = 1;
		for i = 129, 144 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	end

end
----------------------------------------

function _chestKey(id, down, up)

	if Player[id].chest_id ~= 0 and Player[id].loggedIn == true then

		if Player[id].chest_amount[1] == false then
			---------------------------------------------------
			if down == KEY_DOWN then

				if Player[id].chest_select == 1 then

					Player[id].chest_pos[1] = Player[id].chest_pos[1] + 1;
					if Player[id].chest_pos[1] > Player[id].chest_pos[2] then
						Player[id].chest_pos[1] = 1;
					end
					_updateChestPos(id);

				elseif Player[id].chest_select == 2 then

					Player[id].chest_p_pos[1] = Player[id].chest_p_pos[1] + 1;
					if Player[id].chest_p_pos[1] > Player[id].chest_p_pos[2] then
						if Player[id].chest_p_page > 1 then
							Player[id].chest_p_page_current = Player[id].chest_p_page_current + 1;
							_resetalldrawsChest(id);
							_updateItemsChest_player(id);
							if Player[id].chest_p_page_current <= Player[id].chest_p_page then
								Player[id].chest_p_pos[1] = 1;
							else
								Player[id].chest_p_page_current = 1;
								Player[id].chest_p_pos[1] = 1;
								_resetalldrawsChest(id);
								_updateItemsChest_player(id);
							end
						else
							Player[id].chest_p_pos[1] = 1;
						end
					end
					_updateItemsPos(id);
				end

			end
			---------------------------------------------------
			if down == KEY_UP then

				if Player[id].chest_select == 1 then

					Player[id].chest_pos[1] = Player[id].chest_pos[1] - 1;
					if Player[id].chest_pos[1] <= 0 then
						Player[id].chest_pos[1] = Player[id].chest_pos[2];
					end

					_updateChestPos(id);

				elseif Player[id].chest_select == 2 then

					Player[id].chest_p_pos[1] = Player[id].chest_p_pos[1] - 1;
					if Player[id].chest_p_pos[1] < Player[id].chest_p_pos[2] then
						if Player[id].chest_p_page > 1 then
							Player[id].chest_p_page_current = Player[id].chest_p_page_current - 1;
							_resetalldrawsChest(id);
							_updateItemsChest_player(id);
							if Player[id].chest_p_page_current == Player[id].chest_p_page then
								Player[id].chest_p_pos[1] = 16;
							else
								Player[id].chest_p_page_current = 1;
								Player[id].chest_p_pos[1] = 1;
								_resetalldrawsChest(id);
								_updateItemsChest_player(id);
							end
						else
							Player[id].chest_p_pos[1] = 1;
						end
					end
					_updateItemsPos(id);
					_updateItemsChest_player(id);
				end

			end
			---------------------------------------------------
			if down == KEY_RIGHT then

				if Player[id].chest_select == 1 then

					_resetcolorall(id);

					Player[id].chest_select = 2;
					Player[id].chest_pos[1] = 0;
					_updateChestPos(id);

					Player[id].chest_p_pos[1] = 1;
					_updateItemsPos(id);
				end

			end
			---------------------------------------------------
			if down == KEY_LEFT then

				if Player[id].chest_select == 2 then

					_resetcolorall(id);

					Player[id].chest_select = 1;
					Player[id].chest_p_pos[1] = 0;
					_updateItemsPos(id);

					Player[id].chest_pos[1] = 1;
					_updateChestPos(id);
				end
			end
		end

		if down == KEY_ESCAPE then
			ShowChat(id, 1);
			_destroyChestDraw(id);
		end

		---------------------------------------------------

		if down == KEY_RETURN then
			_preaccept(id);
		end
	end

end

function _resetalldrawsChest(id)

	for i = 1, 16 do
		if Player[id].chest_p_draw[1][i] ~= nil then
			SetPlayerDrawText(id, Player[id].chest_p_draw[1][i], "");
			SetPlayerDrawText(id, Player[id].chest_p_draw[2][i], "");
		end
	end

end

function _resetcolorall(id)

	local count = 0;
	for i, _ in pairs(Player[id].chest_items[1]) do
		count = count + 1;
	end

	for i = 1, count do
		SetPlayerDrawColor(id, Player[id].chestdraw[1][i], 255, 255, 255);
		SetPlayerDrawColor(id, Player[id].chestdraw[2][i], 255, 255, 255);
	end

	local count = 0;
	for i, _ in pairs(Player[id].chest_p_items[1]) do
		count = count + 1;
	end

	for i = 1, 16 do
		if Player[id].chest_p_draw[1][i] ~= nil then
			SetPlayerDrawColor(id, Player[id].chest_p_draw[1][i], 255, 255, 255);
			SetPlayerDrawColor(id, Player[id].chest_p_draw[2][i], 255, 255, 255);
		end
	end


end

function _checkCurrentItem(id, cid)

	if Player[id].chest_p_page_current == 1 then

		local c = 1;
		for i = 1, 16 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 2 then

		local c = 1;
		for i = 17, 32 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 3 then

		local c = 1;
		for i = 33, 48 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 4 then

		local c = 1;
		for i = 49, 64 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 5 then

		local c = 1;
		for i = 65, 80 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 6 then

		local c = 1;
		for i = 81, 96 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 7 then

		local c = 1;
		for i = 97, 112 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 8 then

		local c = 1;
		for i = 113, 128 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 9 then

		local c = 1;
		for i = 129, 144 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	end
end

function _checkEmpty(id, cid)

	for i, v in pairs(Player[id].chest_items[1]) do
		if i == cid then
			return false;
		end
	end
	return true;

end

function _checkChestSlots(cid)

	local value = 0;
	local ldir = cid..".txt";
	local file = io.open(DIRITEMS..ldir,"r");

	for line in file:lines() do
		local result, item, amount = sscanf(line, "sd");
		if result == 1 then
			value = value + 1;
		end
	end

	if value < 16 then
		return true;
	else
		return false;
	end

end

function _playerHasItem(id, it)

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
	for line in file:lines() do
		local result, i, a = sscanf(line, "sd");
		if result == 1 then
			if i == it then
				return true;
			end
		end
	end
	return false;

end

function _chestHasItem(cid, it)

	local ldir = cid..".txt";
	local file = io.open(DIRITEMS..ldir,"r");
	for line in file:lines() do
		local result, item, amount = sscanf(line, "sd");
		if result == 1 then
			if item == it then
				return true;
			end
		end
	end
	return false;

end

-- положить в сундук
function _putInChest(id, item, amount)

	
	if _checkChestSlots(Player[id].chest_id) == true or _chestHasItem(Player[id].chest_id, item) == true then

		local key = {};
		for i, v in pairs(Player[id].chest_p_items[1]) do
			if v == item then
				key[1] = i;
				key[2] = v;
				break
			end
		end

		local slot_id = key[1];
		local slot_item = key[2];

		if Player[id].chest_p_items[2][slot_id] > 1 then

			local time = os.date('*t');
		    local ryear = time.year;
			local rmonth = time.month;
			local rday = time.day;
			local rhour = string.format("%02d", time.hour);
			local rminute = string.format("%02d", time.min);
			LogString("Logs/PlayersAll/chest", Player[id].nickname.." забрал из сундука x"..amount.." "..GetItemName(item).." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);

			--SendPlayerMessage(id, 255, 255, 255, "Вы положили в сундук "..GetItemName(item).." x"..amount);
			local str = "Вы положили в сундук "..GetItemName(item).." x"..amount;
			GameTextForPlayer(id, 2710, 1055, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2500);

			RemoveItem(id, item, amount);
			SaveItems(id);

			if _chestHasItem(Player[id].chest_id, item) == false then

				local ldir = Player[id].chest_id..".txt";
				local file = io.open(DIRITEMS..ldir,"a");
				file:write(item.." "..amount.."\n");
				file:close();

			else

				local slot_id_chest = 0;

				for i, v in pairs(Player[id].chest_items[1]) do
					if v == item then
						slot_id_chest = i;
					end
				end

				local ldir = Player[id].chest_id..".txt";

				local oldValue = Player[id].chest_items[2][slot_id_chest];
				local newValue = oldValue + amount;

				local file = io.open(DIRITEMS..ldir,"r+");
				local tempString = file:read("*a");
				file:close();
				local tempString = string.gsub(tempString, string.upper(item).." "..oldValue,string.upper(item).." "..newValue);
				local file = io.open(DIRITEMS..ldir,"w+");
				file:write(tempString);
				file:close();

			end


		elseif Player[id].chest_p_items[2][slot_id] == 1 then

			--SendPlayerMessage(id, 255, 255, 255, "Вы положили в сундук "..GetItemName(item).." x1");

			local time = os.date('*t');
		    local ryear = time.year;
			local rmonth = time.month;
			local rday = time.day;
			local rhour = string.format("%02d", time.hour);
			local rminute = string.format("%02d", time.min);
			LogString("Logs/PlayersAll/chest", Player[id].nickname.." забрал из сундука x1".." "..GetItemName(item).." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);


			local str ="Вы положили в сундук "..GetItemName(item).." x1"
			GameTextForPlayer(id, 2710, 1055, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2500);

			RemoveItem(id, item, 1);
			SaveItems(id);

			table.remove(Player[id].chest_p_items[1], slot_id);
			table.remove(Player[id].chest_p_items[2], slot_id);

			if _chestHasItem(Player[id].chest_id, item) == false then

				local ldir = Player[id].chest_id..".txt";
				local file = io.open(DIRITEMS..ldir,"a");
				file:write(item.." "..amount.."\n");
				file:close();

			else

				local slot_id_chest = 0;

				for i, v in pairs(Player[id].chest_items[1]) do
					if v == item then
						slot_id_chest = i;
					end
				end

				local ldir = Player[id].chest_id..".txt";

				local oldValue = Player[id].chest_items[2][slot_id_chest];
				local newValue = oldValue + 1;

				local file = io.open(DIRITEMS..ldir,"r+");
				local tempString = file:read("*a");
				file:close();
				local tempString = string.gsub(tempString, string.upper(item).." "..oldValue,string.upper(item).." "..newValue);
				local file = io.open(DIRITEMS..ldir,"w+");
				file:write(tempString);
				file:close();

			end

		end

		_destroyAfterDeal(id);
	else
		GameTextForPlayer(id, 2710, 1055, "Сундук переполнен.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2000);
		--SendPlayerMessage(id, 255, 255, 255, "В сундуке нет места.")
	end


end

-- забрать из сундука
function _putInPlayer(id, item, amount)

	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	LogString("Logs/PlayersAll/chest", Player[id].nickname.." забрал из сундука x"..amount.." "..GetItemName(item).." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);

	--SendPlayerMessage(id, 255, 255, 255, "Вы забрали из сундука "..GetItemName(item).." x"..amount);

	local str = "Вы забрали из сундука "..GetItemName(item).." x"..amount;
	GameTextForPlayer(id, 2710, 1055, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2000);
	GiveItem(id, item, amount);
	SaveItems(id);

	local key = {};
	for i, v in pairs(Player[id].chest_items[1]) do
		if v == item then
			key[1] = i;
			key[2] = v;
			break
		end
	end

	local slot_id = key[1];
	local slot_item = key[2];

	if Player[id].chest_items[2][slot_id] > 1 then
		
		local ldir = Player[id].chest_id..".txt";

		local oldValue = Player[id].chest_items[2][slot_id];
		local newValue = oldValue - amount;

		if newValue > 0 then

			local file = io.open(DIRITEMS..ldir,"r+");
			local tempString = file:read("*a");
			file:close();
			local tempString = string.gsub(tempString, string.upper(key[2]).." "..oldValue,string.upper(key[2]).." "..newValue);
			local file = io.open(DIRITEMS..ldir,"w+");
			file:write(tempString);
			file:close();

		else

			table.remove(Player[id].chest_items[1], slot_id);
			table.remove(Player[id].chest_items[2], slot_id);

			local count = 0;
			for i, _ in pairs(Player[id].chest_items[1]) do
				count = count + 1;
			end

			local ldir = Player[id].chest_id..".txt";
			local file = io.open(DIRITEMS..ldir,"w+");

			for i = 1, count do
				file:write(Player[id].chest_items[1][i].." "..Player[id].chest_items[2][i].."\n");
			end

			file:close();
		end

	elseif Player[id].chest_items[2][slot_id] == 1 then
		
		table.remove(Player[id].chest_items[1], slot_id);
		table.remove(Player[id].chest_items[2], slot_id);

		local count = 0;
		for i, _ in pairs(Player[id].chest_items[1]) do
			count = count + 1;
		end

		local ldir = Player[id].chest_id..".txt";
		local file = io.open(DIRITEMS..ldir,"w+");

		for i = 1, count do
			file:write(Player[id].chest_items[1][i].." "..Player[id].chest_items[2][i].."\n");
		end

		file:close();

	end

	_destroyAfterDeal(id);

end

function _preaccept(id)
	
	if Player[id].chest_select == 1 then

		if Player[id].chest_return[2] == 0 then

			local key = Player[id].chest_pos[1];

			if _checkEmpty(id, key) == false then
				SetPlayerDrawColor(id, Player[id].chestdraw[1][key], 149, 247, 69);
				SetPlayerDrawColor(id, Player[id].chestdraw[2][key], 149, 247, 69);
				Player[id].chest_return[2] = key;
				Player[id].chest_return[1] = 1;
			end

		elseif Player[id].chest_return[2] ~= Player[id].chest_pos[1] then

			local key = Player[id].chest_return[2];
			SetPlayerDrawColor(id, Player[id].chestdraw[1][key], 255, 255, 255);
			SetPlayerDrawColor(id, Player[id].chestdraw[2][key], 255, 255, 255);

			local key = Player[id].chest_pos[1];
			SetPlayerDrawColor(id, Player[id].chestdraw[1][key], 149, 247, 69);
			SetPlayerDrawColor(id, Player[id].chestdraw[2][key], 149, 247, 69);
			Player[id].chest_return[2] = key;
			Player[id].chest_return[1] = 1;

		elseif Player[id].chest_return[2] == Player[id].chest_pos[1] then
			_selectAmount(id)
		end

	elseif Player[id].chest_select == 2 then

		if Player[id].chest_return[2] == 0 then

			local key = Player[id].chest_p_pos[1];
			SetPlayerDrawColor(id, Player[id].chest_p_draw[1][key], 149, 247, 69);
			SetPlayerDrawColor(id, Player[id].chest_p_draw[2][key], 149, 247, 69);
			Player[id].chest_return[2] = key;
			Player[id].chest_return[1] = 1;

		elseif Player[id].chest_return[2] ~= Player[id].chest_p_pos[1] then

			local key = Player[id].chest_return[2];
			SetPlayerDrawColor(id, Player[id].chest_p_draw[1][key], 255, 255, 255);
			SetPlayerDrawColor(id, Player[id].chest_p_draw[2][key], 255, 255, 255);

			local key = Player[id].chest_p_pos[1];
			SetPlayerDrawColor(id, Player[id].chest_p_draw[1][key], 149, 247, 69);
			SetPlayerDrawColor(id, Player[id].chest_p_draw[2][key], 149, 247, 69);
			Player[id].chest_return[2] = key;
			Player[id].chest_return[1] = 1;

			

		elseif Player[id].chest_return[2] == Player[id].chest_p_pos[1] then
			_selectAmount(id)
		end

	end

end


function _updateChestPos(id)

	if Player[id].chest_pos[1] ~= 0 and Player[id].chest_pos[2] ~= 0 then

		if Player[id].chest_pos[1] == 1 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 2800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 2 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 3050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 3 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 3300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 4 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 3550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 5 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 3800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 6 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 4050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 7 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 4300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 8 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 4550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 9 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 4800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 10 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 5050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 11 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 5300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 12 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 5550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 13 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 5800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 14 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 6050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 15 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 6300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 16 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 6550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 0 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 0, 0, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end
	end

end

function _updateItemsPos(id)

	-- 4910, 2800 + 250 Y UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 2800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
 
	if Player[id].chest_p_pos[1] ~= 0 and Player[id].chest_p_pos[2] ~= 0 then

		if Player[id].chest_p_pos[1] == 1 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 2800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 2 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 3050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 3 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 3300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 4 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 3550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 5 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 3800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 6 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 4050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 7 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 4300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 8 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 4550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 9 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 4800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 10 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 5050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 11 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 5300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 12 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 5550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 13 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 5800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 14 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 6050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 15 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 6300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 16 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 6550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 0 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 0, 0, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end
	end

end
