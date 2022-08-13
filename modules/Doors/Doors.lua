
_dWORLD = "ODEON_KHORINIS.ZEN";
DOOR_MODELS = {"DOOR_WOODEN.MDS", "DOOR_NW_NORMAL_01.MDS", "DOOR_NW_RICH_01.MDS"}

VALUE_DOORS = 0;
DIRDINFO = "Database/Doors/DOOR_INFO";
DIRDID = "Database/Doors/DOOR_ID";

function _initDoor()


	print(" ####################");
	print(" #   Doors system   #");
	print(" #                  #");
	local file = io.open(DIRDINFO, "r");
	if file then
		for line in file:lines() do
			local result, type, value = sscanf(line, "sd");
			if result == 1 then
				VALUE_DOORS = value;
			end
		end
	end

	DOORS_ARR = {};
	for i = 1, VALUE_DOORS do
		DOORS_ARR[i] = {};
		DOORS_ARR[i].id = "DOOR_ID_"..tostring(i);
		DOORS_ARR[i].mob = nil;
		DOORS_ARR[i].visual = nil;
		DOORS_ARR[i].x = 0;
		DOORS_ARR[i].y = 0;
		DOORS_ARR[i].z = 0;
		DOORS_ARR[i].rx = 0;
		DOORS_ARR[i].ry = 0;
		DOORS_ARR[i].rz = 0;
		DOORS_ARR[i].key = " ";
		DOORS_ARR[i].lockcombo = "NULL";
	end

	for i = 1, VALUE_DOORS do
		local file = io.open(DIRDID..i, "r");
		if file then

			set = file:read("*l");
			local result, x, y, z = sscanf(set, "fff");
			if result == 1 then
				DOORS_ARR[i].x = x;
				DOORS_ARR[i].y = y;
				DOORS_ARR[i].z = z;
			end

			set = file:read("*l");
			local result, x, y, z = sscanf(set, "ddd");
			if result == 1 then
				DOORS_ARR[i].rx = x;
				DOORS_ARR[i].ry = y;
				DOORS_ARR[i].rz = z;
			end

			set = file:read("*l");
			local result, visual = sscanf(set, "s");
			if result == 1 then
				DOORS_ARR[i].visual = visual;
			end

			set = file:read("*l");
			local result, key = sscanf(set, "s");
			if result == 1 then
				DOORS_ARR[i].key = key;
			end

			set = file:read("*l");
			local result, lockcombo = sscanf(set, "s");
			if result == 1 then
				DOORS_ARR[i].lockcombo = lockcombo;
			end

		file:close();

		DOORS_ARR[i].mob = Mob.Create(DOORS_ARR[i].visual, "MOBNAME_DOOR", 3, "DOOR", DOORS_ARR[i].key, _dWORLD, DOORS_ARR[i].x, DOORS_ARR[i].y, DOORS_ARR[i].z, DOORS_ARR[i].id);
		Mob.SetRotation(DOORS_ARR[i].mob, DOORS_ARR[i].rx, DOORS_ARR[i].ry, DOORS_ARR[i].rz)
		print(" #    DOOR_ID_"..i.."+    #");
		end
	end
	print(" #                  #");
	print(" ####################");
end


function _useDoor(id, sc, d_id, used)

	for i = 1, VALUE_DOORS do
		if d_id == "DOOR_ID_"..tostring(i) then
			SendPlayerMessage(id, 255, 255, 255, "Open door #"..d_id);
		end
	end

end


function _getDoorId(d_name)

	local lens = string.len(d_name);
	local id = string.sub(d_name, 9, lens);
	return id;

end

local combotex_1 = CreateTexture(3305, 3623, 5030, 4020, 'dlg_conversation')
local combotex_2 = CreateTexture(3305, 3623, 5030, 4020, 'menu_ingame')

local combo_L = {};
combo_L[1] = CreateTexture(3400, 3700, 3570, 3970, "L");
combo_L[2] = CreateTexture(3670, 3700, 3840, 3970, "L");
combo_L[3] = CreateTexture(3940, 3700, 4110, 3970, "L");
combo_L[4] = CreateTexture(4210, 3700, 4380, 3970, "L");
combo_L[5] = CreateTexture(4480, 3700, 4650, 3970, "L");
combo_L[6] = CreateTexture(4750, 3700, 4920, 3970, "L");


local combo_R = {};
combo_R[1] = CreateTexture(3400, 3700, 3570, 3970, "R");
combo_R[2] = CreateTexture(3670, 3700, 3840, 3970, "R");
combo_R[3] = CreateTexture(3940, 3700, 4110, 3970, "R");
combo_R[4] = CreateTexture(4210, 3700, 4380, 3970, "R");
combo_R[5] = CreateTexture(4480, 3700, 4650, 3970, "R");
combo_R[6] = CreateTexture(4750, 3700, 4920, 3970, "R");

function _checkPickLock(id)

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db","r+");
	if file then
		for line in file:lines() do 
			local result, item, value = sscanf(line,"sd");
			if result == 1 and value > 0 then
				if item == "QBDUUO_ITKE_LOCKPICK" then
					return true;
				end
			end
		end
		file:close();
	end
	return false;

end

function _deletePickLock(id)

	local instance = "QBDUUO_ITKE_LOCKPICK";
	local oldValue;

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db","r+");
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

	local newValue;
	newValue = oldValue - 1;

	if newValue == -1 then
		newValue = 0;
	end

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db","r+");
	local tempString = file:read("*a");
	file:close();
	local tempString = string.gsub(tempString,string.upper(instance).." "..oldValue,string.upper(instance).." "..newValue);
	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db","w+");
	file:write(tempString);
	file:close();

end


function _findNearDoor(id)

	if Player[id].breaking_lock > 0 then
		if _checkPickLock(id) == true then

			local x, y, z = GetPlayerPos(id);
			local x_d, z_d;

			for i = 1, VALUE_DOORS do
				x_d = DOORS_ARR[i].x;
				z_d = DOORS_ARR[i].z;

				if GetDistance2D(x, z, x_d, z_d) < 90 then
					SendPlayerMessage(id, 112, 54, 214, "(dev) Дверь #"..i);
					SendPlayerMessage(id, 255, 255, 255, "Вы начали взлом двери. Используйте стрелочки ВЛЕВО и ВПРАВО.")
					SendPlayerMessage(id, 255, 255, 255, "В случае неудачи вы потеряете одну отмычку")
					SendPlayerMessage(id, 255, 255, 255, "Чтобы прервать взлом нажмите ESC.")
					Player[id].door_id = i;
					Player[id].need_combo = DOORS_ARR[i].lockcombo;
					local angle = GetAngleToPos(x, z, x_d, z_d);
					SetPlayerAngle(id, angle);
					PlayAnimation(id, "T_DOOR_FRONT_STAND_2_S0");
					PlayAnimation(id, "S_DOOR_FRONT_S0");

					ShowTexture(id, combotex_1);
					ShowTexture(id, combotex_2);

					Freeze(id);
					break
				end
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "У вас нет отмычки для взлома.")
		end
	end

end
addCommandHandler({"/break"}, _findNearDoor);

break_oksound = CreateSound("PICKLOCK_SUCCESS.WAV");
break_badsound = CreateSound("PICKLOCK_BROKEN.WAV");



function _breakKey(id, down, up)


	if Player[id].door_id ~= 0 then

		if down == KEY_ESCAPE then

			Player[id].door_id = 0;
			Player[id].need_combo = "";
			PlayAnimation(id, "S_RUN");

			HideTexture(id, combotex_1);
			HideTexture(id, combotex_2);
			_resetTexCombo(id);

			UnFreeze(id);

		end

		if down == KEY_LEFT then

			Player[id].current_combo = Player[id].current_combo.."L";
			PlayAnimation(id, "T_DOOR_FRONT_S0_PICKLEFT");
			if string.len(Player[id].current_combo) == 1 then

				local cmb = string.sub(Player[id].need_combo, 1, 1);
				if cmb == Player[id].current_combo then
					ShowTexture(id, combo_L[1]);
					PlayPlayerSound(id, break_oksound);
				else
					GameTextForPlayer(id, 3150, 3140, "Вы сломали отмычку!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
					_resetTexCombo(id);
					PlayPlayerSound(id, break_badsound);
					Player[id].current_combo = "";
					RemoveItem(id, "QBDUUO_ITKE_LOCKPICK", 1);
					_deletePickLock(id);
					if _checkPickLock(id) == false then
						_badFinish(id);
					end
					
				end

			elseif string.len(Player[id].current_combo) == 2 then
				local cmb = string.sub(Player[id].need_combo, 1, 2);
				if cmb == Player[id].current_combo then
					ShowTexture(id, combo_L[2]);
					PlayPlayerSound(id, break_oksound);
				else
					GameTextForPlayer(id, 3150, 3140, "Вы сломали отмычку!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
					_resetTexCombo(id);
					PlayPlayerSound(id, break_badsound);
					Player[id].current_combo = "";
					RemoveItem(id, "QBDUUO_ITKE_LOCKPICK", 1);
					_deletePickLock(id);
					if _checkPickLock(id) == false then
						_badFinish(id);
					end
				end

			elseif string.len(Player[id].current_combo) == 3 then
				local cmb = string.sub(Player[id].need_combo, 1, 3);
				if cmb == Player[id].current_combo then
					ShowTexture(id, combo_L[3]);
					PlayPlayerSound(id, break_oksound);
				else
					GameTextForPlayer(id, 3150, 3140, "Вы сломали отмычку!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
					_resetTexCombo(id);
					PlayPlayerSound(id, break_badsound);
					Player[id].current_combo = "";
					RemoveItem(id, "QBDUUO_ITKE_LOCKPICK", 1);
					_deletePickLock(id);
					if _checkPickLock(id) == false then
						_badFinish(id);
					end
				end

			elseif string.len(Player[id].current_combo) == 4 then
				local cmb = string.sub(Player[id].need_combo, 1, 4);
				if cmb == Player[id].current_combo then
					ShowTexture(id, combo_L[4]);
					PlayPlayerSound(id, break_oksound);
				else
					GameTextForPlayer(id, 3150, 3140, "Вы сломали отмычку!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
					_resetTexCombo(id);
					PlayPlayerSound(id, break_badsound);
					Player[id].current_combo = "";
					RemoveItem(id, "QBDUUO_ITKE_LOCKPICK", 1);
					_deletePickLock(id);
					if _checkPickLock(id) == false then
						_badFinish(id);
					end
				end

			elseif string.len(Player[id].current_combo) == 5 then
				local cmb = string.sub(Player[id].need_combo, 1, 5);
				if cmb == Player[id].current_combo then
					ShowTexture(id, combo_L[5]);
					PlayPlayerSound(id, break_oksound);
				else
					GameTextForPlayer(id, 3150, 3140, "Вы сломали отмычку!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
					_resetTexCombo(id);
					PlayPlayerSound(id, break_badsound);
					Player[id].current_combo = "";
					RemoveItem(id, "QBDUUO_ITKE_LOCKPICK", 1);
					_deletePickLock(id);
					if _checkPickLock(id) == false then
						_badFinish(id);
					end
				end

			elseif string.len(Player[id].current_combo) == 6 then
				local cmb = string.sub(Player[id].need_combo, 1, 6);
				if cmb == Player[id].current_combo then
					ShowTexture(id, combo_L[6]);
					PlayPlayerSound(id, break_oksound);
					_goodFinish(id)
				else
					GameTextForPlayer(id, 3150, 3140, "Вы сломали отмычку!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
					_resetTexCombo(id);
					PlayPlayerSound(id, break_badsound);
					Player[id].current_combo = "";
					RemoveItem(id, "QBDUUO_ITKE_LOCKPICK", 1);
					_deletePickLock(id);
					if _checkPickLock(id) == false then
						_badFinish(id);
					end
				end
			end

		end

		if down == KEY_RIGHT then

			Player[id].current_combo = Player[id].current_combo.."R";
			PlayAnimation(id, "T_DOOR_FRONT_S0_PICKRIGHT");
			if string.len(Player[id].current_combo) == 1 then

				local cmb = string.sub(Player[id].need_combo, 1, 1);
				if cmb == Player[id].current_combo then
					ShowTexture(id, combo_R[1]);
					PlayPlayerSound(id, break_oksound);
				else
					GameTextForPlayer(id, 3150, 3140, "Вы сломали отмычку!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
					_resetTexCombo(id);
					PlayPlayerSound(id, break_badsound);
					Player[id].current_combo = "";

					RemoveItem(id, "QBDUUO_ITKE_LOCKPICK", 1);
					_deletePickLock(id);

					if _checkPickLock(id) == false then
						_badFinish(id);
					end
					
				end

			elseif string.len(Player[id].current_combo) == 2 then

				local cmb = string.sub(Player[id].need_combo, 1, 2);
				if cmb == Player[id].current_combo then
					ShowTexture(id, combo_R[2]);
					PlayPlayerSound(id, break_oksound);
				else
					GameTextForPlayer(id, 3150, 3140, "Вы сломали отмычку!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
					_resetTexCombo(id);
					PlayPlayerSound(id, break_badsound);
					Player[id].current_combo = "";
					RemoveItem(id, "QBDUUO_ITKE_LOCKPICK", 1);
					_deletePickLock(id);
					if _checkPickLock(id) == false then
						_badFinish(id);
					end
				end

			elseif string.len(Player[id].current_combo) == 3 then

				local cmb = string.sub(Player[id].need_combo, 1, 3);
				if cmb == Player[id].current_combo then
					ShowTexture(id, combo_R[3]);
					PlayPlayerSound(id, break_oksound);
				else
					GameTextForPlayer(id, 3150, 3140, "Вы сломали отмычку!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
					_resetTexCombo(id);
					PlayPlayerSound(id, break_badsound);
					Player[id].current_combo = "";
					RemoveItem(id, "QBDUUO_ITKE_LOCKPICK", 1);
					_deletePickLock(id);
					if _checkPickLock(id) == false then
						_badFinish(id);
					end
				end

			elseif string.len(Player[id].current_combo) == 4 then

				local cmb = string.sub(Player[id].need_combo, 1, 4);
				if cmb == Player[id].current_combo then
					ShowTexture(id, combo_R[4]);
					PlayPlayerSound(id, break_oksound);
				else
					GameTextForPlayer(id, 3150, 3140, "Вы сломали отмычку!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500)
					_resetTexCombo(id);
					PlayPlayerSound(id, break_badsound);
					Player[id].current_combo = "";
					RemoveItem(id, "QBDUUO_ITKE_LOCKPICK", 1);
					_deletePickLock(id);
					if _checkPickLock(id) == false then
						_badFinish(id);
					end
				end

			elseif string.len(Player[id].current_combo) == 5 then

				local cmb = string.sub(Player[id].need_combo, 1, 5);
				if cmb == Player[id].current_combo then
					ShowTexture(id, combo_R[5]);
					PlayPlayerSound(id, break_oksound);
				else
					GameTextForPlayer(id, 3150, 3140, "Вы сломали отмычку!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500)
					_resetTexCombo(id);
					PlayPlayerSound(id, break_badsound);
					Player[id].current_combo = "";
					RemoveItem(id, "QBDUUO_ITKE_LOCKPICK", 1);
					_deletePickLock(id);
					if _checkPickLock(id) == false then
						_badFinish(id);
					end
				end

			elseif string.len(Player[id].current_combo) == 6 then

				local cmb = string.sub(Player[id].need_combo, 1, 6);
				if cmb == Player[id].current_combo then
					ShowTexture(id, combo_R[6]);
					PlayPlayerSound(id, break_oksound);
					_goodFinish(id);
				else
					GameTextForPlayer(id, 3150, 3140, "Вы сломали отмычку!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500)
					_resetTexCombo(id);
					PlayPlayerSound(id, break_badsound);
					Player[id].current_combo = "";
					RemoveItem(id, "QBDUUO_ITKE_LOCKPICK", 1);
					_deletePickLock(id);
					if _checkPickLock(id) == false then
						_badFinish(id);
					end
				end

			end


		end
	end
end

function _badFinish(id)

	UnFreeze(id);
	PlayAnimation(id, "S_RUN");

	_resetTexCombo(id);
	HideTexture(id, combotex_1);
	HideTexture(id, combotex_2);

	Player[id].door_id = 0;
	Player[id].need_combo = "";
	Player[id].current_combo = "";


end

function _goodFinish(id)

	GameTextForPlayer(id, 3150, 3140, "Вы взломали дверь!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 1000)

	UnFreeze(id);
	PlayAnimation(id, "S_RUN");

	_resetTexCombo(id);
	HideTexture(id, combotex_1);
	HideTexture(id, combotex_2);

	Player[id].need_combo = "";
	Player[id].current_combo = "";
	
	local d_id = Player[id].door_id;

	Mob.SetUseWithItem(DOORS_ARR[d_id].mob, " ");
	Player[id].door_id = 0;


end

function _resetTexCombo(id)

	local lens = string.len(Player[id].current_combo);
	local symbol = {};

	if lens == 1 then
		symbol[1] = string.sub(Player[id].current_combo, 1, 1);
		if symbol[1] == "L" then
			HideTexture(id, combo_L[1]);
		else
			HideTexture(id, combo_R[1]);
		end

	elseif lens == 2 then
		symbol[1] = string.sub(Player[id].current_combo, 1, 1);
		symbol[2] = string.sub(Player[id].current_combo, 2, 2);

		if symbol[1] == "L" then
			HideTexture(id, combo_L[1]);
		else
			HideTexture(id, combo_R[1]);
		end

		if symbol[2] == "L" then
			HideTexture(id, combo_L[2]);
		else
			HideTexture(id, combo_R[2]);
		end

	elseif lens == 3 then
		symbol[1] = string.sub(Player[id].current_combo, 1, 1);
		symbol[2] = string.sub(Player[id].current_combo, 2, 2);
		symbol[3] = string.sub(Player[id].current_combo, 3, 3);

		if symbol[1] == "L" then
			HideTexture(id, combo_L[1]);
		else
			HideTexture(id, combo_R[1]);
		end

		if symbol[2] == "L" then
			HideTexture(id, combo_L[2]);
		else
			HideTexture(id, combo_R[2]);
		end

		if symbol[3] == "L" then
			HideTexture(id, combo_L[3]);
		else
			HideTexture(id, combo_R[3]);
		end

	elseif lens == 4 then
		symbol[1] = string.sub(Player[id].current_combo, 1, 1);
		symbol[2] = string.sub(Player[id].current_combo, 2, 2);
		symbol[3] = string.sub(Player[id].current_combo, 3, 3);
		symbol[4] = string.sub(Player[id].current_combo, 4, 4);

		if symbol[1] == "L" then
			HideTexture(id, combo_L[1]);
		else
			HideTexture(id, combo_R[1]);
		end

		if symbol[2] == "L" then
			HideTexture(id, combo_L[2]);
		else
			HideTexture(id, combo_R[2]);
		end

		if symbol[3] == "L" then
			HideTexture(id, combo_L[3]);
		else
			HideTexture(id, combo_R[3]);
		end

		if symbol[4] == "L" then
			HideTexture(id, combo_L[4]);
		else
			HideTexture(id, combo_R[4]);
		end

	elseif lens == 5 then
		symbol[1] = string.sub(Player[id].current_combo, 1, 1);
		symbol[2] = string.sub(Player[id].current_combo, 2, 2);
		symbol[3] = string.sub(Player[id].current_combo, 3, 3);
		symbol[4] = string.sub(Player[id].current_combo, 4, 4);
		symbol[5] = string.sub(Player[id].current_combo, 5, 5);

		if symbol[1] == "L" then
			HideTexture(id, combo_L[1]);
		else
			HideTexture(id, combo_R[1]);
		end

		if symbol[2] == "L" then
			HideTexture(id, combo_L[2]);
		else
			HideTexture(id, combo_R[2]);
		end

		if symbol[3] == "L" then
			HideTexture(id, combo_L[3]);
		else
			HideTexture(id, combo_R[3]);
		end

		if symbol[4] == "L" then
			HideTexture(id, combo_L[4]);
		else
			HideTexture(id, combo_R[4]);
		end

		if symbol[5] == "L" then
			HideTexture(id, combo_L[5]);
		else
			HideTexture(id, combo_R[5]);
		end

	elseif lens == 6 then
		symbol[1] = string.sub(Player[id].current_combo, 1, 1);
		symbol[2] = string.sub(Player[id].current_combo, 2, 2);
		symbol[3] = string.sub(Player[id].current_combo, 3, 3);
		symbol[4] = string.sub(Player[id].current_combo, 4, 4);
		symbol[5] = string.sub(Player[id].current_combo, 5, 5);
		symbol[6] = string.sub(Player[id].current_combo, 6, 6);

		if symbol[1] == "L" then
			HideTexture(id, combo_L[1]);
		else
			HideTexture(id, combo_R[1]);
		end

		if symbol[2] == "L" then
			HideTexture(id, combo_L[2]);
		else
			HideTexture(id, combo_R[2]);
		end

		if symbol[3] == "L" then
			HideTexture(id, combo_L[3]);
		else
			HideTexture(id, combo_R[3]);
		end

		if symbol[4] == "L" then
			HideTexture(id, combo_L[4]);
		else
			HideTexture(id, combo_R[4]);
		end

		if symbol[5] == "L" then
			HideTexture(id, combo_L[5]);
		else
			HideTexture(id, combo_R[5]);
		end

		if symbol[6] == "L" then
			HideTexture(id, combo_L[6]);
		else
			HideTexture(id, combo_R[6]);
		end

	end

end