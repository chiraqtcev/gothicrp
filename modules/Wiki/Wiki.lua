
--  #  Wiki system by royclapton  #
--  #         version: 1.0        #

local wiki_tex = {};
wiki_tex[1] = CreateTexture(860, 1666, 2169, 2272, 'menu_ingame')
wiki_tex[2] = CreateTexture(860, 2331, 2832, 6926, 'menu_ingame')
wiki_tex[3] = CreateTexture(3035, 2335, 7650, 6940, 'menu_ingame')

local WIKIDIR = "modules/Wiki/"
local CATEGORY_VALUE = 0;
local CATEGORIES = {};

local OPEN_WIKI_SOUND = CreateSound("INV_OPEN.WAV");
local CLOSE_WIKI_SOUND = CreateSound("INV_CLOSE.WAV");
local SELECT_WIKI_SOUND = CreateSound("INV_CHANGE.WAV");

function _wikiInit() -- в Ongamemodeinit

	print("");
	print(" ###########################");
	print(" #       Wiki system       #");
	print(" #                         #");

	local file = io.open(WIKIDIR.."/Categories/CategoriesInfo.txt", "r");
	for line in file:lines() do
		local result, name = sscanf(line, "s");
		if result == 1 then
			CATEGORY_VALUE = CATEGORY_VALUE + 1;
			table.insert(CATEGORIES, name);
		end
	end
	file:close();

	print(" #   "..CATEGORY_VALUE.." categories loaded   #");
	print(" #                         #");
	print(" ###########################");

end

function _wikiConnect(id) -- в OnPlayerConnect
	
	Player[id]._wiki_open = false;
	Player[id]._wiki_category = nil;
	Player[id]._wiki_select = nil;
	Player[id]._wiki_select_limit = 0;
	Player[id]._wiki_category_n = nil;

	Player[id]._wiki_draws_pMenu = {}; local y = 2710;
	for i = 1, 20 do
		Player[id]._wiki_draws_pMenu[i] = CreatePlayerDraw(id, 960, y, ""); -- cmds / 960, 2600 / 24 lens
		y = y + 200;
	end

	Player[id]._wiki_draws_text = {}; local y = 2710;
	for i = 1, 20 do
		Player[id]._wiki_draws_text[i] = CreatePlayerDraw(id, 3260, y, ""); -- info / 3560, 2600 / ~ 60-65 lens
		y = y + 200;
	end

	Player[id]._wiki_draws_cat = CreatePlayerDraw(id, 915, 1950, "");


	Player[id]._wiki_draws_main = {};
	Player[id]._wiki_draws_main[1] = CreatePlayerDraw(id, 1481, 2358, "Список", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[id]._wiki_draws_main[2] = CreatePlayerDraw(id, 4651, 2358, "Информация", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[id]._wiki_draws_main[3] = CreatePlayerDraw(id, 934, 1676, "Название категории");
	Player[id]._wiki_draws_main[4] = CreatePlayerDraw(id, 4190, 6590, "Для управления используйте стрелочки", "Font_Old_10_White_Hi.TGA", 125, 125, 125);
end

function _wikiUpdateCategory(id)
	UpdatePlayerDraw(id, Player[id]._wiki_draws_cat, 915, 1950, Player[id]._wiki_category, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
end

function _wikiUpdateList(id)

	_wikiResetList(id);
	Player[id]._wiki_select_limit = 0;

	for i = 1, 20 do

		local file = io.open(WIKIDIR.."Categories/"..Player[id]._wiki_category.."/line_"..i..".txt", "r");
		local count = 1;
		for line in file:lines() do
			local result, text = sscanf(line, "s");
			if result == 1 then
				if count == 1 then
					if text ~= "off" then
						UpdatePlayerDraw(id, Player[id]._wiki_draws_pMenu[i], 960, 2510 + (200 * i), text, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
						count = count + 1;
						Player[id]._wiki_select_limit = Player[id]._wiki_select_limit + 1;
					else
						break
					end
				else
					break
				end
			end
		end
		file:close();

	end

end

function _wikiUpdateText(id)

	_wikiResetText(id);

	local file = io.open(WIKIDIR.."Categories/"..Player[id]._wiki_category.."/line_"..Player[id]._wiki_select..".txt", "r");
	local count = 1; local i = 1;
	for line in file:lines() do
		local result, text = sscanf(line, "s");
		if result == 1 then
			if text ~= "off" then
				if count == 1 then
					count = count + 1;
				else
					if text ~= "##" then
						UpdatePlayerDraw(id, Player[id]._wiki_draws_text[i], 3260, 2400 + (200 * i), text, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
						i = i + 1;
					else
						UpdatePlayerDraw(id, Player[id]._wiki_draws_text[i], 3260, 2400 + (200 * i), " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
						i = i + 1;
					end
				end
			else
				Player[id]._wiki_select = 1;
				_wikiUpdateText(id);
			end
		end
	end
	file:close();

end

function _wikiResetText(id)
	for i = 1, 20 do
		UpdatePlayerDraw(id, Player[id]._wiki_draws_text[i], 0, 0, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end
end

function _wikiResetList(id)
	for i = 1, 20 do
		UpdatePlayerDraw(id, Player[id]._wiki_draws_pMenu[i], 0, 0, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end
end

function _wikiResetColorList(id)
	for i = 1, Player[id]._wiki_select_limit do
		SetPlayerDrawColor(id, Player[id]._wiki_draws_pMenu[i], 255, 255, 255);
	end
end

function _openWiki(id)

	if Player[id].loggedIn == true then
		if Player[id]._wiki_open == false then

			Freeze(id);
			ShowChat(id, 0);
			PlayPlayerSound(id, OPEN_WIKI_SOUND);

			Player[id]._wiki_open = true;
			Player[id]._wiki_category_n = 1;
			Player[id]._wiki_category = CATEGORIES[1];
			Player[id]._wiki_select = 1;

			for i = 1, 20 do
				ShowPlayerDraw(id, Player[id]._wiki_draws_pMenu[i])
			end

			for i = 1, 20 do
				ShowPlayerDraw(id, Player[id]._wiki_draws_text[i])
			end

			for i = 1, table.getn(Player[id]._wiki_draws_main) do
				ShowPlayerDraw(id, Player[id]._wiki_draws_main[i]);
			end

			ShowPlayerDraw(id, Player[id]._wiki_draws_cat);

			for i = 1, table.getn(wiki_tex) do
				ShowTexture(id, wiki_tex[i]);
			end

			_wikiUpdateList(id);
			_wikiUpdateCategory(id);
			_wikiUpdateText(id);
			SetPlayerDrawColor(id, Player[id]._wiki_draws_pMenu[1], 124, 230, 83);

		else

			for i = 1, 20 do
				HidePlayerDraw(id, Player[id]._wiki_draws_pMenu[i])
			end

			for i = 1, 20 do
				HidePlayerDraw(id, Player[id]._wiki_draws_text[i])
			end

			for i = 1, table.getn(Player[id]._wiki_draws_main) do
				HidePlayerDraw(id, Player[id]._wiki_draws_main[i]);
			end

			HidePlayerDraw(id, Player[id]._wiki_draws_cat);

			for i = 1, table.getn(wiki_tex) do
				HideTexture(id, wiki_tex[i]);
			end

			Player[id]._wiki_open = false;
			Player[id]._wiki_category = nil;
			Player[id]._wiki_select = nil;
			Player[id]._wiki_select_limit = 0;
			Player[id]._wiki_category_n = nil;
			ShowChat(id, 1);
			UnFreeze(id);
			PlayPlayerSound(id, CLOSE_WIKI_SOUND);

		end
	end

end
addCommandHandler({"/wiki", "/вики"}, _openWiki);

function _wikiKey(id, down, up) -- в OnPlayerKey

	if Player[id].loggedIn == true then

		if down == KEY_F7 then
			_openWiki(id);
		end

		if Player[id]._wiki_open == true then

			if down == KEY_RIGHT then

				Player[id]._wiki_category_n = Player[id]._wiki_category_n + 1; local cid = Player[id]._wiki_category_n;
				Player[id]._wiki_category = CATEGORIES[cid];
				Player[id]._wiki_select = 1;

				if Player[id]._wiki_category_n > CATEGORY_VALUE then
					Player[id]._wiki_category_n = 1;
					Player[id]._wiki_category = CATEGORIES[1];
					Player[id]._wiki_select = 1;
				end

				_wikiUpdateList(id);
				_wikiUpdateCategory(id);
				_wikiUpdateText(id);
				_wikiResetColorList(id);
				local cid = Player[id]._wiki_select;
				SetPlayerDrawColor(id, Player[id]._wiki_draws_pMenu[cid], 124, 230, 83);
				PlayPlayerSound(id, SELECT_WIKI_SOUND);

			end

			if down == KEY_LEFT then
				
				Player[id]._wiki_category_n = Player[id]._wiki_category_n - 1; local cid = Player[id]._wiki_category_n;
				Player[id]._wiki_category = CATEGORIES[cid];
				Player[id]._wiki_select = 1;

				if Player[id]._wiki_category_n == 0 then
					Player[id]._wiki_category_n = CATEGORY_VALUE;
					Player[id]._wiki_category = CATEGORIES[CATEGORY_VALUE];
					Player[id]._wiki_select = 1;
				end

				_wikiUpdateList(id);
				_wikiUpdateCategory(id);
				_wikiUpdateText(id);
				_wikiResetColorList(id);
				local cid = Player[id]._wiki_select;
				SetPlayerDrawColor(id, Player[id]._wiki_draws_pMenu[cid], 124, 230, 83);
				PlayPlayerSound(id, SELECT_WIKI_SOUND);

			end

			if down == KEY_DOWN then

				Player[id]._wiki_select = Player[id]._wiki_select + 1;
				if Player[id]._wiki_select > Player[id]._wiki_select_limit then
					Player[id]._wiki_select = 1;
				end

				_wikiUpdateText(id);
				_wikiResetColorList(id)
				local cid = Player[id]._wiki_select;
				SetPlayerDrawColor(id, Player[id]._wiki_draws_pMenu[cid], 124, 230, 83);
				PlayPlayerSound(id, SELECT_WIKI_SOUND);

			end


			if down == KEY_UP then

				Player[id]._wiki_select = Player[id]._wiki_select - 1;
				if Player[id]._wiki_select < 1 then
					Player[id]._wiki_select = Player[id]._wiki_select_limit;
				end

				_wikiUpdateText(id);
				_wikiResetColorList(id);
				local cid = Player[id]._wiki_select;
				SetPlayerDrawColor(id, Player[id]._wiki_draws_pMenu[cid], 124, 230, 83);
				PlayPlayerSound(id, SELECT_WIKI_SOUND);

			end
		end
		
	end
end

