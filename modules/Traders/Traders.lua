

--  #    Traders by royclapton     #
--  #       version: 0.9.8         #

TRADERS_COUNT = 0;
TRADERS_COUNT_LIST = {};

DIR_TRADERS = "modules/Traders/TradersBase/"
DIR_TRADERS_INFO = "modules/Traders/TradersBase/TRADERS_INFO.txt"

TRADERS = {};

ITEMS_IDS_XYZ_TEX = {};
for i = 1, 15 do
	ITEMS_IDS_XYZ_TEX[i] = {2585, 1590+250*i, 5540, 1850+250*i};
end

ITEMS_IDS_XYZ_BUTT = {};
for i = 1, 15 do
	ITEMS_IDS_XYZ_BUTT[i] = {2585, 5540, 1590+250*i, 1850+250*i};
end

TRADERS_BUT_BUTTON = {3738, 4434, 5895, 6283};

local BUY_SOUND = CreateSound("GELDBEUTEL.WAV")

function _initTraders()


	print("");
	print("Traders system");

	for line in io.lines(DIR_TRADERS_INFO) do
		TRADERS_COUNT = TRADERS_COUNT + 1;
		table.insert(TRADERS_COUNT_LIST, line);
	end

	if TRADERS_COUNT > 0 then
		for i = 1, TRADERS_COUNT do
			TRADERS[i] = {};
			TRADERS[i].bot = nil;
			TRADERS[i].bot_id = nil;
			TRADERS[i].name = nil;
			TRADERS[i].owner = nil;
			TRADERS[i].items = {};
			TRADERS[i].items_value = {};
			TRADERS[i].items_price = {};
			TRADERS[i].items_price_type = {};
			TRADERS[i].cash = {0, 0};
			TRADERS[i].busy = false;
			TRADERS[i].angle = 0;
			TRADERS[i].pos = {0, 0, 0};
			TRADERS[i].visual = {};
			TRADERS[i].armor = nil;
			TRADERS[i].moving_timer = nil;
		end

		for i = 1, TRADERS_COUNT do
			local file = io.open(DIR_TRADERS..TRADERS_COUNT_LIST[i]..".txt", "r");
			if file then
				TRADERS[i].bot = CreateNPC(TRADERS_COUNT_LIST[i]);
				line = file:read("*l");
				local result, str, cash1, cash2, x, y, z, angle, v1, v2, v3, v4, armor = sscanf(line, "sddddddsdsds");
				if result == 1 then
					TRADERS[i].owner = str;
					TRADERS[i].cash[1] = cash1; TRADERS[i].cash[2] = cash2;
					TRADERS[i].name = TRADERS_COUNT_LIST[i];
					TRADERS[i].angle = angle;
					TRADERS[i].pos = {x, y, z};
					TRADERS[i].visual = {v1, v2, v3, v4};
					TRADERS[i].armor = armor;
					SpawnPlayer(TRADERS[i].bot);
					for c = 0, GetMaxSlots() do
						if GetPlayerName(c) == TRADERS[i].name then
							TRADERS[i].bot_id = c;
							break
						end
					end
					SetPlayerWorld(TRADERS[i].bot, "KOLONIE.ZEN");
					SetPlayerPos(TRADERS[i].bot, x, y, z);
					SetPlayerAngle(TRADERS[i].bot, angle);
					EquipArmor(TRADERS[i].bot, armor);
					SetPlayerAdditionalVisual(TRADERS[i].bot, v1, v2, v3, v4);
				end

			end
		end

		for icount = 1, TRADERS_COUNT do
			local temp = 0;
			for line in io.lines(DIR_TRADERS..TRADERS_COUNT_LIST[icount]..".txt") do
				temp = temp + 1;
				if temp > 1 then
					local result, itemname, value, price, price_type = sscanf(line, "sdds");
					if result == 1 then
						table.insert(TRADERS[icount].items, itemname);
						table.insert(TRADERS[icount].items_value, value);
						table.insert(TRADERS[icount].items_price, price);
						table.insert(TRADERS[icount].items_price_type, price_type);
					end
				end
			end
		end
	end

	print(TRADERS_COUNT.." loaded");


end

traders_select_tex = {};
traders_select_tex[1] = CreateTexture(0, 0, 0, 0, 'dlg_conversation');
traders_select_tex[2] = CreateTexture(0, 0, 0, 0, 'dlg_conversation');
traders_menu_tex = {};
traders_menu_tex[1] = CreateTexture(2490, 1005, 5660, 6525, 'menu_ingame')
traders_menu_tex[2] = CreateTexture(0, 0, 0, 0, '')
traders_focus_tex = CreateTexture(2997, 6223, 5189, 6620, 'menu_ingame')


-- in OnPlayerConnect
function _tradersConnect(id)

	Player[id]._trader_focus = nil;
	Player[id]._trader_select_id = nil;

	Player[id]._trader_focus_draw = CreatePlayerDraw(id, 3280, 6320, "Разговор с торговцем - CTRL");
	Player[id]._trader_bot = {false, nil};

	Player[id]._trader_menu = false;

	Player[id]._trader_menu_main_draws = {};
	Player[id]._trader_menu_main_draws[1] = CreatePlayerDraw(id, 2620, 1590, "Название");
	Player[id]._trader_menu_main_draws[2] = CreatePlayerDraw(id, 4520, 1590, "Кол-во");
	Player[id]._trader_menu_main_draws[3] = CreatePlayerDraw(id, 5120, 1590, "Цена");
	local myrude = string.format("%s","Руда: --"); local myrudec = string.format("%s","Р-е фишки: --"); 
	Player[id]._trader_menu_main_draws[4] = CreatePlayerDraw(id, 2620, 5880, myrude, "Font_Old_10_White_Hi.TGA", 102, 42, 181);
	Player[id]._trader_menu_main_draws[5] = CreatePlayerDraw(id, 2620, 6080, myrudec, "Font_Old_10_White_Hi.TGA", 102, 42, 181);
	Player[id]._trader_menu_main_draws[6] = CreatePlayerDraw(id, 3900, 5975, "");

	Player[id]._trader_items_draws = {};
	Player[id]._trader_items_value_draws = {};
	Player[id]._trader_items_price_draws = {};
	Player[id]._trader_items_price_type_draws = {};

	--------------------------------------------------------------

	Player[id]._traders_my = false;
	Player[id]._traders_my_value = nil;
	Player[id]._traders_my_botid = nil;
	Player[id]._traders_my_price = nil;
	Player[id]._traders_my_price_type = nil;
	--[[Player[id]._traders_settings = {false, nil};
	Player[id]._traders_settings_tex = {};
	Player[id]._traders_settings_tex[1] = CreateTexture(2830, 535, 5300, 5475, 'menu_ingame')
	Player[id]._traders_settings_tex[2] = CreateTexture(2655, 5503, 5490, 6641, 'menu_ingame')

	Player[id]._traders_my_items = {};
	Player[id]._traders_my_items_value = {};
	Player[id]._traders_my_items_select = nil;

	Player[id]._traders_settings_draws_item = {};
	Player[id]._traders_settings_draws_item[1] = CreatePlayerDraw(id, 2770, 5635, "");
	Player[id]._traders_settings_draws_item[2] = CreatePlayerDraw(id, 2770, 5885, "");]]


end

-- in OnPlayerFocus
function _tradersFocus(id, bot)

	if bot ~= -1 then
		for _, v in pairs(TRADERS_COUNT_LIST) do
			if GetPlayerName(bot) == v then
				Player[id]._trader_focus = v;
				ShowTexture(id, traders_focus_tex);
				ShowPlayerDraw(id, Player[id]._trader_focus_draw);
			end
		end
	else
		Player[id]._trader_focus = nil;
		HideTexture(id, traders_focus_tex);
		HidePlayerDraw(id, Player[id]._trader_focus_draw);
	end

end

createGUIMenu("TRADER_MENU", {
	{ "1. Посмотреть ассортимент" },
	{ "2. Информация о торговце" },
	{ "3. Закончить разговор" },
    }, 150, 150, 150, 255, 255, 255, 5430, 3500, "Font_Old_20_White_Hi.TGA", CreateTexture(5295, 3365, 8130, 4440, 'menu_ingame'), 3);

-- in OnPlayerKey
function _tradersKey(id, down, up)

	--_tradersKeySetting(id, down, up);

	if down == KEY_LCONTROL then
		if Player[id].loggedIn == true then
			if Player[id]._trader_focus ~= nil then
				if Player[id]._trader_bot[1] == false then

					Player[id]._trader_bot[1] = true;
					for i = 0, GetMaxSlots() do
						if GetPlayerName(i) == Player[id]._trader_focus then
							Player[id]._trader_bot[2] = i;
							break
						end
					end

					local b_id = nil;
					for i = 1, TRADERS_COUNT do
						if TRADERS[i].name == GetPlayerName(Player[id]._trader_bot[2]) then
							b_id = i;
							break
						end
					end

					if TRADERS[b_id].busy ~= true then
						
						--SendPlayerMessage(id, 255, 255, 255, "(dev) Bot ID: "..Player[id]._trader_bot[2].. " / Bot name: "..Player[id]._trader_focus);
						HideTexture(id, traders_focus_tex);
						HidePlayerDraw(id, Player[id]._trader_focus_draw);
						Player[id]._trader_focus = nil;

						for i = 1, TRADERS_COUNT do
							if TRADERS[i].name == GetPlayerName(Player[id]._trader_bot[2]) then
								b_id = i;
								break
							end
						end

						TRADERS[b_id].busy = true;
						SetPlayerAngle(Player[id]._trader_bot[2], GetAngleToPlayer(Player[id]._trader_bot[2], id));
						showGUIMenu(id, "TRADER_MENU");
						Freeze(id);
						PlayGesticulation(Player[id]._trader_bot[2]);
					else
						SendPlayerMessage(id, 255, 255, 255, "Торговец сейчас занят.")
						Player[id]._trader_bot = {false, nil};
					end
				end
			end
		end
	end

	if down == KEY_UP then
		switchGUIMenuUp(id, "TRADER_MENU");
	end

	if down == KEY_DOWN then
		switchGUIMenuDown(id, "TRADER_MENU");
	end

	if down == KEY_ESCAPE then
		if Player[id]._trader_bot[1] == true then
			if Player[id]._trader_menu == true then

				ShowChat(id, 1);
				SetCursorVisible(id, 0);
				FreezeCamera(id, 0);
				UpdateTexture(traders_select_tex[1], 0, 0, 0, 0, "dlg_conversation");
				UpdateTexture(traders_select_tex[2], 0, 0, 0, 0, "dlg_conversation");
				HideTexture(id, traders_select_tex[1]);
				HideTexture(id, traders_select_tex[2]);
				local b_id = nil;
				for i = 1, TRADERS_COUNT do
					if TRADERS[i].name == GetPlayerName(Player[id]._trader_bot[2]) then
						b_id = i;
						break
					end
				end
				TRADERS[b_id].busy = false;

				Player[id]._trader_menu = false;
				for i = 1, table.getn(traders_menu_tex) do
					HideTexture(id, traders_menu_tex[i]);
				end
				UpdateTexture(traders_menu_tex[2], 0, 0, 0, 0, "");

				for i = 1, table.getn(Player[id]._trader_menu_main_draws) do
					HidePlayerDraw(id, Player[id]._trader_menu_main_draws[i]);
				end

				UpdatePlayerDraw(id, Player[id]._trader_menu_main_draws[6], 3900, 5975, "", "", 255, 255, 255);

				for i = 1, table.getn(TRADERS[b_id].items) do
					HidePlayerDraw(id, Player[id]._trader_items_draws[i]);
					HidePlayerDraw(id, Player[id]._trader_items_value_draws[i]);
					HidePlayerDraw(id, Player[id]._trader_items_price_draws[i]);
					HidePlayerDraw(id, Player[id]._trader_items_price_type_draws[i]);

					DestroyPlayerDraw(id, Player[id]._trader_items_draws[i]);
					DestroyPlayerDraw(id, Player[id]._trader_items_value_draws[i]);
					DestroyPlayerDraw(id, Player[id]._trader_items_price_draws[i]);
					DestroyPlayerDraw(id, Player[id]._trader_items_price_type_draws[i]);
				end

				SetPlayerAngle(Player[id]._trader_bot[2], TRADERS[b_id].angle);
				PlayGesticulation(Player[id]._trader_bot[2]);
				Player[id]._trader_bot[1] = false;
				Player[id]._trader_bot[2] = nil;
				Player[id]._trader_select_id = nil;
				UnFreeze(id);

			end
		end
	end

	if down == KEY_RETURN then
		if Player[id].loggedIn == true then
			if Player[id]._trader_bot[1] == true then

				if getPlayerOptionID(id, "TRADER_MENU") == 1 then
					_loadingTraderItems(id)

				elseif getPlayerOptionID(id, "TRADER_MENU") == 2 then

					local b_id = nil;

					for i = 1, TRADERS_COUNT do
						if TRADERS[i].name == GetPlayerName(Player[id]._trader_bot[2]) then
							b_id = i;
							break
						end
					end
					
					PlayGesticulation(Player[id]._trader_bot[2]);
					SendPlayerMessage(id, 255, 255, 255, " ");
					SendPlayerMessage(id, 255, 255, 255, "Информация о торговце "..GetPlayerName(Player[id]._trader_bot[2])..":")
					SendPlayerMessage(id, 255, 255, 255, "Владелец: "..TRADERS[b_id].owner)

					if TRADERS[b_id].owner == Player[id].nickname then
						SendPlayerMessage(id, 255, 255, 255, " ")
						SendPlayerMessage(id, 255, 255, 255, "Прибыль с продаж")
						SendPlayerMessage(id, 255, 255, 255, "Руда: "..TRADERS[b_id].cash[1])
						SendPlayerMessage(id, 255, 255, 255, "Фишки: "..TRADERS[b_id].cash[2])
						SendPlayerMessage(id, 255, 255, 255, " ")
						SendPlayerMessage(id, 255, 255, 255, "Команды управления:")
						SendPlayerMessage(id, 255, 255, 255, "/упр_бот_прибыль - забрать всю прибыль.")
						SendPlayerMessage(id, 255, 255, 255, "/упр_бот - загрузить товар в торговца.")
					end
					

				elseif getPlayerOptionID(id, "TRADER_MENU") == 3 then

					local b_id = nil;

					for i = 1, TRADERS_COUNT do
						if TRADERS[i].name == GetPlayerName(Player[id]._trader_bot[2]) then
							b_id = i;
							break
						end
					end

					TRADERS[b_id].busy = false;
					SetPlayerAngle(Player[id]._trader_bot[2], TRADERS[b_id].angle);
					PlayGesticulation(Player[id]._trader_bot[2]);
					Player[id]._trader_bot[1] = false;
					Player[id]._trader_bot[2] = nil;
					hideGUIMenu(id, "TRADER_MENU");
					UnFreeze(id);
				end
			end
		end
	end


end

function _loadingTraderItems(id)

	local b_id = nil;
	for i = 1, TRADERS_COUNT do
		if TRADERS[i].name == GetPlayerName(Player[id]._trader_bot[2]) then
			b_id = i;
			break
		end
	end


	if table.getn(TRADERS[b_id].items) > 0 then

		hideGUIMenu(id, "TRADER_MENU");
		Player[id]._trader_menu = true;

		for i = 1, table.getn(traders_menu_tex) do
			ShowTexture(id, traders_menu_tex[i]);
		end

		for i = 1, table.getn(Player[id]._trader_menu_main_draws) do
			ShowPlayerDraw(id, Player[id]._trader_menu_main_draws[i]);
		end

		local myrude = string.format("%s%d","Руда: ",Player[id].rude); local myrudec = string.format("%s%d","Фишки: ",Player[id].rude_coins); 
		UpdatePlayerDraw(id, Player[id]._trader_menu_main_draws[4], 2620, 5880, myrude, "Font_Old_10_White_Hi.TGA", 165, 141, 196);
		UpdatePlayerDraw(id, Player[id]._trader_menu_main_draws[5], 2620, 6080, myrudec, "Font_Old_10_White_Hi.TGA", 165, 141, 196);
		ShowChat(id, 0);
		SetCursorVisible(id, 1);
		FreezeCamera(id, 1);
		ShowTexture(id, traders_select_tex[1]);
		ShowTexture(id, traders_select_tex[2]);

		local dy = 1890;
		for i = 1, table.getn(TRADERS[b_id].items) do
			Player[id]._trader_items_draws[i] = CreatePlayerDraw(id, 2620, dy, GetItemName(TRADERS[b_id].items[i]));
			Player[id]._trader_items_value_draws[i] = CreatePlayerDraw(id, 4520, dy, TRADERS[b_id].items_value[i]);
			Player[id]._trader_items_price_draws[i] = CreatePlayerDraw(id, 5120, dy, TRADERS[b_id].items_price[i]);
			local price_t = string.format("%s%s%s", "(",TRADERS[b_id].items_price_type[i],")");
			Player[id]._trader_items_price_type_draws[i] = CreatePlayerDraw(id, 5395, dy, price_t);
			ShowPlayerDraw(id, Player[id]._trader_items_draws[i]);
			ShowPlayerDraw(id, Player[id]._trader_items_value_draws[i]);
			ShowPlayerDraw(id, Player[id]._trader_items_price_draws[i]);
			ShowPlayerDraw(id, Player[id]._trader_items_price_type_draws[i]);
			dy = dy + 250;
		end

	else
		SendPlayerMessage(id, 255, 255, 255, "В данный момент товаров нет.")
	end

end


function _tradersSelectSlot(id, slot)

	local b_id = nil;
	for i = 1, TRADERS_COUNT do
		if TRADERS[i].name == GetPlayerName(Player[id]._trader_bot[2]) then
			b_id = i;
			break
		end
	end

	if TRADERS[b_id].items[slot] ~= nil then
		UpdateTexture(traders_select_tex[1], ITEMS_IDS_XYZ_TEX[slot][1], ITEMS_IDS_XYZ_TEX[slot][2], ITEMS_IDS_XYZ_TEX[slot][3], ITEMS_IDS_XYZ_TEX[slot][4], "dlg_conversation");
		UpdateTexture(traders_select_tex[2], ITEMS_IDS_XYZ_TEX[slot][1], ITEMS_IDS_XYZ_TEX[slot][2], ITEMS_IDS_XYZ_TEX[slot][3], ITEMS_IDS_XYZ_TEX[slot][4], "dlg_conversation");
		UpdateTexture(traders_menu_tex[2], 3738, 5895, 4434, 6283, 'menu_ingame');
		if TRADERS[b_id].owner ~= Player[id].nickname then
			UpdatePlayerDraw(id, Player[id]._trader_menu_main_draws[6], 3900, 5975, "Купить", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		elseif TRADERS[b_id].owner == Player[id].nickname then
			UpdatePlayerDraw(id, Player[id]._trader_menu_main_draws[6], 3900, 5975, "Снять", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end
		Player[id]._trader_select_id = slot;
	end

end


function _tradersRefresh(id)

	for i = 1, table.getn(Player[id]._trader_items_draws) do
		HidePlayerDraw(id, Player[id]._trader_items_draws[i]);
		DestroyPlayerDraw(id, Player[id]._trader_items_draws[i]);
	end

	for i = 1, table.getn(Player[id]._trader_items_value_draws) do
		HidePlayerDraw(id, Player[id]._trader_items_value_draws[i]);
		DestroyPlayerDraw(id, Player[id]._trader_items_value_draws[i]);
	end

	for i = 1, table.getn(Player[id]._trader_items_price_draws) do
		HidePlayerDraw(id, Player[id]._trader_items_price_draws[i]);
		DestroyPlayerDraw(id, Player[id]._trader_items_price_draws[i]);
	end

	for i = 1, table.getn(Player[id]._trader_items_price_type_draws) do
		HidePlayerDraw(id, Player[id]._trader_items_price_type_draws[i]);
		DestroyPlayerDraw(id, Player[id]._trader_items_price_type_draws[i]);
	end

	Player[id]._trader_items_draws = {};
	Player[id]._trader_items_value_draws = {};
	Player[id]._trader_items_price_draws = {};
	Player[id]._trader_items_price_type_draws = {};


	local b_id = nil;
	for i = 1, TRADERS_COUNT do
		if TRADERS[i].name == GetPlayerName(Player[id]._trader_bot[2]) then
			b_id = i;
			break
		end
	end

	local myrude = string.format("%s%d","Руда: ",Player[id].rude); local myrudec = string.format("%s%d","Фишки: ",Player[id].rude_coins); 
	UpdatePlayerDraw(id, Player[id]._trader_menu_main_draws[4], 2620, 5880, myrude, "Font_Old_10_White_Hi.TGA", 165, 141, 196);
	UpdatePlayerDraw(id, Player[id]._trader_menu_main_draws[5], 2620, 6080, myrudec, "Font_Old_10_White_Hi.TGA", 165, 141, 196);

	local dy = 1890;
	for i = 1, table.getn(TRADERS[b_id].items) do
		Player[id]._trader_items_draws[i] = CreatePlayerDraw(id, 2620, dy, GetItemName(TRADERS[b_id].items[i]));
		Player[id]._trader_items_value_draws[i] = CreatePlayerDraw(id, 4520, dy, TRADERS[b_id].items_value[i]);
		Player[id]._trader_items_price_draws[i] = CreatePlayerDraw(id, 5120, dy, TRADERS[b_id].items_price[i]);
		local price_t = string.format("%s%s%s", "(",TRADERS[b_id].items_price_type[i],")");
		Player[id]._trader_items_price_type_draws[i] = CreatePlayerDraw(id, 5395, dy, price_t);
		ShowPlayerDraw(id, Player[id]._trader_items_draws[i]);
		ShowPlayerDraw(id, Player[id]._trader_items_value_draws[i]);
		ShowPlayerDraw(id, Player[id]._trader_items_price_draws[i]);
		ShowPlayerDraw(id, Player[id]._trader_items_price_type_draws[i]);
		dy = dy + 250;
	end

	UpdateTexture(traders_select_tex[1], 0, 0, 0, 0, "dlg_conversation");
	UpdateTexture(traders_select_tex[2], 0, 0, 0, 0, "dlg_conversation");
	UpdateTexture(traders_menu_tex[2], 0, 0, 0, 0, "");
	UpdatePlayerDraw(id, Player[id]._trader_menu_main_draws[6], 3900, 5975, "", "", 255, 255, 255);

	Player[id]._trader_select_id = nil;

end

function _tradersBackItem(id)

	local b_id = nil;
	for i = 1, TRADERS_COUNT do
		if TRADERS[i].name == GetPlayerName(Player[id]._trader_bot[2]) then
			b_id = i;
			break
		end
	end

	local itemSlot = Player[id]._trader_select_id;
	if TRADERS[b_id].items[itemSlot] ~= nil then

		local item = TRADERS[b_id].items[itemSlot];
		local value = TRADERS[b_id].items_value[itemSlot];
		local price = TRADERS[b_id].items_price[itemSlot];
		local price_type = TRADERS[b_id].items_price_type[itemSlot];

		GiveItem(id, item, value);
		table.remove(TRADERS[b_id].items, itemSlot);
		table.remove(TRADERS[b_id].items_value, itemSlot);
		table.remove(TRADERS[b_id].items_price, itemSlot);
		table.remove(TRADERS[b_id].items_price_type, itemSlot);

		-----------------------------------------
		local count = table.getn(TRADERS[b_id].items);
		local file = io.open(DIR_TRADERS..TRADERS_COUNT_LIST[b_id]..".txt", "w");
		file:write(TRADERS[b_id].owner.." "..TRADERS[b_id].cash[1].." "..TRADERS[b_id].cash[2].." "..TRADERS[b_id].pos[1].." "..TRADERS[b_id].pos[2]..
		" "..TRADERS[b_id].pos[3].." "..TRADERS[b_id].angle.." "..TRADERS[b_id].visual[1].." "..TRADERS[b_id].visual[2].." "..TRADERS[b_id].visual[3].." "..
		TRADERS[b_id].visual[4].." "..TRADERS[b_id].armor.."\n");
		if count > 0 then
			for i = 1, count do
				file:write(TRADERS[b_id].items[i].. " "..TRADERS[b_id].items_value[i].." "..TRADERS[b_id].items_price[i].." "..TRADERS[b_id].items_price_type[i].."\n");
			end
		end
		file:close();
		-----------------------------------------

		GameTextForPlayer(id, 200, 6000, "Предмет снят с продажи.", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 1500);
		PlayPlayerSound(id, BUY_SOUND);
		SaveItems(id);
		SavePlayer(id);
		_tradersRefresh(id);
	end
end	


function _tradersBuyItem(id)

	local b_id = nil;
	for i = 1, TRADERS_COUNT do
		if TRADERS[i].name == GetPlayerName(Player[id]._trader_bot[2]) then
			b_id = i;
			break
		end
	end

	local itemSlot = Player[id]._trader_select_id;

	if TRADERS[b_id].items[itemSlot] ~= nil then

		local item = TRADERS[b_id].items[itemSlot];
		local value = TRADERS[b_id].items_value[itemSlot];
		local price = TRADERS[b_id].items_price[itemSlot];
		local price_type = TRADERS[b_id].items_price_type[itemSlot];

		time = os.date('*t');
		local ryear = time.year;
		local rmonth = time.month;
		local rday = time.day;
		local rhour = string.format("%02d", time.hour);
		local rminute = string.format("%02d", time.min);


		if price_type == "ф" or price_type == "Ф" then
			if Player[id].rude_coins >= price then
				if value > 1 then

					LogString("Logs/Traders/All",Player[id].nickname.." купил "..GetItemName(item).." x1 за "..price.." ("..price_type..") / Дата: "..rday.."."..rmonth.."."..ryear.." "..rhour..":"..rminute);
					LogString("Logs/Traders/All","Баланс бота до: руда - "..TRADERS[b_id].cash[1].." # фишки - "..TRADERS[b_id].cash[2].."/ кол-во предмета: "..TRADERS[b_id].items_value[itemSlot]);
					TRADERS[b_id].items_value[itemSlot] = TRADERS[b_id].items_value[itemSlot] - 1;
					GiveItem(id, item, 1);
					Player[id].rude_coins = Player[id].rude_coins - price;
					TRADERS[b_id].cash[2] = TRADERS[b_id].cash[2] + price;
					LogString("Logs/Traders/All","Баланс бота после: руда - "..TRADERS[b_id].cash[1].." # фишки - "..TRADERS[b_id].cash[2].."/ кол-во предмета: "..TRADERS[b_id].items_value[itemSlot]);
					-----------------------------------------
					local count = table.getn(TRADERS[b_id].items);
					local file = io.open(DIR_TRADERS..TRADERS_COUNT_LIST[b_id]..".txt", "w");
					file:write(TRADERS[b_id].owner.." "..TRADERS[b_id].cash[1].." "..TRADERS[b_id].cash[2].." "..TRADERS[b_id].pos[1].." "..TRADERS[b_id].pos[2]..
					" "..TRADERS[b_id].pos[3].." "..TRADERS[b_id].angle.." "..TRADERS[b_id].visual[1].." "..TRADERS[b_id].visual[2].." "..TRADERS[b_id].visual[3].." "..
					TRADERS[b_id].visual[4].." "..TRADERS[b_id].armor.."\n");
					if count > 0 then
						for i = 1, count do
							file:write(TRADERS[b_id].items[i].. " "..TRADERS[b_id].items_value[i].." "..TRADERS[b_id].items_price[i].." "..TRADERS[b_id].items_price_type[i].."\n");
						end
					end
					file:close();
					-----------------------------------------

					GameTextForPlayer(id, 500, 6000, "Куплено!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 1500);
					PlayPlayerSound(id, BUY_SOUND);
					SaveItems(id);
					SavePlayer(id);
					_tradersRefresh(id);
				else
					LogString("Logs/Traders/All",Player[id].nickname.." купил "..GetItemName(item).." x1 за "..price.." ("..price_type..") / Дата: "..rday.."."..rmonth.."."..ryear.." "..rhour..":"..rminute);
					LogString("Logs/Traders/All","Баланс бота до: руда - "..TRADERS[b_id].cash[1].." # фишки - "..TRADERS[b_id].cash[2].."/ кол-во предмета: "..TRADERS[b_id].items_value[itemSlot]);
					table.remove(TRADERS[b_id].items, itemSlot);
					table.remove(TRADERS[b_id].items_value, itemSlot);
					table.remove(TRADERS[b_id].items_price, itemSlot);
					table.remove(TRADERS[b_id].items_price_type, itemSlot);
					
					GiveItem(id, item, 1);
					Player[id].rude_coins = Player[id].rude_coins - price;
					TRADERS[b_id].cash[2] = TRADERS[b_id].cash[2] + price;
					LogString("Logs/Traders/All","Баланс бота после: руда - "..TRADERS[b_id].cash[1].." # фишки - "..TRADERS[b_id].cash[2].."/ кол-во предмета: 0");
					-----------------------------------------
					local count = table.getn(TRADERS[b_id].items);
					local file = io.open(DIR_TRADERS..TRADERS_COUNT_LIST[b_id]..".txt", "w");
					file:write(TRADERS[b_id].owner.." "..TRADERS[b_id].cash[1].." "..TRADERS[b_id].cash[2].." "..TRADERS[b_id].pos[1].." "..TRADERS[b_id].pos[2]..
					" "..TRADERS[b_id].pos[3].." "..TRADERS[b_id].angle.." "..TRADERS[b_id].visual[1].." "..TRADERS[b_id].visual[2].." "..TRADERS[b_id].visual[3].." "..
					TRADERS[b_id].visual[4].." "..TRADERS[b_id].armor.."\n");
					if count > 0 then
						for i = 1, count do
							file:write(TRADERS[b_id].items[i].. " "..TRADERS[b_id].items_value[i].." "..TRADERS[b_id].items_price[i].." "..TRADERS[b_id].items_price_type[i].."\n");
						end
					end
					file:close();
					-----------------------------------------

					GameTextForPlayer(id, 500, 6000, "Куплено!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 1500);
					PlayPlayerSound(id, BUY_SOUND);
					SaveItems(id);
					SavePlayer(id);
					_tradersRefresh(id);
				end
			else
				GameTextForPlayer(id, 200, 6000, "У вас мало средств.", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 1500);
			end


		elseif price_type == "р" or price_type == "Р" then
			if Player[id].rude >= price then
				if value > 1 then
					LogString("Logs/Traders/All",Player[id].nickname.." купил "..GetItemName(item).." x1 за "..price.." ("..price_type..") / Дата: "..rday.."."..rmonth.."."..ryear.." "..rhour..":"..rminute);
					LogString("Logs/Traders/All","Баланс бота до: руда - "..TRADERS[b_id].cash[1].." # фишки - "..TRADERS[b_id].cash[2].."/ кол-во предмета: "..TRADERS[b_id].items_value[itemSlot]);
					TRADERS[b_id].items_value[itemSlot] = TRADERS[b_id].items_value[itemSlot] - 1;
					GiveItem(id, item, 1);
					Player[id].rude = Player[id].rude - price;
					TRADERS[b_id].cash[1] = TRADERS[b_id].cash[1] + price;
					LogString("Logs/Traders/All","Баланс бота после: руда - "..TRADERS[b_id].cash[1].." # фишки - "..TRADERS[b_id].cash[2].."/ кол-во предмета: "..TRADERS[b_id].items_value[itemSlot]);
					-----------------------------------------
					local count = table.getn(TRADERS[b_id].items);
					local file = io.open(DIR_TRADERS..TRADERS_COUNT_LIST[b_id]..".txt", "w");
					file:write(TRADERS[b_id].owner.." "..TRADERS[b_id].cash[1].." "..TRADERS[b_id].cash[2].." "..TRADERS[b_id].pos[1].." "..TRADERS[b_id].pos[2]..
					" "..TRADERS[b_id].pos[3].." "..TRADERS[b_id].angle.." "..TRADERS[b_id].visual[1].." "..TRADERS[b_id].visual[2].." "..TRADERS[b_id].visual[3].." "..
					TRADERS[b_id].visual[4].." "..TRADERS[b_id].armor.."\n");
					if count > 0 then
						for i = 1, count do
							file:write(TRADERS[b_id].items[i].. " "..TRADERS[b_id].items_value[i].." "..TRADERS[b_id].items_price[i].." "..TRADERS[b_id].items_price_type[i].."\n");
						end
					end
					file:close();
					-----------------------------------------


					GameTextForPlayer(id, 500, 6000, "Куплено!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 1500);
					PlayPlayerSound(id, BUY_SOUND);
					SaveItems(id);
					SavePlayer(id);
					_tradersRefresh(id);
				else
					LogString("Logs/Traders/All",Player[id].nickname.." купил "..GetItemName(item).." x1 за "..price.." ("..price_type..") / Дата: "..rday.."."..rmonth.."."..ryear.." "..rhour..":"..rminute);
					LogString("Logs/Traders/All","Баланс бота до: руда - "..TRADERS[b_id].cash[1].." # фишки - "..TRADERS[b_id].cash[2].."/ кол-во предмета: "..TRADERS[b_id].items_value[itemSlot]);
					table.remove(TRADERS[b_id].items, itemSlot);
					table.remove(TRADERS[b_id].items_value, itemSlot);
					table.remove(TRADERS[b_id].items_price, itemSlot);
					table.remove(TRADERS[b_id].items_price_type, itemSlot);
					
					GiveItem(id, item, 1);
					Player[id].rude = Player[id].rude - price;
					TRADERS[b_id].cash[1] = TRADERS[b_id].cash[1] + price;
					LogString("Logs/Traders/All","Баланс бота после: руда - "..TRADERS[b_id].cash[1].." # фишки - "..TRADERS[b_id].cash[2].."/ кол-во предмета: 0");
					-----------------------------------------
					local count = table.getn(TRADERS[b_id].items);
					local file = io.open(DIR_TRADERS..TRADERS_COUNT_LIST[b_id]..".txt", "w");
					file:write(TRADERS[b_id].owner.." "..TRADERS[b_id].cash[1].." "..TRADERS[b_id].cash[2].." "..TRADERS[b_id].pos[1].." "..TRADERS[b_id].pos[2]..
					" "..TRADERS[b_id].pos[3].." "..TRADERS[b_id].angle.." "..TRADERS[b_id].visual[1].." "..TRADERS[b_id].visual[2].." "..TRADERS[b_id].visual[3].." "..
					TRADERS[b_id].visual[4].." "..TRADERS[b_id].armor.."\n");
					if count > 0 then
						for i = 1, count do
							file:write(TRADERS[b_id].items[i].. " "..TRADERS[b_id].items_value[i].." "..TRADERS[b_id].items_price[i].." "..TRADERS[b_id].items_price_type[i].."\n");
						end
					end
					file:close();
					-----------------------------------------

					GameTextForPlayer(id, 500, 6000, "Куплено!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 1500);
					PlayPlayerSound(id, BUY_SOUND);
					SaveItems(id);
					SavePlayer(id);
					_tradersRefresh(id);
				end
			else
				GameTextForPlayer(id, 200, 6000, "У вас мало средств.", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 1500);
			end
		end
	end
end

function _tradersMouse(id, button, pressed, posX, posY)

	if Player[id]._trader_menu == true then
		if button == MB_LEFT then
			if pressed == 0 then

				local b_id = nil;
				for i = 1, TRADERS_COUNT do
					if TRADERS[i].name == GetPlayerName(Player[id]._trader_bot[2]) then
						b_id = i;
						break
					end
				end

				for i = 1, 15 do
					if posX > ITEMS_IDS_XYZ_BUTT[i][1] and posX < ITEMS_IDS_XYZ_BUTT[i][2] and posY > ITEMS_IDS_XYZ_BUTT[i][3] and posY < ITEMS_IDS_XYZ_BUTT[i][4] then
						_tradersSelectSlot(id, i);
						break
					end
				end

				if posX > TRADERS_BUT_BUTTON[1] and posX < TRADERS_BUT_BUTTON[2] and posY > TRADERS_BUT_BUTTON[3] and posY < TRADERS_BUT_BUTTON[4] then
					if Player[id]._trader_select_id ~= nil then
						if TRADERS[b_id].owner ~= Player[id].nickname then
							_tradersBuyItem(id);
						elseif TRADERS[b_id].owner == Player[id].nickname then
							_tradersBackItem(id);
						end
					end
				end

			end
		end
	end

end


--[[createGUIMenu("TRADER_SETTING", {
	{ "1. Загрузить предметы." },
	{ "2. Назначить цены." },
	{ "3. Закрыть" },
    }, 150, 150, 150, 255, 255, 255, 5430, 3500, "Font_Old_20_White_Hi.TGA", CreateTexture(5295, 3365, 8130, 4440, 'menu_ingame'), 3);


function _tradersKeySetting(id, down, up)

	if Player[id].loggedIn == true and Player[id]._traders_settings[1] == true then

		if down == KEY_UP then
			switchGUIMenuUp(id, "TRADER_SETTING");
		end

		if down == KEY_DOWN then
			switchGUIMenuDown(id, "TRADER_SETTING");
		end

		if down == KEY_RETURN then

			if getPlayerOptionID(id, "TRADER_SETTING") == 1 then
				_tradersLoadItems(id);
			
			elseif getPlayerOptionID(id, "TRADER_SETTING") == 2 then
				SendPlayerMessage(id, 255, 255, 255, "2");

			elseif  getPlayerOptionID(id, "TRADER_SETTING") == 3 then
				hideGUIMenu(id, "TRADER_SETTING");
				UnFreeze(id);
				FreezeCamera(id, 0);
				local b_id = Player[id]._traders_settings[2];
				TRADERS[b_id].busy = false;
				Player[id]._traders_settings = {false, nil};
			end
		end

	end

end

function _tradersSetting(id, sets)

	if Player[id].loggedIn == true then
		if Player[id]._traders_settings[1] == false then
			local result, botid = sscanf(sets, "d");
			if result == 1 then
				for i = 1, TRADERS_COUNT do
					if TRADERS[i].bot_id == botid then
						if TRADERS[i].owner == Player[id].nickname then
							if TRADERS[i].busy == true then
								SendPlayerMessage(id, 255, 255, 255, "Бот сейчас занят другим игроком.")
							else
								TRADERS[i].busy = true;
								showGUIMenu(id, "TRADER_SETTING");
								Freeze(id);
								FreezeCamera(id, 1);
								SendPlayerMessage(id, 255, 255, 255, "Вы открыли меню управления ботом.");
								Player[id]._traders_settings = {true, i};
							end
							break
						else
							SendPlayerMessage(id, 255, 255, 255, "Вы не являетесь управляющим этим ботом.");
						end
					end
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "/упр_бот (бот ид).")
			end
		end
	end
end
addCommandHandler({"/упр_бот", "/set_bot"}, _tradersSetting);


function _tradersLoadItems(id)

	if Player[id]._traders_settings[1] == true then

		for i = 1, table.getn(Player[id]._traders_settings_tex) do
			ShowTexture(id, Player[id]._traders_settings_tex[i]);
		end

		for i = 1, table.getn(Player[id]._traders_settings_draws_item) do
			ShowPlayerDraw(id, Player[id]._traders_settings_draws_item[i]);
		end


		local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
		for line in file:lines() do
			local result, item, value = sscanf(line, "sd");
			if result == 1 then
				table.insert(Player[id]._traders_my_items, item);
				table.insert(Player[id]._traders_my_items_value, value);
			end
		end
		file:close();

		if table.getn(Player[id]._traders_my_items) > 0 then
			Player[id]._traders_my_items_select = 1;
			UpdatePlayerDraw(id, Player[id]._traders_settings_draws_item[1], 2770, 5635, GetItemName(Player[id]._traders_my_items[1]), "Font_Old_10_White_Hi.TGA", 255, 255, 255); 
			UpdatePlayerDraw(id, Player[id]._traders_settings_draws_item[2], 2770, 5885, Player[id]._traders_my_items[1], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end

	end

end]]

function _tradersPaydayAdmin(id, sets)

	if Player[id].loggedIn == true then
		local result, botid, amount, price_type = sscanf(sets, "dds");
		if result == 1 then
			local b_id = nil;
			for i = 1, TRADERS_COUNT do
				if TRADERS[i].bot_id == botid then
					if Player[id].astatus > 3 then
						if TRADERS[i].busy == true then
							SendPlayerMessage(id, 255, 255, 255, "Бот сейчас занят другим игроком.")
						else
							b_id = i;
							break
						end
					end
				end
			end

			if b_id ~= nil then
				if amount > 0 then
					if price_type == "р" or price_type == "Р" then
						if TRADERS[b_id].cash[1] >= amount then
							TRADERS[b_id].cash[1] = TRADERS[b_id].cash[1] - amount;
							Player[id].rude = Player[id].rude + amount;
							SavePlayer(id);
							SendPlayerMessage(id, 255, 255, 255, "Вы забрали "..amount.." руды у торговца.")
							local count = table.getn(TRADERS[b_id].items);
							local file = io.open(DIR_TRADERS..TRADERS_COUNT_LIST[b_id]..".txt", "w");
							file:write(TRADERS[b_id].owner.." "..TRADERS[b_id].cash[1].." "..TRADERS[b_id].cash[2].." "..TRADERS[b_id].pos[1].." "..TRADERS[b_id].pos[2]..
							" "..TRADERS[b_id].pos[3].." "..TRADERS[b_id].angle.." "..TRADERS[b_id].visual[1].." "..TRADERS[b_id].visual[2].." "..TRADERS[b_id].visual[3].." "..
							TRADERS[b_id].visual[4].." "..TRADERS[b_id].armor.."\n");
							if count > 0 then
								for i = 1, count do
									file:write(TRADERS[b_id].items[i].. " "..TRADERS[b_id].items_value[i].." "..TRADERS[b_id].items_price[i].." "..TRADERS[b_id].items_price_type[i].."\n");
								end
							end
							file:close();
						else
							SendPlayerMessage(id, 255, 255, 255, "У торговца нет столько руды.")
						end

					elseif price_type == "ф" or price_type == "Ф" then
						if TRADERS[b_id].cash[2] >= amount then
							TRADERS[b_id].cash[2] = TRADERS[b_id].cash[2] - amount;
							Player[id].rude_coins = Player[id].rude_coins + amount;
							SavePlayer(id);
							SendPlayerMessage(id, 255, 255, 255, "Вы забрали "..amount.." фишек у торговца.")
							local count = table.getn(TRADERS[b_id].items);
							local file = io.open(DIR_TRADERS..TRADERS_COUNT_LIST[b_id]..".txt", "w");
							file:write(TRADERS[b_id].owner.." "..TRADERS[b_id].cash[1].." "..TRADERS[b_id].cash[2].." "..TRADERS[b_id].pos[1].." "..TRADERS[b_id].pos[2]..
							" "..TRADERS[b_id].pos[3].." "..TRADERS[b_id].angle.." "..TRADERS[b_id].visual[1].." "..TRADERS[b_id].visual[2].." "..TRADERS[b_id].visual[3].." "..
							TRADERS[b_id].visual[4].." "..TRADERS[b_id].armor.."\n");
							if count > 0 then
								for i = 1, count do
									file:write(TRADERS[b_id].items[i].. " "..TRADERS[b_id].items_value[i].." "..TRADERS[b_id].items_price[i].." "..TRADERS[b_id].items_price_type[i].."\n");
								end
							end
							file:close();
						else
							SendPlayerMessage(id, 255, 255, 255, "У торговца нет столько фишек.")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "Неверно указан тип валюты. Указано: ("..price_type..") / Правильно: (Р), (р) или (Ф), (ф) -- без скобок.")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Нельзя указывать значения ниже 1.")
				end
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/а_бот_прибыль (бот ид) (кол-во) (тип валюты). ")
		end
	end
end
addCommandHandler({"/а_бот_прибыль"}, _tradersPaydayAdmin);

function _tradersPayday(id, sets)

	if Player[id].loggedIn == true then
		local result, botid = sscanf(sets, "d");
		if result == 1 then
			local b_id = nil;
			for i = 1, TRADERS_COUNT do
				if TRADERS[i].bot_id == botid then
					if TRADERS[i].owner == Player[id].nickname then
						if TRADERS[i].busy == true then
							SendPlayerMessage(id, 255, 255, 255, "Бот сейчас занят другим игроком.")
						else
							b_id = i;
							break
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "Вы не являетесь управляющим этим ботом.");
					end
				end
			end

			if b_id ~= nil then
				Player[id].rude = Player[id].rude + TRADERS[b_id].cash[1];
				Player[id].rude_coins = Player[id].rude_coins + TRADERS[b_id].cash[2];
				SavePlayer(id);

				SendPlayerMessage(id, 255, 255, 255, "Вы забрали "..TRADERS[b_id].cash[1].." руды у торговца.")
				SendPlayerMessage(id, 255, 255, 255, "Вы забрали "..TRADERS[b_id].cash[2].." фишек у торговца.")

				TRADERS[b_id].cash[1] = 0;
				TRADERS[b_id].cash[2] = 0;
				--------------------------------------
				local count = table.getn(TRADERS[b_id].items);
				local file = io.open(DIR_TRADERS..TRADERS_COUNT_LIST[b_id]..".txt", "w");
				file:write(TRADERS[b_id].owner.." "..TRADERS[b_id].cash[1].." "..TRADERS[b_id].cash[2].." "..TRADERS[b_id].pos[1].." "..TRADERS[b_id].pos[2]..
				" "..TRADERS[b_id].pos[3].." "..TRADERS[b_id].angle.." "..TRADERS[b_id].visual[1].." "..TRADERS[b_id].visual[2].." "..TRADERS[b_id].visual[3].." "..
				TRADERS[b_id].visual[4].." "..TRADERS[b_id].armor.."\n");
				if count > 0 then
					for i = 1, count do
						file:write(TRADERS[b_id].items[i].. " "..TRADERS[b_id].items_value[i].." "..TRADERS[b_id].items_price[i].." "..TRADERS[b_id].items_price_type[i].."\n");
					end
				end
				file:close();
				--------------------------------------
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/упр_бот_прибыль (бот ид)")
		end
	end
end
addCommandHandler({"/упр_бот_прибыль"}, _tradersPayday);

function _tradersPlusItems(id, sets)

	if Player[id].loggedIn == true then
		local result, botid, slot, amount, price, price_type = sscanf(sets, "dddds");
		if result == 1 then
			if price_type == "р" or price_type == "Р" or price_type == "ф" or price_type == "Ф" then
				local b_id = nil;
				for i = 1, TRADERS_COUNT do
					if TRADERS[i].bot_id == botid then
						if TRADERS[i].owner == Player[id].nickname then
							if TRADERS[i].busy == true then
								SendPlayerMessage(id, 255, 255, 255, "Бот сейчас занят другим игроком.")
							else
								b_id = i;
								TRADERS[b_id].busy = true;
								break
							end
						else
							SendPlayerMessage(id, 255, 255, 255, "Вы не являетесь управляющим этим ботом.");
						end
					end
				end

				if b_id ~= nil then
					Player[id]._traders_my = true;
					Player[id]._traders_my_value = amount;
					Player[id]._traders_my_botid = b_id;
					Player[id]._traders_my_price = price;
					Player[id]._traders_my_price_type = price_type;
					GetPlayerItem(id, slot);
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Неверно указан тип валюты. Указано: ("..price_type..") / Правильно: (Р), (р) или (Ф), (ф) -- без скобок.")
				if b_id ~= nil then
					TRADERS[b_id].busy = false;
				end
			end

		else
			SendPlayerMessage(id, 255, 255, 255, "/упр_бот (бот ид) (слот с 0) (кол-во) (цена) (валюта). ")
		end
	end


end
addCommandHandler({"/упр_бот", "/set_bot"}, _tradersPlusItems);

function _tradersResponse(id, slot, itemInstance, amount, equipped)

	if Player[id]._traders_my == true then
		local b_id = Player[id]._traders_my_botid;
		if itemInstance ~= "NULL" then
			if Player[id]._traders_my_value <= amount then

				local status = false;

				if table.getn(TRADERS[b_id].items) > 0 then

					for i = 1, table.getn(TRADERS[b_id].items) do
						if TRADERS[b_id].items[i] == string.upper(itemInstance) then

							TRADERS[b_id].items_value[i] = TRADERS[b_id].items_value[i] + Player[id]._traders_my_value;
							TRADERS[b_id].items_price[i] = Player[id]._traders_my_price; 
							TRADERS[b_id].items_price_type[i] = string.lower(Player[id]._traders_my_price_type);

							RemoveItem(id, string.upper(itemInstance), Player[id]._traders_my_value);
							SaveItems(id);
							SendPlayerMessage(id, 255, 255, 255, "Добавлено: "..GetItemName(itemInstance).." в кол-ве "..Player[id]._traders_my_value.." по цене "..Player[id]._traders_my_price.." "..string.lower(Player[id]._traders_my_price_type)..".");
							------------------------------------------------------------------
							local count = table.getn(TRADERS[b_id].items);
							local file = io.open(DIR_TRADERS..TRADERS_COUNT_LIST[b_id]..".txt", "w");
							file:write(TRADERS[b_id].owner.." "..TRADERS[b_id].cash[1].." "..TRADERS[b_id].cash[2].." "..TRADERS[b_id].pos[1].." "..TRADERS[b_id].pos[2]..
							" "..TRADERS[b_id].pos[3].." "..TRADERS[b_id].angle.." "..TRADERS[b_id].visual[1].." "..TRADERS[b_id].visual[2].." "..TRADERS[b_id].visual[3].." "..
							TRADERS[b_id].visual[4].." "..TRADERS[b_id].armor.."\n");
							if count > 0 then
								for i = 1, count do
									file:write(TRADERS[b_id].items[i].. " "..TRADERS[b_id].items_value[i].." "..TRADERS[b_id].items_price[i].." "..TRADERS[b_id].items_price_type[i].."\n");
								end
							end
							file:close();
							Player[id]._traders_my = false;
							Player[id]._traders_my_value = nil;
							Player[id]._traders_my_botid = nil;
							Player[id]._traders_my_price = nil;
							Player[id]._traders_my_price_type = nil;
							------------------------------------------------------------------
							TRADERS[b_id].busy = false;
							status = true;
							break
						end
					end

					if status == false then
						if table.getn(TRADERS[b_id].items) < 15 then
							table.insert(TRADERS[b_id].items, itemInstance);
							table.insert(TRADERS[b_id].items_value, Player[id]._traders_my_value);
							table.insert(TRADERS[b_id].items_price, Player[id]._traders_my_price);
							table.insert(TRADERS[b_id].items_price_type, string.lower(Player[id]._traders_my_price_type));
							SendPlayerMessage(id, 255, 255, 255, "Добавлено: "..GetItemName(itemInstance).." в кол-ве "..Player[id]._traders_my_value.." по цене "..Player[id]._traders_my_price.." "..string.lower(Player[id]._traders_my_price_type)..".");
							TRADERS[b_id].busy = false;
							RemoveItem(id, string.upper(itemInstance), Player[id]._traders_my_value);
							SaveItems(id);
							------------------------------------------------------------------
							local count = table.getn(TRADERS[b_id].items);
							local file = io.open(DIR_TRADERS..TRADERS_COUNT_LIST[b_id]..".txt", "w");
							file:write(TRADERS[b_id].owner.." "..TRADERS[b_id].cash[1].." "..TRADERS[b_id].cash[2].." "..TRADERS[b_id].pos[1].." "..TRADERS[b_id].pos[2]..
							" "..TRADERS[b_id].pos[3].." "..TRADERS[b_id].angle.." "..TRADERS[b_id].visual[1].." "..TRADERS[b_id].visual[2].." "..TRADERS[b_id].visual[3].." "..
							TRADERS[b_id].visual[4].." "..TRADERS[b_id].armor.."\n");
							if count > 0 then
								for i = 1, count do
									file:write(TRADERS[b_id].items[i].. " "..TRADERS[b_id].items_value[i].." "..TRADERS[b_id].items_price[i].." "..TRADERS[b_id].items_price_type[i].."\n");
								end
							end
							file:close();
							Player[id]._traders_my = false;
							Player[id]._traders_my_value = nil;
							Player[id]._traders_my_botid = nil;
							Player[id]._traders_my_price = nil;
							Player[id]._traders_my_price_type = nil;
							------------------------------------------------------------------
						else
							SendPlayerMessage(id, 255, 255, 255, "Бот переполнен (предел - 15 товаров).")
						end
					end
				else
					table.insert(TRADERS[b_id].items, itemInstance);
					table.insert(TRADERS[b_id].items_value, Player[id]._traders_my_value);
					table.insert(TRADERS[b_id].items_price, Player[id]._traders_my_price);
					table.insert(TRADERS[b_id].items_price_type, string.lower(Player[id]._traders_my_price_type));
					SendPlayerMessage(id, 255, 255, 255, "Добавлено: "..GetItemName(itemInstance).." в кол-ве "..Player[id]._traders_my_value.." по цене "..Player[id]._traders_my_price.." "..string.lower(Player[id]._traders_my_price_type)..".");
					TRADERS[b_id].busy = false;
					RemoveItem(id, string.upper(itemInstance), Player[id]._traders_my_value);
					SaveItems(id);
					------------------------------------------------------------------
					local count = table.getn(TRADERS[b_id].items);
					local file = io.open(DIR_TRADERS..TRADERS_COUNT_LIST[b_id]..".txt", "w");
					file:write(TRADERS[b_id].owner.." "..TRADERS[b_id].cash[1].." "..TRADERS[b_id].cash[2].." "..TRADERS[b_id].pos[1].." "..TRADERS[b_id].pos[2]..
					" "..TRADERS[b_id].pos[3].." "..TRADERS[b_id].angle.." "..TRADERS[b_id].visual[1].." "..TRADERS[b_id].visual[2].." "..TRADERS[b_id].visual[3].." "..
					TRADERS[b_id].visual[4].." "..TRADERS[b_id].armor.."\n");
					if count > 0 then
						for i = 1, count do
							file:write(TRADERS[b_id].items[i].. " "..TRADERS[b_id].items_value[i].." "..TRADERS[b_id].items_price[i].." "..TRADERS[b_id].items_price_type[i].."\n");
						end
					end
					file:close();
					Player[id]._traders_my = false;
					Player[id]._traders_my_value = nil;
					Player[id]._traders_my_botid = nil;
					Player[id]._traders_my_price = nil;
					Player[id]._traders_my_price_type = nil;
					------------------------------------------------------------------
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "У вас нет такого количества предмета.")
				TRADERS[b_id].busy = false;
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "Неверно выбран слот.")
			TRADERS[b_id].busy = false;
		end
	end
end