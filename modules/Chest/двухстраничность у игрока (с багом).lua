
local chest_window_left = CreateTexture(200, 1673, 3276, 7255, 'chest_gui_v3_chest')
local chest_window_right = CreateTexture(4776, 1673, 7846, 7255, 'chest_gui_v3_player')

local slots_down_chest = CreateTexture(2415, 6750, 2535, 6925, 'U')
local slots_down_player = CreateTexture(7015, 6750, 7135, 6925, 'U')

-- U - вниз
-- O - вверх

CHEST = {};
DIR = "Database/Chests/";
DIRITEMS = "Database/Chests/Items/";
DIRINFO = "Database/Chests/Info/";

function _initChest()

	WORLD = "ODEON_KHORINIS.ZEN";
	_chestArr = {};

	_chestArr[1] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", " ", WORLD, 27492.048828125, 2598.0927734375, 9765.837890625, "chest_1");
	Mob.SetRotation(_chestArr[1], 0, -80, 0)

	_chestArr[2] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", " ", WORLD, 27692.048828125, 2598.0927734375, 9765.837890625, "chest_2");
	Mob.SetRotation(_chestArr[2], 0, -80, 0)

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
			count = count + 1;
			local result, item, amount = sscanf(line,"sd");
			if result == 1 then
				Player[id].chest_items[1][#Player[id].chest_items[1] + 1] = item;
				Player[id].chest_items[2][#Player[id].chest_items[2] + 1] = amount;
			end
		end


		Player[id].chest_select = 1;
		Freeze(id);
		_updatePlayerDraws(id);


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

function _updatePlayerDraws(id)

	for i = 1, 2 do
		Player[id].chest_p_items[i] = {};
	end

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
	if file then

		local count = 0;
		for line in file:lines() do
			count = count + 1;
			local result, item, amount = sscanf(line,"sd");
			if result == 1 then
				Player[id].chest_p_items[1][#Player[id].chest_p_items[1] + 1] = item;
				Player[id].chest_p_items[2][#Player[id].chest_p_items[2] + 1] = amount;
			end
		end

		if count < 17 then
			Player[id].chest_p_pos_list = 1;
			Player[id].chest_p_pos = {1, count};
		else
			Player[id].chest_p_pos_list = 2;
			Player[id].chest_p_pos = {1, 16};
		end

		Player[id].chest_p_pos_draw = CreatePlayerDraw(id, 4950, 2800, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		ShowPlayerDraw(id, Player[id].chest_p_pos_draw);


		for i = 1, 2 do
			Player[id].chest_p_draw[i] = {};
		end

		if count < 17 then

			for i = 1, count do
				Player[id].chest_p_draw[1][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
				Player[id].chest_p_draw[2][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
				ShowPlayerDraw(id, Player[id].chest_p_draw[1][i]);
				ShowPlayerDraw(id, Player[id].chest_p_draw[2][i]);
			end

			local pos = 2800;
			for i, v in pairs(Player[id].chest_p_items[1]) do
				local str = string.format("%s", GetItemName(v));
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][i], 5000, pos, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250;
			end

			local pos = 2800;
			for i, v in pairs(Player[id].chest_p_items[2]) do
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][i], 7270, pos, v, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250;
			end

			Player[id].chest_player_list = {1, 1};

		elseif count > 16 then

			Player[id].chest_player_list = {1, 2};
			Player[id].player_value = 0;
			_playerList1(id);
			ShowTexture(id, slots_down_player);
		end

	end
end

function _playerList1(id)

	if Player[id].player_value == 0 then

		for i = 1, 16 do
			Player[id].chest_p_draw[1][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			Player[id].chest_p_draw[2][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			ShowPlayerDraw(id, Player[id].chest_p_draw[1][i]);
			ShowPlayerDraw(id, Player[id].chest_p_draw[2][i]);
			Player[id].player_value = Player[id].player_value + 1;
		end

	else

		for i = 1, Player[id].player_value do
			HidePlayerDraw(id, Player[id].chest_p_draw[1][i]);
			HidePlayerDraw(id, Player[id].chest_p_draw[2][i]);
			DestroyPlayerDraw(id, Player[id].chest_p_draw[1][i]);
			DestroyPlayerDraw(id, Player[id].chest_p_draw[2][i]);
		end

		Player[id].player_value = 0;

		for i = 1, 16 do
			Player[id].chest_p_draw[1][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			Player[id].chest_p_draw[2][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			ShowPlayerDraw(id, Player[id].chest_p_draw[1][i]);
			ShowPlayerDraw(id, Player[id].chest_p_draw[2][i]);
			Player[id].player_value = Player[id].player_value + 1;
		end

	end

	local limit = 0;
	for i, _ in pairs(Player[id].chest_p_items[1]) do
		limit = limit + 1;
	end

	if limit > 17 then
		limit = 16;
	end


	local pos = 2800;
	for i = 1, limit do
		local str = string.format("%s", GetItemName(Player[id].chest_p_items[1][i]));
		UpdatePlayerDraw(id, Player[id].chest_p_draw[1][i], 5000, pos, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		pos = pos + 250;
	end

	local pos = 2800;
	for i = 1, limit do
		local str = string.format("%d", Player[id].chest_p_items[2][i]);
		UpdatePlayerDraw(id, Player[id].chest_p_draw[2][i], 7270, pos, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		pos = pos + 250;
	end

end

function _playerList2(id)

	if Player[id].player_value ~= 0 then

		for i = 1, Player[id].player_value do
			HidePlayerDraw(id, Player[id].chest_p_draw[1][i]);
			HidePlayerDraw(id, Player[id].chest_p_draw[2][i]);
			DestroyPlayerDraw(id, Player[id].chest_p_draw[1][i]);
			DestroyPlayerDraw(id, Player[id].chest_p_draw[2][i]);
		end

		Player[id].player_value = 0;

		local limit = 0;
		for i, _ in pairs(Player[id].chest_p_items[1]) do
			limit = limit + 1;
		end

		local _from = 16;
		local _do = 0;
		
		if limit > 16 then
			_do = limit;
		end

		for i = _from, _do do
			Player[id].chest_p_draw[1][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			Player[id].chest_p_draw[2][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			ShowPlayerDraw(id, Player[id].chest_p_draw[1][i]);
			ShowPlayerDraw(id, Player[id].chest_p_draw[2][i]);
			Player[id].player_value = Player[id].player_value + 1;
		end

	else

		local limit = 0;
		for i, _ in pairs(Player[id].chest_p_items[1]) do
			limit = limit + 1;
		end

		local _from = 16;
		local _do = 0;
		
		if limit > 16 then
			_do = limit;
		end

		for i = _from, _do do
			Player[id].chest_p_draw[1][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			Player[id].chest_p_draw[2][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			ShowPlayerDraw(id, Player[id].chest_p_draw[1][i]);
			ShowPlayerDraw(id, Player[id].chest_p_draw[2][i]);
			Player[id].player_value = Player[id].player_value + 1;
		end

	end



	local limit = 0;
	for i, _ in pairs(Player[id].chest_p_items[1]) do
		limit = limit + 1;
	end

	local _from = 16;
	local _do = 0;
	
	if limit > 16 then
		_do = limit;
	end

	local pos = 2800;
	for i = _from, _do do
		local str = string.format("%s", GetItemName(Player[id].chest_p_items[1][i]));
		UpdatePlayerDraw(id, Player[id].chest_p_draw[1][i], 5000, pos, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		pos = pos + 250;
	end

	local pos = 2800;
	for i = _from, _do do
		local str = string.format("%d", Player[id].chest_p_items[2][i]);
		UpdatePlayerDraw(id, Player[id].chest_p_draw[2][i], 7270, pos, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		pos = pos + 250;
	end

end

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

	for i = 1, count do
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

	Player[id].chest_items = {}
	Player[id].chest_p_items = {};

	if Player[id].chest_pos[1] > 0 and Player[id].chest_pos[2] > 0 then
		HidePlayerDraw(id, Player[id].chest_pos_draw);
	end
	if Player[id].chest_p_pos[1] > 0 and Player[id].chest_p_pos[2] > 0 then
		HidePlayerDraw(id, Player[id].chest_p_pos_draw);
	end

	Player[id].chest_pos = {0, 0};
	Player[id].chest_p_pos = {0, 0};

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

	for i = 1, count do
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

	if Player[id].chest_pos[1] > 0 and Player[id].chest_pos[2] > 0 then
		HidePlayerDraw(id, Player[id].chest_pos_draw);
	end
	if Player[id].chest_p_pos[1] > 0 and Player[id].chest_p_pos[2] > 0 then
		HidePlayerDraw(id, Player[id].chest_p_pos_draw);
	end

	Player[id].chest_pos = {0, 0};
	Player[id].chest_p_pos = {0, 0};
	Player[id].chest_return = {0, 0};

	_chestDraw(id);

end


function _chestKey(id, down, up)

	if Player[id].chest_id ~= 0 and Player[id].loggedIn == true then

		---------------------------------------------------
		if down == KEY_DOWN then

			if Player[id].chest_select == 1 then -- переключение в сундуке

				Player[id].chest_pos[1] = Player[id].chest_pos[1] + 1;
				if Player[id].chest_pos[1] > Player[id].chest_pos[2] then
					Player[id].chest_pos[1] = 1;
				end
				_updateChestPos(id);

			------------------------------------------------------
			elseif Player[id].chest_select == 2 then -- переключение в инвентаре персонажа

				Player[id].chest_p_pos[1] = Player[id].chest_p_pos[1] + 1;
				if Player[id].chest_p_pos[1] > Player[id].chest_p_pos[2] then
					if Player[id].chest_p_pos_list == 1 then
						Player[id].chest_p_pos[1] = 1;
					else
						Player[id].chest_p_pos[1] = 1;
						_playerList2(id);
					end
				end
				_updateItemsPos(id);
			end

		end
		---------------------------------------------------
		if down == KEY_UP then

			if Player[id].chest_select == 1 then -- переключение в сундуке

				Player[id].chest_pos[1] = Player[id].chest_pos[1] - 1;
				if Player[id].chest_pos[1] <= 0 then
					Player[id].chest_pos[1] = Player[id].chest_pos[2];
				end

				_updateChestPos(id);

			---------------------------------------------------------
			elseif Player[id].chest_select == 2 then -- переключение в инвентаре персонажа

				Player[id].chest_p_pos[1] = Player[id].chest_p_pos[1] - 1;
				if Player[id].chest_p_pos[1] <= 0 then
					if Player[id].chest_p_pos_list == 1 then
						Player[id].chest_p_pos[1] = Player[id].chest_p_pos[2];
					else
						Player[id].chest_p_pos[1] = 16;
						_playerList1(id);
					end
				end
				_updateItemsPos(id);
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

		if down == KEY_ESCAPE then
			_destroyChestDraw(id);
		end

		---------------------------------------------------

		if down == KEY_RETURN then
			_preaccept(id);
		end
	end

end

function _resetcolorall(id)

	--[[
	local count = 0;
	for i, _ in pairs(Player[id].chest_items[1]) do
		count = count + 1;
	end

	for i = 1, count do
		SetPlayerDrawColor(id, Player[id].chestdraw[1][i], 255, 255, 255);
		SetPlayerDrawColor(id, Player[id].chestdraw[2][i], 255, 255, 255);
	end

	------------------------------------------------------------------
	local limit = 0;
	for i, _ in pairs(Player[id].chest_p_items[1]) do
		limit = limit + 1;
	end

	local _from = 16;
	local _do = 0;
	
	if limit > 16 then
		_do = limit;
	end

	if count < 17 then

		for i = 1, limit do
			SetPlayerDrawColor(id, Player[id].chest_p_draw[1][i], 255, 255, 255);
			SetPlayerDrawColor(id, Player[id].chest_p_draw[2][i], 255, 255, 255);
		end

	else

		for i = _from, _do do
			SetPlayerDrawColor(id, Player[id].chest_p_draw[1][i], 255, 255, 255);
			SetPlayerDrawColor(id, Player[id].chest_p_draw[2][i], 255, 255, 255);
		end

	end

	]]

end

function _checkEmpty(id, cid)

	for i, v in pairs(Player[id].chest_items[1]) do
		if i == cid then
			return false;
		end
	end
	return true;

end

function _checkChestSlots()

	local count = 0;
	for i, v in pairs(Player[id].chest_items[1]) do
		count = count + 1;
	end

	if count < 16 then
		return true;
	else
		return false;
	end

end

function _putInPlayer(id, item, amount)

	SendPlayerMessage(id, 255, 255, 255, "Вы забрали из сундука "..GetItemName(item));
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
		local newValue = oldValue - 1;

		local file = io.open(DIRITEMS..ldir,"r+");
		local tempString = file:read("*a");
		file:close();
		local tempString = string.gsub(tempString, string.upper(key[2]).." "..oldValue,string.upper(key[2]).." "..newValue);
		local file = io.open(DIRITEMS..ldir,"w+");
		file:write(tempString);
		file:close();

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

			local key = Player[id].chest_pos[1];
			local item = Player[id].chest_items[1][key];
			_putInPlayer(id, item, 1);

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

			-- drop to chest.

		end

	end

end


function _useChest(id, sc, chest_id, used)
	
	if sc == "CHESTBIG" then
		if used == 1 then

			if chest_id == "CHEST_1" then
				Player[id].chest_id = 1;
				_chestDraw(id, 1);

			elseif chest_id == "CHEST_2" then

				Player[id].chest_id = 2;
				_chestDraw(id, 1);

			end

		else

			if Player[id].chest_id ~= 0 then
				_destroyChestDraw(id);
			end

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
