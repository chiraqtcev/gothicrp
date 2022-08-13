
--  #     Vobber by royclapton   #
--  #         version: 0.1       #

VOBBER_USE = false; -- статус использования воббера
VOBBER_DEFAULT = "NC_PLANKS_V01.3DS"; -- базовый воб (если каталоги пусты).
VOBBER_CATEGORY = {}; -- каталоги объектов
VOBBER_VOBS_IDS = {};

VOBBER_VOB_OBJECTS = {}; VOBBER_VOB_COUNT = 0; -- список созданных вобов и их кол-во
VOBBER_MOBSI_OBJECTS = {}; VOBBER_MOBSI_COUNT = 0; -- список созданных мобси и их кол-во


VOBBER_TEXTURES = {}; -- создаем текстуры
VOBBER_TEXTURES[1] = CreateTexture(6762, 142, 8104, 2806, 'menu_ingame')
VOBBER_TEXTURES[2] = CreateTexture(4623, 185, 6786, 405, 'menu_ingame')
VOBBER_TEXTURES[3] = CreateTexture(6763, 3070, 8107, 3490, 'menu_ingame')
VOBBER_TEXTURES[4] = CreateTexture(6763, 3770, 8107, 4190, 'menu_ingame')

function _vobberInit() -- инициализация объектов

	-- загружаем вобы на сервер (спавним)
	local file = io.open("modules/Vobber/VobberBase/Objects/Vob_objs.txt", "r");
	if file then -- если файл найден, начинается считывание всех строк и выгрузка.
		for line in file:lines() do
			local result, a = sscanf(line, "s");
			if result == 1 then
				--
			end
		end
		file:close();
	else -- если файл не найден, он создается.
		print("Cannot to open VobberBase/Objects/Vob_objs.txt (nil). File recreated.")
		local fileW = io.open("modules/Vobber/VobberBase/Objects/Vob_objs.txt", "w");
		fileW:close();
	end

	-----------------------------------------------------------------------------------

	-- загружаем мобси на сервер (спавним)
	local file = io.open("modules/Vobber/VobberBase/Objects/Mobsi_objs.txt", "r");
	if file then
		for line in file:lines() do
			local result, a = sscanf(line, "s");
			if result == 1 then
				--
			end
		end
		file:close();
	else -- если файл не найден, он создается.
		print("Cannot to open VobberBase/Objects/Mobsi_objs.txt (nil). File recreated.")
		local fileW = io.open("modules/Vobber/VobberBase/Objects/Mobsi_objs.txt", "w");
		fileW:close();
	end

	-- #######################################################################################

	-- загружаем регистрацию категорий (списки)
	local file = io.open("modules/Vobber/VobberBase/Category/List.txt", "r");
	if file then
		for line in file:lines() do
			local result, list = sscanf(line, "s");
			if result == 1 then
				table.insert(VOBBER_CATEGORY, list);
			end
		end
		file:close();
	else -- если файл не найден, он создается.
		print("Cannot to open VobberBase/Category/List.txt (nil). File recreated.")
		local fileW = io.open("modules/Vobber/VobberBase/Category/List.txt", "w");
		fileW:close();
	end


end

function _vobberConnect(id) -- в OnPlayerConnect:

	-- other
	Player[id]._vober_open = false; -- отвечает за активность воббера
	Player[id]._vober_type = "none"; -- определяет текущий тип сетки вобов (vob / mobsi / none)
	Player[id]._vober_timer = nil;
	Player[id]._vober_draws = {}; -- дравы
	Player[id]._vober_draws[1] = CreatePlayerDraw(id, 4860, 204, ""); -- название воба
	Player[id]._vober_draws[2] = CreatePlayerDraw(id, 6854, 204, ""); -- айди воба:
	Player[id]._vober_draws[3] = CreatePlayerDraw(id, 6854, 404, ""); -- скор. движения:
	Player[id]._vober_draws[4] = CreatePlayerDraw(id, 6854, 604, ""); -- скор. вращения:
	Player[id]._vober_draws[5] = CreatePlayerDraw(id, 6854, 804, ""); -- категория: 
	Player[id]._vober_draws[6] = CreatePlayerDraw(id, 6854, 1004, ""); -- id в списке: 
	Player[id]._vober_draws[7] = CreatePlayerDraw(id, 6854, 1204, ""); -- коллизия: 
	Player[id]._vober_draws[8] = CreatePlayerDraw(id, 7175, 3186, "СОЗДАТЬ"); -- СОЗДАТЬ
	Player[id]._vober_draws[9] = CreatePlayerDraw(id, 7375, 1204, "");

	-- list
	Player[id]._vober_category = ""; -- выбранная категория
	Player[id]._vober_category_n = 0; -- выбранная категория (номер)
	Player[id]._vober_cid = 0; -- выбранные воб в списке категории

	-- main vars
	Player[id]._vober_vob = nil; -- текущий объект
	Player[id]._vober_speedmove = 0; -- скорость движения
	Player[id]._vober_speedrotate = 0; -- скорость вращения
	Player[id]._vober_collision = false; -- статус коллизии
	Player[id]._vober_current_id = 0; -- айди объекта
	Player[id]._vober_visual = ""; -- название модели
	Player[id]._vober_pos = {}; -- текущее положение объекта
	Player[id]._vober_rotate = {}; -- текущий поворот объекта

	-- mobsi
	Player[id]._vober_scheme = nil; -- схема мобси
	Player[id]._vober_obj_name = nil; -- имя объекта (прим: BED / CHEST etc)
	Player[id]._vober_withItem = nil; -- с каким предметом можно использовать

	-- control
	Player[id]._vober_type = 0;
	Player[id]._vober_W = 0; -- вперед
	Player[id]._vober_S = 0; -- назад
	Player[id]._vober_A = 0; -- влево
	Player[id]._vober_D = 0; -- вправо
	Player[id]._vober_Q = 0; -- вверх
	Player[id]._vober_E = 0; -- вниз

end

function _vobberDefault(id) -- задаем первоначальные настройки (не базовые)

	Player[id]._vober_open = true; -- активируем воббер
	Player[id]._vober_speedmove = 5; -- указываем скорость движения
	Player[id]._vober_speedrotate = 5; -- указываем скорость вращения
	Player[id]._vober_collision = true; -- указываем положительную коллизию (включаем столкновения)
	Player[id]._vober_cid = 1; -- обозначаем стартовый номер объекта
	Player[id]._vober_type = 1; -- ставим режим движения.

end

function _vobberEnd(id) -- обнуляем все переменные
	
	Player[id]._vober_open = false;
	Player[id]._vober_vob = nil;
	Player[id]._vober_type = "none";
	Player[id]._vober_category = "";
	Player[id]._vober_category_n = 0;
	Player[id]._vober_cid = 0;
	Player[id]._vober_speedmove = 0;
	Player[id]._vober_speedrotate = 0;
	Player[id]._vober_collision = false;
	Player[id]._vober_current_id = 0;
	Player[id]._vober_visual = "";
	Player[id]._vober_pos = {};
	Player[id]._vober_rotate = {};
	Player[id]._vober_scheme = nil;
	Player[id]._vober_obj_name = nil;
	Player[id]._vober_withItem = nil;
	Player[id]._vober_type = 0;

end

function _voberUpdateDraw(id) -- обновляем дравы по мере необходимости

	UpdatePlayerDraw(id, Player[id]._vober_draws[1],  4660, 204, string.lower(Player[id]._vober_visual), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._vober_draws[2],  6854, 204, string.format("%s%d", "ID: ", Player[id]._vober_current_id), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._vober_draws[3],  6854, 404, string.format("%s%d", "Скор. движения: ",Player[id]._vober_speedmove), "Font_Old_10_White_Hi.TGA", 255, 255, 255); -- Скор. движения:
	UpdatePlayerDraw(id, Player[id]._vober_draws[4],  6854, 604, string.format("%s%d", "Скор: вращения: ", Player[id]._vober_speedrotate), "Font_Old_10_White_Hi.TGA", 255, 255, 255); -- Скор. вращения:
	UpdatePlayerDraw(id, Player[id]._vober_draws[5],  6854, 804, string.format("%s%s", "Категория: ",Player[id]._vober_category), "Font_Old_10_White_Hi.TGA", 255, 255, 255); -- Категория: 
	UpdatePlayerDraw(id, Player[id]._vober_draws[6],  6854, 1004, string.format("%s%d", "ID в кат-и: ", Player[id]._vober_cid), "Font_Old_10_White_Hi.TGA", 255, 255, 255); -- ID в списке: 

	if Player[id]._vober_collision == true then
		UpdatePlayerDraw(id, Player[id]._vober_draws[7],  6854, 1204, "Коллизия: да", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	else
		UpdatePlayerDraw(id, Player[id]._vober_draws[7],  6854, 1204, "Коллизия: нет", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end

	if Player[id]._vober_type == 1 then
		UpdatePlayerDraw(id, Player[id]._vober_draws[7],  6854, 1404, "Режим: движение", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	elseif Player[id]._vober_type == 2 then
		UpdatePlayerDraw(id, Player[id]._vober_draws[7],  6854, 1404, "Режим: вращение", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end

end

function _vobberOpen(id) -- начало работы с воббером

	if Player[id]._vober_open == false then -- если воббер выключен
		if VOBBER_USE == false then -- делаем проверку, использует ли воббер кто-то в данный момент

			VOBBER_USE = true; -- устанавливаем статус работы воббера.
			_vobberDefault(id); -- делаем базовые параметры
			SetCursorVisible(id, 1); -- включаем курсор
			SetPlayerScale(id, 0, 0, 0); -- убираем возможность любого движения (в т.ч. поломку заморозки через функцию FreezePlayer) + прячем пользователя
			FreezePlayer(id, 1); -- замораживаем пользователя.
			Player[id]._vober_timer = SetTimerEx(_voberMove, 50, 1, id); -- запускаем таймер на движение
			ShowChat(id, 0); -- прячем чат

			for i = 1, table.getn(VOBBER_TEXTURES) do -- показываем нужные текстуры
				ShowTexture(id, VOBBER_TEXTURES[i]);
			end

			for i = 1, table.getn(Player[id]._vober_draws) do -- показываем нужные дравы
				ShowPlayerDraw(id, Player[id]._vober_draws[i]);
			end

			_voberUpdateDraw(id);
		else
			SendPlayerMessage(id, 255, 255, 255, "(VOBBER) Кто-то уже пользуется инструментом.")
		end

	else

		VOBBER_USE = false; -- устанавливаем статус работы воббера.
		VOBBER_VOBS_IDS = {}; -- сбрасываем память вобов
		_vobberEnd(id); -- сбрасываем значения переменных
		SetCursorVisible(id, 0); -- выключаем курсор
		SetPlayerScale(id, 1, 1, 1); -- включаем возможность движения
		FreezePlayer(id, 0); -- размораживаем пользователя
		SetDefaultCamera(id); -- сбрасываем камеру игроку
		ShowChat(id, 1); -- включаем чат
		if Player[id]._vober_timer ~= nil then
			KillTimer(Player[id]._vober_timer); -- убиваем таймер
			Player[id]._vober_timer = nil;
		end


		for i = 1, table.getn(VOBBER_TEXTURES) do -- показываем нужные текстуры
			HideTexture(id, VOBBER_TEXTURES[i]);
		end

		for i = 1, table.getn(Player[id]._vober_draws) do -- показываем нужные дравы
			HidePlayerDraw(id, Player[id]._vober_draws[i]);
		end

	end
end
addCommandHandler({"/vobber", "/воббер"}, _vobberOpen);

function _vobberCreate(id) -- создание нового объекта

	local x, y, z = GetPlayerPos(id); -- получаем позицию игрока
	local world = GetPlayerWorld(id); -- получаем мир игрока
	Player[id]._vober_pos = {x, y + 100, z}; -- записываем координаты объекта

	if table.getn(VOBBER_CATEGORY) < 1 then -- если категорий нет - спавним базовый воб
		Player[id]._vober_visual = VOBBER_DEFAULT;
		Player[id]._vober_vob = Vob.Create(VOBBER_DEFAULT, world, x, y + 100, z);
		if table.getn(VOBBER_VOBS_IDS) > 0 then
			Player[id]._vober_current_id = table.getn(VOBBER_VOBS_IDS) + 1;
		else
			Player[id]._vober_current_id = 1;
		end
		_voberUpdateDraw(id);
	else
		Player[id]._vober_vob = Vob.Create(" ", world, x, y + 100, z);
		if Player[id]._vober_category_n == 0 then -- если выбранный пункт == 0, то сделаем его 1.
			Player[id]._vober_category_n = 1;
		end
		local c_n = Player[id]._vober_category_n; -- записываем пункт в переменную для упрощения жизни
		Player[id]._vober_category = VOBBER_CATEGORY[c_n];
		
		local file = io.open("modules/Vobber/VobberBase/Category/"..VOBBER_CATEGORY[c_n]..".txt", "r"); -- открываем файл со списком (пунктами) по нужной категории
		if file then
			local i = 1;
			for line in file:lines() do
				local result, vob = sscanf(line, "s");
				if result == 1 then
					if Player[id]._vober_cid == i then
						Player[id]._vober_cid = i;
						Vob.SetVisual(Player[id]._vober_vob, vob);
						Player[id]._vober_visual = string.lower(vob);
						_voberUpdateDraw(id);
						break
					else
						i = i + 1;
					end
				end
			end
			file:close();
		else
			print("Cannot loading list #"..c_n.."! ERROR!");
		end


	end

	SetCameraBehindVob(id, Player[id]._vober_vob);

end

function _vobberKey(id, down, up) -- колбек на клавиши

	if Player[id]._vober_open == true and Player[id]._vober_vob ~= nil then

		-- ПЕРЕМЕЩЕНИЕ + ПОВОРОТ

		-- переключение режимов

		if down == KEY_1 then
			Player[id]._vober_type = 1;
			_voberUpdateDraw(id);
			GameTextForPlayer(id, 2224, 203, "Выбран режим движения!", "Font_Old_10_White_Hi.TGA", 255, 110, 110, 500)
		end

		if down == KEY_2 then
			Player[id]._vober_type = 2;
			_voberUpdateDraw(id);
			GameTextForPlayer(id, 2224, 203, "Выбран режим вращения!", "Font_Old_10_White_Hi.TGA", 255, 110, 110, 500)
		end


		-- действия

		-- если кнопку удерживают
		if down == KEY_W then
			Player[id]._vober_W = 1;
		end

		if down == KEY_S then
			Player[id]._vober_S = 1;
		end

		if down == KEY_A then
			Player[id]._vober_A = 1;
		end

		if down == KEY_D then
			Player[id]._vober_D = 1;
		end

		if down == KEY_Q then
			Player[id]._vober_Q = 1;
		end

		if down == KEY_E then
			Player[id]._vober_E = 1;
		end

		-- если кнопку отпустили
		if up == KEY_W then
			Player[id]._vober_W = 0;
		end

		if up == KEY_S then
			Player[id]._vober_S = 0;
		end

		if up == KEY_A then
			Player[id]._vober_A = 0;
		end

		if up == KEY_D then
			Player[id]._vober_D = 0;
		end

		if up == KEY_Q then
			Player[id]._vober_Q = 0;
		end

		if up == KEY_E then
			Player[id]._vober_E = 0;
		end

		-- ##########################################
		-- каталоги

		if down == KEY_LEFT then

			if table.getn(VOBBER_CATEGORY) > 0 then
				local count = table.getn(VOBBER_CATEGORY);
				if Player[id]._vober_category_n ~= 0 then
					Player[id]._vober_category_n = Player[id]._vober_category_n - 1;
					if Player[id]._vober_category_n == 0 then
						Player[id]._vober_category_n = 1;
					end
					Player[id]._vober_cid = 1;
					local cid = Player[id]._vober_category_n; Player[id]._vober_category = VOBBER_CATEGORY[cid];
					_voberUpdateDraw(id);
					_vobberUpdateObject(id);
					GameTextForPlayer(id, 2224, 203, "Каталог обновлен.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
				end
			end


		end

		if down == KEY_RIGHT then

			if table.getn(VOBBER_CATEGORY) > 0 then
				local count = table.getn(VOBBER_CATEGORY);
				if Player[id]._vober_category_n < count then
					Player[id]._vober_category_n = Player[id]._vober_category_n + 1;
					Player[id]._vober_cid = 1;
					local cid = Player[id]._vober_category_n; Player[id]._vober_category = VOBBER_CATEGORY[cid];
					_voberUpdateDraw(id);
					_vobberUpdateObject(id);
					GameTextForPlayer(id, 2224, 203, "Каталог обновлен.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
				end
			end

		end

		-- ##########################################
		-- объекты

		if down == KEY_UP then

			if Player[id]._vober_cid > 0 then
				Player[id]._vober_cid = Player[id]._vober_cid - 1;
				if Player[id]._vober_cid == 0 then
					Player[id]._vober_cid = 1;
				end
			end
			_vobberUpdateObject(id);
			_voberUpdateDraw(id);

		end


		if down == KEY_DOWN then

			local oldVisual = Player[id]._vober_visual;
			Player[id]._vober_cid = Player[id]._vober_cid + 1;
			_vobberUpdateObject(id);
			_voberUpdateDraw(id);

			if oldVisual == Player[id]._vober_visual then
				Player[id]._vober_cid = 1;
				_vobberUpdateObject(id);
				_voberUpdateDraw(id);
			end

		end

		-- ##########################################
		-- скорость

		-- скорость движения
		if down == KEY_MINUS then
			Player[id]._vober_speedmove = Player[id]._vober_speedmove - 1;
			if Player[id]._vober_speedmove < 1 then
				Player[id]._vober_speedmove = 1;
			end
			_voberUpdateDraw(id);
			GameTextForPlayer(id, 2224, 203, "Скорость движения уменьшена", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
		end


		if down == KEY_EQUALS then
			Player[id]._vober_speedmove = Player[id]._vober_speedmove + 1;
			if Player[id]._vober_speedmove > 50 then
				Player[id]._vober_speedmove = 50;
			end
			_voberUpdateDraw(id);
			GameTextForPlayer(id, 2224, 203, "Скорость движения увеличена", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
		end

		-- скорость поворота
		if down == KEY_COMMA then
			Player[id]._vober_speedrotate = Player[id]._vober_speedrotate - 1;
			if Player[id]._vober_speedrotate < 1 then
				Player[id]._vober_speedrotate = 1;
			end
			_voberUpdateDraw(id);
			GameTextForPlayer(id, 2224, 203, "Скорость поворота уменьшена", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
		end


		if down == KEY_PERIOD then
			Player[id]._vober_speedrotate = Player[id]._vober_speedrotate + 1;
			if Player[id]._vober_speedrotate > 10 then
				Player[id]._vober_speedrotate = 10;
			end
			_voberUpdateDraw(id);
			GameTextForPlayer(id, 2224, 203, "Скорость поворота увеличена", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
		end

	end

end

function _vobberUpdateObject(id) -- обновляем объект при переключении

	local c_n = Player[id]._vober_category_n; -- записываем пункт в переменную для упрощения жизни
	local file = io.open("modules/Vobber/VobberBase/Category/"..VOBBER_CATEGORY[c_n]..".txt", "r"); -- открываем файл со списком (пунктами) по нужной категории
	if file then
		local i = 1;
		for line in file:lines() do
			local result, vob = sscanf(line, "s");
			if result == 1 then
				if Player[id]._vober_cid == i then
					newVisual = Player[id]._vober_visual;
					Player[id]._vober_visual = vob;
					Vob.SetVisual(Player[id]._vober_vob, vob);
					_voberUpdateDraw(id);
					GameTextForPlayer(id, 2224, 203, "Объект переключен! Обновление..", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
					break
				else
					i = i + 1;
				end
			end
		end
		file:close();
	end

end 

function _voberMove(id)

	local speedMove = Player[id]._vober_speedmove * 20;
	local speedRot  = Player[id]._vober_speedrotate * 5;

	if Player[id]._vober_type == 1 then -- если текущий режим "движение"

		if Player[id]._vober_W == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation();
			local x, y, z = vob:GetPosition();
			local _sin = math.sin(math.rad(r_y));
			local _cos = math.cos(math.rad(r_y));
			local v_x, v_y, v_z = vob:GetPosition()
			x = x + Player[id]._vober_speedmove * _sin;
			z = z + Player[id]._vober_speedmove * _cos;
			vob:SetPosition(x, y, z);
			Player[id]._vober_pos = {x, y, z};
		end

		if Player[id]._vober_S == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation();
			local x, y, z = vob:GetPosition();
			local _sin = math.sin(math.rad(r_y));
			local _cos = math.cos(math.rad(r_y));
			local v_x, v_y, v_z = vob:GetPosition()
			x = x - Player[id]._vober_speedmove * _sin;
			z = z - Player[id]._vober_speedmove * _cos;
			vob:SetPosition(x, y, z);
			Player[id]._vober_pos = {x, y, z};
		end

		if Player[id]._vober_A == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation()
			local v_x,v_y,v_z = vob:GetPosition()
			vob:SetRotation(r_x, r_y - speedRot, r_z);
			Player[id]._vober_rotate = {r_x, r_y - speedRot, r_z}
		end

		if Player[id]._vober_D == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation()
			local v_x,v_y,v_z = vob:GetPosition()
			vob:SetRotation(r_x, r_y + speedRot, r_z);
			Player[id]._vober_rotate = {r_x, r_y + speedRot, r_z}
		end

		local text = string.format("%s %s %s", Player[id]._vober_pos[1], Player[id]._vober_pos[2], Player[id]._vober_pos[3]);
		GameTextForPlayer(id, 2224, 203, text, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)

	elseif Player[id]._vober_type == 2 then -- если текущий режим "вращение"

		if Player[id]._vober_W == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation();
			vob:SetRotation(r_x + speedRot / 5, r_y, r_z);
		end

		if Player[id]._vober_S == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation();
			vob:SetRotation(r_x - speedRot / 5, r_y, r_z);
		end

		if Player[id]._vober_A == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation();
			vob:SetRotation(r_x, r_y, r_z + speedRot / 5);

		end

		if Player[id]._vober_D == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation();
			vob:SetRotation(r_x, r_y, r_z - speedRot / 5);
		end

	end

	if Player[id]._vober_Q == 1 then
		local vob = Player[id]._vober_vob;
		local x, y, z = vob:GetPosition();
		vob:SetPosition(x, y + speedRot, z);
		Player[id]._vober_pos = {x, y + speedRot, z};
		local text = string.format("%s %s %s", Player[id]._vober_pos[1], Player[id]._vober_pos[2], Player[id]._vober_pos[3]);
		GameTextForPlayer(id, 2224, 203, text, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
	end

	if Player[id]._vober_E == 1 then
		local vob = Player[id]._vober_vob;
		local x, y, z = vob:GetPosition();
		vob:SetPosition(x, y - speedRot, z);
		Player[id]._vober_pos = {x, y - speedRot, z};
		local text = string.format("%s %s %s", Player[id]._vober_pos[1], Player[id]._vober_pos[2], Player[id]._vober_pos[3]);
		GameTextForPlayer(id, 2224, 203, text, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
	end

	

end

function _vobberMouse(id, button, pressed, posX, posY) -- колбек на мышку

	if Player[id]._vober_open == true then

		if button == MB_LEFT then
			if pressed == 0 then

				if posX > 3553 and posX < 8107 and posY > 3070 and posY < 3490 then -- кнопка "СОЗДАТЬ"
					_vobberCreate(id);
				end

			end
		end
	end
end
