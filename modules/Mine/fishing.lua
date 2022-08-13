
--  #   Fishing system by royclapton  #
--  #           version: 1.0          #


function _mGetOnline()
	local on = 0;
	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true and IsPlayerConnected(i) == 1 then
			on = on + 1;
		end
	end
	ONLINE = on;
end

function freezeCameraTimerF(id)
	--FreezeCamera(id, 1);
	Freeze(id);
end

function _fishing(id, instance, a, h)

	if instance == "OOLTYB_ITMI_FISHING" then
		_mGetOnline();
		if ONLINE > 4 then
			if Player[id].energy > 4 then
				Player[id].energy = Player[id].energy - 5;
				_updateHud(id);
				ShowTexture(id, Player[id].prog_background_f);
				ShowTexture(id, Player[id].prog_f);
				--SetDefaultCamera(id);
				_newSetCameraBeforePlayer(id, 1)
				SetTimerEx("freezeCameraTimerF", 400, 0, id);
				SavePlayer(id);
				Player[id].prog_timer = SetTimerEx("_lF", 60, 1, id);
			else
				GameTextForPlayer(id, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		else
			GameTextForPlayer(id, 50, 6000, "Рыбачить можно при онлайне 5+","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
		end
	end
end

function _lF(id)

	if Player[id].current_size_f > Player[id].zero_size_f then
		Player[id].current_size_f = Player[id].current_size_f - 20;
		UpdateTexture(Player[id].prog_f, 3007, 7283, Player[id].current_size_f, 7469, 'PROGRESS_BLUE_BAR');
	else
		KillTimer(Player[id].prog_timer);
		UpdateTexture(Player[id].prog_f, 3007, 7283, Player[id].start_size_f, 7469, 'PROGRESS_BLUE_BAR');
		Player[id].current_size_f = Player[id].start_size_f;
		Player[id].prog_timer = nil;
		HideTexture(id, Player[id].prog_f)
		HideTexture(id, Player[id].prog_background_f);
		FreezeCamera(id, 0);
		SetDefaultCamera(id);
		UnFreeze(id);

		math.randomseed(os.time());
		local rnd = math.random(1, 100);

		if rnd <= 45 then
			GameTextForPlayer(id, 50, 6000, "Вы ничего не поймали.","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);

		elseif rnd == 46 then
			GameTextForPlayer(id, 50, 6000, "Вы выловили мензурку.","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			GiveItem(id, "OOLTYB_ITMI_FLASK", 1);
			SaveItems(id);

		elseif rnd == 47 then
			GameTextForPlayer(id, 50, 6000, "Вы выловили тяжелый сук.","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			GiveItem(id, "JKZTZD_ITMW_1H_BAU_MACE", 1);
			SaveItems(id);

		elseif rnd == 48 then
			GameTextForPlayer(id, 50, 6000, "Вы выловили стрелу.","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			GiveItem(id, "JKZTZD_ITRW_ARROW", 1);
			SaveItems(id);

		elseif rnd == 49 then
			GameTextForPlayer(id, 50, 6000, "Вы выловили бижутерию.","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			GiveItem(id, "OOLTYB_ITMI_BIJOUTERIE", 1);
			SaveItems(id);

		elseif rnd == 50 then
			GameTextForPlayer(id, 50, 6000, "Вы выловили кость.","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			GiveItem(id, "OOLTYB_ITAT_GOBLINBONE", 1);
			SaveItems(id);

		elseif rnd > 50 and rnd <= 80 then
			GameTextForPlayer(id, 50, 6000, "Вы выловили рыбу (х1).","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			GiveItem(id, "ZDPWLA_ITFO_FISH", 1);
			SaveItems(id);

		elseif rnd > 80 then
			GameTextForPlayer(id, 50, 6000, "Вы выловили рыбу (х2).","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			GiveItem(id, "ZDPWLA_ITFO_FISH", 2);
			SaveItems(id);
		end
	end
end
