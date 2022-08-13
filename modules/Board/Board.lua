

--  # Board system by royclapton #
--  #       version: 1.2         #

DIRBOARDINFO = "Database/Board/BOARD_INFO"
DIRBOARD = "Database/Board/"

DIRBOARD2 = "Database/Board2/"
DIRBOARDINFO2 = "Database/Board2/BOARD_INFO"

DIRBOARD3 = "Database/Board3/"
DIRBOARDINFO3 = "Database/Board3/BOARD_INFO"

DIRBOARD4 = "Database/Board4/"
DIRBOARDINFO4 = "Database/Board4/BOARD_INFO"

DIRBOARD5 = "Database/Board5/"
DIRBOARDINFO5 = "Database/Board5/BOARD_INFO"

VALUE_BOARD_LISTS_COUNT = 0;
VALUE_BOARD_LISTS = {}

VALUE_BOARD_LISTS_COUNT2 = 0;
VALUE_BOARD_LISTS2 = {}

VALUE_BOARD_LISTS_COUNT3 = 0;
VALUE_BOARD_LISTS3 = {}

VALUE_BOARD_LISTS_COUNT4 = 0;
VALUE_BOARD_LISTS4 = {}

VALUE_BOARD_LISTS_COUNT5 = 0;
VALUE_BOARD_LISTS5 = {}

BOARD_STRING = {};
BOARD_X = 2450;
BOARD_Y = 1320;
BOARD_LIMIT_LENS = 30;

function _initBoard()

	print("");
	print(" ####################");
	print(" #   Board system   #");
	print(" #                  #");
	print(" #     Board #1     #");

	local file = io.open(DIRBOARDINFO, "r");
	if file then
		for line in file:lines() do
			local result, value = sscanf(line, "d");
			if result == 1 then
				if value == 1 then
					VALUE_BOARD_LISTS_COUNT = VALUE_BOARD_LISTS_COUNT + 1;
					table.insert(VALUE_BOARD_LISTS, "1");
				else
					table.insert(VALUE_BOARD_LISTS, "0");
				end
			end
		end
	end
	print(" #     "..VALUE_BOARD_LISTS_COUNT.." loaded     #");
	print(" #                  #");
	print(" #     Board #2     #");

	local file = io.open(DIRBOARDINFO2, "r");
	if file then
		for line in file:lines() do
			local result, value = sscanf(line, "d");
			if result == 1 then
				if value == 1 then
					VALUE_BOARD_LISTS_COUNT2 = VALUE_BOARD_LISTS_COUNT2 + 1;
					table.insert(VALUE_BOARD_LISTS2, "1");
				else
					table.insert(VALUE_BOARD_LISTS2, "0");
				end
			end
		end
	end
	print(" #     "..VALUE_BOARD_LISTS_COUNT2.." loaded     #");
	print(" #                  #");
	print(" #     Board #3     #");

	local file = io.open(DIRBOARDINFO3, "r");
	if file then
		for line in file:lines() do
			local result, value = sscanf(line, "d");
			if result == 1 then
				if value == 1 then
					VALUE_BOARD_LISTS_COUNT3 = VALUE_BOARD_LISTS_COUNT3 + 1;
					table.insert(VALUE_BOARD_LISTS3, "1");
				else
					table.insert(VALUE_BOARD_LISTS3, "0");
				end
			end
		end
	end
	print(" #     "..VALUE_BOARD_LISTS_COUNT3.." loaded     #");
	print(" #                  #");
	print(" #     Board #4     #");

	local file = io.open(DIRBOARDINFO4, "r");
	if file then
		for line in file:lines() do
			local result, value = sscanf(line, "d");
			if result == 1 then
				if value == 1 then
					VALUE_BOARD_LISTS_COUNT4 = VALUE_BOARD_LISTS_COUNT4 + 1;
					table.insert(VALUE_BOARD_LISTS4, "1");
				else
					table.insert(VALUE_BOARD_LISTS4, "0");
				end
			end
		end
	end
	print(" #     "..VALUE_BOARD_LISTS_COUNT4.." loaded     #");
	print(" #                  #");
	print(" #     Board #5     #");

	local file = io.open(DIRBOARDINFO5, "r");
	if file then
		for line in file:lines() do
			local result, value = sscanf(line, "d");
			if result == 1 then
				if value == 1 then
					VALUE_BOARD_LISTS_COUNT5 = VALUE_BOARD_LISTS_COUNT5 + 1;
					table.insert(VALUE_BOARD_LISTS5, "1");
				else
					table.insert(VALUE_BOARD_LISTS5, "0");
				end
			end
		end
	end
	print(" #     "..VALUE_BOARD_LISTS_COUNT5.." loaded     #");
	print(" #                  #");
	print(" ####################");


	for i = 1, 19 do
		BOARD_STRING[i] = {BOARD_X, BOARD_Y};
		BOARD_Y = BOARD_Y + 300;
	end


end

b_buttons_1 = {2516, 3168, 2212, 3536};
b_buttons_2 = {2660, 3328, 3732, 5056};
b_buttons_3 = {3636, 4296, 2196, 3520};
b_buttons_4 = {3841, 4501, 3732, 5056};
b_buttons_5 = {4805, 5465, 2202, 3532};
b_buttons_6 = {4789, 5470, 3742, 5078};

local letters = {};
letters[1] = CreateTexture(2516, 2212, 3168, 3536, 'letters');
letters[2] = CreateTexture(2660, 3732, 3328, 5056, 'letters');
letters[3] = CreateTexture(3636, 2196, 4296, 3520, 'letters');
letters[4] = CreateTexture(3841, 3732, 4501, 5056, 'letters');
letters[5] = CreateTexture(4805, 2202, 5465, 3532, 'letters');
letters[6] = CreateTexture(4789, 3742, 5470, 5078, 'letters');

local board_1 = CreateTexture(2290, 1830, 5710, 5300, 'NW_CITY_INSIDEFLOOR_11');
local board_2 = CreateTexture(2260, 1770, 5770, 5370, 'menu_ingame');
local emptyletter = CreateTexture(2185, 650, 5985, 7510, 'letters');

local s_openList = CreateSound("BOOK_TURNPAGE1.WAV");
local s_write = CreateSound("LOGENTRY.WAV");

function _board(id, sc, on, used)

	if sc == "BOOKSHELF" then
		if used == 1 then
			_oBoard(id)
			SendPlayerMessage(id, 255, 255, 255, " ");
			SendPlayerMessage(id, 255, 255, 255, "Чтобы написать новое объявление: /д_новое"); 
			SendPlayerMessage(id, 255, 255, 255, "Сорвать объявление: /д_сорвать");
			SendPlayerMessage(id, 255, 255, 255, "Закрыть открытое объявление - (F)");
			SendPlayerMessage(id, 255, 255, 255, "Закрыть доску - (ESC)");
		end
	end

end

function _oBoard(id)
	Player[id].board_open = true;
	Freeze(id);
	ShowTexture(id, board_1);
	ShowTexture(id, board_2);

	local board = {12996.5, 1048.62, -1843.31};
	local board2 = {5946.21, 519.862, 2319.84};
	local board3 = {-473.343, -28.2733, -2020.86};
	local board4 = {6976.5, 449.047, -5054.08};
	local board5 = {12644.4, 1104.9, 2711.97};
	local x, y, z = GetPlayerPos(id);

	if GetDistance3D(x, y, z, board[1], board[2], board[3]) < 400 then

		for i, v in pairs(VALUE_BOARD_LISTS) do
			if v == "1" then
				ShowTexture(id, letters[i]);
				table.insert(Player[id].board_textures, "1");
			else
				table.insert(Player[id].board_textures, "0");
			end
		end
		Player[id].board_id = 1;

	elseif GetDistance3D(x, y, z, board2[1], board2[2], board2[3]) < 400 then

		for i, v in pairs(VALUE_BOARD_LISTS2) do
			if v == "1" then
				ShowTexture(id, letters[i]);
				table.insert(Player[id].board_textures, "1");
			else
				table.insert(Player[id].board_textures, "0");
			end
		end

		Player[id].board_id = 2;

	elseif GetDistance3D(x, y, z, board3[1], board3[2], board3[3]) < 400 then

		for i, v in pairs(VALUE_BOARD_LISTS3) do
			if v == "1" then
				ShowTexture(id, letters[i]);
				table.insert(Player[id].board_textures, "1");
			else
				table.insert(Player[id].board_textures, "0");
			end
		end

		Player[id].board_id = 3;

	elseif GetDistance3D(x, y, z, board4[1], board4[2], board4[3]) < 400 then

		for i, v in pairs(VALUE_BOARD_LISTS4) do
			if v == "1" then
				ShowTexture(id, letters[i]);
				table.insert(Player[id].board_textures, "1");
			else
				table.insert(Player[id].board_textures, "0");
			end
		end

		Player[id].board_id = 4;

	elseif GetDistance3D(x, y, z, board5[1], board5[2], board5[3]) < 400 then

		for i, v in pairs(VALUE_BOARD_LISTS5) do
			if v == "1" then
				ShowTexture(id, letters[i]);
				table.insert(Player[id].board_textures, "1");
			else
				table.insert(Player[id].board_textures, "0");
			end
		end

		Player[id].board_id = 5;

	end
	ShowPlayerDraw(id, Player[id].board_namedraw[2]);
	Player[id].board_namedraw[1] = true;
	SetCursorVisible(id, 1);
	FreezeCamera(id, 1);
end

function _unBoard(id)

	UnFreeze(id);
	HideTexture(id, board_1);
	HideTexture(id, board_2);

	local board = {12996.5, 1048.62, -1843.31};
	local board2 = {5946.21, 519.862, 2319.84};
	local board3 = {-473.343, -28.2733, -2020.86};
	local board4 = {6976.5, 449.047, -5054.08};
	local board5 = {12644.4, 1104.9, 2711.97};
	local x, y, z = GetPlayerPos(id);

	for i, v in pairs(Player[id].board_textures) do
		if v == "1" then
			HideTexture(id, letters[i]);
		end
	end

	if Player[id].board_open_list == true then
		_hideOpenList(id)
	end

	if Player[id].board_tips[4] == true then
		HidePlayerDraw(id, Player[id].board_tips[1]);
		HidePlayerDraw(id, Player[id].board_tips[2]);
		HidePlayerDraw(id, Player[id].board_tips[3]);
		Player[id].board_tips[4] = false;
	end

	if Player[id].board_namedraw[1] == true then
		HidePlayerDraw(id, Player[id].board_namedraw[2]);
		Player[id].board_namedraw[1] = false;
	end

	SetCursorVisible(id, 0);
	FreezeCamera(id, 0);

	if Player[id].board_write == true then
		for i = 1, 19 do
			HidePlayerDraw(id, Player[id].board_draws[i]);
			DestroyPlayerDraw(id, Player[id].board_draws[i]);
		end
		HideTexture(id, emptyletter);
	end

	ShowChat(id, 1);

	_boardPlayer(id);

end

function _boardPlayer(id)

	Player[id].board_id = 0;
	Player[id].board_open = false;
	Player[id].board_write = false;
	Player[id].board_open_list = false;
	Player[id].board_currentLine = 0;
	Player[id].board_currentText = {};
	Player[id].board_tempArr = {0, 0};
	Player[id].board_draws = {};
	Player[id].board_destroy = false;
	Player[id].board_namedraw = {}
	Player[id].board_namedraw[1] = false;
 	Player[id].board_namedraw[2] = CreatePlayerDraw(id, 2330, 1620, "Доска объявлений", "Font_Old_20_White_Hi.TGA", 179, 176, 34);
 	Player[id].board_textures = {};
 	Player[id].board_tips = {};
 	Player[id].board_tips[1] = CreatePlayerDraw(id, 2360, 6730, "L.CTRL - пропустить строчку.", "Font_Old_10_White_Hi.TGA", 26, 25, 25);
 	Player[id].board_tips[2] = CreatePlayerDraw(id, 2360, 6930, "ESC - прерваться.", "Font_Old_10_White_Hi.TGA", 26, 25, 25);
 	Player[id].board_tips[3] = CreatePlayerDraw(id, 2360, 7130, "/д_готово - завершить.", "Font_Old_10_White_Hi.TGA", 26, 25, 25);
 	Player[id].board_tips[4] = false;

end

function _boardMouse(id, button, pressed, posX, posY)

	if button == MB_LEFT then
		if pressed == 0 then
			if Player[id].board_open == true and Player[id].board_write == false then
				if Player[id].board_open_list == false then
					if posX > b_buttons_1[1] and posX < b_buttons_1[2] and posY > b_buttons_1[3] and posY < b_buttons_1[4] then
						if Player[id].board_destroy == false then
							Player[id].board_open_list = true;
							_openList(id, 1);
						else
							_destroyList(id, 1)
						end
					end

					if posX > b_buttons_2[1] and posX < b_buttons_2[2] and posY > b_buttons_2[3] and posY < b_buttons_2[4] then
						if Player[id].board_destroy == false then
							Player[id].board_open_list = true;
							_openList(id, 2);
						else
							_destroyList(id, 2)
						end
					end

					if posX > b_buttons_3[1] and posX < b_buttons_3[2] and posY > b_buttons_3[3] and posY < b_buttons_3[4] then
						if Player[id].board_destroy == false then
							Player[id].board_open_list = true;
							_openList(id, 3);
						else
							_destroyList(id, 3)
						end
					end

					if posX > b_buttons_4[1] and posX < b_buttons_4[2] and posY > b_buttons_4[3] and posY < b_buttons_4[4] then
						if Player[id].board_destroy == false then
							Player[id].board_open_list = true;
							_openList(id, 4);
						else
							_destroyList(id, 4)
						end
					end

					if posX > b_buttons_5[1] and posX < b_buttons_5[2] and posY > b_buttons_5[3] and posY < b_buttons_5[4] then
						if Player[id].board_destroy == false then
							Player[id].board_open_list = true;
							_openList(id, 5);
						else
							_destroyList(id, 5)
						end
					end

					if posX > b_buttons_6[1] and posX < b_buttons_6[2] and posY > b_buttons_6[3] and posY < b_buttons_6[4] then
						if Player[id].board_destroy == false then
							Player[id].board_open_list = true;
							_openList(id, 6);
						else
							_destroyList(id, 6)
						end
					end
				end

			end
		end
	end

end

function _openList(id, list)


	if Player[id].board_id == 1 then
		local file = io.open(DIRBOARD.."BOARD_"..list, "r");
		local count = 0;
		for line in file:lines() do
			count = count + 1;
		end
		file:close();

		if count > 1 then

			PlayPlayerSound(id, s_openList);

			if Player[id].board_namedraw[1] == true then
				HidePlayerDraw(id, Player[id].board_namedraw[2]);
				Player[id].board_namedraw[1] = false;
			end

			ShowTexture(id, emptyletter);
			for i = 1, count do
				Player[id].board_draws[i] = CreatePlayerDraw(id, BOARD_STRING[i][1], BOARD_STRING[i][2], "", "Font_Old_20_White_Hi.TGA", 38, 37, 37);
				ShowPlayerDraw(id, Player[id].board_draws[i]);
				Player[id].board_tempArr[1] = Player[id].board_tempArr[1] + 1;
			end

			local file = io.open(DIRBOARD.."BOARD_"..list, "r");
			for i = 1, count do
				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					UpdatePlayerDraw(id, Player[id].board_draws[i], BOARD_STRING[i][1], BOARD_STRING[i][2], text, "Font_Old_20_White_Hi.TGA", 38, 37, 37);
				end
			end
			file:close()

		end

	elseif Player[id].board_id == 2 then

		local file = io.open(DIRBOARD2.."BOARD_"..list, "r");
		local count = 0;
		for line in file:lines() do
			count = count + 1;
		end
		file:close();

		if count > 1 then

			PlayPlayerSound(id, s_openList);

			if Player[id].board_namedraw[1] == true then
				HidePlayerDraw(id, Player[id].board_namedraw[2]);
				Player[id].board_namedraw[1] = false;
			end

			ShowTexture(id, emptyletter);
			for i = 1, count do
				Player[id].board_draws[i] = CreatePlayerDraw(id, BOARD_STRING[i][1], BOARD_STRING[i][2], "", "Font_Old_20_White_Hi.TGA", 38, 37, 37);
				ShowPlayerDraw(id, Player[id].board_draws[i]);
				Player[id].board_tempArr[1] = Player[id].board_tempArr[1] + 1;
			end

			local file = io.open(DIRBOARD2.."BOARD_"..list, "r");
			for i = 1, count do
				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					UpdatePlayerDraw(id, Player[id].board_draws[i], BOARD_STRING[i][1], BOARD_STRING[i][2], text, "Font_Old_20_White_Hi.TGA", 38, 37, 37);
				end
			end
			file:close()

		end

	elseif Player[id].board_id == 3 then

		local file = io.open(DIRBOARD3.."BOARD_"..list, "r");
		local count = 0;
		for line in file:lines() do
			count = count + 1;
		end
		file:close();

		if count > 1 then

			PlayPlayerSound(id, s_openList);

			if Player[id].board_namedraw[1] == true then
				HidePlayerDraw(id, Player[id].board_namedraw[2]);
				Player[id].board_namedraw[1] = false;
			end

			ShowTexture(id, emptyletter);
			for i = 1, count do
				Player[id].board_draws[i] = CreatePlayerDraw(id, BOARD_STRING[i][1], BOARD_STRING[i][2], "", "Font_Old_20_White_Hi.TGA", 38, 37, 37);
				ShowPlayerDraw(id, Player[id].board_draws[i]);
				Player[id].board_tempArr[1] = Player[id].board_tempArr[1] + 1;
			end

			local file = io.open(DIRBOARD3.."BOARD_"..list, "r");
			for i = 1, count do
				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					UpdatePlayerDraw(id, Player[id].board_draws[i], BOARD_STRING[i][1], BOARD_STRING[i][2], text, "Font_Old_20_White_Hi.TGA", 38, 37, 37);
				end
			end
			file:close()

		end

	elseif Player[id].board_id == 4 then

		local file = io.open(DIRBOARD4.."BOARD_"..list, "r");
		local count = 0;
		for line in file:lines() do
			count = count + 1;
		end
		file:close();

		if count > 1 then

			PlayPlayerSound(id, s_openList);

			if Player[id].board_namedraw[1] == true then
				HidePlayerDraw(id, Player[id].board_namedraw[2]);
				Player[id].board_namedraw[1] = false;
			end

			ShowTexture(id, emptyletter);
			for i = 1, count do
				Player[id].board_draws[i] = CreatePlayerDraw(id, BOARD_STRING[i][1], BOARD_STRING[i][2], "", "Font_Old_20_White_Hi.TGA", 38, 37, 37);
				ShowPlayerDraw(id, Player[id].board_draws[i]);
				Player[id].board_tempArr[1] = Player[id].board_tempArr[1] + 1;
			end

			local file = io.open(DIRBOARD4.."BOARD_"..list, "r");
			for i = 1, count do
				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					UpdatePlayerDraw(id, Player[id].board_draws[i], BOARD_STRING[i][1], BOARD_STRING[i][2], text, "Font_Old_20_White_Hi.TGA", 38, 37, 37);
				end
			end
			file:close()

		end

	elseif Player[id].board_id == 5 then

		local file = io.open(DIRBOARD5.."BOARD_"..list, "r");
		local count = 0;
		for line in file:lines() do
			count = count + 1;
		end
		file:close();

		if count > 1 then

			PlayPlayerSound(id, s_openList);

			if Player[id].board_namedraw[1] == true then
				HidePlayerDraw(id, Player[id].board_namedraw[2]);
				Player[id].board_namedraw[1] = false;
			end

			ShowTexture(id, emptyletter);
			for i = 1, count do
				Player[id].board_draws[i] = CreatePlayerDraw(id, BOARD_STRING[i][1], BOARD_STRING[i][2], "", "Font_Old_20_White_Hi.TGA", 38, 37, 37);
				ShowPlayerDraw(id, Player[id].board_draws[i]);
				Player[id].board_tempArr[1] = Player[id].board_tempArr[1] + 1;
			end

			local file = io.open(DIRBOARD5.."BOARD_"..list, "r");
			for i = 1, count do
				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					UpdatePlayerDraw(id, Player[id].board_draws[i], BOARD_STRING[i][1], BOARD_STRING[i][2], text, "Font_Old_20_White_Hi.TGA", 38, 37, 37);
				end
			end
			file:close()

		end

	end

end

function _writeToBoard(id)

	if Player[id].board_open == true then
		Player[id].board_write = true;
		ShowChat(id, 0);
		ShowPlayerDraw(id, Player[id].board_tips[1]);
		ShowPlayerDraw(id, Player[id].board_tips[2]);
		ShowPlayerDraw(id, Player[id].board_tips[3]);
		Player[id].board_tips[4] = true;
		Player[id].board_currentLine = 1;

		if Player[id].board_namedraw[1] == true then
			HidePlayerDraw(id, Player[id].board_namedraw[2]);
			Player[id].board_namedraw[1] = false;
		end

		ShowTexture(id, emptyletter);

		for i = 1, 19 do
			Player[id].board_draws[i] = CreatePlayerDraw(id, BOARD_STRING[i][1], BOARD_STRING[i][2], "", "Font_Old_20_White_Hi.TGA", 38, 37, 37);
			ShowPlayerDraw(id, Player[id].board_draws[i]);
		end


	end

end
addCommandHandler({"/д_новое"}, _writeToBoard);

function _endWriteToBoard(id)

	if Player[id].board_id == 1 then

		if VALUE_BOARD_LISTS_COUNT < 6 then

			
			local str_size = table.getn(Player[id].board_currentText);

			if str_size > 1 then

				local pos = 0;
				for i, v in pairs(VALUE_BOARD_LISTS) do
					if v == "0" then
						pos = i;
						VALUE_BOARD_LISTS[i] = "1";
						break;
					end
				end

				local file = io.open(DIRBOARD.."BOARD_"..pos, "w+");
				for i = 1, str_size do
					file:write(Player[id].board_currentText[i].."\n");
				end
				file:close();

				VALUE_BOARD_LISTS_COUNT = VALUE_BOARD_LISTS_COUNT + 1;

				local file = io.open(DIRBOARDINFO, "w+");
				for i = 1, 6 do
					file:write(VALUE_BOARD_LISTS[i].."\n");
				end
				file:close()

				HidePlayerDraw(id, Player[id].board_tips[1]);
				HidePlayerDraw(id, Player[id].board_tips[2]);
				HidePlayerDraw(id, Player[id].board_tips[3]);
				Player[id].board_tips[4] = false;

				ShowChat(id, 1);
				SendPlayerMessage(id, 255, 255, 255, "Вы повесили объявление на доске.");
				_unBoard(id);
				_oBoard(id);

			else
				SendPlayerMessage(id, 255, 255, 255, "В объявлении должно быть больше 1 строки.");
			end
		else
			GameTextForPlayer(id, 2995, 7580, "На доске много писем", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
		end

	elseif Player[id].board_id == 2 then

		if VALUE_BOARD_LISTS_COUNT2 < 6 then

			
			local str_size = table.getn(Player[id].board_currentText);

			if str_size > 1 then

				local pos = 0;
				for i, v in pairs(VALUE_BOARD_LISTS2) do
					if v == "0" then
						pos = i;
						VALUE_BOARD_LISTS2[i] = "1";
						break;
					end
				end

				local file = io.open(DIRBOARD2.."BOARD_"..pos, "w+");
				for i = 1, str_size do
					file:write(Player[id].board_currentText[i].."\n");
				end
				file:close();

				VALUE_BOARD_LISTS_COUNT2 = VALUE_BOARD_LISTS_COUNT2 + 1;

				local file = io.open(DIRBOARDINFO2, "w+");
				for i = 1, 6 do
					file:write(VALUE_BOARD_LISTS2[i].."\n");
				end
				file:close()

				HidePlayerDraw(id, Player[id].board_tips[1]);
				HidePlayerDraw(id, Player[id].board_tips[2]);
				HidePlayerDraw(id, Player[id].board_tips[3]);
				Player[id].board_tips[4] = false;

				ShowChat(id, 1);
				SendPlayerMessage(id, 255, 255, 255, "Вы повесили объявление на доске.");
				_unBoard(id);
				_oBoard(id);

			else
				SendPlayerMessage(id, 255, 255, 255, "В объявлении должно быть больше 1 строки.");
			end
		else
			GameTextForPlayer(id, 2995, 7580, "На доске много писем", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
		end

	elseif Player[id].board_id == 3 then

		if VALUE_BOARD_LISTS_COUNT3 < 6 then

			
			local str_size = table.getn(Player[id].board_currentText);

			if str_size > 1 then

				local pos = 0;
				for i, v in pairs(VALUE_BOARD_LISTS3) do
					if v == "0" then
						pos = i;
						VALUE_BOARD_LISTS3[i] = "1";
						break;
					end
				end

				local file = io.open(DIRBOARD3.."BOARD_"..pos, "w+");
				for i = 1, str_size do
					file:write(Player[id].board_currentText[i].."\n");
				end
				file:close();

				VALUE_BOARD_LISTS_COUNT3 = VALUE_BOARD_LISTS_COUNT3 + 1;

				local file = io.open(DIRBOARDINFO3, "w+");
				for i = 1, 6 do
					file:write(VALUE_BOARD_LISTS3[i].."\n");
				end
				file:close()

				HidePlayerDraw(id, Player[id].board_tips[1]);
				HidePlayerDraw(id, Player[id].board_tips[2]);
				HidePlayerDraw(id, Player[id].board_tips[3]);
				Player[id].board_tips[4] = false;

				ShowChat(id, 1);
				SendPlayerMessage(id, 255, 255, 255, "Вы повесили объявление на доске.");
				_unBoard(id);
				_oBoard(id);

			else
				SendPlayerMessage(id, 255, 255, 255, "В объявлении должно быть больше 1 строки.");
			end
		else
			GameTextForPlayer(id, 2995, 7580, "На доске много писем", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
		end

	elseif Player[id].board_id == 4 then

		if VALUE_BOARD_LISTS_COUNT4 < 6 then

			
			local str_size = table.getn(Player[id].board_currentText);

			if str_size > 1 then

				local pos = 0;
				for i, v in pairs(VALUE_BOARD_LISTS4) do
					if v == "0" then
						pos = i;
						VALUE_BOARD_LISTS4[i] = "1";
						break;
					end
				end

				local file = io.open(DIRBOARD4.."BOARD_"..pos, "w+");
				for i = 1, str_size do
					file:write(Player[id].board_currentText[i].."\n");
				end
				file:close();

				VALUE_BOARD_LISTS_COUNT4 = VALUE_BOARD_LISTS_COUNT4 + 1;

				local file = io.open(DIRBOARDINFO4, "w+");
				for i = 1, 6 do
					file:write(VALUE_BOARD_LISTS4[i].."\n");
				end
				file:close()

				HidePlayerDraw(id, Player[id].board_tips[1]);
				HidePlayerDraw(id, Player[id].board_tips[2]);
				HidePlayerDraw(id, Player[id].board_tips[3]);
				Player[id].board_tips[4] = false;

				ShowChat(id, 1);
				SendPlayerMessage(id, 255, 255, 255, "Вы повесили объявление на доске.");
				_unBoard(id);
				_oBoard(id);

			else
				SendPlayerMessage(id, 255, 255, 255, "В объявлении должно быть больше 1 строки.");
			end
		else
			GameTextForPlayer(id, 2995, 7580, "На доске много писем", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
		end

	elseif Player[id].board_id == 5 then

		if VALUE_BOARD_LISTS_COUNT5 < 6 then

			
			local str_size = table.getn(Player[id].board_currentText);

			if str_size > 1 then

				local pos = 0;
				for i, v in pairs(VALUE_BOARD_LISTS5) do
					if v == "0" then
						pos = i;
						VALUE_BOARD_LISTS5[i] = "1";
						break;
					end
				end

				local file = io.open(DIRBOARD5.."BOARD_"..pos, "w+");
				for i = 1, str_size do
					file:write(Player[id].board_currentText[i].."\n");
				end
				file:close();

				VALUE_BOARD_LISTS_COUNT5 = VALUE_BOARD_LISTS_COUNT5 + 1;

				local file = io.open(DIRBOARDINFO5, "w+");
				for i = 1, 6 do
					file:write(VALUE_BOARD_LISTS5[i].."\n");
				end
				file:close()

				HidePlayerDraw(id, Player[id].board_tips[1]);
				HidePlayerDraw(id, Player[id].board_tips[2]);
				HidePlayerDraw(id, Player[id].board_tips[3]);
				Player[id].board_tips[4] = false;

				ShowChat(id, 1);
				SendPlayerMessage(id, 255, 255, 255, "Вы повесили объявление на доске.");
				_unBoard(id);
				_oBoard(id);

			else
				SendPlayerMessage(id, 255, 255, 255, "В объявлении должно быть больше 1 строки.");
			end
		else
			GameTextForPlayer(id, 2995, 7580, "На доске много писем", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
		end

	end

end
addCommandHandler({"/д_готово"}, _endWriteToBoard);

function _destroyList(id, list)

	if Player[id].board_id == 1 then

		local file = io.open(DIRBOARD.."BOARD_"..list, "r");
		local count = 0;
		for line in file:lines() do
			count = count + 1;
		end
		file:close();

		if count > 1 then

			local file = io.open(DIRBOARD.."BOARD_"..list, "w+");
			file:write("");
			file:close();

			
			VALUE_BOARD_LISTS_COUNT = VALUE_BOARD_LISTS_COUNT - 1;
			VALUE_BOARD_LISTS[list] = "0";

			local file = io.open(DIRBOARDINFO, "w+");
			for i = 1, 6 do
				file:write(VALUE_BOARD_LISTS[i].."\n");
			end
			file:close()



			_unBoard(id);
			_oBoard(id);

			SendPlayerMessage(id, 255, 255, 255, "Вы сорвали лист с доски объявлений.")

			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) <= 1000 then
					SendPlayerMessage(i, 255, 255, 255, "Игрок "..GetPlayerName(id).." сорвал объявление с доски.");
				end
			end

		end

	elseif Player[id].board_id == 2 then

		local file = io.open(DIRBOARD2.."BOARD_"..list, "r");
		local count = 0;
		for line in file:lines() do
			count = count + 1;
		end
		file:close();

		if count > 1 then

			local file = io.open(DIRBOARD2.."BOARD_"..list, "w+");
			file:write("");
			file:close();

			
			VALUE_BOARD_LISTS_COUNT2 = VALUE_BOARD_LISTS_COUNT2 - 1;
			VALUE_BOARD_LISTS2[list] = "0";

			local file = io.open(DIRBOARDINFO2, "w+");
			for i = 1, 6 do
				file:write(VALUE_BOARD_LISTS2[i].."\n");
			end
			file:close()



			_unBoard(id);
			_oBoard(id);

			SendPlayerMessage(id, 255, 255, 255, "Вы сорвали лист с доски объявлений.")

			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) <= 1000 then
					SendPlayerMessage(i, 255, 255, 255, "Игрок "..GetPlayerName(id).." сорвал объявление с доски.");
				end
			end

		end

	elseif Player[id].board_id == 3 then

		local file = io.open(DIRBOARD3.."BOARD_"..list, "r");
		local count = 0;
		for line in file:lines() do
			count = count + 1;
		end
		file:close();

		if count > 1 then

			local file = io.open(DIRBOARD3.."BOARD_"..list, "w+");
			file:write("");
			file:close();

			
			VALUE_BOARD_LISTS_COUNT3 = VALUE_BOARD_LISTS_COUNT3 - 1;
			VALUE_BOARD_LISTS3[list] = "0";

			local file = io.open(DIRBOARDINFO3, "w+");
			for i = 1, 6 do
				file:write(VALUE_BOARD_LISTS3[i].."\n");
			end
			file:close()



			_unBoard(id);
			_oBoard(id);

			SendPlayerMessage(id, 255, 255, 255, "Вы сорвали лист с доски объявлений.")

			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) <= 1000 then
					SendPlayerMessage(i, 255, 255, 255, "Игрок "..GetPlayerName(id).." сорвал объявление с доски.");
				end
			end

		end

	elseif Player[id].board_id == 4 then

		local file = io.open(DIRBOARD4.."BOARD_"..list, "r");
		local count = 0;
		for line in file:lines() do
			count = count + 1;
		end
		file:close();

		if count > 1 then

			local file = io.open(DIRBOARD4.."BOARD_"..list, "w+");
			file:write("");
			file:close();

			
			VALUE_BOARD_LISTS_COUNT4 = VALUE_BOARD_LISTS_COUNT4 - 1;
			VALUE_BOARD_LISTS4[list] = "0";

			local file = io.open(DIRBOARDINFO4, "w+");
			for i = 1, 6 do
				file:write(VALUE_BOARD_LISTS4[i].."\n");
			end
			file:close()



			_unBoard(id);
			_oBoard(id);

			SendPlayerMessage(id, 255, 255, 255, "Вы сорвали лист с доски объявлений.")

			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) <= 1000 then
					SendPlayerMessage(i, 255, 255, 255, "Игрок "..GetPlayerName(id).." сорвал объявление с доски.");
				end
			end

		end

	elseif Player[id].board_id == 5 then

		local file = io.open(DIRBOARD5.."BOARD_"..list, "r");
		local count = 0;
		for line in file:lines() do
			count = count + 1;
		end
		file:close();

		if count > 1 then

			local file = io.open(DIRBOARD5.."BOARD_"..list, "w+");
			file:write("");
			file:close();

			
			VALUE_BOARD_LISTS_COUNT5 = VALUE_BOARD_LISTS_COUNT5 - 1;
			VALUE_BOARD_LISTS5[list] = "0";

			local file = io.open(DIRBOARDINFO5, "w+");
			for i = 1, 6 do
				file:write(VALUE_BOARD_LISTS5[i].."\n");
			end
			file:close()



			_unBoard(id);
			_oBoard(id);

			SendPlayerMessage(id, 255, 255, 255, "Вы сорвали лист с доски объявлений.")

			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) <= 1000 then
					SendPlayerMessage(i, 255, 255, 255, "Игрок "..GetPlayerName(id).." сорвал объявление с доски.");
				end
			end

		end

	end

end

function _bDestroy(id)
	Player[id].board_destroy = true;
	SendPlayerMessage(id, 255, 255, 255, "Чтобы сорвать лист - нажмите на него.")
end
addCommandHandler({"/д_сорвать"}, _bDestroy)



function _writeText(id, text)

	local l = Player[id].board_currentLine;

	if Player[id].board_currentLine < 19 then
		if string.len(text) > BOARD_LIMIT_LENS then
			if string.len(text) < 60 then

				PlayPlayerSound(id, s_write);

				local txt = {};
				txt[1] = string.sub(text, 1, 30); Player[id].board_currentText[l] = txt[1];
				txt[1] = txt[1]..".."
				UpdatePlayerDraw(id, Player[id].board_draws[l], BOARD_STRING[l][1], BOARD_STRING[l][2], Player[id].board_currentText[l], "Font_Old_20_White_Hi.TGA", 38, 37, 37);
				Player[id].board_currentLine = Player[id].board_currentLine + 1;

				if Player[id].board_currentLine < 19 then

					l = Player[id].board_currentLine;
					txt[2] = string.sub(text, 31, string.len(text));
					Player[id].board_currentText[l] = txt[2];
					UpdatePlayerDraw(id, Player[id].board_draws[l], BOARD_STRING[l][1], BOARD_STRING[l][2], Player[id].board_currentText[l], "Font_Old_20_White_Hi.TGA", 38, 37, 37);
					Player[id].board_currentLine = Player[id].board_currentLine + 1;

				end

			elseif string.len(text) > 60 then
				PlayPlayerSound(id, s_write);

				local txt = {};
				txt[1] = string.sub(text, 1, 30); Player[id].board_currentText[l] = txt[1];
				txt[1] = txt[1]..".."
				UpdatePlayerDraw(id, Player[id].board_draws[l], BOARD_STRING[l][1], BOARD_STRING[l][2], Player[id].board_currentText[l], "Font_Old_20_White_Hi.TGA", 38, 37, 37);
				Player[id].board_currentLine = Player[id].board_currentLine + 1;

				if Player[id].board_currentLine < 19 then

					l = Player[id].board_currentLine;
					txt[2] = string.sub(text, 31, 60);
					txt[2] = txt[2].."."

					Player[id].board_currentText[l] = txt[2];
					UpdatePlayerDraw(id, Player[id].board_draws[l], BOARD_STRING[l][1], BOARD_STRING[l][2], Player[id].board_currentText[l], "Font_Old_20_White_Hi.TGA", 38, 37, 37);
					Player[id].board_currentLine = Player[id].board_currentLine + 1;
				end

			end

		else
			PlayPlayerSound(id, s_write);
			Player[id].board_currentText[l] = text;
			UpdatePlayerDraw(id, Player[id].board_draws[l], BOARD_STRING[l][1], BOARD_STRING[l][2], Player[id].board_currentText[l], "Font_Old_20_White_Hi.TGA", 38, 37, 37);
			Player[id].board_currentLine = Player[id].board_currentLine + 1;
		end
	else
		GameTextForPlayer(id, 2995, 7580, "Достигнут лимит строк", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
	end

end

function _boardKey(id, down, up)

	if Player[id].board_write == true then
		if down == KEY_LCONTROL then
			if Player[id].board_currentLine < 18 then
				GameTextForPlayer(id, 2995, 7580, "Вы пропустили строчку", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
				Player[id].board_currentText[#Player[id].board_currentText + 1] = " ";
				Player[id].board_currentLine = Player[id].board_currentLine + 1;
			else
				GameTextForPlayer(id, 2995, 7580, "Достигнут лимит строк", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
			end
		end
	end

	if Player[id].board_open_list == true then
		if down == KEY_F then
			_hideOpenList(id);
		end
	end

	if down == KEY_ESCAPE then
		if Player[id].board_open == true then
			_unBoard(id)
		end
	end





end

function _hideOpenList(id)
	for i = 1, Player[id].board_tempArr[1] do
		HidePlayerDraw(id, Player[id].board_draws[i]);
		DestroyPlayerDraw(id, Player[id].board_draws[i]);
	end

	HideTexture(id, emptyletter);
	Player[id].board_open_list = false;
	Player[id].board_tempArr[1] = 0;

	if Player[id].board_namedraw[1] == false then
		ShowPlayerDraw(id, Player[id].board_namedraw[2]);
		Player[id].board_namedraw[1] = true;
	end

end