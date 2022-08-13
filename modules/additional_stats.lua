DLP = {};

function InitDLPlayerInfo(playerid)
	DLP[playerid] = nil;
	DLP[playerid] = {};
	DLP[playerid].science = {};
	AddScience(playerid, "Кузнец", 0);
	AddScience(playerid, "Алхимия", 0);
	AddScience(playerid, "Повар", 0);
	AddScience(playerid, "Оружейник", 0);
	AddScience(playerid, "Бронник", 0);
	AddScience(playerid, "Кожевник", 0);
	AddScience(playerid, "Портной", 0);
	AddScience(playerid, "Плотник", 0);
	AddScience(playerid, "Взломщик", 0);
	

	LoadDLPlayerInfo(playerid);
end

function LoadDLPlayerInfo(playerid)
	local file = io.open("dlbase/account/"..GetPlayerName(playerid)..".me","r+");
	if file then
		local i = 0;
		for line in file:lines() do
			
			local result, ttype, level, uid = sscanf(line,"sds");
			if result == 1 then
				if ttype == "SCIENCE" then
					AddScience(playerid, tostring(uid), tonumber(level));
				end
			end
			
		end
	file:close();
	else
		SaveDLPlayerInfo(playerid);
	end
end


function SaveDLPlayerInfo(playerid)
	local file = io.open("dlbase/account/"..GetPlayerName(playerid)..".me","w");
	
	for k, v in pairs(DLP[playerid].science) do
		file:write("SCIENCE "..DLP[playerid].science[k].level.." "..k..'\n');
	end
	file:close();
end

function AddScience(playerid, uid, level)
	DLP[playerid].science[uid] = {};
	DLP[playerid].science[uid].level	= level;
end


local GUI_Playerinfo_page1_t = 0;
local GUI_Playerinfo_page2_t = 0;
local GUI_Playerinfo_page3_t = 0;

function InitAS()
	repeat
		GUI_Playerinfo_page1_t = CreateTexture(2000, 1000, 3500, 6200, 'dlg_conversation');
	until GUI_Playerinfo_page1_t ~= 0;
	repeat
		GUI_Playerinfo_page2_t = CreateTexture(3500, 1000, 5000, 6200, 'dlg_conversation');
	until GUI_Playerinfo_page2_t ~= 0;
	repeat
		GUI_Playerinfo_page3_t = CreateTexture(5000, 1000, 6500, 6200, 'dlg_conversation');
	until GUI_Playerinfo_page3_t ~= 0;
end
InitAS();


function GetScienceLevel(playerid, uid)
	if DLP[playerid].science[uid] ~= nil then
		return DLP[playerid].science[uid].level;
	else
		return 0;
	end
end



GUI_Playerinfo = {};

function GUIPlayerinfoInit(playerid, playerid)
	if GUI_Playerinfo[playerid] ~= nil then
		DestroyDLPlayerinfo(playerid);
		GUI_Playerinfo[playerid] = nil;
	end
	
	if IsNPC(playerid) == 0 and DLP[playerid] == nil then
		InitDLPlayerInfo(playerid);
	end
	
	if IsPlayerConnected(playerid) == 1 and IsNPC(playerid) == 0 and DLP[playerid] ~= nil then
		GUI_Playerinfo[playerid] = {};
		GUI_Playerinfo[playerid].tid = playerid;
		GUI_Playerinfo[playerid].page1_d = CreatePlayerDraw(playerid, 2500, 800, "Класс", "Font_Old_20_White_Hi.TGA", 240, 230, 140);
		GUI_Playerinfo[playerid].page2_d = CreatePlayerDraw(playerid, 4000, 800, "Навыки", "Font_Old_20_White_Hi.TGA", 240, 230, 140);
		GUI_Playerinfo[playerid].page3_d = CreatePlayerDraw(playerid, 5500, 800, "Прочее", "Font_Old_20_White_Hi.TGA", 240, 230, 140);
		
		GUI_Playerinfo[playerid].name = CreatePlayerDraw(playerid, 2100, 1250, string.format("Имя: %s", GetPlayerName(playerid)), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		
		GUI_Playerinfo[playerid].lp = CreatePlayerDraw(playerid, 2100, 1600, "Очки навыков: 0", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		
		
		GUI_Playerinfo[playerid].science_dname = {};
		GUI_Playerinfo[playerid].science_dlvl = {};
		
		table.insert(GUI_Playerinfo[playerid].science_dname, CreatePlayerDraw(playerid, 3600, 1250, "Охота", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		table.insert(GUI_Playerinfo[playerid].science_dlvl, CreatePlayerDraw(playerid, 4600, 1250, string.format("Ур. %d", Player[playerid].huntlevel), "Font_Old_10_White_Hi.TGA", 240, 230, 140));

		i = 1;
		for k in pairs(DLP[playerid].science) do
			if k ~= "Охотник" then
				table.insert(GUI_Playerinfo[playerid].science_dname, CreatePlayerDraw(playerid, 3600, 1250 + 300*i, k, "Font_Old_10_White_Hi.TGA", 255, 255, 255));
				table.insert(GUI_Playerinfo[playerid].science_dlvl, CreatePlayerDraw(playerid, 4600, 1250 + 300*i, string.format("Ур. %d", DLP[playerid].science[k].level), "Font_Old_10_White_Hi.TGA", 240, 230, 140));
				i = i + 1;
			end
		end

		table.insert(GUI_Playerinfo[playerid].science_dname, CreatePlayerDraw(playerid, 3600, 1650 + 300*i, "Чтение свитков", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		table.insert(GUI_Playerinfo[playerid].science_dlvl, CreatePlayerDraw(playerid, 4600, 1650 + 300*i, string.format("Ур. %d", Player[playerid].readscrolls), "Font_Old_10_White_Hi.TGA", 240, 230, 140));
		i = i + 1;

		
		GUI_Playerinfo[playerid].dinfo = {};
		
		i = 0;
		
		table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Рудные фишки: %d", Player[playerid].rude_coins), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
		table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Руда: %d", Player[playerid].rude), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
--		table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Монеты З/С/М: %d\/%d\/%d", Player[playerid].bank1, Player[playerid].bank, Player[playerid].bank2), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
--		i = i + 1;
		
		--table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Шиллинги: %d", Player[playerid].bank1), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
		--table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Руда: %d", Player[playerid].rude), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
		table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Одноручное: %d%%", GetPlayerSkillWeapon(playerid, SKILL_1H)), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
		table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Двуручное: %d%%", GetPlayerSkillWeapon(playerid, SKILL_2H)), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
		table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Лук: %d%%", GetPlayerSkillWeapon(playerid,SKILL_BOW)), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
		table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Арбалет: %d%%", GetPlayerSkillWeapon(playerid,SKILL_CBOW)), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
		table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Сила: %d", GetPlayerStrength(playerid)), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
		table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Ловкость: %d", GetPlayerDexterity(playerid)), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
		table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("HP: %d,%d", GetPlayerHealth(playerid), GetPlayerMaxHealth(playerid)), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
		table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("MP: %d,%d", GetPlayerMana(playerid), GetPlayerMaxMana(playerid)), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
		table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Круги магии: %d", GetPlayerMagicLevel(playerid)), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
		table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Акробатика: %d", Player[playerid].acrob), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
		table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Стамина: %d", Player[playerid].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
		
		--table.insert(GUI_Playerinfo[playerid].dinfo, CreatePlayerDraw(playerid, 5100, 1250 + 300*i, string.format("Голод: %d", Player[playerid].hunger), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		i = i + 1;
	
	end
end

function ShowDLPlayerinfo(playerid)
	Player[playerid].onGUI = true;
	FreezePlayer(playerid, 1);
	ShowChat(playerid, 0);
	ShowPlayerDraw(playerid, GUI_Playerinfo[playerid].page1_d);
	ShowPlayerDraw(playerid, GUI_Playerinfo[playerid].page2_d);
	ShowPlayerDraw(playerid, GUI_Playerinfo[playerid].page3_d);
	ShowTexture(playerid, GUI_Playerinfo_page1_t);
	ShowTexture(playerid, GUI_Playerinfo_page2_t);
	ShowTexture(playerid, GUI_Playerinfo_page3_t);
	
	ShowPlayerDraw(playerid, GUI_Playerinfo[playerid].name);
	ShowPlayerDraw(playerid, GUI_Playerinfo[playerid].lp);
	
	
	for k in pairs(GUI_Playerinfo[playerid].science_dname) do
		ShowPlayerDraw(playerid, GUI_Playerinfo[playerid].science_dname[k]);
		ShowPlayerDraw(playerid, GUI_Playerinfo[playerid].science_dlvl[k]);
	end
	
	for k in pairs(GUI_Playerinfo[playerid].dinfo) do
		ShowPlayerDraw(playerid, GUI_Playerinfo[playerid].dinfo[k]);
	end
	
	if GUI_Playerinfo[playerid].tid == playerid then
			
	end
end

function UpdateDLPlayerinfo(playerid)
	
end

function HideDLPlayerinfo(playerid)
	if GUI_Playerinfo[playerid] ~= nil then
		HidePlayerDraw(playerid, GUI_Playerinfo[playerid].page1_d);
		HidePlayerDraw(playerid, GUI_Playerinfo[playerid].page2_d);
		HidePlayerDraw(playerid, GUI_Playerinfo[playerid].page3_d);
		HideTexture(playerid, GUI_Playerinfo_page1_t);
		HideTexture(playerid, GUI_Playerinfo_page2_t);
		HideTexture(playerid, GUI_Playerinfo_page3_t);
		
		HidePlayerDraw(playerid, GUI_Playerinfo[playerid].name);
		HidePlayerDraw(playerid, GUI_Playerinfo[playerid].lp);
		--HidePlayerDraw(playerid, GUI_Playerinfo[playerid].cursor);
		
	
		
		for k in pairs(GUI_Playerinfo[playerid].science_dname) do
			HidePlayerDraw(playerid, GUI_Playerinfo[playerid].science_dname[k]);
			HidePlayerDraw(playerid, GUI_Playerinfo[playerid].science_dlvl[k]);
		end
		
		for k in pairs(GUI_Playerinfo[playerid].dinfo) do
			HidePlayerDraw(playerid, GUI_Playerinfo[playerid].dinfo[k]);
		end
		
		Player[playerid].onGUI = false;
		FreezePlayer(playerid, 0);
		ShowChat(playerid, 1);
	end
end

function DestroyDLPlayerinfo(playerid)
	if GUI_Playerinfo[playerid] ~= nil then
		if GUI_Playerinfo[playerid].page1_d ~= nil then
			DestroyPlayerDraw(playerid, GUI_Playerinfo[playerid].page1_d);
		end
		
		if GUI_Playerinfo[playerid].page2_d ~= nil then
			DestroyPlayerDraw(playerid, GUI_Playerinfo[playerid].page2_d);
		end
		
		if GUI_Playerinfo[playerid].page3_d ~= nil then
			DestroyPlayerDraw(playerid, GUI_Playerinfo[playerid].page3_d);
		end
		
		if GUI_Playerinfo[playerid].name ~= nil then
			DestroyPlayerDraw(playerid, GUI_Playerinfo[playerid].name);
		end
		
		if GUI_Playerinfo[playerid].lp ~= nil then
			DestroyPlayerDraw(playerid, GUI_Playerinfo[playerid].lp);
		end
		
		
		for k in pairs(GUI_Playerinfo[playerid].science_dname) do
			DestroyPlayerDraw(playerid, GUI_Playerinfo[playerid].science_dname[k]);
			DestroyPlayerDraw(playerid, GUI_Playerinfo[playerid].science_dlvl[k]);
		end
		
		for k in pairs(GUI_Playerinfo[playerid].dinfo) do
			DestroyPlayerDraw(playerid, GUI_Playerinfo[playerid].dinfo[k]);
		end
		GUI_Playerinfo[playerid] = nil;
	end
end

function SaveDLChanges(playerid)
	
end

function InfoKey (playerid, keydown, keyup)
	if keydown == KEY_V then
		if Player[playerid].loggedIn == true then
			GUIPlayerinfoInit(playerid, playerid);
			ShowDLPlayerinfo(playerid);
		else
			HideDLPlayerinfo(playerid);
			DestroyDLPlayerinfo(playerid);
		end

	elseif GUI_Playerinfo[playerid] ~= nil then
		if keydown == KEY_ESCAPE then
			HideDLPlayerinfo(playerid);
			DestroyDLPlayerinfo(playerid);	
		end	
	end
end

function CMD_SHOWDLINFO(playerid, params)
	local playerid = tonumber(params);
	if Player[playerid].astatus > 1 then
		if IsPlayerConnected(playerid) == 1 then
			GUIPlayerinfoInit(playerid, playerid);
			ShowDLPlayerinfo(playerid);
		else
		
		end
	elseif playerid == playerid then
		GUIPlayerinfoInit(playerid, playerid);
		ShowDLPlayerinfo(playerid);
	end
end
addCommandHandler({"/статс"}, CMD_SHOWDLINFO);

function CMD_GAINSCIENCE(playerid, params)
	local result, playerid, level, uid = sscanf(params, "dds");
	if Player[playerid].astatus > 1 then
		if result == 1 and IsPlayerConnected(playerid) == 1 then
			AddScience(playerid, uid, level);
			SaveDLPlayerInfo(playerid);
			SendPlayerMessage(playerid, 255, 255, 0, string.format("Вы получили уровень ремесла \"%s\". Текущий уровень: %d. Администратор: %s", uid, level, GetPlayerName(playerid)));
			SendPlayerMessage(playerid, 255, 255, 0, string.format("Вы выдали уровень ремесла \"%s\" игроку %s. Текущий уровень: %d", uid, GetPlayerName(playerid), level));
		    LogString("logREMESLO",string.format("%s %s %s %s %s %s", os.date("(%d/%m)"), GetPlayerName(playerid),"give",GetPlayerName(playerid), uid, level));
		else
		
		end
	else
	
	end
end