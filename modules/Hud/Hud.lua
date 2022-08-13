
--  #   Hud system by royclapton  #
--  #         version: 1.0        #

local t_hud = CreateTexture(96, 7516, 1160, 8063, 'tom_hud_text')

function _hudConnect(id)

	Player[id].hud_draw = {};
	Player[id].hud = false;
	Player[id].h_hp = 0;
	Player[id].h_mp = 0;

end

-- init
function _hudInit(id)

	for i = 1, 3 do
		Player[id].hud_draw[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	_hud(id);

end

function _hud(id)

	if Player[id].hud == false then

		for i = 1, 3 do
			ShowPlayerDraw(id, Player[id].hud_draw[i]);
		end
		_updateHud(id);
		ShowTexture(id, t_hud);
		Player[id].hud = true;

		ShowPlayerDraw(id, gtdraw);
		ShowPlayerDraw(id, rtdraw);
		ShowPlayerDraw(id, datedraw);
		ShowTexture(id, timebc);
		UpdateTTable(id);
		Player[id].animtimer = SetTimerEx("UpdateTTable", 6000, 1, id);

		ShowPlayerDraw(id, Player[id].medraw);
		ShowPlayerDraw(id, Player[id].namedraw);

	else

		for i = 1, 3 do
			HidePlayerDraw(id, Player[id].hud_draw[i]);
		end
		_updateHud(id)
		HideTexture(id, t_hud);
		Player[id].hud = false;

		HidePlayerDraw(id, gtdraw);
		HidePlayerDraw(id, rtdraw);
		HidePlayerDraw(id, datedraw);
		HideTexture(id, timebc);
		KillTimer(Player[id].animtimer);

		HidePlayerDraw(id, Player[id].medraw);
		HidePlayerDraw(id, Player[id].namedraw);
		
	end

end


function _destroyHud(id)

	for i = 1, 3 do
		HidePlayerDraw(id, Player[id].hud_draw[i]);
		DestroyPlayerDraw(id, Player[id].hud_draw[i]);
	end
	HideTexture(id, t_hud);
	Player[id].hud = false;

end

function _hudKey(id, down, up)

	if Player[id].loggedIn == true then
		if down == KEY_F4 then
			_hud(id);
		end
	end

end

function _updateHud(id)

	if Player[id].h_hp > 99 then
		UpdatePlayerDraw(id, Player[id].hud_draw[1], 165, 7370, GetPlayerHealth(id), "Font_Old_10_White_Hi.TGA", 255, 255, 255)
	elseif Player[id].h_hp > 9 and Player[id].h_hp < 100 then
		UpdatePlayerDraw(id, Player[id].hud_draw[1], 165+30, 7370, GetPlayerHealth(id), "Font_Old_10_White_Hi.TGA", 255, 255, 255)
	elseif Player[id].h_hp < 10 then
		UpdatePlayerDraw(id, Player[id].hud_draw[1], 165+50, 7370, GetPlayerHealth(id), "Font_Old_10_White_Hi.TGA", 255, 255, 255)
	end

	if Player[id].h_mp > 99 then
		UpdatePlayerDraw(id, Player[id].hud_draw[2], 560, 7370, GetPlayerMana(id), "Font_Old_10_White_Hi.TGA", 255, 255, 255)
	elseif Player[id].h_mp > 9 and Player[id].h_mp < 100 then
		UpdatePlayerDraw(id, Player[id].hud_draw[2], 560+30, 7370, GetPlayerMana(id), "Font_Old_10_White_Hi.TGA", 255, 255, 255)
	elseif Player[id].h_mp < 10 then
		UpdatePlayerDraw(id, Player[id].hud_draw[2], 560+50, 7370, GetPlayerMana(id), "Font_Old_10_White_Hi.TGA", 255, 255, 255)
	end

	if Player[id].energy > 99 then
		if Player[id].energyblock < 100 then
			UpdatePlayerDraw(id, Player[id].hud_draw[3], 937, 7370, Player[id].energy, "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		else
			UpdatePlayerDraw(id, Player[id].hud_draw[3], 937, 7370, Player[id].energy, "Font_Old_10_White_Hi.TGA", 247, 77, 77)
		end
	elseif Player[id].energy > 9 and Player[id].energy < 100 then
		if Player[id].energyblock < 100 then
			UpdatePlayerDraw(id, Player[id].hud_draw[3], 937+30, 7370, Player[id].energy, "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		else
			UpdatePlayerDraw(id, Player[id].hud_draw[3], 937+30, 7370, Player[id].energy, "Font_Old_10_White_Hi.TGA", 247, 77, 77)
		end
	elseif Player[id].energy < 10 then
		if Player[id].energyblock < 100 then
			UpdatePlayerDraw(id, Player[id].hud_draw[3], 937+50, 7370, Player[id].energy, "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		else
			UpdatePlayerDraw(id, Player[id].hud_draw[3], 937+50, 7370, Player[id].energy, "Font_Old_10_White_Hi.TGA", 247, 77, 77)
		end
	end



end

function _updateHealth(id)

	local proc = GetPlayerHealth(id) / GetPlayerMaxHealth(id);
	local formula = (proc * 100);

	Player[id].h_hp = GetPlayerHealth(id);
	_updateHud(id);

end


function _checkHealth(id, new, old)

	if new ~= old then
		_updateHealth(id)
	end

end

function _updateMana(id)

	local proc = GetPlayerMana(id) / GetPlayerMaxMana(id);
	local formula = (proc * 100);

	Player[id].h_mp = GetPlayerMana(id);
	_updateHud(id);

end

function _checkMana(id, new, old)

	if new ~= old then
		_updateMana(id)
	end

end


