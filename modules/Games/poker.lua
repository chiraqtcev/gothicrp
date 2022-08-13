

--  #   Poker by royclapton    #
--  #       version: 1.0       #


-- разметка для кубов слева
poker_rd_left = {}
poker_rd_left[1] = {1980, 1481, 2600, 2431};
poker_rd_left[2] = {1980, 2582, 2600, 3509};
poker_rd_left[3] = {1980, 3644, 2600, 4544};
poker_rd_left[4] = {1980, 4692, 2600, 5588};
poker_rd_left[5] = {1980, 5739, 2600, 6620};


-- разметка для кубов справа
poker_rd_right = {}
poker_rd_right[1] = {5365, 1481, 5980, 2431};
poker_rd_right[2] = {5365, 2582, 5980, 3509};
poker_rd_right[3] = {5365, 3644, 5980, 4544};
poker_rd_right[4] = {5365, 4692, 5980, 5588};
poker_rd_right[5] = {5365, 5739, 5980, 6620};


-- текстуры оформления
local poker_left = CreateTexture(1744, 1181, 2871, 7267, 'menu_ingame')
local poker_right = CreateTexture(5086, 1193, 6213, 7270, 'menu_ingame')
local poker_down = CreateTexture(1721, 7225, 6258, 8115, 'menu_ingame')

local poker_sound = CreateSound("poker_game_sound.wav")

poker_buttons_tex = {};
poker_buttons_tex[1] = CreateTexture(3553, 1678, 4458, 2033, 'menu_ingame')
poker_buttons_tex[2] = CreateTexture(3553, 2178, 4458, 2533, 'menu_ingame')

function _poker_textureSlots()

	for p = 0, GetMaxPlayers() do

		Player[p]._poker_texleft = {};
		Player[p]._poker_texleft[1] = CreateTexture(poker_rd_left[1][1], poker_rd_left[1][2], poker_rd_left[1][3], poker_rd_left[1][4], '')
		Player[p]._poker_texleft[2] = CreateTexture(poker_rd_left[2][1], poker_rd_left[2][2], poker_rd_left[2][3], poker_rd_left[2][4], '')
		Player[p]._poker_texleft[3] = CreateTexture(poker_rd_left[3][1], poker_rd_left[3][2], poker_rd_left[3][3], poker_rd_left[3][4], '')
		Player[p]._poker_texleft[4] = CreateTexture(poker_rd_left[4][1], poker_rd_left[4][2], poker_rd_left[4][3], poker_rd_left[4][4], '')
		Player[p]._poker_texleft[5] = CreateTexture(poker_rd_left[5][1], poker_rd_left[5][2], poker_rd_left[5][3], poker_rd_left[5][4], '')

		Player[p]._poker_texright = {};
		Player[p]._poker_texright[1] = CreateTexture(poker_rd_right[1][1], poker_rd_right[1][2], poker_rd_right[1][3], poker_rd_right[1][4], '')
		Player[p]._poker_texright[2] = CreateTexture(poker_rd_right[2][1], poker_rd_right[2][2], poker_rd_right[2][3], poker_rd_right[2][4], '')
		Player[p]._poker_texright[3] = CreateTexture(poker_rd_right[3][1], poker_rd_right[3][2], poker_rd_right[3][3], poker_rd_right[3][4], '')
		Player[p]._poker_texright[4] = CreateTexture(poker_rd_right[4][1], poker_rd_right[4][2], poker_rd_right[4][3], poker_rd_right[4][4], '')
		Player[p]._poker_texright[5] = CreateTexture(poker_rd_right[5][1], poker_rd_right[5][2], poker_rd_right[5][3], poker_rd_right[5][4], '')

		Player[p]._poker_texleft_select = {};
		Player[p]._poker_texleft_select[1] = CreateTexture(0, 0, 0, 0, '');
		Player[p]._poker_texleft_select[2] = CreateTexture(0, 0, 0, 0, '');
		Player[p]._poker_texleft_select[3] = CreateTexture(0, 0, 0, 0, '');
		Player[p]._poker_texleft_select[4] = CreateTexture(0, 0, 0, 0, '');
		Player[p]._poker_texleft_select[5] = CreateTexture(0, 0, 0, 0, '');

		Player[p]._poker_texright_select = {};
		Player[p]._poker_texright_select[1] = CreateTexture(0, 0, 0, 0, '');
		Player[p]._poker_texright_select[2] = CreateTexture(0, 0, 0, 0, '');
		Player[p]._poker_texright_select[3] = CreateTexture(0, 0, 0, 0, '');
		Player[p]._poker_texright_select[4] = CreateTexture(0, 0, 0, 0, '');
		Player[p]._poker_texright_select[5] = CreateTexture(0, 0, 0, 0, '');

	end


end


function _pokerConnect(id)

	Player[id]._poker_play = false;
	Player[id]._poker_invite = {0, nil};
	Player[id]._poker_pos = 0;
	Player[id]._poker_enemy = nil;
	Player[id]._poker_hod = false;
	Player[id]._poker_score = {};
	Player[id]._poker_score_nums = {1, 1, 1, 1, 1};
	Player[id]._poker_select = {};
	Player[id]._poker_block = false;
	Player[id]._poker_power = 0;
	Player[id]._poker_turn = nil;
	Player[id]._poker_draws = {};

	for i = 1, 7 do
		Player[id]._poker_draws[i] = CreatePlayerDraw(id, 0, 0, "");
	end

end

function _poker_startGame(id)

	ShowChat(id, 0);
	SetCursorVisible(id, 1);
	Freeze(id);
	FreezeCamera(id, 1);

	math.randomseed(os.time());
	

	Player[id]._poker_play = true;
	Player[id]._poker_pos = Player[id]._poker_invite[1];
	Player[id]._poker_enemy = Player[id]._poker_invite[2];
	local pid = Player[id]._poker_enemy;
	if Player[id]._poker_invite[1] == 1 then
		Player[id]._poker_turn = GetPlayerName(id);
	else
		Player[id]._poker_turn = GetPlayerName(Player[id]._poker_invite[2]);
	end

	for i = 1, 7 do
		ShowPlayerDraw(id, Player[id]._poker_draws[i]);
	end

	ShowTexture(id, poker_left);
	ShowTexture(id, poker_right);
	ShowTexture(id, poker_down);

	for i = 1, table.getn(Player[id]._poker_texleft) do
		ShowTexture(id, Player[id]._poker_texleft[i]);
	end

	for i = 1, table.getn(Player[id]._poker_texright) do
		ShowTexture(id, Player[id]._poker_texright[i]);
	end

	for i = 1, table.getn(Player[id]._poker_texleft_select) do
		ShowTexture(id, Player[id]._poker_texleft_select[i]);
	end

	for i = 1, table.getn(Player[id]._poker_texright_select) do
		ShowTexture(id, Player[id]._poker_texright_select[i]);
	end

	for i = 1, table.getn(poker_buttons_tex) do
		ShowTexture(id, poker_buttons_tex[i]);
	end

	_poker_updateNames(id);
	_poker_GetCombo(id);
	_poker_updateDrawTurn(id);

	_poker_UpdateTex(id)
	_poker_UpdateTexReDice(id);
	_poker_updateButtons(id);

end
addCommandHandler({"/пкр"}, _poker_startGame);

function _poker_tUpdate(id)
	_poker_UpdateTex(id);
	_poker_GetCombo(id);
	_poker_updateDrawTurn(id);

	for i = 0, GetMaxPlayers() do
		if GetDistancePlayers(id, i) <= 600 then
			SendPlayerMessage(i, 255, 255, 255, "(Покер) "..GetPlayerName(id).." имеет: "
												..Player[id]._poker_score_nums[1].." "..Player[id]._poker_score_nums[2].." "
												..Player[id]._poker_score_nums[3].." "..Player[id]._poker_score_nums[4].." " 
												..Player[id]._poker_score_nums[5]);       
		end
	end

	PlayPlayerSound(id, poker_sound);
	


end

function _poker_firstRandom(id)

	for i = 1, 5 do
		Player[id]._poker_score_nums[i] = math.random(1, 6);
	end

end

function _poker_leave(id)

	for i = 0, GetMaxPlayers() do
		if GetDistancePlayers(id, i) <= 600 then
			SendPlayerMessage(i, 255, 255, 255, "(Покер) "..GetPlayerName(id).." сдался. ");         
		end
	end
	PlayAnimation(id, "T_NO");


	local pid = Player[id]._poker_enemy;
	_poker_reUpdateReRollTex(id);
	_poker_reUpdateReRollTex(pid);
	_poker_FinalEnd(id)
	_poker_FinalEnd(pid)
	Player[id]._poker_play = false;
	Player[id]._poker_invite = {0, nil};
	Player[id]._poker_pos = 0;
	Player[id]._poker_enemy = nil;
	Player[id]._poker_hod = false;
	Player[id]._poker_score = {};
	Player[id]._poker_score_nums = {};
	Player[id]._poker_select = {};
	Player[id]._poker_block = false;
	Player[id]._poker_turn = nil;
	--Player[id]._poker_texleft = {}; Player[id]._poker_texleft_select = {}; -- INV_SLOT_EQUIPPED_FOCUS
	--Player[id]._poker_texright = {}; Player[id]._poker_texright_select = {}; -- INV_SLOT_EQUIPPED_FOCUS

	-------------------------------------------------------

	SetCursorVisible(pid, 0);
	UnFreeze(pid);
	FreezeCamera(pid, 0);
	ShowChat(pid, 1);

	for i = 1, 7 do
		HidePlayerDraw(pid, Player[pid]._poker_draws[i]);
	end


	HideTexture(pid, poker_left);
	HideTexture(pid, poker_right);
	HideTexture(pid, poker_down);

	for i = 1, table.getn(Player[pid]._poker_texleft) do
		HideTexture(id, Player[pid]._poker_texleft[i]);
	end

	for i = 1, table.getn(Player[pid]._poker_texright) do
		HideTexture(id, Player[pid]._poker_texright[i]);
	end

	for i = 1, table.getn(Player[pid]._poker_texleft_select) do
		HideTexture(id, Player[pid]._poker_texleft_select[i]);
	end

	for i = 1, table.getn(Player[pid]._poker_texright_select) do
		HideTexture(id, Player[pid]._poker_texright_select[i]);
	end

	for i = 1, table.getn(poker_buttons_tex) do
		HideTexture(id, poker_buttons_tex[i]);
	end

	Player[pid]._poker_play = false;
	Player[pid]._poker_invite = {0, nil};
	Player[pid]._poker_pos = 1;
	Player[pid]._poker_enemy = nil;
	Player[pid]._poker_hod = false;
	Player[pid]._poker_score = {};
	Player[pid]._poker_score_nums = {};
	Player[pid]._poker_select = {};
	Player[pid]._poker_block = false;
	Player[pid]._poker_turn = nil;
	--Player[pid]._poker_texleft = {}; Player[pid]._poker_texleft_select = {}; -- INV_SLOT_EQUIPPED_FOCUS
	--Player[pid]._poker_texright = {}; Player[pid]._poker_texright_select = {}; -- INV_SLOT_EQUIPPED_FOCUS



end

function _poker_updateButtons(id)
	UpdatePlayerDraw(id, Player[id]._poker_draws[6], 3760, 1757, "  Пас", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._poker_draws[7], 3760, 2257, "  Ход", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
end

function _poker_UpdateTex(id)
	

	if Player[id]._poker_pos == 1 then

		local pid = Player[id]._poker_enemy;
		table.sort(Player[id]._poker_score_nums, function (a, b) return (a > b) end);
		Player[id]._poker_score = {tostring("poker"..Player[id]._poker_score_nums[1]),
								   tostring("poker"..Player[id]._poker_score_nums[2]),
								   tostring("poker"..Player[id]._poker_score_nums[3]),
								   tostring("poker"..Player[id]._poker_score_nums[4]),
								   tostring("poker"..Player[id]._poker_score_nums[5])};

		for i = 1, 5 do
			UpdateTexture(Player[id]._poker_texleft[i], poker_rd_left[i][1], poker_rd_left[i][2], poker_rd_left[i][3], poker_rd_left[i][4], Player[id]._poker_score[i]);
		end
		--------------------------------------------------------------------------------------
		table.sort(Player[pid]._poker_score_nums, function (a, b) return (a > b) end);
		Player[pid]._poker_score = {tostring("poker"..Player[pid]._poker_score_nums[1]),
								   tostring("poker"..Player[pid]._poker_score_nums[2]),
								   tostring("poker"..Player[pid]._poker_score_nums[3]),
								   tostring("poker"..Player[pid]._poker_score_nums[4]),
								   tostring("poker"..Player[pid]._poker_score_nums[5])};
		for i = 1, 5 do
			UpdateTexture(Player[id]._poker_texright[i], poker_rd_right[i][1], poker_rd_right[i][2], poker_rd_right[i][3], poker_rd_right[i][4], Player[pid]._poker_score[i]);
		end


	elseif Player[id]._poker_pos == 2 then

		local pid = Player[id]._poker_enemy;

		table.sort(Player[pid]._poker_score_nums, function (a, b) return (a > b) end);
		Player[pid]._poker_score = {tostring("poker"..Player[pid]._poker_score_nums[1]),
								   tostring("poker"..Player[pid]._poker_score_nums[2]),
								   tostring("poker"..Player[pid]._poker_score_nums[3]),
								   tostring("poker"..Player[pid]._poker_score_nums[4]),
								   tostring("poker"..Player[pid]._poker_score_nums[5])};

		for i = 1, 5 do
			UpdateTexture(Player[id]._poker_texleft[i], poker_rd_left[i][1], poker_rd_left[i][2], poker_rd_left[i][3], poker_rd_left[i][4], Player[pid]._poker_score[i]);
		end
		--------------------------------------------------------------------------------------
		table.sort(Player[id]._poker_score_nums, function (a, b) return (a > b) end);
		Player[id]._poker_score = {tostring("poker"..Player[id]._poker_score_nums[1]),
								   tostring("poker"..Player[id]._poker_score_nums[2]),
								   tostring("poker"..Player[id]._poker_score_nums[3]),
								   tostring("poker"..Player[id]._poker_score_nums[4]),
								   tostring("poker"..Player[id]._poker_score_nums[5])};

		for i = 1, 5 do
			UpdateTexture(Player[id]._poker_texright[i], poker_rd_right[i][1], poker_rd_right[i][2], poker_rd_right[i][3], poker_rd_right[i][4], Player[id]._poker_score[i]);
		end
	end

end

function _poker_SelectReRoll(id, d)

	if Player[id]._poker_turn == GetPlayerName(id) then

		local status = false;
		for i, v in pairs(Player[id]._poker_select) do
			if v == d then
				_poker_GameText(id, "Отмена кость #"..d, 700);
				_poker_reUpdateReRollTex(id);
				table.remove(Player[id]._poker_select, i);
				status = true;
				break
			end
		end

		if status == false then
			_poker_GameText(id, "Выбрана кость #"..d, 700);
			table.insert(Player[id]._poker_select, d);
		end

		_poker_UpdateTexReDice(id);
	end
	
end

function _poker_reUpdateReRollTex(id)

	if Player[id]._poker_pos == 1 then

		for i = 1, 5 do
			UpdateTexture(Player[id]._poker_texleft_select[i], 0, 0, 0, 0, "");
		end

	elseif Player[id]._poker_pos == 2 then

		for i = 1, 5 do
			UpdateTexture(Player[id]._poker_texright_select[i], 0, 0, 0, 0, "");
		end
	end

end

function _poker_ReRoll(id)

	local pid = Player[id]._poker_enemy;

	if Player[id]._poker_turn == GetPlayerName(id) then
		if Player[id]._poker_hod == false then

			_poker_reUpdateReRollTex(id);

			for i, v in pairs(Player[id]._poker_select) do
				Player[id]._poker_score_nums[v] = math.random(1, 6);
			end

			Player[id]._poker_turn = GetPlayerName(pid);
			Player[pid]._poker_turn = GetPlayerName(pid);

			_poker_UpdateTex(id);	
			_poker_GetCombo(id);
			_poker_updateDrawTurn(id);

			_poker_UpdateTex(pid);
			_poker_GetCombo(pid);
			_poker_updateDrawTurn(pid);

			_poker_GameText(id, "Ход обновлен.");
			_poker_GameText(pid, "Ваш ход.", 1300);

			Player[id]._poker_hod = true;

			for i = 0, GetMaxPlayers() do
			if GetDistancePlayers(id, i) <= 600 then
				SendPlayerMessage(i, 255, 255, 255, "(Покер) "..GetPlayerName(id).." имеет: "
													..Player[id]._poker_score_nums[1].." "..Player[id]._poker_score_nums[2].." "
													..Player[id]._poker_score_nums[3].." "..Player[id]._poker_score_nums[4].." " 
													..Player[id]._poker_score_nums[5]);

				SendPlayerMessage(i, 255, 255, 255, "(Покер) "..GetPlayerName(pid).." имеет: "
													..Player[pid]._poker_score_nums[1].." "..Player[pid]._poker_score_nums[2].." "
													..Player[pid]._poker_score_nums[3].." "..Player[pid]._poker_score_nums[4].." " 
													..Player[pid]._poker_score_nums[5]);        
				end
			end

			PlayPlayerSound(id, poker_sound);
			PlayPlayerSound(pid, poker_sound);

		end
	end

	if Player[id]._poker_hod == true and Player[pid]._poker_hod == true then

		Player[id]._poker_turn = "---";
		Player[pid]._poker_turn = "---";
		SetTimerEx(_poker_FinalEnd, 5000, 0, id);
		SetTimerEx(_poker_FinalEnd, 5000, 0, pid);
		_poker_Final(id);
		_poker_UpdateTex(pid);
		_poker_GetCombo(pid);
		_poker_updateDrawTurn(pid);

	end
	

end

function _poker_Final(id)

	local pid = Player[id]._poker_enemy;

	if Player[id]._poker_power > Player[pid]._poker_power then

		for i = 0, GetMaxPlayers() do
			if GetDistancePlayers(id, i) <= 600 then
				SendPlayerMessage(i, 255, 255, 255, "(Покер) "..GetPlayerName(id).." победил. ");  
				SendPlayerMessage(i, 255, 255, 255, "Выигрышная комбинация: ".._poker_cPoker(id));
			end
		end

		_poker_GameText(id, "Вы победили!", 2500);
		_poker_GameText(pid, "Вы проиграли!", 2500);

	elseif Player[id]._poker_power < Player[pid]._poker_power then

		for i = 0, GetMaxPlayers() do
			if GetDistancePlayers(id, i) <= 600 then
				SendPlayerMessage(i, 255, 255, 255, "(Покер) "..GetPlayerName(pid).." победил. "); 
				SendPlayerMessage(i, 255, 255, 255, "Выигрышная комбинация: ".._poker_cPoker(pid));        
			end
		end

		_poker_GameText(pid, "Вы победили!", 2500);
		_poker_GameText(id, "Вы проиграли!", 2500);

	elseif Player[id]._poker_power == Player[pid]._poker_power then

		local sum1 = 0; local sum2 = 0;
		for i, v in pairs(Player[id]._poker_score_nums) do
			sum1 = sum1 + v;
		end

		for i, v in pairs(Player[pid]._poker_score_nums) do
			sum2 = sum2 + v;
		end

		if sum1 > sum2 then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) <= 600 then
					SendPlayerMessage(i, 255, 255, 255, "(Покер) "..GetPlayerName(id).." победил. ");
					SendPlayerMessage(i, 255, 255, 255, "Выигрышная комбинация: ".._poker_cPoker(id));     
				end
			end

			_poker_GameText(id, "Вы победили!", 2500);
			_poker_GameText(pid, "Вы проиграли!", 2500);

		elseif sum2 > sum1 then

			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(pid, i) <= 600 then
					SendPlayerMessage(i, 255, 255, 255, "(Покер) "..GetPlayerName(pid).." победил. ");     
					SendPlayerMessage(i, 255, 255, 255, "Выигрышная комбинация: ".._poker_cPoker(pid));    
				end
			end

			_poker_GameText(pid, "Вы победили!", 2500);
			_poker_GameText(id, "Вы проиграли!", 2500);

		elseif sum1 == sum2 then

			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) <= 600 then
					SendPlayerMessage(i, 255, 255, 255, "(Покер) Между игроками ничья. ");         
				end
			end

			_poker_GameText(pid, "Ничья!", 2500);
			_poker_GameText(id, "Ничья!", 2500);

		end


	end

end

function _poker_FinalEnd(id)

	SetCursorVisible(id, 0);
	UnFreeze(id);
	FreezeCamera(id, 0);
	ShowChat(id, 1);

	for i = 1, 7 do
		HidePlayerDraw(id, Player[id]._poker_draws[i]);
	end


	HideTexture(id, poker_left);
	HideTexture(id, poker_right);
	HideTexture(id, poker_down);

	for i = 1, table.getn(Player[id]._poker_texleft) do
		HideTexture(id, Player[id]._poker_texleft[i]);
	end

	for i = 1, table.getn(Player[id]._poker_texright) do
		HideTexture(id, Player[id]._poker_texright[i]);
	end

	for i = 1, table.getn(Player[id]._poker_texleft_select) do
		HideTexture(id, Player[id]._poker_texleft_select[i]);
	end

	for i = 1, table.getn(Player[id]._poker_texright_select) do
		HideTexture(id, Player[id]._poker_texright_select[i]);
	end

	for i = 1, table.getn(poker_buttons_tex) do
		HideTexture(id, poker_buttons_tex[i]);
	end


	Player[id]._poker_play = false;
	Player[id]._poker_invite = {0, nil};
	Player[id]._poker_pos = 0;
	Player[id]._poker_enemy = nil;
	Player[id]._poker_hod = false;
	Player[id]._poker_score = {};
	Player[id]._poker_score_nums = {};
	Player[id]._poker_select = {};
	Player[id]._poker_block = false;
	Player[id]._poker_turn = nil;
	--Player[id]._poker_texleft = {}; Player[id]._poker_texleft_select = {}; -- INV_SLOT_EQUIPPED_FOCUS
	--Player[id]._poker_texright = {}; Player[id]._poker_texright_select = {}; -- INV_SLOT_EQUIPPED_FOCUS


end

function _poker_GameText(id, text, time)

	if time then
		GameTextForPlayer(id, 4349, 7572, text, "Font_Old_10_White_Hi.TGA", 255, 255, 255, time)
	else
		GameTextForPlayer(id, 4349, 7572, text, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 1500)
	end

end

function _pokerMouse(id, button, pressed, posX, posY);

	if button == MB_LEFT then
		if pressed == 0 then
			if Player[id]._poker_play == true then

				if posX > 3553 and posX < 4458 and posY > 1678 and posY < 2033 then
					_poker_leave(id);
				end

				if Player[id]._poker_turn == GetPlayerName(id) then
				
					if posX > 3553 and posX < 4458 and posY > 2178 and posY < 2533 then
						_poker_ReRoll(id);
					end

					------------------------------------------------------
					
					if Player[id]._poker_pos == 1 then

						for i = 1, 5 do
							if posX > poker_rd_left[i][1] and posX < poker_rd_left[i][3] and posY > poker_rd_left[i][2] and posY < poker_rd_left[i][4] then
								_poker_SelectReRoll(id, i);
								break
							end
						end

					elseif Player[id]._poker_pos == 2 then

						for i = 1, 5 do
							if posX > poker_rd_right[i][1] and posX < poker_rd_right[i][3] and posY > poker_rd_right[i][2] and posY < poker_rd_right[i][4] then
								_poker_SelectReRoll(id, i);
								break
							end
						end

					end
				end
			end
		end
	end
end

function _poker_UpdateTexReDice(id)

	if Player[id]._poker_pos == 1 then

		for i, v in pairs(Player[id]._poker_select) do
			UpdateTexture(Player[id]._poker_texleft_select[v], poker_rd_left[v][1], poker_rd_left[v][2], poker_rd_left[v][3], poker_rd_left[v][4], 'INV_SLOT_EQUIPPED_FOCUS');
		end

	elseif Player[id]._poker_pos == 2 then

		for i, v in pairs(Player[id]._poker_select) do
			UpdateTexture(Player[id]._poker_texright_select[v], poker_rd_right[v][1], poker_rd_right[v][2], poker_rd_right[v][3], poker_rd_right[v][4], 'INV_SLOT_EQUIPPED_FOCUS');
		end

	end

end


function _poker_GetTurn(id)
	return Player[id]._poker_turn;
end

function _poker_updateDrawTurn(id)

	local txt = string.format("%s%s", "Текущий ход: ", _poker_GetTurn(id)); 
	UpdatePlayerDraw(id, Player[id]._poker_draws[3], 1871, 7372, txt, "Font_Old_10_White_Hi.TGA", 255, 255, 255);

end


function _poker_updateNames(id) 

	local nick_my = GetPlayerName(id);
	local nick_enemy = GetPlayerName(Player[id]._poker_enemy);

	if Player[id]._poker_pos == 1 then

		UpdatePlayerDraw(id, Player[id]._poker_draws[1], 1791, 1014, nick_my, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id]._poker_draws[2], 5116, 1010, nick_enemy, "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	elseif Player[id]._poker_pos == 2 then

		UpdatePlayerDraw(id, Player[id]._poker_draws[1], 1791, 1014, nick_enemy, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id]._poker_draws[2], 5116, 1010, nick_my, "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	end


end

function _poker_GetCombo(id)


	local txt = string.format("%s%s", "Ваше комбо: ", _poker_cPoker(id)); 
	UpdatePlayerDraw(id, Player[id]._poker_draws[4], 1871, 7572, txt, "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	local txt = string.format("%s%s", "Ком-бо противника: ", _poker_cPoker(Player[id]._poker_enemy)); 
	UpdatePlayerDraw(id, Player[id]._poker_draws[5], 1871, 7772, txt, "Font_Old_10_White_Hi.TGA", 255, 255, 255);


end

-- да мне похуй что говнокод я ничего умнее не придумал
function _poker_cPoker(id)


	table.sort(Player[id]._poker_score_nums, function (a, b) return (a > b) end);

	local num = nil;
	if Player[id]._poker_score_nums[1] ~= nil then
		num = Player[id]._poker_score_nums[1];
		local combo = "Наивысшее число: "..num;
		Player[id]._poker_power = 1;
	else
		combo = "Наивысшее число: %6";
	end

	-- пара
	if  Player[id]._poker_score_nums[5] == Player[id]._poker_score_nums[4]
		or Player[id]._poker_score_nums[4] == Player[id]._poker_score_nums[3]
		or Player[id]._poker_score_nums[3] == Player[id]._poker_score_nums[2]
		or Player[id]._poker_score_nums[2] == Player[id]._poker_score_nums[1] then
		combo = "Пара";
		Player[id]._poker_power = 2;
	end

	-- две пары
	if  Player[id]._poker_score_nums[5] == Player[id]._poker_score_nums[4]
		and Player[id]._poker_score_nums[4] ~= Player[id]._poker_score_nums[3]
		and Player[id]._poker_score_nums[3] == Player[id]._poker_score_nums[2] then
		combo = "Две пары";
		Player[id]._poker_power = 3;

	elseif  Player[id]._poker_score_nums[5] == Player[id]._poker_score_nums[4]
		and Player[id]._poker_score_nums[4] ~= Player[id]._poker_score_nums[3]
		and Player[id]._poker_score_nums[3] ~= Player[id]._poker_score_nums[2]
		and Player[id]._poker_score_nums[2] == Player[id]._poker_score_nums[1] then
		combo = "Две пары";
		Player[id]._poker_power = 3;

	elseif Player[id]._poker_score_nums[1] == Player[id]._poker_score_nums[2]
		and Player[id]._poker_score_nums[2] ~= Player[id]._poker_score_nums[3]
		and Player[id]._poker_score_nums[3] == Player[id]._poker_score_nums[4] then
		combo = "Две пары";
		Player[id]._poker_power = 3;

	elseif Player[id]._poker_score_nums[1] ~= Player[id]._poker_score_nums[2] and
		Player[id]._poker_score_nums[2] == Player[id]._poker_score_nums[3] and
		Player[id]._poker_score_nums[3] ~= Player[id]._poker_score_nums[4] and
		Player[id]._poker_score_nums[4] == Player[id]._poker_score_nums[5] then
		combo = "Две пары";
		Player[id]._poker_power = 3;

	

	end

	-- тройка
	if  Player[id]._poker_score_nums[5] == Player[id]._poker_score_nums[4]
		and Player[id]._poker_score_nums[4] == Player[id]._poker_score_nums[3] then
		combo = "Тройка";
		Player[id]._poker_power = 4;

	elseif Player[id]._poker_score_nums[1] == Player[id]._poker_score_nums[2]
		and Player[id]._poker_score_nums[2] == Player[id]._poker_score_nums[3] then
		combo = "Тройка";
		Player[id]._poker_power = 4;

	elseif Player[id]._poker_score_nums[2] == Player[id]._poker_score_nums[3]
		and Player[id]._poker_score_nums[3] == Player[id]._poker_score_nums[4] then
		combo = "Тройка";
		Player[id]._poker_power = 4;
	end

	-- стрит
	if  Player[id]._poker_score_nums[1] == 6 and 
		Player[id]._poker_score_nums[2] == 5 and
		Player[id]._poker_score_nums[3] == 4 and
		Player[id]._poker_score_nums[4] == 3 and
		Player[id]._poker_score_nums[5] == 2 then
		combo = "Стрит";
		Player[id]._poker_power = 5;
	
	elseif  Player[id]._poker_score_nums[1] == 5 and 
			Player[id]._poker_score_nums[2] == 4 and
			Player[id]._poker_score_nums[3] == 3 and
			Player[id]._poker_score_nums[4] == 2 and
			Player[id]._poker_score_nums[5] == 1 then
			combo = "Стрит";
			Player[id]._poker_power = 5;
	end

	-- фулл хаус
	if  Player[id]._poker_score_nums[5] == Player[id]._poker_score_nums[4]
		and Player[id]._poker_score_nums[4] == Player[id]._poker_score_nums[3]
		and Player[id]._poker_score_nums[3] ~= Player[id]._poker_score_nums[2]
		and Player[id]._poker_score_nums[2] == Player[id]._poker_score_nums[1] then
		combo = "Фулл-хаус";
		Player[id]._poker_power = 6;

	elseif Player[id]._poker_score_nums[1] == Player[id]._poker_score_nums[2]
		and Player[id]._poker_score_nums[2] == Player[id]._poker_score_nums[3]
		and Player[id]._poker_score_nums[3] ~= Player[id]._poker_score_nums[4]
		and Player[id]._poker_score_nums[4] == Player[id]._poker_score_nums[5] then
		combo = "Фулл-хаус";
		Player[id]._poker_power = 6;
	end


	-- каре
	if  Player[id]._poker_score_nums[5] == Player[id]._poker_score_nums[4]
		and Player[id]._poker_score_nums[4] == Player[id]._poker_score_nums[3]
		and Player[id]._poker_score_nums[3] == Player[id]._poker_score_nums[2]
		and Player[id]._poker_score_nums[2] ~= Player[id]._poker_score_nums[1] then
		combo = "Каре";
		Player[id]._poker_power = 7;

	elseif Player[id]._poker_score_nums[1] == Player[id]._poker_score_nums[2]
		and Player[id]._poker_score_nums[2] == Player[id]._poker_score_nums[3]
		and Player[id]._poker_score_nums[3] == Player[id]._poker_score_nums[4]
		and Player[id]._poker_score_nums[4] ~= Player[id]._poker_score_nums[5] then
		combo = "Каре";
		Player[id]._poker_power = 7;
	end


	-- покер
	if  Player[id]._poker_score_nums[1] == Player[id]._poker_score_nums[2] 
		and Player[id]._poker_score_nums[2] == Player[id]._poker_score_nums[3]
		and Player[id]._poker_score_nums[3] == Player[id]._poker_score_nums[4]
		and Player[id]._poker_score_nums[4] == Player[id]._poker_score_nums[5] then
		combo = "Покер";
		Player[id]._poker_power = 8;
	end

	return combo;
end


-----------------------------------------------------------------------------------
-- ################################################################################
-----------------------------------------------------------------------------------

function _poker_invite(id, sets)

	local result, pid = sscanf(sets, "d");
	if result == 1 then
		if Player[id].loggedIn == true then
			if Player[pid]._poker_play == false then
				if IsNPC(pid) == 0 then
					if pid ~= id then
						if GetDistancePlayers(id, pid) <= 500 then
							SendPlayerMessage(pid, 255, 255, 255, GetPlayerName(id).." приглашает вас сыграть в покер.")
							SendPlayerMessage(pid, 255, 255, 255, "Для ответа введите: /покер_да или /покер_нет.")
							SendPlayerMessage(id, 255, 255, 255, "Вы отправили приглашение игроку "..GetPlayerName(pid)..".");
							SendPlayerMessage(id, 255, 255, 255, "Для открытия чата во время игры нажмите F12.");
							SendPlayerMessage(pid, 255, 255, 255, "Для открытия чата во время игры нажмите F12.");
							Player[id]._poker_invite = {1, pid};
							Player[pid]._poker_invite = {2, id};
						else
							SendPlayerMessage(id, 255, 255, 255, "Игрок далеко от вас.")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "Нельзя указывать свой ID.")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Это бот.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Игрок уже играет.")
			end
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "/покер (ид)")
	end

end
addCommandHandler({"/покер", "/poker"}, _poker_invite);

function _poker_inviteYes(id)

	if Player[id].loggedIn == true then
		if Player[id]._poker_play == false then
			if Player[id]._poker_invite[1] ~= 0 then
				_poker_firstRandom(id);
				_poker_firstRandom(Player[id]._poker_invite[2]);
				_poker_startGame(id);
				_poker_startGame(Player[id]._poker_invite[2]);
				SetTimerEx(_poker_tUpdate, 500, 0, id);
				SetTimerEx(_poker_tUpdate, 500, 0, Player[id]._poker_invite[2]);

				for i = 0, GetMaxPlayers() do
					if GetDistancePlayers(id, i) <= 1000 then
						SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id).." начал партию с "..GetPlayerName(Player[id]._poker_invite[2])..".");         
					end
				end

			end
		end
	end

end
addCommandHandler({"/покер_да", "/poker_yes"}, _poker_inviteYes);

-- мне все еще похуй что получилось уебищно!)
function _poker_inviteNo(id)

	if Player[id].loggedIn == true then
		if Player[id]._poker_play == false then
			if Player[id]._poker_invite[1] ~= 0 then
				local pid = Player[id]._poker_invite[2];
				SendPlayerMessage(id, 255, 255, 255, "(Покер) Вы отказались от игры.")
				SendPlayerMessage(pid, 255, 255, 255, "(Покер) Игрок отказался от игры.")
				Player[id]._poker_invite = {0, nil};
				Player[pid]._poker_invite = {0, nil};
			end
		end
	end

end
addCommandHandler({"/покер_нет", "/poker_no"}, _poker_inviteNo);