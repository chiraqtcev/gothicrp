function random(arg)
	return math.random(arg);
end

function Freeze(arg)
	return FreezePlayer(arg, 1);
end

function UnFreeze(arg)
	return FreezePlayer(arg, 0);
end

-- vars
require "gamemodes/global_var"

-- Bimbol
require "Bimbol Engine/require"
gui_Init(true);
ai_Init(true);

-- Stats info
require "modules/additional_stats"
require "modules/LogCraft/log_craft"

-- Reg/Log
require "modules/Registration/Registration"
require "modules/Login/Login"

-- Macroses
require "modules/macros"

-- Player
require "modules/Player/PlayerScructure"
require "modules/Player/ButtonsXYZ"
require "modules/Player/draws"

-- Saves
require "modules/Saves/SavePlayer"
require "modules/Saves/SaveStats"
require "modules/Saves/SaveItems"
require "modules/Saves/SaveSkill"
require "modules/Saves/SaveMYSQL"

-- CMDs
require "modules/CMDs/cmds"
require "modules/CMDs/cmdschats"
require "modules/CMDs/cmdsadmin"
require "modules/CMDs/inst"
require "modules/CMDs/anims"


-- Time
require "modules/Time/gametime"

-- Bots
require "modules/Bots/CreateBots"
require "modules/Bots/Bots"
require "modules/Bots/OBDialogs"

-- Mine
require "modules/Mine/mine"
require "modules/Mine/sheeps"
require "modules/Mine/fishing"

-- Energy
require "modules/Energy/energy"

-- Arena
require "modules/Stats Up/statsup"

-- Craft
require "modules/Craft/minecraft"

-- RPINV
require "modules/Inventory RP/rpinventory_dis"

-- Anim Bots
require "modules/AnimBot/setanimbot"

-- AI Bots
require "modules/Bots/BE_Bots"

-- Hunting
require "modules/Hunting/Hunting"

-- Board
require "modules/Board/Board"

-- Handscript
require "modules/Handscript_Inventory/handscript"
require "modules/Handscript_Inventory/inventory"

-- Admin logs
require "modules/Logs/a_logs"

-- Zones
require "modules/Zones/zones"

-- Map (Osmith)
require "modules/Map/map"

-- Games
require "modules/Games/game_21"
require "modules/Games/poker"

-- Regeneration HP (bed)
require "modules/Regeneration/Regeneration"

-- Language
require "modules/Language/Language"

-- Skinset
require "modules/Skinset/skinset"

-- Traders
require "modules/Traders/Traders"

-- Hud
require "modules/Hud/Hud"

-- Wiki
require "modules/Wiki/Wiki"

-- Mac
require "modules/Mac/Mac"

-- Hero info
require "modules/Hero Info/Hero Info"

-- Players info
require "modules/Players info/Players info"

-- Warn
require "modules/Warn/Warn"

-- Info about player
require "modules/Info/Info"

-- Heroes
require "modules/Hero/Hero"

-- Animation on chat
require "modules/AnimText/AnimText"

-- Workers
require "modules/Workers/Workers"

-- AC
require "modules/Anti-cheat/ac_items"
require "modules/Anti-cheat/ac_att"

-- Chest
require "modules/Chest/Chest"

-- Vobber
require "modules/Vobber/Vobber"


--#################################################

function ClearChat(playerid)
	for i = 0, 50 do
		SendPlayerMessage(playerid, 1, 1, 1, " ");
	end
end
addCommandHandler({"/clear", "/очистить"}, ClearChat);

function _saverPlayers()

	-- Периодический сейвер всех подключенных игроков.
	-- by royclapton

	local time = os.date('*t');
	local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local count = 0; local tempArr = {};
	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true and IsPlayerConnected(i) == 1 and IsNPC(i) == 0 and GetPlayerInstance(i) == "PC_HERO" then
			count = count + 1; table.insert(tempArr, Player[i].nickname);
			SavePlayer(i);
			SaveStats(i);
			SaveItems(i);
		end
	end

	if table.getn(tempArr) > 0 then
		LogString("Logs/Server/Saves", "Все подключенные аккаунты сохранены. Список аккаунтов: "..count);
		LogString("Logs/Server/Saves", "Дата: ("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."). Список игроков:");
		for _, v in pairs(tempArr) do
			LogString("Logs/Server/Saves", v);
		end
	end

end


function BE_OnGamemodeInit()
	math.randomseed(os.time()); -- радомайзер на основе времени железа
	EnableChat(0); -- глобальное использование чата
	OpenLocks(0); -- открыть закрытое (двери, сундуки). НА ЗАПУСКЕ ПОМЕНЯТЬ НА 0 !!!
	Enable_OnPlayerKey(1); -- функция, включающая использование кнопок через OnPlayerKey
	EnableExitGame(0); -- вкл/выкл выхода через ESC
	-- SetBarrier(10000000000, 10, 45, 5); -- барьер
	EnableNickname(1); -- ники над головами.
	EnableNicknameID(0); -- айдишники в нике

	SetGamemodeName("RPC v.1.0"); -- игровой мод
	SetServerDescription("Roleplay Corner\nVK: vk.com/roleplaycorner\nDiscord: discord.com/invite/ESE4EdqyJj"); -- описание сервера

	-- SetWeather(int weather, int lightning, int startHour, int startMinute, int endHour, int endMinute) -- 1 - rain - 2 snow - 0 nil
	-- SetWeather(1, 0, 14, 30, 14, 40)

	-- нпс
	OtherNPC();
	NCInit();

	-- мобы
	InitMobs();
	SpawnMobs();
	_readNewBots();

	-- крафты?
	InitCraftList();

	-- доски
	_initBoard();

	-- handscript / inv
	InitInventTexture();
	InitHandscripts();

	-- osmith map
	_InitMap();
	
	-- traders
	_initTraders();
	
	-- hunting timer
	SetTimer(_timerHunting, 2000, 1);

	-- wiki
	_wikiInit();


	-- mac
	_macForumInit();

	-- sheeps
	_sheepsSpawn();

	-- blocks
	_initBlocks();

	-- saver
	SetTimer(_saverPlayers, 600000, 1);

	-- heroes
	_heroInit();

	-- workers
	_initWorkers();

	-- chests
	_initChest();
	
	-- poker
	_poker_textureSlots();
	
	-- energy
	_initEnergy();

	init_MySQL("localhost", "root", "root", "gothic");

end
ai_Init(true);

function OnPlayerTriggerMob(playerid, scheme, objectName, trigger)
	_board(playerid, scheme, objectName, trigger);
	_onBed(playerid, scheme, objectName, trigger);
	_useChest(playerid, scheme, objectName, trigger);
end

function OnPlayerResponseItem(playerid, slot, itemInstance, amount, equipped)
	
	_tradersResponse(playerid, slot, itemInstance, amount, equipped);
	_ac_Response(playerid, slot, itemInstance, amount, equipped);

	if Player[playerid].drop == true and Player[playerid].chest_id == 0 then
		DropItem(playerid, itemInstance, Player[playerid].amounts);
		Player[playerid].drop = false;
	end

end


function LockShowChat(playerid, toggle)

	if toggle == true then
		Player[playerid].showchat = true;
		ShowChat(playerid, 1);
	else
		Player[playerid].showchat = false;
		ShowChat(playerid, 0);
	end

end


function LoadingLogin(playerid)

	local file = io.open("Database/Players/Profiles/"..GetPlayerName(playerid)..".txt", "r+");
	if file then
		Player[playerid].timerconnect = SetTimerEx("SL", 3000, 0, playerid);
		ShowPlayerDraw(playerid, reglogPODSKAZOCHKA);
		file:close();
	else
		Player[playerid].timerconnect = SetTimerEx("SR", 3000, 0, playerid);
		ShowPlayerDraw(playerid, reglogPODSKAZOCHKA);
	end

end

function OnPlayerOpenInventory(playerid)

	_ac_openInventory(playerid);

	if Player[playerid].chest_id ~= 0 then
		CloseInventory(playerid);
	end

	if Player[playerid].onGUI == true then
		CloseInventory(playerid);
	end
end


-- function OnPlayerMD5File(playerid, pathFile, hash)
-- 	if pathFile == "Data\\ToM_Anims.VDF" then
-- 		if hash ~= "906fe56101b23f929eeee4deb40c6397" then
-- 			ShowChat(playerid, 1);
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Обнаружен некорректная версия файла 'ToM_Anims.VDF'.")
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Пожалуйста, скачайте свежую версию игрового ресурс-пака с нашего форума.")
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Ссылка: gothic2online.ru")
-- 			Kick(playerid);
-- 		end

-- 	elseif pathFile == "Data\\ToM_Meshes.VDF" then
-- 		if hash ~= "85ae59780ab1bfa7b282cf7bd458bcc6" then
-- 			ShowChat(playerid, 1);
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Обнаружен некорректная версия файла 'ToM_Meshes.VDF'.")
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Пожалуйста, скачайте свежую версию игрового ресурс-пака с нашего форума.")
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Ссылка: gothic2online.ru")
-- 			Kick(playerid);
-- 		end

-- 	elseif pathFile == "Data\\ToM_Scripts.VDF" then
-- 		if hash ~= "01d019310fa2542a8f9c32010efdf8f3" then
-- 			ShowChat(playerid, 1);
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Обнаружен некорректная версия файла 'ToM_Scripts.VDF'.")
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Пожалуйста, скачайте свежую версию игрового ресурс-пака с нашего форума.")
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Ссылка: gothic2online.ru")
-- 			Kick(playerid);
-- 		end

-- 	elseif pathFile == "Data\\ToM_Sounds.VDF" then
-- 		if hash ~= "12df9cc148b0ced917bf2d7a3b011ad5" then
-- 			ShowChat(playerid, 1);
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Обнаружен некорректная версия файла 'ToM_Sounds.VDF'.")
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Пожалуйста, скачайте свежую версию игрового ресурс-пака с нашего форума.")
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Ссылка: gothic2online.ru")
-- 			Kick(playerid);
-- 		end

-- 	elseif pathFile == "Data\\ToM_Textures.VDF" then
-- 		if hash ~= "d0c6552fd1dcf4684bc5c73362b1e3f3" then
-- 			ShowChat(playerid, 1);
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Обнаружен некорректная версия файла 'ToM_Textures.VDF'.")
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Пожалуйста, скачайте свежую версию игрового ресурс-пака с нашего форума.")
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Ссылка: gothic2online.ru")
-- 			Kick(playerid);
-- 		end

-- 	elseif pathFile == "Data\\ToM_Worlds.VDF" then
-- 		if hash ~= "d1120dddb5f71049ccdc0a2919176013" then
-- 			ShowChat(playerid, 1);
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Обнаружен некорректная версия файла 'ToM_Worlds.VDF'.")
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Пожалуйста, скачайте свежую версию игрового ресурс-пака с нашего форума.")
-- 			SendPlayerMessage(playerid, 255, 255, 255, "(SERVER) Ссылка: gothic2online.ru")
-- 			Kick(playerid);
-- 		end
-- 	end
-- end

local bad_symbols = {"1", "2", "3,", "4", "5", "6", "7", "8", "9", "0", "?"}
function BE_OnPlayerConnect(playerid)

	if IsNPC(playerid) == 0 then
	
		
		local name = GetPlayerName(playerid);
		local result = string.find(name, " ");
		
		if name == "Nickname" then
			SEM(playerid, "Данный никнейм запрещен.");
			Kick(playerid);
		end

		if result then
			SEM(playerid, "В нике не должно быть пробелов.");
			Kick(playerid);
		else

			for _, v in pairs(bad_symbols) do
				local bad = tostring(v);
				if string.find(name, bad) then
					SEM(playerid, "Обнаружены запрещенные символы в нике.")
					Kick(playerid);
					break
				end
			end
			EnablePlayerPlayerlist(playerid, 0)
			_checkMac(playerid);

			GetMD5File(playerid, "Data\\ToM_Anims.VDF");
			GetMD5File(playerid, "Data\\ToM_Meshes.VDF");
			GetMD5File(playerid, "Data\\ToM_Scripts.VDF");
			GetMD5File(playerid, "Data\\ToM_Sounds.VDF");
			GetMD5File(playerid, "Data\\ToM_Textures.VDF");
			GetMD5File(playerid, "Data\\ToM_Worlds.VDF");

			_playersInfoCheckConnectsDisconnects(playerid);
			SetPlayerInstance(playerid, "PC_HERO")
			SetPlayerWorld(playerid, "RPCORNER_KHORINIS.ZEN")
			SetPlayerVirtualWorld(playerid, math.random(300,700));

			-- Warn
			Player[playerid].warns = 0;

			-- AFK
			Player[playerid].afk = false;
			Player[playerid].afkdraw = CreatePlayerDraw(playerid, 0, 0, "");

			-- hand-inv
			Player[playerid].onGUI = false;

			-- fat
			Player[playerid].fatness = 0.0;

			-- info_me
			Player[playerid].meinfo = " ";
			Player[playerid].medraw = nil; Player[playerid].medraw = CreatePlayerDraw(playerid, 0, 0, "");
			Player[playerid].namedraw = nil; Player[playerid].namedraw = CreatePlayerDraw(playerid, 0, 0, "");
			
			-- PM
			Player[playerid].blockpm = false;
			Player[playerid].stalkerpm = false;

			-- admin chat
			Player[playerid].adminchat = true;

			-- mass draws
			DrawInit(playerid);
					
			-- board
			_boardPlayer(playerid);

			-- map osmith
			_playerMap(playerid);

			-- craft log
			_logVar(playerid);

			-- use bed for regen
			_onBedConnect(playerid);

			-- traders
			_tradersConnect(playerid);

			-- languages
			_languageConnect(playerid);

			-- hunting
			_huntingConnect(playerid);

			-- hud
			_hudConnect(playerid);

			-- games
			_21game_var(playerid);
			_pokerConnect(playerid);

			-- wiki
			_wikiConnect(playerid);

			-- sheep
			_sheepConnect(playerid);
			
			-- hero info
			_heroInfoConnect(playerid);
			
			-- players info
			_playersInfoConnect(playerid);

			-- hero-system
			_aHeroConnect(playerid);

			-- enable nickname
			Player[playerid].tnickname = false;
			EnablePlayerNickname(playerid, 1);

			-- Craft Levels
			_craftExpSkillConnect(playerid);

			-- Workers
			_workersConnect(playerid);

			-- AC
			_ac_connect(playerid);
			_ac_att_connect(playerid);

			-- chests
			_chestConnect(playerid);

			-- new stats
			_newStatsConnect(playerid);


			-- for player-orc
			Player[playerid].areorc = 0;

			-- inst
			Player[playerid].IsInstance = false;

			-- mine
			Player[playerid].zero_size_f = 3017;
			Player[playerid].start_size_f = 5191;
			Player[playerid].current_size_f = 5191;
			Player[playerid].prog_background_f = CreateTexture(2565, 7045, 5619, 7625, 'PROGRESS_BLUE')
			Player[playerid].prog_f = CreateTexture(3007, 7283, Player[playerid].start_size_f, 7469, 'PROGRESS_BLUE_BAR')
			Player[playerid].prog_timer = nil;

			-- rp inventory #1
			Player[playerid].openinv = false;
			Player[playerid].rpinventory = {};
			Player[playerid].rpinventory_amount = {};
			Player[playerid].rpinventory_slot = nil;
			Player[playerid].rpinventory_final = false;

			-- skills
			Player[playerid].readscrolls = 0;

			-- Bot_AI
			Player[playerid].inviseforbots = false;

			-- mask
			Player[playerid].masked = false;

			-- admin
			Player[playerid].invise = false;

			-- tag
			Player[playerid].zvanie = nil;

			-- res
			Player[playerid].mine = 0;
			Player[playerid].wood = 0;
			Player[playerid].iron = 0;

			-- cur. zone
			Player[playerid].zone = {false, false};
		
			-- energy(stamina) -- полоска
			Player[playerid].energy = 100;
			Player[playerid].energyblock = 0;
			Player[playerid].energydate = 0;
			Player[playerid].energybar = {};
			Player[playerid].energybar_x = 1099;
			Player[playerid].energybar[1] = CreateTexture(74, 7592, Player[playerid].energybar_x, 7809, 'BAR1');
			Player[playerid].eBar = false;

			-- xz.
			Player[playerid].openstatspanel = false;

			-- craft #1 - старое
			Player[playerid].opencraft = false;
			Player[playerid].craftpage = 0;
			Player[playerid].selectcraftitem = 0;
			Player[playerid].craftlevel = {1, 2, 3}; -- [1] - smith, [2] - alchemy, [3] - wood
			Player[playerid].craftexp = {0, 0, 0};

			-- craft #2 
			Player[playerid].nEXP = 0;

			-- player
			Player[playerid].nickname = GetPlayerName(playerid);
			Player[playerid].password = "";
			Player[playerid].astatus = 0;
			Player[playerid].loggedIn = false;
			Player[playerid].lastplay_data = "";
			Player[playerid].overlay = "";
			Player[playerid].skin = {};


			-- money
			Player[playerid].rude_coins = 0;
			Player[playerid].rude = 0;

			-- stats
			Player[playerid].h1 = 10;
			Player[playerid].h2 = 10;
			Player[playerid].bow = 10;
			Player[playerid].cbow = 10;
			Player[playerid].hp = 300;
			Player[playerid].chp = 300;
			Player[playerid].mp = 0;
			Player[playerid].cmp = 0;
			Player[playerid].currenthp = 300;
			Player[playerid].str = 10;
			Player[playerid].dex = 10;
			Player[playerid].mag = 0;

			-- other
			Player[playerid].menuopen = 0;
			Player[playerid].showchat = true;
			Player[playerid].vobtimer = nil;
			Player[playerid].enterreg = false;
			Player[playerid].enterlog = false;
			Player[playerid].logconnect = false;
			Player[playerid].rdy = false;
			Player[playerid].stepone = false;
			Player[playerid].steptwo = false;
			Player[playerid].stepthree = false;
			Player[playerid].regclass = 0;
			Player[playerid].animtimer = nil;
			Player[playerid].exittimer = nil;
			Player[playerid].aduty = false;
			Player[playerid].ahide = false;
			Player[playerid].defclick = 0;
			Player[playerid].dlg = false;
			Player[playerid].campos = 0;
			Player[playerid].statsmenu = false;
			Player[playerid].hOldHP = 10;

			-- food
			Player[playerid].food = 100;
			Player[playerid].dead = 0;

			SetTimerEx("LoadingLogin", 3000, 0, playerid);
			SpawnPlayer(playerid);
			--LockShowChat(playerid, false); 
			ShowChat(playerid, 0);
			SSM(playerid, "Добро пожаловать, "..GetPlayerName(playerid).."!");
			SYNM(playerid, "Используйте 'F7', чтобы открыть справочник.");

		end

	end

end


function SR(playerid)
	Player[playerid].enterreg = true;
	Player[playerid].logconnect = false;
	ShowRegister(playerid);
end

function SL(playerid)
	Player[playerid].enterlog = true;
	Player[playerid].logconnect = true;
	ShowLogin(playerid);
end

function BE_OnPlayerDisconnect(playerid, reason)
    
	_playersInfoCheckConnectsDisconnects(playerid);

   if IsNPC(playerid) == 0 then

  	 	for i, v in pairs(HEROES_LIST_ACTIVE) do
			if v == Player[playerid].hero_use[2] then
				table.remove(HEROES_LIST_ACTIVE, i);
			end
		end

		if Player[playerid].loggedIn == true then
			if Player[playerid].animtimer ~= nil then
				KillTimer(Player[playerid].animtimer);
			end
			
			Player[playerid].animtimer = "";
			Player[playerid].loggedIn = false;

			if Player[playerid]._trader_bot[1] == true then
				for i = 1, TRADERS_COUNT do
					if TRADERS[i].name == GetPlayerName(Player[playerid]._trader_bot[2]) then
						TRADERS[i].busy = false;
						break
					end
				end
			end

			if Player[playerid]._worker_bot[2] == true then
				for i = 1, WORKERS_COUNT do
					if WORKERS[i].worker_name == GetPlayerName(Player[id]._worker_bot[2]) then
						WORKERS[i].worker_busy = false;
						break
					end
				end
			end

		end
	end

end

function BE_OnPlayerSpawn(playerid)
	
	SetPlayerScale(playerid, 1, 1, 1);
	SetPlayerPos(playerid, -6263.4360351562, -431.19046020508, -1240.5786132812);
	SetPlayerScience(playerid, 1, 1)

	if GetPlayerName(playerid) == "Матур" then
		SetPlayerScale(playerid, 1, 0.8, 0.9);
		SetPlayerFatness(playerid, 0.7);
	end


	if IsNPC(playerid) == 1 then
		math.randomseed(os.time());

		if GetPlayerName(playerid) == "Бандит" then
			local head = math.random(1, 5); local Hhead;

			if head == 1 then
				Hhead = "Hum_Head_FatBald"
			elseif head == 2 then
				Hhead = "Hum_Head_Fighter";
			elseif head == 3 then
				Hhead = "Hum_Head_Bald";
			elseif head == 4 then
				Hhead = "Hum_Head_Thief";
			elseif head == 5 then
				Hhead = "Hum_Head_Psionic";
			end
			SetPlayerAdditionalVisual(playerid, "Hum_Body_Naked0", 8, Hhead, math.random(319, 419));

		elseif GetPlayerName(playerid) == "Разбойник" then
			local head = math.random(1, 5); local Hhead;
			if head == 1 then
				Hhead = "Hum_Head_FatBald"
			elseif head == 2 then
				Hhead = "Hum_Head_Fighter";
			elseif head == 3 then
				Hhead = "Hum_Head_Bald";
			elseif head == 4 then
				Hhead = "Hum_Head_Thief";
			elseif head == 5 then
				Hhead = "Hum_Head_Psionic";
			end
			SetPlayerAdditionalVisual(playerid, "Hum_Body_Naked0", 8, Hhead, math.random(319, 419));
		end

	end
end


function BE_OnPlayerText(playerid, text)

	if Player[playerid].enterreg == true then
		EnterPasswordReg(playerid, text); -- ввод при регистрации.
	end

	if Player[playerid].enterlog == true then
		EnterPasswordLog(playerid, text); -- ввод при логине.
	end
	
	if Player[playerid].board_write == true then
		_writeText(playerid, text) -- ввод на доске.
	end

	if Player[playerid].loggedIn == true and Player[playerid].board_write == false and WriteHandscript(playerid, text) == 0 then
		_languageText(playerid, text);
		_findAnim(playerid, text);
	end
end

function BE_OnPlayerKey(playerid, keyDown, keyUp)

	if Player[playerid].hero_use[1] == false then
		CheckCraftGUI(playerid, keyDown, keyUp); -- кнопки крафта
		MINE_OnPlayerKey(playerid, keyDown, keyUp); -- кнопки добычи
		TrainKey(playerid, keyDown, keyUp); -- кнопки тренировки
		rpinvKey(playerid, keyDown, keyUp); -- кнопки РП-инвентаря (ныне какие-то бля статусы)
		ShopKeys_OtherBots(playerid, keyDown, keyUp); -- кнопки бота торговца (PAO)
		HandscriptKey(playerid, keyDown, keyUp); -- кнопки handscript (письма)
		CheckInventoryGUI(playerid, keyDown, keyUp); -- кнопки inventory (рп инвентарь на I)
		_tradersKey(playerid, keyDown, keyUp); -- кнопки для торговцев
		SkinKey1(playerid, keyDown, keyUp); -- скинченджер
		_huntKey(playerid, keyDown, keyUp); -- охота.
		_sheepKey(playerid, keyDown, keyUp); -- овцы
		_heroKey(playerid, keyDown, keyUp); -- кнопки инфо о персонаже
		_workersKey(playerid, keyDown, keyUp); -- кнопки рабочих
		_chestKey(playerid, keyDown, keyUp); -- сундуки
		_selectKey(playerid, keyDown, keyUp); -- ввод кол-во сундуки
	end

	_boardKey(playerid, keyDown, keyUp); -- кнопки доски
	_logCraftKey(playerid, keyDown, keyUp); -- проверка крафтов игрока.
	_heroesKey(playerid, keyDown, keyUp); -- выход из списка персонажей
	_hudKey(playerid, keyDown, keyUp) -- худ.
	_wikiKey(playerid, keyDown, keyUp); -- вики
	GesticKey(playerid, keyDown, keyUp); -- фаст анимки
	_playersInfoKey(playerid, keyDown, keyUp); -- лист игроков

	if keyDown == KEY_M then
		_openMap(playerid)
	end

	if keyDown == KEY_F8 then
		GameExit(playerid);
	end

end

function GameExit(playerid)
	if Player[playerid].loggedIn == true then

		for i, v in pairs(HEROES_LIST_ACTIVE) do
			if v == Player[playerid].hero_use[2] then
				table.remove(HEROES_LIST_ACTIVE, i);
			end
		end
		
		if Player[playerid].exittimer ~= nil then
			KillTimer(Player[playerid].exittimer);
			Player[playerid].exittimer = nil;
			SSM(playerid, "Вы отменили выход из игры.");
			return true;
		end

		SavePlayer(playerid);
		SaveStats(playerid);
		Player[playerid].exittimer = SetTimerEx(_timerToExit, 5000, 0, playerid);
		SSM(playerid, "Вы покинете игру через 5 секунд.");
		SYNM(playerid, "Вы можете ввести /выход (/вых) или нажать F8, чтобы отменить выход.");
	end
end

function _timerToExit(id)
	if IsPlayerConnected(id) == 1 then
		ExitGame(id);
	end
end

addCommandHandler({"/выход", "/вых"}, GameExit);

function BE_OnPlayerFocus(playerid, focusid)
	BotsShop_Focus(playerid, focusid);
	_tradersFocus(playerid, focusid);
	_sheepsFocus(playerid, focusid)
	_workersFocus(playerid, focusid);

	local str = "";
	if focusid ~= -1 then
		if IsNPC(focusid) == 0 then
			if Player[focusid].masked == false then
				str = string.format("%s%s%d%s",GetPlayerName(focusid)," (ИД: ", focusid, ")");
			else
				str = string.format("%s%s%d%s","Неизвестный"," (ИД: ", focusid, ")");
			end
		else
			str = string.format("%s%s%d%s",GetPlayerName(focusid)," (ИД: ", focusid, ")");
		end
		UpdatePlayerDraw(playerid,Player[playerid].namedraw, 1300, 7500, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		if IsNPC(focusid) == 0 then
			if Player[focusid].loggedIn == true then

				if Player[focusid].meinfo ~= nil and Player[focusid].meinfo ~= "NULL" then
					local text = Player[focusid].meinfo;
					if Player[playerid].loggedIn == true then
						UpdatePlayerDraw(playerid, Player[playerid].medraw, 1300, 7800, text, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
					end
				end

				if Player[focusid].afk == true then
					UpdatePlayerDraw(playerid, Player[playerid].afkdraw, 1300, 7200, "Игрок АФК", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				end

			end
		end
	else
		UpdatePlayerDraw(playerid,Player[playerid].namedraw, 1300, 7500, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		if Player[playerid].loggedIn == true then
			UpdatePlayerDraw(playerid, Player[playerid].medraw, 1300, 7800, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end
		UpdatePlayerDraw(playerid, Player[playerid].afkdraw, 0, 0, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end

end


function OnPlayerMouse(playerid, button, pressed, posX, posY)

	RegMouse(playerid, button, pressed, posX, posY);
	LogMouse(playerid, button, pressed, posX, posY);
	SkinMouse(playerid, button, pressed, posX, posY);
	StatsMouse(playerid, button, pressed, posX, posY);
	RPInvMouse(playerid, button, pressed, posX, posY);
	_boardMouse(playerid, button, pressed, posX, posY);
	_21game_mouse(playerid, button, pressed, posX, posY);
	SkinMouse1(playerid, button, pressed, posX, posY);
	_tradersMouse(playerid, button, pressed, posX, posY);
	_pokerMouse(playerid, button, pressed, posX, posY);

end

function BE_OnPlayerHit(playerid, killerid)

	--_gItemsHit(playerid, killerid);

	local time = os.date('*t');
	local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	
	if IsNPC(playerid) == 0 and IsNPC(killerid) == 0 then
		local damage = Player[playerid].hOldHP - GetPlayerHealth(playerid);
		
		local txt = GetPlayerName(killerid).." ударил игрока "..GetPlayerName(playerid).." / Старое ХП: "..Player[playerid].hOldHP.." - Новое ХП: "..GetPlayerHealth(playerid).." (урон "..damage..")";
		Player[playerid].hOldHP = GetPlayerHealth(playerid);
		
		LogString("Logs/Hits/Hits", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear..") "..txt);
		SaveStats(playerid);
	end

	if IsNPC(playerid) == 0 then

		if Player[playerid].loggedIn == true then
			_updateHealth(playerid);
			if IsNPC(killerid) == 0 and Player[killerid].loggedIn == true then
				_updateHealth(killerid);
			end
		end

		if Player[playerid].afk == true then
			if IsNPC(killerid) == 0 then
				SEM(killerid, "Нельзя атаковать игрока в АФК.");
				SSM(playerid, "Вы были атакованы, будучи в АФК - "..GetPlayerName(killerid));
				LogString("Logs/PlayersAll/AFK", Player[killerid].nickname.." атаковал игрока в статусе АФК - "..Player[playerid].nickname);
			end
		end

	end
	
	if IsNPC(playerid) == 1 then
	
		--[[local b_id = nil;
		for i = 1, TRADERS_COUNT do
			if TRADERS[i].name == GetPlayerName(playerid) then
				SetPlayerHealth(playerid, 9999);
				SendPlayerMessage(killerid, 255, 255, 255, "Нельзя атаковать ботов-торговцев.")
				for v = 0, GetMaxPlayers() do
					if Player[v].astatus > 0 then
						SendPlayerMessage(v, 255, 255, 255, "(SERVER) Игрок "..GetPlayerName(killerid).." атакует бота-торговца "..GetPlayerName(playerid).."("..playerid..").");
					end
				end
			end
		end


		for i = 1, WORKERS_COUNT do
			if WORKERS[i].worker_bot == playerid then
				SetPlayerHealth(playerid, 9999);
				SendPlayerMessage(killerid, 255, 255, 255, "Нельзя атаковать ботов-рабочих.")
				for v = 0, GetMaxPlayers() do
					if Player[v].astatus > 0 then
						SendPlayerMessage(v, 255, 255, 255, "(SERVER) Игрок "..GetPlayerName(killerid).." атакует бота-рабочего "..GetPlayerName(playerid).."("..playerid..").");
					end
				end
			end
		end]]

	end

end

function OnPlayerChangeHealth(playerid, newValue, oldValue)

	if IsNPC(playerid) == 0 then
		if Player[playerid].loggedIn == true then
			_checkHealth(playerid, newValue, oldValue)
		end
	end
	
end

function OnPlayerChangeMana(playerid, newValue, oldValue)

	if IsNPC(playerid) == 0 then
		if Player[playerid].loggedIn == true then
			_checkMana(playerid, newValue, oldValue)
		end
	end

end

function LoadStats(playerid)
	
	SetPlayerMaxHealth(playerid, Player[playerid].hp);
	SetPlayerHealth(playerid, Player[playerid].chp);
	SetPlayerMana(playerid, Player[playerid].cmp);
	SetPlayerMaxMana(playerid, Player[playerid].mp);
	SetPlayerMagicLevel(playerid, Player[playerid].mag);

	SetPlayerDexterity(playerid, Player[playerid].dex);
	SetPlayerStrength(playerid, Player[playerid].str);

	SetPlayerSkillWeapon(playerid, SKILL_1H, Player[playerid].h1);
	SetPlayerSkillWeapon(playerid, SKILL_2H, Player[playerid].h2);
	SetPlayerSkillWeapon(playerid, SKILL_BOW, Player[playerid].bow);
	SetPlayerSkillWeapon(playerid, SKILL_CBOW, Player[playerid].cbow);
	
	Player[playerid].hOldHP = Player[playerid].chp;


end

function BE_OnPlayerTakeItem(playerid, itemID, itemInstance, amount, x, y, z, world)

	if Player[playerid].hero_use[1] == false and Player[playerid].IsInstance == false then

		if GetPlayerInstance(playerid) == "PC_HERO" or Player[playerid].areorc == 1 then
			local name = GetPlayerName(playerid);
			local oldValue;
			local file = io.open("Database/Players/Items/"..GetPlayerName(playerid)..".db","r+");
			if file then
				for line in file:lines() do
					local result, item, value = sscanf(line,"sd");
					if result == 1 then
						if string.upper(item) == itemInstance then
							oldValue = value;
						end
					end
				end
				file:close();
			end
			
			if oldValue == nil then
				local file = io.open("Database/Players/Items/"..GetPlayerName(playerid)..".db","a+");
				file:write(itemInstance.." "..amount.."\n");
				file:close();
				SaveItems(playerid);
			else
				local newValue = oldValue + amount;
				local file = io.open("Database/Players/Items/"..GetPlayerName(playerid)..".db","r+");
				local tempString = file:read("*a");
				file:close();
				tempString = string.gsub(tempString,string.upper(itemInstance).." "..oldValue,string.upper(itemInstance).." "..newValue);
				local file = io.open("Database/Players/Items/"..GetPlayerName(playerid)..".db","w+");
				file:write(tempString);
				file:close();
				SaveItems(playerid);
			end
			
			local time = os.date('*t');
			local ryear = time.year;
			local rmonth = time.month;
			local rday = time.day;
			local rhour = string.format("%02d", time.hour);
			local rminute = string.format("%02d", time.min);
			LogString("Logs/Drop/Drop", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear..") "..GetPlayerName(playerid).." поднял "..itemInstance.." в кол-ве "..amount);
		end
	else
		local file = io.open("Database/Heroes/Items/"..Player[playerid].nickname..".txt","w+");
		local items = getPlayerItems(playerid);
		if items then
			for i in pairs(items) do
				file:write(items[i].instance.." "..items[i].amount.."\n");
			end
		end

		
		file:close();
	end
end

function BE_OnPlayerDropItem(playerid, itemid, instance, amount, posX, posY, posZ, world, rotX, rotY, rotZ)
	
	local name = GetPlayerName(playerid);
	local ip = GetPlayerIP(playerid);
	local mac = GetMacAddress(playerid);
	local oldValue;

	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	if Player[playerid].hero_use[1] == false and Player[playerid].IsInstance == false then

		local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","r+");
		if file then
			for line in file:lines() do 
				local result, item, value = sscanf(line,"sd");
				if result == 1 then
					if string.upper(item) == instance then
						oldValue = value;
					end
				end
			end
			file:close();
		end
		
		if oldValue == nil then
			oldValue = 0;
		end
		
		local newValue = oldValue - amount;
		if newValue < 0 then
			newValue = 0;
			if Player[playerid].astatus < 8 and instance ~= "ITLSTORCHBURNING" then
				local sum = amount - oldValue;
				if sum > 1 then
					DestroyItem(itemid);
					SEM(playerid, "Вы были кикнуты по подозрению в дюпе.");
					Kick(playerid);
					LogString("Logs/AC/ac_items",name.." выбросил: "..GetItemName(instance).." (x "..amount.."), имея по БД: "..oldValue.." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);
				end
			end
		end
		
		
		local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","r+");
		local tempString = file:read("*a");
		file:close();
		local tempString = string.gsub(tempString,string.upper(instance).." "..oldValue,string.upper(instance).." "..newValue);
		local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","w+");
		file:write(tempString);
		file:close();
		
		local time = os.date('*t');
		local ryear = time.year;
		local rmonth = time.month;
		local rday = time.day;
		local rhour = string.format("%02d", time.hour);
		local rminute = string.format("%02d", time.min);
		LogString("Logs/Drop/Drop", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear..") "..GetPlayerName(playerid).." выбросил "..instance.." в кол-ве "..amount);
		SaveItems(playerid);
	else
		local file = io.open("Database/Heroes/Items/"..Player[playerid].nickname..".txt","w+");
		local items = getPlayerItems(playerid);
		if items then
			for i in pairs(items) do
				file:write(items[i].instance.." "..items[i].amount.."\n");
			end
		end
		file:close();
	end

end


function OnPlayerHasItem(playerid, itemInstance, amount, equipped, checkid)

	MINE_OnPlayerHasItem(playerid, itemInstance, amount, equipped, checkid)
	CheckPaper(playerid, itemInstance, amount, equipped, checkid); -- handscript

end

function _goOutVW(id)
	SetPlayerVirtualWorld(id, 0);
end

function OnPlayerUseItem(playerid, itemInstance, amount, hand)

	if Player[playerid].hero_use[1] == false and Player[playerid].IsInstance == false then
		MINE_OnPlayerUseItem(playerid, itemInstance, amount, hand); -- предметы добычи
		UseEnergyItems(playerid, itemInstance, amount, hand); -- предметы стамины
		_fishing(playerid, itemInstance, amount, hand); -- рыбалка

		local potions_code = string.upper(itemInstance);
		local potions = string.find(potions_code, "CJCPGP");
		if potions then
			SetPlayerVirtualWorld(playerid, math.random(30, 100));
			SetTimerEx(_goOutVW, 2000, 0, playerid);
		end

		local oldValue;
		local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","r+");
		if file then
			for line in file:lines() do 
				local result, item, value = sscanf(line,"sd");
				if result == 1 then
					if string.upper(item) == itemInstance
					and itemInstance ~= "AIXOPT_ITMI_RAKE"
					and itemInstance ~= "AIXOPT_ITMI_BRUSH"
					and itemInstance ~= "AIXOPT_ITMI_SCOOP"
					and itemInstance ~= "AIXOPT_ITMI_BROOM"
					and itemInstance ~= "AIXOPT_ITMI_LUTE"
					and itemInstance ~= "AIXOPT_ITMI_SAW"
					then
						oldValue = value;
					end
				end
			end
			file:close();
		end

		if oldValue == nil then
			oldValue = 0;
		end

		local newValue = oldValue - amount;
		if newValue < 0 then
			newValue = 0;
		end

		local item = string.upper(itemInstance); local itfo = string.find(item, "ITFO");
		if item ~= "GKWQDZ_ITMW_PICKAXE" then
			if item ~= "AIXOPT_ITMI_SAW" then
				if item ~= "AIXOPT_ITMI_FISHINGROD" then
					if item ~= "AIXOPT_ITMI_BRUSH" then
						if item ~= "AIXOPT_ITMI_BROOM" then
							local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","r+");
							local tempString = file:read("*a");
							file:close();

							local tempString = string.gsub(tempString,string.upper(itemInstance).." "..oldValue,string.upper(itemInstance).." "..newValue);
							local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","w+");
							file:write(tempString);
							file:close();
							removeItem(playerid, string.upper(itemInstance), 1);
							SaveItems(playerid);
						end
					end
				end
			end
		end
	end

end


function OnPlayerDeath(playerid, p_classid, killerid, k_classid)

	if killerid ~= -1 and IsNPC(killerid) == 0 then
		_deathMonster(playerid, killerid);
	end
	
	if killerid ~= -1 and IsNPC(killerid) == 0 and Player[killerid].loggedIn == true then

		if IsNPC(playerid) == 0 then
			SAM("Игрок "..GetPlayerName(killerid).." ("..Player[killerid].nickname..") убил "..GetPlayerName(playerid).." ("..Player[playerid].nickname..").");
			Player[playerid].dead = 1; -- Устанавливаем переменную, чтобы игрок не смог съебаться после релога
		else
			SAM("Игрок "..GetPlayerName(killerid).." ("..Player[killerid].nickname..") убил "..GetPlayerName(playerid));
		end
	end

	if IsNPC(playerid) == 0 and Player[playerid].loggedIn == true then

		SetPlayerHealth(playerid, 0);
		SaveStats(playerid);
		SSM(playerid, "Ваш персонаж мертв.");
		SYNM(playerid, "Обратитесь к игровым мастерам, если считаете смерть несправедливой.");
	end
end


function OnPlayerSpellCast(playerid, itemInstance)

	-- отслеживание использования свитков (royclapton)

	if GetPlayerInstance(playerid) == "PC_HERO" or Player[playerid].areorc == 1 then
		if Player[playerid].hero_use[1] == false then
			local HYMYRK = string.find(itemInstance, "HYMYRK");
			if HYMYRK then
				local item = string.upper(itemInstance);
				removeItem(playerid, item, 1);
				SaveItems(playerid);
			end
		end
	end

end

--[[function _removeArrowBD(playerid)

	local item = "JKZTZD_ITRW_ARROW";
	local oldValue = 0;
	local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db", "r");
	if file then
		for line in file:lines() do
			local result, arrow, amount = sscanf(line, "sd");
			if result == 1 then
				if arrow == item then
					oldValue = amount;
					break
				end
			end
		end
	end


	local newValue = 0;
	if oldValue > 0 then
		newValue = oldValue - 1;
	end

	local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db", "r+");
	local tempString = file:read("*a");
	file:close();
	local tempString = string.gsub(tempString, string.upper(item).." "..oldValue,string.upper(item).." "..newValue);
	local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db", "w+");
	file:write(tempString);
	file:close();

end]]

function _checkArrows(playerid)

	-- отслеживание стрел/болтов с погрешностью (royclapton).

    if Player[playerid].hero_use[1] == false then
	    local animation = GetPlayerAnimationName(playerid)
	    if animation == "T_BOWRELOAD" then
			removeItem(playerid, "ITRW_ARROW", 1);
			SaveItems(playerid);

	    elseif animation == "T_CBOWRELOAD" then
	    	removeItem(playerid, "ITRW_BOLT", 1);
			SaveItems(playerid);

	    end
	end

end

function _timerCheckArrows()

	-- отслеживание стрел/болтов с погрешностью (royclapton).

    for i = 0, GetMaxPlayers() do
        if Player[i].loggedIn == true then
            _checkArrows(i);
        end
    end

end
SetTimer(_timerCheckArrows, 900, 1);


-- AC
function OnPlayerChangeStrength(playerid, newValue, oldValue)
	_ac_ChangeStrength(playerid, newValue, oldValue);
end

function OnPlayerChangeDexterity(playerid, newValue, oldValue)
	_ac_ChangeDexterity(playerid, newValue, oldValue);
end

function OnPlayerChangeAcrobatic(playerid, newValue, oldValue)
	_ac_ChangeAcrobatic(playerid, newValue, oldValue);
end

