
--  #  Hero system by royclapton  #
--  #         version: 1.0        #

DIR_HEROES = "Database/Heroes/";
HEROES_LIST = {};
HEROES_LIST_ACTIVE = {};

HERO_TEX = CreateTexture(40, 44, 8187, 7232, 'menu_ingame')

function _heroInit()
	
	print("");
	print(" ############################");
	print(" #        Hero system       #");
	print(" #                          #");

	local file = io.open(DIR_HEROES.."HeroesBase.txt", "r");
	if file then
		for line in file:lines() do
			local result, hero = sscanf(line, "s");
			if result == 1 then
				table.insert(HEROES_LIST, hero);
			end
		end
		file:close();
	end
	print(" #          "..table.getn(HEROES_LIST).." load          #");
	print(" ############################");


end

function _aHeroConnect(id)

	for _, v in pairs(HEROES_LIST) do
		if GetPlayerName(id) == v then
			ShowChat(id, 1);
			SendPlayerMessage(id, 255, 255, 255, "Текущий никнейм уже занят.")
			Kick(id);
		end
	end

	Player[id].hero_list = false;
	Player[id].hero_use = {false, nil};
	Player[id].hero_draws = {};
	for i = 1, 27 do
		Player[id].hero_draws[i] = CreatePlayerDraw(id, 0, 0, "");
	end

end

function _createHero(id, sets)

	if Player[id].astatus > 0 then
		if Player[id].hero_list == false then
			local cmdfull, hero_type, hero_str, hero_dex, hero_hp, hero_mp, hero_h1, hero_h2, hero_bow, hero_cbow, hero_circle, hero_name = sscanf(sets, "sddddddddds");
			if cmdfull == 1 then

				local time = os.date('*t');
			    local ryear = time.year;
				local rmonth = time.month;
				local rday = time.day;
				local rhour = string.format("%02d", time.hour);
				local rminute = string.format("%02d", time.min);
				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(id);

				local file_players = io.open("Database/Players/Profiles/"..hero_name..".txt", "r");
				if file_players then
					SendPlayerMessage(id, 255, 255, 255, "Текущее имя занято игроком.")
					file_players:close();
				else
					local filename = hero_name;
					local file_b = io.open("Database/Heroes/Profiles/"..filename..".txt", "w");

					file_b:write(hero_name.."\n");

					if hero_type == "человек" then
						file_b:write("PC_HERO".."\n");
						file_b:write(bodyM.." "..bodyT.." "..headM.." "..headT.."\n");

					elseif hero_type == "орк" then
						file_b:write("ORC_ROAM".."\n");
						file_b:write("NULL".."\n");

					elseif hero_type == "орк-воин" then
						file_b:write("ORCWARRIOR_ROAM".."\n");
						file_b:write("NULL".."\n");

					elseif hero_type == "элитный-орк" then
						file_b:write("ORCELITE_ROAM".."\n");
						file_b:write("NULL".."\n");

					elseif hero_type == "орк-шаман" then
						file_b:write("ORCSHAMAN_SIT".."\n");
						file_b:write("NULL".."\n");
					end

					file_b:write(hero_str.."\n");
					file_b:write(hero_dex.."\n");
					file_b:write(hero_hp.."\n");
					file_b:write(hero_mp.."\n");
					file_b:write(hero_h1.."\n");
					file_b:write(hero_h2.."\n");
					file_b:write(hero_bow.."\n");
					file_b:write(hero_cbow.."\n");
					file_b:write(hero_circle.."\n");
					file_b:write(Player[id].meinfo.."\n");
					file_b:write(Player[id].nickname.."\n");
					file_b:write(rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);
					file_b:close();

					local file_i = io.open("Database/Heroes/Items/"..filename..".txt","w+");
					if hero_type == "человек" then

						if GetEquippedArmor(id) ~= "NULL" then
							file_i:write(string.upper(GetEquippedArmor(id)).." 1\n");
						end

						if GetEquippedMeleeWeapon(id) ~= "NULL" then
							file_i:write(string.upper(GetEquippedMeleeWeapon(id)).." 1\n");
						end

						if GetEquippedRangedWeapon(id) ~= "NULL" then
							file_i:write(string.upper(GetEquippedRangedWeapon(id)).." 1\n");
						end

						file_i:close();
					else
						file_i:close();
					end

					local file = io.open("Database/Heroes/HeroesBase.txt", "a+");
					file:write(hero_name.."\n");
					file:close();

					table.insert(HEROES_LIST, hero_name);

					SendPlayerMessage(id, 255, 255, 255, "Персонаж "..hero_name.." создан!");
					LogString("Logs/Admins/Heroes", Player[id].nickname.." создал персонажа "..hero_name.." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Неправильно введена команда. Внимательнее контролируйте заполнение каждого пункта:")
				SendPlayerMessage(id, 255, 255, 255, "/сперс (тип персонажа) (сила) (ловкость) (хп) (мана) (одноруч) (двуруч) (лук) (арбалет) (маг. круг) (имя персонажа) ")
				SendPlayerMessage(id, 255, 255, 255, "Имя персонажа может содержать пробелы.")
				SendPlayerMessage(id, 255, 255, 255, "Активные типы персонажа: человек / орк / орк-воин / элитный-орк / орк-шаман")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "Вначале закройте список персонажей.")
		end
	end
end
addCommandHandler({"/сперс"}, _createHero);

function _heroesKey(id, down, up)

	if down == KEY_ESCAPE then
		if Player[id].astatus > 0 then
			if Player[id].hero_list == true then
				HideTexture(id, HERO_TEX);
				for i = 1, 25 do
					HidePlayerDraw(id, Player[id].hero_draws[i]);
				end
				UnFreeze(id);
				FreezeCamera(id, 0);
				SetDefaultCamera(id);
				ShowChat(id, 1);
				Player[id].hero_list = false;
			end
		end
	end

end

function _heroList(id, sets)

	if Player[id].astatus > 0 then
		local result, page = sscanf(sets, "d");
		if result == 1 then
			if Player[id].hero_list == false then
				if table.getn(HEROES_LIST) > 0 then
					ShowTexture(id, HERO_TEX);
					for i = 1, 25 do
						ShowPlayerDraw(id, Player[id].hero_draws[i]);
					end
					_heroListUpdate(id, page);
					Freeze(id);
					FreezeCamera(id, 1);
					ShowChat(id, 0);
					Player[id].hero_list = true;
				else
					SendPlayerMessage(id, 255, 255, 255, "Список персонажей пуст.")
				end
			else
				HideTexture(id, HERO_TEX);
				for i = 1, 25 do
					HidePlayerDraw(id, Player[id].hero_draws[i]);
				end
				UnFreeze(id);
				FreezeCamera(id, 0);
				SetDefaultCamera(id);
				ShowChat(id, 1);
				Player[id].hero_list = false;
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/персонажи (1-4)")
		end
	end

end
addCommandHandler({"/персонажи"}, _heroList);

function _heroClearDraws(id)

	for i = 1, 25 do
		UpdatePlayerDraw(id, Player[id].hero_draws[i], 0, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end

end

function _heroListUpdate(id, page)

	_heroClearDraws(id)

	if page == 1 then
		for i = 1, 25 do
			if HEROES_LIST[i] ~= nil then
				local filename = string.upper(HEROES_LIST[i]);
				local file = io.open("Database/Heroes/Profiles/"..filename..".txt", "r");
				local admin_name = ""; local date = ""; local stats = "";

				line = file:read("*l");

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					if text == "PC_HERO" then
						stats = stats.."Человек".." / ";
					elseif text == "ORC_ROAM" then
						stats = stats.."Орк".." / ";
					elseif text == "ORCWARRIOR_ROAM" then
						stats = stats.."Орк-воин".." / ";
					elseif text == "ORCSHAMAN_SIT" then
						stats = stats.."Орк-шаман".." / ";
					elseif text == "ORCELITE_ROAM" then
						stats = stats.."Элитный-орк".." / ";
					end
				end

				line = file:read("*l");

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."с-"..text.." / ";
				end

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."л-"..text.." / ";
				end

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."хп-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."мп-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."о-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."д-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."л-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."а-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."к-"..text.." / ";
				end
				
				line = file:read("*l");

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					admin_name = text;
				end

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					date = text;
				end



				file:close();
				local str = "ID: "..i.." # "..HEROES_LIST[i].." / "..stats..date.." ("..admin_name..")";
				UpdatePlayerDraw(id, Player[id].hero_draws[i], 300, 260+250*i, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			end
		end
	elseif page == 2 then
		
		local c = 1;

		for i = 26, 50 do
			if HEROES_LIST[i] ~= nil then
				local filename = string.upper(HEROES_LIST[i]);
				local file = io.open("Database/Heroes/Profiles/"..filename..".txt", "r");
				local admin_name = ""; local date = ""; local stats = "";

				line = file:read("*l");

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					if text == "PC_HERO" then
						stats = stats.."Человек".." / ";
					elseif text == "ORC_ROAM" then
						stats = stats.."Орк".." / ";
					elseif text == "ORCWARRIOR_ROAM" then
						stats = stats.."Орк-воин".." / ";
					elseif text == "ORCSHAMAN_SIT" then
						stats = stats.."Орк-шаман".." / ";
					elseif text == "ORCELITE_ROAM" then
						stats = stats.."Элитный-орк".." / ";
					end
				end

				line = file:read("*l");

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."с-"..text.." / ";
				end

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."л-"..text.." / ";
				end

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."хп-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."мп-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."о-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."д-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."л-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."а-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."к-"..text.." / ";
				end
				
				line = file:read("*l");
	
				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					admin_name = text;
				end

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					date = text;
				end



				file:close();
				local str = "ID: "..i.." # "..HEROES_LIST[i].." / "..stats..date.." ("..admin_name..")";
				UpdatePlayerDraw(id, Player[id].hero_draws[c], 300, 260+250*c, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				c = c + 1;
			end
		end
	elseif page == 3 then

		local c = 1;
		for i = 51, 75 do
			if HEROES_LIST[i] ~= nil then
				local filename = string.upper(HEROES_LIST[i]);
				local file = io.open("Database/Heroes/Profiles/"..filename..".txt", "r");
				local admin_name = ""; local date = ""; local stats = "";

				line = file:read("*l");

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					if text == "PC_HERO" then
						stats = stats.."Человек".." / ";
					elseif text == "ORC_ROAM" then
						stats = stats.."Орк".." / ";
					elseif text == "ORCWARRIOR_ROAM" then
						stats = stats.."Орк-воин".." / ";
					elseif text == "ORCSHAMAN_SIT" then
						stats = stats.."Орк-шаман".." / ";
					elseif text == "ORCELITE_ROAM" then
						stats = stats.."Элитный-орк".." / ";
					end
				end

				line = file:read("*l");

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."с-"..text.." / ";
				end

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."л-"..text.." / ";
				end

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."хп-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."мп-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."о-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."д-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."л-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."а-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."к-"..text.." / ";
				end
				
				line = file:read("*l");

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					admin_name = text;
				end

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					date = text;
				end



				file:close();
				local str = "ID: "..i.." # "..HEROES_LIST[i].." / "..stats..date.." ("..admin_name..")";
				UpdatePlayerDraw(id, Player[id].hero_draws[c], 300, 260+250*c, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				c = c + 1;
			end
		end
	elseif page == 4 then

		local c = 1;
		for i = 76, 100 do
			if HEROES_LIST[i] ~= nil then
				local filename = string.upper(HEROES_LIST[i]);
				local file = io.open("Database/Heroes/Profiles/"..filename..".txt", "r");
				local admin_name = ""; local date = ""; local stats = "";

				line = file:read("*l");

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					if text == "PC_HERO" then
						stats = stats.."Человек".." / ";
					elseif text == "ORC_ROAM" then
						stats = stats.."Орк".." / ";
					elseif text == "ORCWARRIOR_ROAM" then
						stats = stats.."Орк-воин".." / ";
					elseif text == "ORCSHAMAN_SIT" then
						stats = stats.."Орк-шаман".." / ";
					elseif text == "ORCELITE_ROAM" then
						stats = stats.."Элитный-орк".." / ";
					end
				end

				line = file:read("*l");

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."с-"..text.." / ";
				end

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."л-"..text.." / ";
				end

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."хп-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."мп-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."о-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."д-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."л-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."а-"..text.." / ";
				end


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					stats = stats.."к-"..text.." / ";
				end
				
				line = file:read("*l");


				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					admin_name = text;
				end

				line = file:read("*l");
				local result, text = sscanf(line, "s");
				if result == 1 then
					date = text;
				end



				file:close();
				local str = "ID: "..i.." # "..HEROES_LIST[i].." / "..stats..date.." ("..admin_name..")";
				UpdatePlayerDraw(id, Player[id].hero_draws[c], 300, 260+250*c, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				c = c + 1;
			end
		end
	end

end

function _intoHero(id, sets)

	if Player[id].astatus > 0 then
		local result, hero_id = sscanf(sets, "d");
		if result == 1 then
			if Player[id].hero_use[1] == false then
				if HEROES_LIST[hero_id] ~= nil then

					local block_status = false;
					for i, v in pairs(HEROES_LIST_ACTIVE) do
						if v == hero_id then
							block_status = true;
						end
					end

					if block_status == false then
						table.insert(HEROES_LIST_ACTIVE, hero_id);
						SavePlayer(id);
						SaveItems(id);
						SaveStats(id);
						SaveSkill(id);
						-----------------------------------

						Player[id].hero_use[1] = true;
						Player[id].hero_use[2] = hero_id;

						-- hero params
						Player[id].meinfo = "";
						Player[id].zvanie = "";
						Player[id].nickname = HEROES_LIST[hero_id];
						SetPlayerName(id, HEROES_LIST[hero_id]);

						-- hero stats
						local file = io.open("Database/Heroes/Profiles/"..HEROES_LIST[hero_id]..".txt", "r");
						
						line = file:read("*l"); -- name
						line = file:read("*l"); -- instance
						local result, text = sscanf(line, "s");
						if result == 1 then
							SetPlayerInstance(id, text);
						end

						if GetPlayerInstance(id) == "PC_HERO" then
							line = file:read("*l"); -- skin
							local result, v1, v2, v3, v4 = sscanf(line, "sdsd");
							if result == 1 then
								SetPlayerAdditionalVisual(id, v1, v2, v3, v4);
								SetPlayerScience(id, 1, 1);
							end
						else
							line = file:read("*l"); -- instance
						end

						line = file:read("*l"); -- str
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerStrength(id, text);
						end

						line = file:read("*l"); -- dex
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerDexterity(id, text);
						end

						line = file:read("*l"); -- hp
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerMaxHealth(id, text);
							SetPlayerHealth(id, text);
						end

						line = file:read("*l"); -- mp
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerMaxMana(id, text);
							SetPlayerMana(id, text);
						end

						line = file:read("*l"); -- h1
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerSkillWeapon(id, SKILL_1H, text);			
						end

						line = file:read("*l"); -- h2
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerSkillWeapon(id, SKILL_2H, text);								
						end

						line = file:read("*l"); -- bow
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerSkillWeapon(id, SKILL_BOW, text);	
						end

						line = file:read("*l"); -- cbow
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerSkillWeapon(id, SKILL_CBOW, text);								
						end
						

						line = file:read("*l"); -- circle
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerMagicLevel(id, text);		
						end

						line = file:read("*l"); -- meinfo
						local result, text = sscanf(line, "s");
						if result == 1 then
							Player[id].meinfo = text;	
						end
						file:close();

						-- items
						ClearInventory(id);
						ReadItems(id);
						SaveItems(id);

						SendPlayerMessage(id, 255, 255, 255, "Вы вселились в персонажа "..GetPlayerName(id));

					else
						SendPlayerMessage(id, 255, 255, 255, "Персонажем уже кто-то управляет.")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Неверно указан ID персонажа.")
				end
			else

				if HEROES_LIST[hero_id] ~= nil then

					local block_status = false;
					for i, v in pairs(HEROES_LIST_ACTIVE) do
						if v == hero_id then
							block_status = true;
						end
					end

					if block_status == false then

						for i, v in pairs(HEROES_LIST_ACTIVE) do
							if v == Player[id].hero_use[2] then
								table.remove(HEROES_LIST_ACTIVE, i);
							end
						end

						table.insert(HEROES_LIST_ACTIVE, hero_id);
						Player[id].hero_use[1] = true;
						Player[id].hero_use[2] = hero_id;
						
						-- hero params
						Player[id].meinfo = "";
						Player[id].zvanie = "";
						Player[id].nickname = HEROES_LIST[hero_id];
						SetPlayerName(id, HEROES_LIST[hero_id]);

						-- hero stats
						local file = io.open("Database/Heroes/Profiles/"..HEROES_LIST[hero_id]..".txt", "r");
						
						line = file:read("*l"); -- name
						line = file:read("*l"); -- instance
						local result, text = sscanf(line, "s");
						if result == 1 then
							SetPlayerInstance(id, text);
						end

						if GetPlayerInstance(id) == "PC_HERO" then
							line = file:read("*l"); -- skin
							local result, v1, v2, v3, v4 = sscanf(line, "sdsd");
							if result == 1 then
								SetPlayerAdditionalVisual(id, v1, v2, v3, v4);
								SetPlayerScience(id, 1, 1);
							end
						else
							line = file:read("*l"); -- instance
						end

						line = file:read("*l"); -- str
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerStrength(id, text);
						end

						line = file:read("*l"); -- dex
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerDexterity(id, text);
						end

						line = file:read("*l"); -- hp
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerMaxHealth(id, text);
							SetPlayerHealth(id, text);
						end

						line = file:read("*l"); -- mp
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerMaxMana(id, text);
							SetPlayerMana(id, text);
						end

						line = file:read("*l"); -- h1
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerSkillWeapon(id, SKILL_1H, text);			
						end

						line = file:read("*l"); -- h2
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerSkillWeapon(id, SKILL_2H, text);								
						end

						line = file:read("*l"); -- bow
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerSkillWeapon(id, SKILL_BOW, text);	
						end

						line = file:read("*l"); -- cbow
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerSkillWeapon(id, SKILL_CBOW, text);								
						end
						

						line = file:read("*l"); -- circle
						local result, text = sscanf(line, "d");
						if result == 1 then
							SetPlayerMagicLevel(id, text);		
						end

						line = file:read("*l"); -- meinfo
						local result, text = sscanf(line, "s");
						if result == 1 then
							Player[id].meinfo = text;	
						end

						file:close();

						-- items
						ClearInventory(id);
						ReadItems(id);
						SaveItems(id);

						SendPlayerMessage(id, 255, 255, 255, "Вы вселились в персонажа "..GetPlayerName(id));
					else
						SendPlayerMessage(id, 255, 255, 255, "Персонажем уже кто-то управляет.")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Неверно указан ID персонажа.")
				end
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/вперс (ид)")
		end
	end
end
addCommandHandler({"/вперс"}, _intoHero);


function _itemHero(id, sets)

	if Player[id].astatus > 0 then
		local cmd, hero_id, amount, item_name = sscanf(sets, "dds");
		if cmd == 1 then
			if HEROES_LIST[hero_id] ~= nil then

				local status = false;
				for i, v in pairs(HEROES_LIST_ACTIVE) do
					if v == hero_id then
						status = true;
					end
				end

				if status == true then

					local pid = nil;
					for i = 0, GetMaxPlayers() do
						if Player[i].hero_use[2] == hero_id then
							pid = i;
							break
						end
					end

					local rusname = GetItemCode(item_name);
					if rusname ~= item_name then
						GiveItem(pid, string.upper(GetItemCode(item_name)), amount);
						SendPlayerMessage(pid, 255, 255, 255, "Персонаж получил: "..GetItemCode(item_name).." x"..amount);
						SendPlayerMessage(id, 255, 255, 255, "Персонаж получил: "..GetItemCode(item_name).." x"..amount);
						SaveItems(pid);
					else
						SendPlayerMessage(id, 255, 255, 255, "Предмет не найден.")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Персонаж неактивен.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Персонаж не найден.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/пдать (ид персонажа) (кол-во) (название предмета)")
		end
	end
end
addCommandHandler({"/пдать"}, _itemHero);

function _deleteHero(id, sets)

	if Player[id].astatus > 2 then
		local cmd, hero_id = sscanf(sets, "d");
		if Player[id].hero_list == false then
			if cmd == 1 then
				if HEROES_LIST[hero_id] ~= nil then
					local hero_name = HEROES_LIST[hero_id];
					SendPlayerMessage(id, 255, 255, 255, "Персонаж "..HEROES_LIST[hero_id].." удален.")

					local status = false;
					for i, v in pairs(HEROES_LIST_ACTIVE) do
						if v == hero_id then
							status = true;
							table.remove(HEROES_LIST_ACTIVE, i);
						end
					end

					table.remove(HEROES_LIST, hero_id);

					if status == true then
						for i = 0, GetMaxPlayers() do
							if Player[i].hero_use[2] == hero_id then
								Player[i].hero_use[2] = nil;
								Player[i].hero_use[1] = false;
								Kick(i);
							end
						end
					end

					os.remove("Database/Heroes/Items/"..hero_name..".txt");
					os.remove("Database/Heroes/Profiles/"..hero_name..".txt");
					local file = io.open("Database/Heroes/HeroesBase.txt", "w+");
					for i, v in pairs(HEROES_LIST) do
						file:write(HEROES_LIST[i].."\n");
					end
					file:close();

				else
					SendPlayerMessage(id, 255, 255, 255, "Персонаж не найден.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "/уперс (ид)")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "Вначале закройте список персонажей.");
		end
	end
end
addCommandHandler({"/уперс"}, _deleteHero);