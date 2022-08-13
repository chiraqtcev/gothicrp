
--  # ---------------------------------------------------- #
--  #  Craft system by DirkLoggan / rewrite by royclapton  #
--  #                     version: 1.0                     #
--  #----------------------------------------------------- #

function tLen(arg)
  return table.getn(arg)
end

function DeleteItem(playerid, item_instance, amountremove)
local oldValue;
local file = io.open("Database/Players/Items"..Player[playerid].nickname..".db","r+");
if file then
	for line in file:lines() do
		local result, item, value = sscanf(line,"sd");
		if result == 1 then
			if string.upper(item) == item_instance then
				oldValue = value;
			end
		end
	end
	file:close();
end
if oldValue == nil then
	oldValue = 0;
end
local newValue = oldValue - amountremove;
if newValue < 0 then
	newValue = 0;
end
local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","r+");
local tempString = file:read("*a");
file:close();
local tempString = string.gsub(tempString,string.upper(item_instance).." "..oldValue,string.upper(item_instance).." "..newValue);
local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","r+");
file:write(tempString);
file:close();
RemoveItem(playerid, item_instance, amountremove);
end

function tCount(arg)
	local count = 0;
	for _ in pairs(arg) do
		count = count + 1;
	end
	return count;
end

local CraftCategory = {};
local CraftItem = {};
local CraftPenalty = {};
local PenaltyTimer = {};
local Workspace = {};

function AddAlchemyWorkspace(x, y, z)
	local size = tLen(Workspace);
	Workspace[size] = {};
	Workspace[size].x = x;
	Workspace[size].y = y;
	Workspace[size].z = z;
	Workspace[size].range = 9999999;
	Workspace[size].cat = {};
	AddWorkspaceCategory(size, "Алхимия (1 уровень)");
	AddWorkspaceCategory(size, "Алхимия (2 уровень)");
	AddWorkspaceCategory(size, "Алхимия (3 уровень)");
	AddWorkspaceCategory(size, "Повар (1 уровень)");
	AddWorkspaceCategory(size, "Повар (2 уровень)");
	AddWorkspaceCategory(size, "Повар (3 уровень)");
	AddWorkspaceCategory(size, "Кузнец (Расходники)");
	AddWorkspaceCategory(size, "Кузнец (Инструменты)");
	AddWorkspaceCategory(size, "(О)Кузнец (Без уровня)");
	AddWorkspaceCategory(size, "(О)Кузнец (1 уровень)");
	AddWorkspaceCategory(size, "(О)Кузнец (2 уровень)");
	AddWorkspaceCategory(size, "(О)Кузнец (3 уровень)");
	AddWorkspaceCategory(size, "(О)Кузнец (4 уровень)");
	AddWorkspaceCategory(size, "(Б)Кузнец (Без уровня)");
	AddWorkspaceCategory(size, "(Б)Кузнец (1 уровень)");
	AddWorkspaceCategory(size, "(Б)Кузнец (2 уровень)");
	AddWorkspaceCategory(size, "(Б)Кузнец (3 уровень)");
	AddWorkspaceCategory(size, "(Б)Кузнец (4 уровень)");
	AddWorkspaceCategory(size, "Кожевник (Расходники)");
	AddWorkspaceCategory(size, "Кожевник (Без уровня)");
	AddWorkspaceCategory(size, "Кожевник (1 уровень)");
	AddWorkspaceCategory(size, "Кожевник (2 уровень)");
	AddWorkspaceCategory(size, "Кожевник (3 уровень)");
	AddWorkspaceCategory(size, "Кожевник (4 уровень)");
	AddWorkspaceCategory(size, "Плотник (Расходники)");
	AddWorkspaceCategory(size, "Плотник (Без уровня)");
	AddWorkspaceCategory(size, "Плотник (1 уровень)");
	AddWorkspaceCategory(size, "Плотник (2 уровень)");
	AddWorkspaceCategory(size, "Плотник (3 уровень)");
	AddWorkspaceCategory(size, "Плотник (4 уровень)");
	AddWorkspaceCategory(size,"Портной (Расходники)");
	AddWorkspaceCategory(size, "Портной (Без уровня)");
	AddWorkspaceCategory(size, "Портной (1 уровень)");
	AddWorkspaceCategory(size, "Портной (2 уровень)");
	AddWorkspaceCategory(size, "Портной (3 уровень)");
	AddWorkspaceCategory(size, "Портной (4 уровень)");
	AddWorkspaceCategory(size, "(Р) 1-й Круг");
	AddWorkspaceCategory(size, "(Р) 2-й Круг");
	AddWorkspaceCategory(size, "(С) 1-й Круг");
  AddWorkspaceCategory(size, "(С) 2-й Круг");
end


function AddWorkspaceCategory(uid, category)
	table.insert(Workspace[uid].cat, category);
end

function WorkspaceReachable(pid, uid)
	local pX, pY, pZ = GetPlayerPos(pid);
	local tDist = GetDistance3D(pX, pY, pZ, Workspace[uid].x, Workspace[uid].y, Workspace[uid].z);
	if tDist <= Workspace[uid].range then
		return 1;
	else
		return 0;
	end
end

function WorkspaceHasCategory(uid, category)
	for k, v in pairs(Workspace[uid].cat) do
		if v == category then
			return 1;
		end
	end
	
	return 0;
end

function LoadPenaltyList()
	local iFile = io.open("dlbase/craftpenaltylist.me", "r+");
	local filestream = iFile:read();
	for line in io.lines("dlbase/craftpenaltylist.me") do
		local result, name, ptime = sscanf(filestream,"sd");
		if result == 1 then
			CraftPenalty[name] = ptime;
			PenaltyTimer[name] = SetTimerEx("DecreasePenalty", 60*1000, 1, name);
		end
		filestream = iFile:read("*l");
	end
	iFile:close();
end

function DecreasePenalty(name)
	CraftPenalty[name] = CraftPenalty[name] - 1;
	if CraftPenalty[name] <= 0 then
		KillTimer(PenaltyTimer[name]);
		CraftPenalty[name] = nil;
	end
end

function SavePenaltyList()
	local pFile = io.open("dlbase/craftpenaltylist.me", "w");
	
	for k, v in pairs(CraftPenalty) do
		pFile:write(k, " ");
		pFile:write(v, "\n");
	end
				
	pFile:close();
end

function InitCategory(name)
	if CraftCategory[name] == nil then
		CraftCategory[name] = {};
		CraftCategory[name].items = {};
		CraftCategory[name].acquire_workspace = false;
	end
end

function ToggleWorkspace(name)
	InitCategory(name);
	CraftCategory[name].acquire_workspace = true;
end

function AddCategoryScience(name, science)
	InitCategory(name)
	CraftCategory[name].science = science;
end


function InitItem(instance)
	instance = string.upper(instance);
	if CraftItem[instance] == nil then
		CraftItem[instance] = {};
		CraftItem[instance].exp = 0;
		CraftItem[instance].exp_skill = nil;
		CraftItem[instance].amount = 0;
		CraftItem[instance].penalty = 0;
		CraftItem[instance].energy = 0;
		CraftItem[instance].ing = {};
		CraftItem[instance].altering = {};
		CraftItem[instance].tools = {};
		CraftItem[instance].science = {};
	end
end

function AddItemCategory(name, instance)
	instance = string.upper(instance);
	InitCategory(name);
	table.insert(CraftCategory[name].items, instance);
end

function AddTool(instance, tool_instance)
	instance = string.upper(instance);
	InitItem(instance);
	tool_instance = string.upper(tool_instance);
	CraftItem[instance].tools[tool_instance] = {};
	CraftItem[instance].tools[tool_instance].amount = 1;
end

function AddIngre(instance, ing_instance, amount)
	instance = string.upper(instance);
	InitItem(instance);
	ing_instance = string.upper(ing_instance);
	CraftItem[instance].ing[ing_instance] = {};
	CraftItem[instance].ing[ing_instance].amount = amount;
end

function AddAlterIngre(instance, ing_instance, amount)
    instance = string.upper(instance);
	InitItem(instance);
	ing_instance = string.upper(ing_instance);
	CraftItem[instance].altering[ing_instance] = {};
	CraftItem[instance].altering[ing_instance].amount = amount;
end

function SetCraftEXP(instance, value)
	instance = string.upper(instance);
	InitItem(instance);
	CraftItem[instance].exp = value;
end

function SetCraftEXP_SKILL(instance, skill)
	instance = string.upper(instance);
	InitItem(instance);
	CraftItem[instance].exp_skill = tostring(skill);
end

function SetCraftAmount(instance, amount)
	instance = string.upper(instance);
	InitItem(instance);
	CraftItem[instance].amount = amount;
end

function SetCraftPenalty(instance, minutes)
	instance = string.upper(instance);
	InitItem(instance);
	CraftItem[instance].penalty = minutes;
end

function SetenergyPenalty(instance, energy)
	instance = string.upper(instance);
	InitItem(instance);
	CraftItem[instance].energy = energy;
end

function SetCraftScience(instance, science, level)
	instance = string.upper(instance);
	InitItem(instance);
	CraftItem[instance].science[science] = level;
end

function InitCraftList()
	LoadPenaltyList();
	
	AddAlchemyWorkspace(-1250.7536621094, -778.23889160156, -6898.2431640625);


	ToggleWorkspace("Кузнец (Расходники)");
	ToggleWorkspace("Кузнец (Инструменты)");
	ToggleWorkspace("(О)Кузнец (Без уровня)");
	ToggleWorkspace("(О)Кузнец (1 уровень)");
	ToggleWorkspace("(О)Кузнец (2 уровень)");
	ToggleWorkspace("(О)Кузнец (3 уровень)");
	ToggleWorkspace("(О)Кузнец (4 уровень)");
	ToggleWorkspace("(Б)Кузнец (Без уровня)");
	ToggleWorkspace("(Б)Кузнец (1 уровень)");
	ToggleWorkspace("(Б)Кузнец (2 уровень)");
	ToggleWorkspace("(Б)Кузнец (3 уровень)");
	ToggleWorkspace("(Б)Кузнец (4 уровень)");
	ToggleWorkspace("Кожевник (Расходники)");
	ToggleWorkspace("Кожевник (Без уровня)");
	ToggleWorkspace("Кожевник (1 уровень)");
	ToggleWorkspace("Кожевник (2 уровень)");
	ToggleWorkspace("Кожевник (3 уровень)");
	ToggleWorkspace("Кожевник (4 уровень)");
	ToggleWorkspace("Плотник (Расходники)");
	ToggleWorkspace("Плотник (Без уровня)");
	ToggleWorkspace("Плотник (1 уровень)");
	ToggleWorkspace("Плотник (2 уровень)");
	ToggleWorkspace("Плотник (3 уровень)");
	ToggleWorkspace("Плотник (4 уровень)");
	ToggleWorkspace("Алхимия (1 уровень)");
	ToggleWorkspace("Алхимия (2 уровень)");
	ToggleWorkspace("Алхимия (3 уровень)");
	ToggleWorkspace("Повар (1 уровень)");
	ToggleWorkspace("Повар (2 уровень)");
	ToggleWorkspace("Повар (3 уровень)");
	ToggleWorkspace("Портной (Расходники)");
	ToggleWorkspace("Портной (Без уровня)");
	ToggleWorkspace("Портной (1 уровень)");
	ToggleWorkspace("Портной (2 уровень)");
	ToggleWorkspace("Портной (3 уровень)");
	ToggleWorkspace("Портной (4 уровень)");
	ToggleWorkspace("(Р) 1-й Круг");
	ToggleWorkspace("(Р) 2-й Круг");
	ToggleWorkspace("(С) 1-й Круг");
	ToggleWorkspace("(С) 2-й Круг");
	
	--[[ToggleWorkspace("(Р) 1-й Круг");
	ToggleWorkspace("(Р) 2-й Круг");
	ToggleWorkspace("(Р) 3-й Круг");
	ToggleWorkspace("(Р) 4-й Круг");
	ToggleWorkspace("(Р) 5-й Круг");
	ToggleWorkspace("(С) 1-й Круг");
	ToggleWorkspace("(С) 2-й Круг");
	ToggleWorkspace("(С) 3-й Круг");
	ToggleWorkspace("(С) 4-й Круг");
	ToggleWorkspace("(С) 5-й Круг");]]
	
	AddCategoryScience("Кузнец (Расходники)", "Кузнец");
	AddCategoryScience("Кузнец (Инструменты)", "Кузнец");
	AddCategoryScience("(О)Кузнец (Без уровня)", "Оружейник");
	AddCategoryScience("(О)Кузнец (1 уровень)", "Оружейник");
	AddCategoryScience("(О)Кузнец (2 уровень)", "Оружейник");
	AddCategoryScience("(О)Кузнец (3 уровень)", "Оружейник");
	AddCategoryScience("(О)Кузнец (4 уровень)", "Оружейник");
	AddCategoryScience("(Б)Кузнец (Без уровня)", "Бронник");
	AddCategoryScience("(Б)Кузнец (1 уровень)", "Бронник");
	AddCategoryScience("(Б)Кузнец (2 уровень)", "Бронник");
	AddCategoryScience("(Б)Кузнец (3 уровень)", "Бронник");
	AddCategoryScience("(Б)Кузнец (4 уровень)", "Бронник");
	AddCategoryScience("Кожевник (Расходники)", "Кожевник");
	AddCategoryScience("Кожевник (Без уровня)", "Кожевник");
	AddCategoryScience("Кожевник (1 уровень)", "Кожевник");
	AddCategoryScience("Кожевник (2 уровень)", "Кожевник");
	AddCategoryScience("Кожевник (3 уровень)", "Кожевник");
	AddCategoryScience("Кожевник (4 уровень)", "Кожевник");
	AddCategoryScience("Плотник (Расходники)", "Плотник");
	AddCategoryScience("Плотник (Без уровня)", "Плотник");
	AddCategoryScience("Плотник (1 уровень)", "Плотник");
	AddCategoryScience("Плотник (2 уровень)", "Плотник");
	AddCategoryScience("Плотник (3 уровень)", "Плотник");
	AddCategoryScience("Плотник (4 уровень)", "Плотник");
	AddCategoryScience("Портной (Расходники)", "Портной");
	AddCategoryScience("Портной (Без уровня)", "Портной");
	AddCategoryScience("Портной (1 уровень)", "Портной");
	AddCategoryScience("Портной (2 уровень)", "Портной");
	AddCategoryScience("Портной (3 уровень)", "Портной");
	AddCategoryScience("Портной (4 уровень)", "Портной");
	AddCategoryScience("Алхимия (1 уровень)", "Алхимия");
	AddCategoryScience("Алхимия (2 уровень)", "Алхимия");
	AddCategoryScience("Алхимия (3 уровень)", "Алхимия");
	AddCategoryScience("Повар (1 уровень)", "Повар");
	AddCategoryScience("Повар (2 уровень)", "Повар");
	AddCategoryScience("Повар (3 уровень)", "Повар");
	AddCategoryScience("(С) 1-й Круг", "Магия");
	AddCategoryScience("(С) 2-й Круг", "Магия");
	AddCategoryScience("(Р) 1-й Круг", "Магия");
	AddCategoryScience("(Р) 2-й Круг", "Магия");
	
	
	--[[AddCategoryScience("(С) 1-й Круг", "Магия");
	AddCategoryScience("(С) 2-й Круг", "Магия");
	AddCategoryScience("(С) 3-й Круг", "Магия");
	AddCategoryScience("(С) 4-й Круг", "Магия");
	AddCategoryScience("(С) 5-й Круг", "Магия");
	AddCategoryScience("(Р) 1-й Круг", "Магия");
	AddCategoryScience("(Р) 2-й Круг", "Магия");
	AddCategoryScience("(Р) 3-й Круг", "Магия");
	AddCategoryScience("(Р) 4-й Круг", "Магия");
	AddCategoryScience("(Р) 5-й Круг", "Магия");]]
	

--ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА
	
	AddItemCategory ("Без профессии", "ZDPWLA_ItFoMutton"); ----- Жареное мясо
	SetCraftAmount("ZDPWLA_ItFoMutton", 3);
     AddIngre("ZDPWLA_ItFoMutton", "ZDPWLA_ItFoMuttonRaw", 3);
    SetCraftPenalty("ZDPWLA_ItFoMutton", 5);
	SetCraftScience("ZDPWLA_ItFoMutton", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFoMutton", 50);

	AddItemCategory ("Без профессии", "ZDPWLA_ItFo_FishFried"); ----- Жареная рыба
	SetCraftAmount("ZDPWLA_ItFo_FishFried", 3);
     AddIngre("ZDPWLA_ItFo_FishFried", "ZDPWLA_ItFo_Fish", 3);
	SetCraftPenalty("ZDPWLA_ItFo_FishFried", 5);
	SetCraftScience("ZDPWLA_ItFo_FishFried", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFo_FishFried", 50);
	
	AddItemCategory ("Без профессии", "ZDPWLA_ItFo_Honey"); ----- Мед
	SetCraftAmount("ZDPWLA_ItFo_Honey", 2);
     AddIngre("ZDPWLA_ItFo_Honey", "OOLTYB_ITMI_HONEYCOMB", 1);
	SetCraftPenalty("ZDPWLA_ItFo_Honey", 5);
	SetCraftScience("ZDPWLA_ItFo_Honey", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFo_Honey", 25);
	
	AddItemCategory ("Без профессии", "ZDPWLA_ItFo_Addon_Shellflesh"); ----- Мясо моллюска
	SetCraftAmount("ZDPWLA_ItFo_Addon_Shellflesh", 2);
     AddIngre("ZDPWLA_ItFo_Addon_Shellflesh", "OOLTYB_ItMi_ReMi2", 1);
	SetCraftPenalty("ZDPWLA_ItFo_Addon_Shellflesh", 5);
	SetCraftScience("ZDPWLA_ItFo_Addon_Shellflesh", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFo_Addon_Shellflesh", 25);
	
	AddItemCategory ("Без профессии", "OOLTYB_ItFo_MeatbugFried"); ----- Жареный жук
	SetCraftAmount("OOLTYB_ItFo_MeatbugFried", 6);
     AddIngre("OOLTYB_ItFo_MeatbugFried", "OOLTYB_ItAt_Meatbugflesh", 6);
	SetCraftPenalty("OOLTYB_ItFo_MeatbugFried", 5);
	SetCraftScience("OOLTYB_ItFo_MeatbugFried", "Без профессии", 0);
	SetenergyPenalty("OOLTYB_ItFo_MeatbugFried", 50);
	
	AddItemCategory ("Без профессии", "ZDPWLA_ItFo_PoorSoup"); ----- Суп бедняка
	SetCraftAmount("ZDPWLA_ItFo_PoorSoup", 3);
     AddIngre("ZDPWLA_ItFo_PoorSoup", "OOLTYB_ItAt_Meatbugflesh", 3);
	 AddIngre("ZDPWLA_ItFo_PoorSoup", "ZDPWLA_ItPl_Temp_Herb", 3);
	SetCraftPenalty("ZDPWLA_ItFo_PoorSoup", 10);
	SetCraftScience("ZDPWLA_ItFo_PoorSoup", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFo_PoorSoup", 100);
	
	AddItemCategory ("Без профессии", "ZDPWLA_ItFo_MushroomOffal"); ----- Грибная требуха
	SetCraftAmount("ZDPWLA_ItFo_MushroomOffal", 1);
	 AddIngre("ZDPWLA_ItFo_MushroomOffal", "ZDPWLA_ItPl_Mushroom_02", 1);
     AddIngre("ZDPWLA_ItFo_MushroomOffal", "ZDPWLA_ItPl_Mushroom_01", 2);
	SetCraftPenalty("ZDPWLA_ItFo_MushroomOffal", 10);
	SetCraftScience("ZDPWLA_ItFo_MushroomOffal", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFo_MushroomOffal", 50);
	
	AddItemCategory ("Без профессии", "ZDPWLA_ItFo_GrapeJuice"); ----- Виноградный сок
	SetCraftAmount("ZDPWLA_ItFo_GrapeJuice", 2);
     AddIngre("ZDPWLA_ItFo_GrapeJuice", "ZDPWLA_ITFO_WINEBERRYS2", 5);
	 AddIngre("ZDPWLA_ItFo_GrapeJuice", "OOLTYB_ItMi_Flask", 2);
	SetCraftPenalty("ZDPWLA_ItFo_GrapeJuice", 5);
	SetCraftScience("ZDPWLA_ItFo_GrapeJuice", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFo_GrapeJuice", 25);
	
	AddItemCategory ("Без профессии", "OOLTYB_ITMI_FLOUR"); ----- мука
	SetCraftAmount("OOLTYB_ITMI_FLOUR", 1);
     AddIngre("OOLTYB_ITMI_FLOUR", "ZDPWLA_ITFO_RICE", 45);
	 AddAlterIngre("OOLTYB_ITMI_FLOUR", "zdpwla_itfo_millet", 45);
	SetCraftPenalty("OOLTYB_ITMI_FLOUR", 5);
	SetCraftScience("OOLTYB_ITMI_FLOUR", "Без профессии", 0);
	SetenergyPenalty("OOLTYB_ITMI_FLOUR", 10);
	
	AddItemCategory ("Без профессии", "OOLTYB_ItMi_Joint"); ----- Самокрутка
	SetCraftAmount("OOLTYB_ItMi_Joint", 3);
     AddIngre("OOLTYB_ItMi_Joint", "ZDPWLA_ItPl_SwampHerb", 3);
     	AddTool("OOLTYB_ItMi_Joint", "ooltyb_itmi_jointrecipe1");
	SetCraftPenalty("OOLTYB_ItMi_Joint", 5);
	SetCraftScience("OOLTYB_ItMi_Joint", "Без профессии", 0);
	SetenergyPenalty("OOLTYB_ItMi_Joint", 25);
	
	AddItemCategory ("Без профессии", "OOLTYB_ItMi_Coal"); ----- Уголь
	SetCraftAmount("OOLTYB_ItMi_Coal", 15);
     AddIngre("OOLTYB_ItMi_Coal", "OOLTYB_ITMI_WOOD", 30);
	SetCraftPenalty("OOLTYB_ItMi_Coal", 5);
	SetCraftScience("OOLTYB_ItMi_Coal", "Без профессии", 0);
	SetenergyPenalty("OOLTYB_ItMi_Coal", 25);
	
	AddItemCategory ("Без профессии", "OOLTYB_ITMI_Stroy"); ---- Строительные материалы
	SetCraftAmount("OOLTYB_ITMI_Stroy", 2);
	 AddIngre("OOLTYB_ITMI_Stroy", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddIngre("OOLTYB_ITMI_Stroy", "OOLTYB_ITMI_OBRABOTDER", 1);
     AddIngre("OOLTYB_ITMI_Stroy", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddIngre("OOLTYB_ITMI_Stroy", "OOLTYB_ITMI_LEATHER", 1);
	SetCraftPenalty("OOLTYB_ITMI_Stroy", 10);
	SetCraftScience("OOLTYB_ItMi_Coal", "Без профессии", 0);
	SetenergyPenalty("OOLTYB_ITMI_Stroy", 25);
	
	AddItemCategory ("Без профессии", "itlstorch"); ---- Факел
	SetCraftAmount("itlstorch", 15);
	 AddIngre("itlstorch", "ooltyb_itmi_pitch", 1);
	 AddIngre("itlstorch", "jkztzd_itmw_1h_bau_mace", 1);
	SetCraftPenalty("itlstorch", 1);
	SetCraftScience("OOLTYB_ItMi_Coal", "Без профессии", 0);
	SetenergyPenalty("itlstorch", 10);
	
	AddItemCategory ("Без профессии", "yfauun_itar_koszyk"); ---- Корзинка для зерна
	SetCraftAmount("yfauun_itar_koszyk", 1);
	 AddIngre("yfauun_itar_koszyk", "zdpwla_itfo_rice", 1);
	 AddIngre("yfauun_itar_koszyk", "zdpwla_itpl_weed", 1);
	SetCraftPenalty("yfauun_itar_koszyk", 1);
	SetCraftScience("OOLTYB_ItMi_Coal", "Без профессии", 0);
	SetenergyPenalty("yfauun_itar_koszyk", 10);
	
	AddItemCategory ("Без профессии", "yfauun_itar_koszyk2"); ---- Корзинка для руды
	SetCraftAmount("yfauun_itar_koszyk2", 1);
	 AddIngre("yfauun_itar_koszyk2", "ooltyb_itmi_nugget", 1);
	SetCraftPenalty("yfauun_itar_koszyk2", 1);
	SetCraftScience("OOLTYB_ItMi_Coal", "Без профессии", 0);
	SetenergyPenalty("yfauun_itar_koszyk2", 10);
	
	AddItemCategory ("Без профессии", "yfauun_itar_koszyk3"); ---- Корзинка для травы
	SetCraftAmount("yfauun_itar_koszyk3", 1);
	 AddIngre("yfauun_itar_koszyk3", "zdpwla_itpl_temp_herb", 1);
	SetCraftPenalty("yfauun_itar_koszyk3", 1);
	SetCraftScience("OOLTYB_ItMi_Coal", "Без профессии", 0);
	SetenergyPenalty("yfauun_itar_koszyk3", 10);
	
--ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА	
		
	
	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_SausagE"); ----- Колбаса
	SetCraftAmount("ZDPWLA_ItFo_SausagE", 5);
	 AddIngre("ZDPWLA_ItFo_SausagE", "ZDPWLA_ItFoMuttonRaW", 10);
	 AddIngre("ZDPWLA_ItFo_SausagE", "OOLTYB_ItAt_Fat", 1);
    AddTool("ZDPWLA_ItFo_SausagE", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("ZDPWLA_ItFo_SausagE", 5);
	SetCraftScience("ZDPWLA_ItFo_SausagE", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_SausagE", 25);
	
	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_MarinMushroom"); ----- Маринованные грибы
	SetCraftAmount("ZDPWLA_ItFo_MarinMushroom", 20);
	 AddIngre("ZDPWLA_ItFo_MarinMushroom", "ZDPWLA_ItPl_Mushroom_01", 5);
	 AddIngre("ZDPWLA_ItFo_MarinMushroom", "ZDPWLA_ItPl_Mushroom_02", 1);
	 AddIngre("ZDPWLA_ItFo_MarinMushroom", "ZDPWLA_ItMi_Vinegar", 1);
	 AddIngre("ZDPWLA_ItFo_MarinMushroom", "OOLTYB_ItMi_Flask", 20);
    AddTool("ZDPWLA_ItFo_MarinMushroom", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_MarinMushroom", 5);
	SetCraftScience("ZDPWLA_ItFo_MarinMushroom", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_MarinMushroom", 50);	

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_Bread"); ----- Хлеб
	SetCraftAmount("ZDPWLA_ItFo_Bread", 20);
	 AddIngre("ZDPWLA_ItFo_Bread", "OOLTYB_ITMI_DOUGH", 1);
    AddTool("ZDPWLA_ItFo_Bread", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Bread", 5);
	SetCraftScience("ZDPWLA_ItFo_Bread", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_Bread", 50);

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_Addon_MeatSoup"); ----- Мясная похлебка
	SetCraftAmount("ZDPWLA_ItFo_Addon_MeatSoup", 5);
	 AddIngre("ZDPWLA_ItFo_Addon_MeatSoup", "ZDPWLA_ItFoMuttonRaw", 15);
	 AddIngre("ZDPWLA_ItFo_Addon_MeatSoup", "ZDPWLA_ITFO_RICE", 35);
	 AddIngre("ZDPWLA_ItFo_Addon_MeatSoup", "OOLTYB_ItMi_Flask", 5);
    AddTool("ZDPWLA_ItFo_Addon_MeatSoup", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Addon_MeatSoup", 5);
	SetCraftScience("ZDPWLA_ItFo_Addon_MeatSoup", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_Addon_MeatSoup", 50);

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_FishBatter"); ----- Рыба в кляре
	SetCraftAmount("ZDPWLA_ItFo_FishBatter", 20);
	 AddIngre("ZDPWLA_ItFo_FishBatter", "ZDPWLA_ItFo_Fish", 27);
	 AddIngre("ZDPWLA_ItFo_FishBatter", "OOLTYB_ITMI_FLOUR", 1);
    AddTool("ZDPWLA_ItFo_FishBatter", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_FishBatter", 10);
	SetCraftScience("ZDPWLA_ItFo_FishBatter", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_FishBatter", 100);

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ITFO_MEATBUGRAGOUT"); ----- Рагу из жуков
	SetCraftAmount("ZDPWLA_ITFO_MEATBUGRAGOUT", 5);
	 AddIngre("ZDPWLA_ITFO_MEATBUGRAGOUT", "OOLTYB_ItAt_Meatbugflesh", 11);
	 AddIngre("ZDPWLA_ITFO_MEATBUGRAGOUT", "ZDPWLA_ITFO_RICE", 30);
	 AddIngre("ZDPWLA_ITFO_MEATBUGRAGOUT", "OOLTYB_ItMi_Flask", 5);
    AddTool("ZDPWLA_ITFO_MEATBUGRAGOUT", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ITFO_MEATBUGRAGOUT", 10);
	SetCraftScience("ZDPWLA_ITFO_MEATBUGRAGOUT", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ITFO_MEATBUGRAGOUT", 50);

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ITFO_BERRYSALAD"); ----- Ягодный салат
	SetCraftAmount("ZDPWLA_ITFO_BERRYSALAD", 5);
	 AddIngre("ZDPWLA_ITFO_BERRYSALAD", "ZDPWLA_ItPl_Forestberry", 4);
	 AddIngre("ZDPWLA_ITFO_BERRYSALAD", "ZDPWLA_ITFO_WINEBERRYS2", 2);
	 AddIngre("ZDPWLA_ITFO_BERRYSALAD", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", 2);
	 AddIngre("ZDPWLA_ITFO_BERRYSALAD", "OOLTYB_ItMi_Flask", 5);
    AddTool("ZDPWLA_ITFO_BERRYSALAD", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ITFO_BERRYSALAD", 5);
	SetCraftScience("ZDPWLA_ITFO_BERRYSALAD", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ITFO_BERRYSALAD", 25);

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_Cheese"); ----- Сыр
	SetCraftAmount("ZDPWLA_ItFo_Cheese", 10);
	 AddIngre("ZDPWLA_ItFo_Cheese", "ZDPWLA_ItFo_Milk", 13);
    AddTool("ZDPWLA_ItFo_Cheese", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Cheese", 5);
	SetCraftScience("ZDPWLA_ItFo_Cheese", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_Cheese", 25);

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ITFO_TEA"); ----- Чай
	SetCraftAmount("ZDPWLA_ITFO_TEA", 10);
	 AddIngre("ZDPWLA_ITFO_TEA", "ZDPWLA_ItPl_Mana_Herb_01", 2);
	 AddIngre("ZDPWLA_ITFO_TEA", "ZDPWLA_ItPl_Temp_Herb", 4);
	 AddIngre("ZDPWLA_ITFO_TEA", "OOLTYB_ItMi_Flask", 10);
    AddTool("ZDPWLA_ITFO_TEA", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ITFO_TEA", 2);
	SetCraftScience("ZDPWLA_ITFO_TEA", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ITFO_TEA", 25);

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_Mors"); ----- Морс
	SetCraftAmount("ZDPWLA_ItFo_Mors", 10);
	 AddIngre("ZDPWLA_ItFo_Mors", "ZDPWLA_ItPl_Forestberry", 10);
	 AddIngre("ZDPWLA_ItFo_Mors", "OOLTYB_ItMi_Flask", 10);
    AddTool("ZDPWLA_ItFo_Mors", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Mors", 5);
	SetCraftScience("ZDPWLA_ItFo_Mors", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_Mors", 25);

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ITFO_RICEBOOZE"); ----- Рисовый шнапс
	SetCraftAmount("ZDPWLA_ITFO_RICEBOOZE", 10);
	 AddIngre("ZDPWLA_ITFO_RICEBOOZE", "ZDPWLA_ITFO_RICE", 40);
	 AddIngre("ZDPWLA_ITFO_RICEBOOZE", "OOLTYB_ItMi_Flask", 10);
	 AddIngre("ZDPWLA_ITFO_RICEBOOZE", "OOLTYB_ItMi_Coal", 8);
    AddTool("ZDPWLA_ITFO_RICEBOOZE", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ITFO_RICEBOOZE", 10);
	SetCraftScience("ZDPWLA_ITFO_RICEBOOZE", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ITFO_RICEBOOZE", 50);

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ITFO_ACORNBOOZE"); ----- Желудевка
	SetCraftAmount("ZDPWLA_ITFO_ACORNBOOZE", 20);
	 AddIngre("ZDPWLA_ITFO_ACORNBOOZE", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	 AddIngre("ZDPWLA_ITFO_ACORNBOOZE", "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", 8);
	 AddIngre("ZDPWLA_ITFO_ACORNBOOZE", "OOLTYB_ItMi_FlasK", 20);
    AddTool("ZDPWLA_ITFO_ACORNBOOZE", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ITFO_ACORNBOOZE", 20);
	SetCraftScience("ZDPWLA_ITFO_ACORNBOOZE", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ITFO_ACORNBOOZE", 100);
	
	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ITFO_SOUP"); ----- Суп из кореньев
	SetCraftAmount("ZDPWLA_ITFO_SOUP", 10);
	 AddIngre("ZDPWLA_ITFO_SOUP", "ZDPWLA_ITFO_PLANTS_STONEROOT_01", 1);
	 AddIngre("ZDPWLA_ITFO_SOUP", "ZDPWLA_ItPl_Mana_Herb_03", 1);
	 AddIngre("ZDPWLA_ITFO_SOUP", "ZDPWLA_ItPl_Strength_Herb_01", 1);
	 AddIngre("ZDPWLA_ITFO_SOUP", "OOLTYB_ItMi_FlasK", 10);
    AddTool("ZDPWLA_ITFO_SOUP", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ITFO_SOUP", 20);
	SetCraftScience("ZDPWLA_ITFO_SOUP", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ITFO_SOUP", 100);	
	
	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_Medovuha"); ----- Медовуха
	SetCraftAmount("ZDPWLA_ItFo_Medovuha", 59);
	 AddIngre("ZDPWLA_ItFo_Medovuha", "ZDPWLA_ItFo_Honey", 7);
	 AddIngre("ZDPWLA_ItFo_Medovuha", "ZDPWLA_ItPl_Forestberry", 15);
	 AddIngre("ZDPWLA_ItFo_Medovuha", "OOLTYB_ItMi_FlasK", 59);
    AddTool("ZDPWLA_ItFo_Medovuha", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Medovuha", 20);
	SetCraftScience("ZDPWLA_ItFo_Medovuha", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_Medovuha", 100);	
	
	
	AddItemCategory ("Повар (1 уровень)", "ITMI_SPICES"); ----- Специи
	SetCraftAmount("ITMI_SPICES", 1);
	 AddIngre("ITMI_SPICES", "ZDPWLA_ItPl_Dex_Herb_01", 1);
	 AddIngre("ITMI_SPICES", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", 15);
	 AddAlterIngre("ITMI_SPICES", "ZDPWLA_ITFO_PLANTS_TROLLBERRYS_01", 1)
	 AddAlterIngre("ITMI_SPICES", "OOLTYB_ItMi_ReMi", 4)
	SetCraftPenalty("ITMI_SPICES", 10);
	SetCraftScience("ITMI_SPICES", "Повар", 1);
	SetenergyPenalty("ITMI_SPICES", 50);


	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItMi_Vinegar"); ----- Уксус
	SetCraftAmount("ZDPWLA_ItMi_Vinegar", 5);
	 AddIngre("ZDPWLA_ItMi_Vinegar", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	 AddIngre("ZDPWLA_ItMi_Vinegar", "ZDPWLA_ITFO_WINEBERRYS2", 10);
	 AddIngre("ZDPWLA_ItMi_Vinegar", "OOLTYB_ItMi_FlasK", 5);
	SetCraftPenalty("ZDPWLA_ItMi_Vinegar", 5);
	SetCraftScience("ZDPWLA_ItMi_Vinegar", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItMi_Vinegar", 25);	
	
	
	AddItemCategory ("Повар (1 уровень)", "OOLTYB_ITMI_DOUGH"); ----- Тесто
	SetCraftAmount("OOLTYB_ITMI_DOUGH", 1);
	 AddIngre("OOLTYB_ITMI_DOUGH", "OOLTYB_ITMI_FLOUR", 1);
	 AddIngre("OOLTYB_ITMI_DOUGH", "ZDPWLA_ITFO_EGG", 1);
	 AddIngre("OOLTYB_ITMI_DOUGH", "ZDPWLA_ItFo_Milk", 5);
	SetCraftPenalty("OOLTYB_ITMI_DOUGH", 5);
	SetCraftScience("OOLTYB_ITMI_DOUGH", "Повар", 1);
	SetenergyPenalty("OOLTYB_ITMI_DOUGH", 25);		
	
	
	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ITFO_BARBECUE"); ----- Шашлык
	SetCraftAmount("ZDPWLA_ITFO_BARBECUE", 13);
	 AddIngre("ZDPWLA_ITFO_BARBECUE", "ZDPWLA_ItFoMuttonRaW", 25);
	 AddIngre("ZDPWLA_ITFO_BARBECUE", "OOLTYB_ItMi_Coal", 5);
	 AddIngre("ZDPWLA_ITFO_BARBECUE", "JKZTZD_ItMw_1h_Bau_Mace", 1);
    AddTool("ZDPWLA_ITFO_BARBECUE", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("ZDPWLA_ITFO_BARBECUE", 10);
	SetCraftScience("ZDPWLA_ITFO_BARBECUE", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ITFO_BARBECUE", 50);	
	
	
	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_MushroomCutlet"); ----- Грибная котлета
	SetCraftAmount("ZDPWLA_ItFo_MushroomCutlet", 32);
	 AddIngre("ZDPWLA_ItFo_MushroomCutlet", "ZDPWLA_ItFo_MushroomOffal", 4);
	 AddIngre("ZDPWLA_ItFo_MushroomCutlet", "OOLTYB_ItMi_ReMi", 2);
	 AddIngre("ZDPWLA_ItFo_MushroomCutlet", "OOLTYB_ITMI_DOUGH", 1);
    AddTool("ZDPWLA_ItFo_MushroomCutlet", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_MushroomCutlet", 10);
	SetCraftScience("ZDPWLA_ItFo_MushroomCutlet", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_MushroomCutlet", 100);	
	

	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_FishSouP"); ----- Уха
	SetCraftAmount("ZDPWLA_ItFo_FishSouP", 13);
     AddIngre("ZDPWLA_ItFo_FishSouP", "ZDPWLA_ItFo_Fish", 30);
     AddIngre("ZDPWLA_ItFo_FishSouP", "OOLTYB_ItMi_ReMi", 4);
	 AddIngre("ZDPWLA_ItFo_FishSouP", "OOLTYB_ItMi_FlasK", 13);
	 AddTool("ZDPWLA_ItFo_FishSouP", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_FishSouP", 10);
	SetCraftScience("ZDPWLA_ItFo_FishSouP", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_FishSouP", 100);
	

	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_WinE"); ----- Вино
	SetCraftAmount("ZDPWLA_ItFo_WinE", 31);
     AddIngre("ZDPWLA_ItFo_WinE", "ZDPWLA_ITFO_WINEBERRYS2", 10);
	 AddIngre("ZDPWLA_ItFo_WinE", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
     AddIngre("ZDPWLA_ItFo_WinE", "OOLTYB_ItMi_FlasK", 31);
	 AddTool("ZDPWLA_ItFo_WinE", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_WinE", 20);
	SetCraftScience("ZDPWLA_ItFo_WinE", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_WinE", 100);


	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_HoneyMeat"); ----- Мясо в медовом соусе
	SetCraftAmount("ZDPWLA_ItFo_HoneyMeat", 30);
     AddIngre("ZDPWLA_ItFo_HoneyMeat", "ZDPWLA_ItFoMuttonRaW", 20);
	 AddIngre("ZDPWLA_ItFo_HoneyMeat", "ZDPWLA_ItFo_Honey", 8);
     AddIngre("ZDPWLA_ItFo_HoneyMeat", "ZDPWLA_ITFO_PLANTS_TROLLBERRYS_01", 1);
	 AddTool("ZDPWLA_ItFo_HoneyMeat", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_HoneyMeat", 10);
	SetCraftScience("ZDPWLA_ItFo_HoneyMeat", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_HoneyMeat", 100);


	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ITFO_MEATBUGPATE"); ----- Паштет из жуков
	SetCraftAmount("ZDPWLA_ITFO_MEATBUGPATE", 13);
     AddIngre("ZDPWLA_ITFO_MEATBUGPATE", "OOLTYB_ItAt_Meatbugflesh", 8);
	 AddIngre("ZDPWLA_ITFO_MEATBUGPATE", "ZDPWLA_ItMi_Vinegar", 1);
     AddIngre("ZDPWLA_ITFO_MEATBUGPATE", "OOLTYB_ItMi_ReMi1", 2);
	 AddTool("ZDPWLA_ITFO_MEATBUGPATE", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ITFO_MEATBUGPATE", 10);
	SetCraftScience("ZDPWLA_ITFO_MEATBUGPATE", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ITFO_MEATBUGPATE", 50);
	

	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_AcornBread"); ----- Желудевый хлеб
	SetCraftAmount("ZDPWLA_ItFo_AcornBread", 52);
     AddIngre("ZDPWLA_ItFo_AcornBread", "OOLTYB_ITMI_DOUGH", 1);
	 AddIngre("ZDPWLA_ItFo_AcornBread", "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", 6);
     AddIngre("ZDPWLA_ItFo_AcornBread", "OOLTYB_ItMi_ReMi", 2);
	 AddTool("ZDPWLA_ItFo_AcornBread", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_AcornBread", 20);
	SetCraftScience("ZDPWLA_ItFo_AcornBread", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_AcornBread", 100);


	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_BoozE"); ----- Джин
	SetCraftAmount("ZDPWLA_ItFo_BoozE", 26);
     AddIngre("ZDPWLA_ItFo_BoozE", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
     AddIngre("ZDPWLA_ItFo_BoozE", "ZDPWLA_ITFO_PLANTS_STONEROOT_01", 1);
     AddIngre("ZDPWLA_ItFo_BoozE", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", 20);
     AddIngre("ZDPWLA_ItFo_BoozE", "OOLTYB_ItMi_FlasK", 26);
	 AddTool("ZDPWLA_ItFo_BoozE", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_BoozE", 10);
	SetCraftScience("ZDPWLA_ItFo_BoozE", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_BoozE", 100);


	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_BerryLiqueur"); ----- Ягодная наливка
	SetCraftAmount("ZDPWLA_ItFo_BerryLiqueur", 26);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "ZDPWLA_ItPl_Forestberry", 25);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "ZDPWLA_ItPl_Dex_Herb_01", 1);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "OOLTYB_ItMi_FlasK", 26);
	 AddTool("ZDPWLA_ItFo_BerryLiqueur", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_BerryLiqueur", 10);
	SetCraftScience("ZDPWLA_ItFo_BerryLiqueur", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_BerryLiqueur", 100);


	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ITFO_SEASALAD"); ----- Морской салат
	SetCraftAmount("ZDPWLA_ITFO_SEASALAD", 57);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "OOLTYB_ItMi_ReMi1", 4);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "ZDPWLA_ItMi_Vinegar", 1);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "ZDPWLA_ItFo_Addon_Shellflesh", 5);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "OOLTYB_ItMi_FlasK", 57);
	 AddTool("ZDPWLA_ITFO_SEASALAD", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ITFO_SEASALAD", 10);
	SetCraftScience("ZDPWLA_ITFO_SEASALAD", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ITFO_SEASALAD", 100);


	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_MBlinchik"); ----- Блины с медом
	SetCraftAmount("ZDPWLA_ItFo_MBlinchik", 58);
	 AddIngre("ZDPWLA_ItFo_MBlinchik", "OOLTYB_ITMI_DOUGH", 2);
	 AddIngre("ZDPWLA_ItFo_MBlinchik", "ZDPWLA_ItFo_Honey", 6);
	 AddIngre("ZDPWLA_ItFo_MBlinchik", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", 1);
	 AddTool("ZDPWLA_ItFo_MBlinchik", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_MBlinchik", 20);
	SetCraftScience("ZDPWLA_ItFo_MBlinchik", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_MBlinchik", 100);
	
	
	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_Bomber"); ----- Бомбер
	SetCraftAmount("ZDPWLA_ItFo_Bomber", 13);
     AddIngre("ZDPWLA_ItFo_Bomber", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 3);
     AddIngre("ZDPWLA_ItFo_Bomber", "ZDPWLA_ItPl_Strength_Herb_01", 1);
     AddIngre("ZDPWLA_ItFo_Bomber", "ZDPWLA_ItPl_Mana_Herb_03", 1);
     AddIngre("ZDPWLA_ItFo_Bomber", "OOLTYB_ItMi_FlasK", 13);
	 AddTool("ZDPWLA_ItFo_Bomber", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_Bomber", 20);
	SetCraftScience("ZDPWLA_ItFo_Bomber", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_Bomber", 100);
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Casserole"); ----- Фермерская запеканка
	SetCraftAmount("ZDPWLA_ItFo_Casserole", 10);
	 AddIngre("ZDPWLA_ItFo_Casserole", "ZDPWLA_ItFo_Bread", 8);
	 AddIngre("ZDPWLA_ItFo_Casserole", "ZDPWLA_ItFo_Cheese", 8);
	 AddIngre("ZDPWLA_ItFo_Casserole", "ZDPWLA_ItFoMuttonRaW", 40);
	 AddTool("ZDPWLA_ItFo_Casserole", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_Casserole", 10);
	SetCraftScience("ZDPWLA_ItFo_Casserole", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Casserole", 50);	
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_WineStew"); ----- Тушеное мясо в вине
	SetCraftAmount("ZDPWLA_ItFo_WineStew", 9);
	 AddIngre("ZDPWLA_ItFo_WineStew", "ZDPWLA_ItFo_WinE", 4);
	 AddIngre("ZDPWLA_ItFo_WineStew", "ZDPWLA_ItFoMuttonRaW", 10);
	 AddIngre("ZDPWLA_ItFo_WineStew", "ITMI_SPICES", 1);
	 AddIngre("ZDPWLA_ItFo_WineStew", "OOLTYB_ItMi_FlasK", 9);
	 AddTool("ZDPWLA_ItFo_WineStew", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_WineStew", 10);
	SetCraftScience("ZDPWLA_ItFo_WineStew", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_WineStew", 50);		
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ITFO_FRIEDEGG"); ----- Яичница с колбасой
	SetCraftAmount("ZDPWLA_ITFO_FRIEDEGG", 9);
	 AddIngre("ZDPWLA_ITFO_FRIEDEGG", "ZDPWLA_ITFO_EGG", 3);
	 AddIngre("ZDPWLA_ITFO_FRIEDEGG", "ZDPWLA_ItFo_SausagE", 4);
	 AddIngre("ZDPWLA_ITFO_FRIEDEGG", "OOLTYB_ItMi_FlasK", 9);
	 AddTool("ZDPWLA_ITFO_FRIEDEGG", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ITFO_FRIEDEGG", 5);
	SetCraftScience("ZDPWLA_ITFO_FRIEDEGG", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ITFO_FRIEDEGG", 25);		
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Bacon"); ----- Окорок
	SetCraftAmount("ZDPWLA_ItFo_Bacon", 16);
	 AddIngre("ZDPWLA_ItFo_Bacon", "ZDPWLA_ItFoMuttonRaW", 18);
	 AddIngre("ZDPWLA_ItFo_Bacon", "OOLTYB_ItMi_Coal", 5);
	 AddIngre("ZDPWLA_ItFo_Bacon", "ITMI_SPICES", 1);
	 AddTool("ZDPWLA_ItFo_Bacon", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("ZDPWLA_ItFo_Bacon", 10);
	SetCraftScience("ZDPWLA_ItFo_Bacon", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Bacon", 50);	
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_SmokedFish"); ----- Копченая рыба
	SetCraftAmount("ZDPWLA_ItFo_SmokedFish", 16);
	 AddIngre("ZDPWLA_ItFo_SmokedFish", "ZDPWLA_ItFo_Fish", 6);
	 AddIngre("ZDPWLA_ItFo_SmokedFish", "OOLTYB_ItMi_Coal", 5);
	 AddIngre("ZDPWLA_ItFo_SmokedFish", "ITMI_SPICES", 1);
	 AddTool("ZDPWLA_ItFo_SmokedFish", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_SmokedFish", 10);
	SetCraftScience("ZDPWLA_ItFo_SmokedFish", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_SmokedFish", 50);		
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ITFO_HONEYBISCUIT"); ----- Медовое печенье
	SetCraftAmount("ZDPWLA_ITFO_HONEYBISCUIT", 185);
	 AddIngre("ZDPWLA_ITFO_HONEYBISCUIT", "OOLTYB_ITMI_DOUGH", 4);
	 AddIngre("ZDPWLA_ITFO_HONEYBISCUIT", "ZDPWLA_ItFo_Honey", 10);
	 AddTool("ZDPWLA_ITFO_HONEYBISCUIT", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ITFO_HONEYBISCUIT", 20);
	SetCraftScience("ZDPWLA_ITFO_HONEYBISCUIT", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ITFO_HONEYBISCUIT", 100);			
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_BerryPie"); ----- Ягодный пирог
	SetCraftAmount("ZDPWLA_ItFo_BerryPie", 32);
	 AddIngre("ZDPWLA_ItFo_BerryPie", "OOLTYB_ITMI_DOUGH", 1);
	 AddIngre("ZDPWLA_ItFo_BerryPie", "ZDPWLA_ItPl_Forestberry", 25);
	 AddIngre("ZDPWLA_ItFo_BerryPie", "ZDPWLA_ITFO_WINEBERRYS2", 10);
	 AddTool("ZDPWLA_ItFo_BerryPie", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_BerryPie", 10);
	SetCraftScience("ZDPWLA_ItFo_BerryPie", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_BerryPie", 50);		


	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_BeafPie"); ----- Пирог со шкварками
	SetCraftAmount("ZDPWLA_ItFo_BeafPie", 64);
	 AddIngre("ZDPWLA_ItFo_BeafPie", "OOLTYB_ITMI_DOUGH", 2);
	 AddIngre("ZDPWLA_ItFo_BeafPie", "OOLTYB_ItAt_Fat", 8);
	 AddIngre("ZDPWLA_ItFo_BeafPie", "ITMI_SPICES", 1);
	 AddTool("ZDPWLA_ItFo_BeafPie", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_BeafPie", 20);
	SetCraftScience("ZDPWLA_ItFo_BeafPie", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_BeafPie", 100);	


	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_MagicSoup"); ----- Волшебный суп
	SetCraftAmount("ZDPWLA_ItFo_MagicSoup", 25);
	 AddIngre("ZDPWLA_ItFo_MagicSoup", "ZDPWLA_ItMi_Vinegar", 3);
	 AddIngre("ZDPWLA_ItFo_MagicSoup", "ZDPWLA_ItPl_Mushroom_04", 3);
	 AddIngre("ZDPWLA_ItFo_MagicSoup", "ZDPWLA_ItFo_MushroomOffal", 9);
	 AddIngre("ZDPWLA_ItFo_MagicSoup", "OOLTYB_ItMi_FlasK", 25);
	 AddTool("ZDPWLA_ItFo_MagicSoup", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_MagicSoup", 20);
	SetCraftScience("ZDPWLA_ItFo_MagicSoup", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_MagicSoup", 100);	
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Addon_FireSteW"); ----- Пламенная нарезка
	SetCraftAmount("ZDPWLA_ItFo_Addon_FireSteW", 16);
	 AddIngre("ZDPWLA_ItFo_Addon_FireSteW", "OOLTYB_ItAt_WaranFiretongue", 2); 
	 AddIngre("ZDPWLA_ItFo_Addon_FireSteW", "ZDPWLA_ItPl_Mana_Herb_01", 5);
     AddIngre("ZDPWLA_ItFo_Addon_FireSteW", "ZDPWLA_ItMi_Vinegar", 1);	 
	 AddTool("ZDPWLA_ItFo_Addon_FireSteW", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_Addon_FireSteW", 10);
	SetCraftScience("ZDPWLA_ItFo_Addon_FireSteW", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Addon_FireSteW", 50);

	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ITFO_SHAURMA"); ----- Амброзия в лаваше
	SetCraftAmount("ZDPWLA_ITFO_SHAURMA", 16);
	 AddIngre("ZDPWLA_ITFO_SHAURMA", "OOLTYB_ITMI_DOUGH", 1); 
	 AddIngre("ZDPWLA_ITFO_SHAURMA", "ITMI_SPICES", 2);
     AddIngre("ZDPWLA_ITFO_SHAURMA", "ZDPWLA_ItFoMuttonRaW", 16);	 
	 AddTool("ZDPWLA_ITFO_SHAURMA", "JKZTZD_ITMW_1H_KNIFE_0");
	SetCraftPenalty("ZDPWLA_ITFO_SHAURMA", 20);
	SetCraftScience("ZDPWLA_ITFO_SHAURMA", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ITFO_SHAURMA", 100);
	

	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Managa"); ----- Манага
	SetCraftAmount("ZDPWLA_ItFo_Managa", 16);
	 AddIngre("ZDPWLA_ItFo_Managa", "ZDPWLA_ItFo_Milk", 3);
	 AddIngre("ZDPWLA_ItFo_Managa", "ZDPWLA_ItPl_SwampHerb", 8);
	 AddIngre("ZDPWLA_ItFo_Managa", "ITMI_SPICES", 1);
	 AddIngre("ZDPWLA_ItFo_Managa", "OOLTYB_ItMi_FlasK", 16);
	 AddTool("ZDPWLA_ItFo_Managa", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Managa", 10);
	SetCraftScience("ZDPWLA_ItFo_Managa", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Managa", 50);	


	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Baron"); ----- Победа Дорра
	SetCraftAmount("ZDPWLA_ItFo_Baron", 32);
	 AddIngre("ZDPWLA_ItFo_Baron", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 2);
	 AddIngre("ZDPWLA_ItFo_Baron", "ITMI_SPICES", 1);
	 AddIngre("ZDPWLA_ItFo_Baron", "ZDPWLA_ItFo_Milk", 15);
	 AddIngre("ZDPWLA_ItFo_Baron", "OOLTYB_ItMi_FlasK", 32);
	 AddTool("ZDPWLA_ItFo_Baron", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Baron", 20);
	SetCraftScience("ZDPWLA_ItFo_Baron", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Baron", 100);	


	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Freedom"); ----- Глоток свободы
	SetCraftAmount("ZDPWLA_ItFo_Freedom", 17);
	 AddIngre("ZDPWLA_ItFo_Freedom", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 2);
	 AddIngre("ZDPWLA_ItFo_Freedom", "ZDPWLA_ItPl_SwampHerb", 12);
	 AddIngre("ZDPWLA_ItFo_Freedom", "ZDPWLA_ItFo_Honey", 4);
	 AddIngre("ZDPWLA_ItFo_Freedom", "OOLTYB_ItMi_FlasK", 17);
	 AddTool("ZDPWLA_ItFo_Freedom", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Freedom", 10);
	SetCraftScience("ZDPWLA_ItFo_Freedom", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Freedom", 50);	


	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_OysterSoup"); ----- Суп из устриц
	SetCraftAmount("ZDPWLA_ItFo_OysterSoup", 18);
	 AddIngre("ZDPWLA_ItFo_OysterSoup", "ZDPWLA_ItFo_Addon_Shellflesh", 8);
	 AddIngre("ZDPWLA_ItFo_OysterSoup", "ZDPWLA_ItMi_Vinegar", 3);
	 AddIngre("ZDPWLA_ItFo_OysterSoup", "ITMI_SPICES", 1);
	 AddIngre("ZDPWLA_ItFo_OysterSoup", "OOLTYB_ItMi_ReMi1", 7);
	 AddIngre("ZDPWLA_ItFo_OysterSoup", "OOLTYB_ItMi_FlasK", 18);
	 AddTool("ZDPWLA_ItFo_OysterSoup", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_OysterSoup", 20);
	SetCraftScience("ZDPWLA_ItFo_OysterSoup", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_OysterSoup", 100);	


--ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА


	AddItemCategory ("Алхимия (1 уровень)", "OOLTYB_ITMI_JOINT_1");  ----- Вялый Джо
	SetCraftAmount("OOLTYB_ITMI_JOINT_1", 5);
	 AddIngre("OOLTYB_ITMI_JOINT_1", "ZDPWLA_ItPl_SwampHerb", 5);
	 AddTool("OOLTYB_ITMI_JOINT_1", "OOLTYB_ITMI_JOINTRECIPE1");
	SetCraftPenalty("OOLTYB_ITMI_JOINT_1", 5);
	SetCraftScience("OOLTYB_ITMI_JOINT_1", "Алхимия", 1);
	SetenergyPenalty("OOLTYB_ITMI_JOINT_1", 25);


	AddItemCategory ("Алхимия (1 уровень)", "OOLTYB_ITMI_PRIPARKA");  ----- Лечебная припарка
	SetCraftAmount("OOLTYB_ITMI_PRIPARKA", 10);
	 AddIngre("OOLTYB_ITMI_PRIPARKA", "ZDPWLA_ItPl_Health_Herb_01", 1);
	 AddIngre("OOLTYB_ITMI_PRIPARKA", "ZDPWLA_ITFO_PLANTS_MOUNTAINMOSS_01", 1);
	 AddIngre("OOLTYB_ITMI_PRIPARKA", "OOLTYB_ItAt_Fat", 1);
	 AddTool("OOLTYB_ITMI_PRIPARKA", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("OOLTYB_ITMI_PRIPARKA", 10);
	SetCraftScience("OOLTYB_ITMI_PRIPARKA", "Алхимия", 1);
	SetenergyPenalty("OOLTYB_ITMI_PRIPARKA", 50);


	AddItemCategory ("Алхимия (1 уровень)", "ZEQFRN_ItPo_Health_01");  ----- Лечебная эссенция
	SetCraftAmount("ZEQFRN_ItPo_Health_01", 20);
	AddIngre("ZEQFRN_ItPo_Health_01", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("ZEQFRN_ItPo_Health_01", "ZDPWLA_ItPl_Health_Herb_01", 8);
    AddIngre("ZEQFRN_ItPo_Health_01", "OOLTYB_ItMi_FlasK", 20);
	SetCraftPenalty("ZEQFRN_ItPo_Health_01", 20);
	SetCraftScience("ZEQFRN_ItPo_Health_01", "Алхимия", 1);
	SetenergyPenalty("ZEQFRN_ItPo_Health_01", 100);


	AddItemCategory ("Алхимия (1 уровень)", "ZEQFRN_ItPo_Mana_01"); ---- Эссенция маны
	SetCraftAmount("ZEQFRN_ItPo_Mana_01", 10);
	AddIngre("ZEQFRN_ItPo_Mana_01", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("ZEQFRN_ItPo_Mana_01", "ZDPWLA_ItPl_Mana_Herb_01", 8);
	AddIngre("ZEQFRN_ItPo_Mana_01", "OOLTYB_ItMi_FlasK", 10);
	SetCraftPenalty("ZEQFRN_ItPo_Mana_01", 20);
	SetCraftScience("ZEQFRN_ItPo_Mana_01", "Алхимия", 1);
	SetenergyPenalty("ZEQFRN_ItPo_Mana_01", 100);


	AddItemCategory ("Алхимия (1 уровень)", "OOLTYB_ITMI_TAN");  ---- Дубильный состав
	SetCraftAmount("OOLTYB_ITMI_TAN", 1);
	AddIngre("OOLTYB_ITMI_TAN", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("OOLTYB_ITMI_TAN", "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", 5);
	SetCraftPenalty("OOLTYB_ITMI_TAN", 10);
	SetCraftScience("OOLTYB_ITMI_TAN", "Алхимия", 1);
	SetenergyPenalty("OOLTYB_ITMI_TAN", 50);
	

	AddItemCategory ("Алхимия (1 уровень)", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01");  ---- Спирт
	SetCraftAmount("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "ZDPWLA_ItPl_Temp_Herb", 12);
	AddIngre("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "OOLTYB_ItMi_FlasK", 1);
	AddAlterIngre("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "zdpwla_itfo_plants_seraphis_01", 12);
	AddAlterIngre("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "OOLTYB_ItMi_FlasK", 1);
	SetCraftPenalty("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 5);
	SetCraftScience("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "Алхимия", 1);
	SetenergyPenalty("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 20);


	AddItemCategory ("Алхимия (1 уровень)", "ZDPWLA_ItMi_Acid");  ---- Кислота
	SetCraftAmount("ZDPWLA_ItMi_Acid", 2);
	AddIngre("ZDPWLA_ItMi_Acid", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("ZDPWLA_ItMi_Acid", "OOLTYB_ItMi_Sulfur", 5);
	SetCraftPenalty("ZDPWLA_ItMi_Acid", 10);
	SetCraftScience("ZDPWLA_ItMi_Acid", "Алхимия", 1);
	SetenergyPenalty("ZDPWLA_ItMi_Acid", 50);


	AddItemCategory ("Алхимия (1 уровень)", "ZDPWLA_ItMi_Glue");  ---- Клей
	SetCraftAmount("ZDPWLA_ItMi_Glue", 2);
	AddIngre("ZDPWLA_ItMi_Glue", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("ZDPWLA_ItMi_Glue", "OOLTYB_ItMi_Sulfur", 1);
	AddIngre("ZDPWLA_ItMi_Glue", "OOLTYB_ItMi_Pitch", 3);	
	SetCraftPenalty("ZDPWLA_ItMi_Glue", 10);
	SetCraftScience("ZDPWLA_ItMi_Glue", "Алхимия", 1);
	SetenergyPenalty("ZDPWLA_ItMi_Glue", 50);


	AddItemCategory ("Алхимия (1 уровень)", "ZDPWLA_ItMi_Dye");  ---- Краска
	SetCraftAmount("ZDPWLA_ItMi_Dye", 2);
	AddIngre("ZDPWLA_ItMi_Dye", "OOLTYB_ItMi_ReMi2", 2);
	AddIngre("ZDPWLA_ItMi_Dye", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_02", 3);
	AddIngre("ZDPWLA_ItMi_Dye", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_01", 3);	
	AddIngre("ZDPWLA_ItMi_Dye", "ZDPWLA_ITFO_EGG", 2);
	SetCraftPenalty("ZDPWLA_ItMi_Dye", 10);
	SetCraftScience("ZDPWLA_ItMi_Dye", "Алхимия", 1);
	SetenergyPenalty("ZDPWLA_ItMi_Dye", 50);


	AddItemCategory ("Алхимия (1 уровень)", "ZDPWLA_ItMi_AlchBasis"); ----- Алхимическая основа
	SetCraftAmount("ZDPWLA_ItMi_AlchBasis", 1);
	AddIngre("ZDPWLA_ItMi_AlchBasis", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("ZDPWLA_ItMi_AlchBasis", "OOLTYB_ItMi_ReMi1", 3);
	AddIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ITFO_PLANTS_STONEROOT_01", 1);
	AddIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_01", 3);
	AddIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ItPl_Strength_Herb_01", 1);
	AddIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ITFO_PLANTS_TROLLBERRYS_01", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchBasis", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", 12);
    AddAlterIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ItPl_Perm_Herb", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ItPl_Dex_Herb_01", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_02", 3);
	AddAlterIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ITFO_PLANTS_MOUNTAINMOSS_01", 2)
	SetCraftPenalty("ZDPWLA_ItMi_AlchBasis", 10);
	SetCraftScience("ZDPWLA_ItMi_AlchBasis", "Алхимия", 1);
	SetenergyPenalty("ZDPWLA_ItMi_AlchBasis", 50);


	AddItemCategory ("Алхимия (1 уровень)", "ZDPWLA_ItMi_AlchSub"); ----- Алхимический субстрат
	SetCraftAmount("ZDPWLA_ItMi_AlchSub", 1);
	AddIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ItAt_BugMandibles", 2);
	AddIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ItAt_Sting", 2);
	AddIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ItAt_WaranFiretongue", 1);
	AddIngre("ZDPWLA_ItMi_AlchSub", "ZDPWLA_ITFO_PLANTS_STONEROOT_01", 1);
	AddIngre("ZDPWLA_ItMi_AlchSub", "ZDPWLA_ItPl_Perm_Herb", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ItAt_CrawlerMandibles", 2);
    AddAlterIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ItAt_Wing", 2);
	AddAlterIngre("ZDPWLA_ItMi_AlchSub", "ZDPWLA_ItPl_Mushroom_04", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchSub", "ZDPWLA_ItPl_Strength_Herb_01", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ItMi_ReMi", 4)
	SetCraftPenalty("ZDPWLA_ItMi_AlchSub", 10);
	SetCraftScience("ZDPWLA_ItMi_AlchSub", "Алхимия", 1);
	SetenergyPenalty("ZDPWLA_ItMi_AlchSub", 50);


	AddItemCategory ("Алхимия (2 уровень)", "OOLTYB_ITMI_JOINT_2");  ----- Северный темный
	SetCraftAmount("OOLTYB_ITMI_JOINT_2", 6);
	 AddIngre("OOLTYB_ITMI_JOINT_2", "ZDPWLA_ItPl_SwampHerb", 6);
	 AddIngre("OOLTYB_ITMI_JOINT_2", "ZDPWLA_ITFO_PLANTS_MOUNTAINMOSS_01", 1);
	 AddTool("OOLTYB_ITMI_JOINT_2", "OOLTYB_ITMI_JOINTRECIPE_2");
	SetCraftPenalty("OOLTYB_ITMI_JOINT_2", 10);
	SetCraftScience("OOLTYB_ITMI_JOINT_2", "Алхимия", 2);
	SetenergyPenalty("OOLTYB_ITMI_JOINT_2", 50);


	AddItemCategory ("Алхимия (2 уровень)", "OOLTYB_ITMI_APTEKA");  ----- Аптечка
	SetCraftAmount("OOLTYB_ITMI_APTEKA", 5);
	 AddIngre("OOLTYB_ITMI_APTEKA", "OOLTYB_ITMI_PRIPARKA", 1);
	 AddIngre("OOLTYB_ITMI_APTEKA", "OOLTYB_ITMI_BINT", 2);
	 AddIngre("OOLTYB_ITMI_APTEKA", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	 AddIngre("OOLTYB_ITMI_APTEKA", "JKZTZD_ITMW_1H_KNIFE_0", 1);
	SetCraftPenalty("OOLTYB_ITMI_APTEKA", 10);
	SetCraftScience("OOLTYB_ITMI_APTEKA", "Алхимия", 2);
	SetenergyPenalty("OOLTYB_ITMI_APTEKA", 50);


	AddItemCategory ("Алхимия (2 уровень)", "ZEQFRN_ItPo_Health_02"); ----- Лечебный экстракт
	SetCraftAmount("ZEQFRN_ItPo_Health_02", 30);
	AddIngre("ZEQFRN_ItPo_Health_02", "ZDPWLA_ItMi_AlchBasis", 1);
	AddIngre("ZEQFRN_ItPo_Health_02", "ZDPWLA_ItPl_Health_Herb_02", 5);
	AddIngre("ZEQFRN_ItPo_Health_02", "OOLTYB_ItMi_FlasK", 30);
	AddAlterIngre("ZEQFRN_ItPo_Health_02", "ZDPWLA_ItMi_AlchSub", 1);
	AddAlterIngre("ZEQFRN_ItPo_Health_02", "ZDPWLA_ItPl_Health_Herb_02", 5);
	AddAlterIngre("ZEQFRN_ItPo_Health_02", "OOLTYB_ItMi_FlasK", 30);
	SetCraftPenalty("ZEQFRN_ItPo_Health_02", 20);
	SetCraftScience("ZEQFRN_ItPo_Health_02", "Алхимия", 2);
	SetenergyPenalty("ZEQFRN_ItPo_Health_02", 100);


	AddItemCategory ("Алхимия (2 уровень)", "ZEQFRN_ItPo_Mana_02"); --- Экстракт маны
	SetCraftAmount("ZEQFRN_ItPo_Mana_02", 15);
	AddIngre("ZEQFRN_ItPo_Mana_02", "ZDPWLA_ItMi_AlchBasis", 1);
	AddIngre("ZEQFRN_ItPo_Mana_02", "ZDPWLA_ItPl_Mana_Herb_02", 5);
	AddIngre("ZEQFRN_ItPo_Mana_02", "OOLTYB_ItMi_FlasK", 15);
	AddAlterIngre("ZEQFRN_ItPo_Mana_02", "ZDPWLA_ItMi_AlchSub", 1);
	AddAlterIngre("ZEQFRN_ItPo_Mana_02", "ZDPWLA_ItPl_Mana_Herb_02", 5);
	AddAlterIngre("ZEQFRN_ItPo_Mana_02", "OOLTYB_ItMi_FlasK", 15);
	SetCraftPenalty("ZEQFRN_ItPo_Mana_02", 20);
	SetCraftScience("ZEQFRN_ItPo_Mana_02", "Алхимия", 2);
	SetenergyPenalty("ZEQFRN_ItPo_Mana_02", 100);


	AddItemCategory ("Алхимия (3 уровень)", "OOLTYB_ITMI_JOINT_3");  ----- Мечта рудокопа
	SetCraftAmount("OOLTYB_ITMI_JOINT_3", 7);
	 AddIngre("OOLTYB_ITMI_JOINT_3", "ZDPWLA_ItPl_SwampHerb", 6);
	 AddIngre("OOLTYB_ITMI_JOINT_3", "ZDPWLA_ItPl_Mushroom_04", 2);
	 AddTool("OOLTYB_ITMI_JOINT_3", "OOLTYB_ITMI_JOINTRECIPE_2");
	SetCraftPenalty("OOLTYB_ITMI_JOINT_3", 20);
	SetCraftScience("OOLTYB_ITMI_JOINT_3", "Алхимия", 3);
	SetenergyPenalty("OOLTYB_ITMI_JOINT_3", 100);
	
	
	AddItemCategory ("Алхимия (3 уровень)", "ZDPWLA_ItFo_Opus");  ----- Опус Максима
	SetCraftAmount("ZDPWLA_ItFo_Opus", 15);
	 AddIngre("ZDPWLA_ItFo_Opus", "ZDPWLA_ItMi_AlchBasis", 1);
	 AddIngre("ZDPWLA_ItFo_Opus", "ZDPWLA_ItMi_AlchSub", 1);
	 AddIngre("ZEQFRN_ItPo_Health_03", "OOLTYB_ItMi_FlasK", 15);
	 AddTool("ZDPWLA_ItFo_Opus", "OOLTYB_ITMI_OPUSRECIPE");
	SetCraftPenalty("ZDPWLA_ItFo_Opus", 20);
	SetCraftScience("ZDPWLA_ItFo_Opus", "Алхимия", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Opus", 100);	


	AddItemCategory ("Алхимия (3 уровень)", "ZEQFRN_ItPo_Health_03"); ---- Лечебный эликсир
	SetCraftAmount("ZEQFRN_ItPo_Health_03", 20);
	AddIngre("ZEQFRN_ItPo_Health_03", "ZDPWLA_ItMi_AlchBasis", 1);
	AddIngre("ZEQFRN_ItPo_Health_03", "ZDPWLA_ItPl_Health_Herb_03", 5);
	AddIngre("ZEQFRN_ItPo_Health_03", "OOLTYB_ItMi_FlasK", 20);
	AddAlterIngre("ZEQFRN_ItPo_Health_03", "ZDPWLA_ItMi_AlchSub", 1);
	AddAlterIngre("ZEQFRN_ItPo_Health_03", "ZDPWLA_ItPl_Health_Herb_03", 5);
	AddAlterIngre("ZEQFRN_ItPo_Health_03", "OOLTYB_ItMi_FlasK", 20);
	SetCraftPenalty("ZEQFRN_ItPo_Health_03", 20);
	SetCraftScience("ZEQFRN_ItPo_Health_03", "Алхимия", 3);
	SetenergyPenalty("ZEQFRN_ItPo_Health_03", 100);


	AddItemCategory ("Алхимия (3 уровень)", "ZEQFRN_ItPo_Mana_03"); ---- Эликсир маны
	SetCraftAmount("ZEQFRN_ItPo_Mana_03", 10);
	AddIngre("ZEQFRN_ItPo_Mana_03", "ZDPWLA_ItMi_AlchBasis", 1);
	AddIngre("ZEQFRN_ItPo_Mana_03", "ZDPWLA_ItPl_Mana_Herb_03", 5);
	AddIngre("ZEQFRN_ItPo_Mana_03", "OOLTYB_ItMi_FlasK", 10);
	AddAlterIngre("ZEQFRN_ItPo_Mana_03", "ZDPWLA_ItMi_AlchSub", 1);
	AddAlterIngre("ZEQFRN_ItPo_Mana_03", "ZDPWLA_ItPl_Mana_Herb_03", 5);
	AddAlterIngre("ZEQFRN_ItPo_Mana_03", "OOLTYB_ItMi_FlasK", 10);
	SetCraftPenalty("ZEQFRN_ItPo_Mana_03", 20);
	SetCraftScience("ZEQFRN_ItPo_Mana_03", "Алхимия", 3);
	SetenergyPenalty("ZEQFRN_ItPo_Mana_03", 100);
	

	AddItemCategory ("Алхимия (3 уровень)", "ZEQFRN_ITPO_SON");  ---- Снотворное
	SetCraftAmount("ZEQFRN_ITPO_SON", 1);
	AddIngre("ZEQFRN_ITPO_SON", "ZDPWLA_ItPl_SwampHerb", 6);
	AddIngre("ZEQFRN_ITPO_SON", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_02", 5);
	AddIngre("ZEQFRN_ITPO_SON", "OOLTYB_ItMi_FlasK", 1);
	SetCraftPenalty("ZEQFRN_ITPO_SON", 20);
	SetCraftScience("ZEQFRN_ITPO_SON", "Алхимия", 3);
	SetenergyPenalty("ZEQFRN_ITPO_SON", 100);

	
	AddItemCategory ("Алхимия (3 уровень)", "ZEQFRN_ITPO_IAD");  ---- Яд
	SetCraftAmount("ZEQFRN_ITPO_IAD", 1);
	AddIngre("ZEQFRN_ITPO_IAD", "OOLTYB_ItAt_SharkTeeth", 1);
	AddIngre("ZEQFRN_ITPO_IAD", "OOLTYB_ItAt_Sting", 1);
	AddIngre("ZEQFRN_ITPO_IAD", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	SetCraftPenalty("ZEQFRN_ITPO_IAD", 20);
	SetCraftScience("ZEQFRN_ITPO_IAD", "Алхимия", 3);
	SetenergyPenalty("ZEQFRN_ITPO_IAD", 100);
	
	
	AddItemCategory ("Алхимия (3 уровень)", "ZEQFRN_ITPO_ANTIDOTE");  ---- Антидот
	SetCraftAmount("ZEQFRN_ITPO_ANTIDOTE", 1);
	AddIngre("ZEQFRN_ITPO_ANTIDOTE", "OOLTYB_ItAt_SharkTeeth", 5);
	AddIngre("ZEQFRN_ITPO_ANTIDOTE", "OOLTYB_ItAt_Sting", 1);
	AddIngre("ZEQFRN_ITPO_ANTIDOTE", "ZDPWLA_ItPl_Health_Herb_03", 5);
	AddIngre("ZEQFRN_ITPO_ANTIDOTE", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 3);
	SetCraftPenalty("ZEQFRN_ITPO_ANTIDOTE", 20);
	SetCraftScience("ZEQFRN_ITPO_ANTIDOTE", "Алхимия", 3);
	SetenergyPenalty("ZEQFRN_ITPO_ANTIDOTE", 100);


--АААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААаа

	
	AddItemCategory ("Кузнец (Расходники)", "OOLTYB_ITMI_S_IGNOT"); ----- Слиток
	SetCraftAmount("OOLTYB_ITMI_S_IGNOT", 1);
	 AddIngre("OOLTYB_ITMI_S_IGNOT", "OOLTYB_ItMi_Nugget", 20);
	 AddIngre("OOLTYB_ITMI_S_IGNOT", "OOLTYB_ItMi_CoaL", 5);
	 AddTool("OOLTYB_ITMI_S_IGNOT", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ITMI_S_IGNOT", 5);
	SetCraftScience("OOLTYB_ITMI_S_IGNOT", "Кузнец", 1);
	SetenergyPenalty("OOLTYB_ITMI_S_IGNOT", 25);
	
	
	AddItemCategory ("Кузнец (Расходники)", "OOLTYB_ITMI_RIVET"); ----- Заклепка
	SetCraftAmount("OOLTYB_ITMI_RIVET", 10);
	 AddIngre("OOLTYB_ITMI_RIVET", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("OOLTYB_ITMI_RIVET", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ITMI_RIVET", 10);
	SetCraftScience("OOLTYB_ITMI_RIVET", "Кузнец", 1);
	SetenergyPenalty("OOLTYB_ITMI_RIVET", 50);
	

	AddItemCategory ("Кузнец (Расходники)", "OOLTYB_ITMI_BIJOUTERIE"); ----- Бижутерия
	SetCraftAmount("OOLTYB_ITMI_BIJOUTERIE", 1);
	 AddIngre("OOLTYB_ITMI_BIJOUTERIE", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddIngre("OOLTYB_ITMI_BIJOUTERIE", "OOLTYB_ItMi_GoldNugget_Addon", 2);
	 AddAlterIngre("OOLTYB_ITMI_BIJOUTERIE", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddAlterIngre("OOLTYB_ITMI_BIJOUTERIE", "OOLTYB_ItMi_SilverNugget", 2);
	 AddTool("OOLTYB_ITMI_BIJOUTERIE", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ITMI_BIJOUTERIE", 10);
	SetCraftScience("OOLTYB_ITMI_BIJOUTERIE", "Кузнец", 1);
	SetenergyPenalty("OOLTYB_ITMI_BIJOUTERIE", 50);
	
	
	AddItemCategory ("Кузнец (Расходники)", "OOLTYB_ItMiSwordraw"); ----- Обработанная сталь
	SetCraftAmount("OOLTYB_ItMiSwordraw", 1);
	 AddIngre("OOLTYB_ItMiSwordraw", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddIngre("OOLTYB_ItMiSwordraw", "ZDPWLA_ItMi_Acid", 1);
	 AddTool("OOLTYB_ItMiSwordraw", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ItMiSwordraw", 10);
	SetCraftScience("OOLTYB_ItMiSwordraw", "Кузнец", 1);
	SetenergyPenalty("OOLTYB_ItMiSwordraw", 50);	
	
	
	AddItemCategory ("Кузнец (Расходники)", "OOLTYB_ITMI_LINKAGE"); --- Рычажный механизм
	SetCraftAmount("OOLTYB_ITMI_LINKAGE", 1);
	 AddIngre("OOLTYB_ITMI_LINKAGE", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddTool("OOLTYB_ITMI_LINKAGE", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ITMI_LINKAGE", 10);
	SetCraftScience("OOLTYB_ITMI_LINKAGE", "Кузнец", 1);
	SetenergyPenalty("OOLTYB_ITMI_LINKAGE", 50);
	
	
	AddItemCategory ("Кузнец (Расходники)", "OOLTYB_ITMI_CHIP"); --- Рудная фишка
	SetCraftAmount("OOLTYB_ITMI_CHIP", 25);
	 AddIngre("OOLTYB_ITMI_CHIP", "OOLTYB_ITMI_CRUMB", 10);
	 AddTool("OOLTYB_ITMI_CHIP", "OOLTYB_ITMI_CHIPRECIPE");
	 AddTool("OOLTYB_ITMI_CHIP", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ITMI_CHIP", 5);
	SetCraftScience("OOLTYB_ITMI_CHIP", "Кузнец", 1);
	SetenergyPenalty("OOLTYB_ITMI_CHIP", 10);
	
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА


	AddItemCategory ("Кузнец (Инструменты)", "JKZTZD_ItMw_1h_Vlk_AxE"); ---- Топорик
	SetCraftAmount("JKZTZD_ItMw_1h_Vlk_AxE", 1);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_Axe", "OOLTYB_ItMi_Nugget", 5);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_Axe", "OOLTYB_ITMI_WOOD", 5)
	 AddTool("JKZTZD_ItMw_1h_Vlk_Axe", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Vlk_Axe", 2);
	SetCraftScience("JKZTZD_ItMw_1h_Vlk_Axe", "Кузнец", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Vlk_Axe", 10);	
	

	AddItemCategory ("Кузнец (Инструменты)", "ZDPWLA_ITMI_BUCKET"); ---- Ведро
	SetCraftAmount("ZDPWLA_ITMI_BUCKET", 1);
	 AddIngre("ZDPWLA_ITMI_BUCKET", "OOLTYB_ItMi_Nugget", 5);
	 AddIngre("ZDPWLA_ITMI_BUCKET", "OOLTYB_ITMI_WOOD", 5)
	 AddTool("ZDPWLA_ITMI_BUCKET", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("ZDPWLA_ITMI_BUCKET", 2);
	SetCraftScience("ZDPWLA_ITMI_BUCKET", "Кузнец", 1);
	SetenergyPenalty("ZDPWLA_ITMI_BUCKET", 10);


	AddItemCategory ("Кузнец (Инструменты)", "JKZTZD_ItMw_2H_Axe_L_01"); ---- Кирка
	SetCraftAmount("JKZTZD_ItMw_2H_Axe_L_01", 1);
	 AddIngre("JKZTZD_ItMw_2H_Axe_L_01", "OOLTYB_ItMi_Nugget", 5);
	 AddIngre("JKZTZD_ItMw_2H_Axe_L_01", "OOLTYB_ITMI_WOOD", 5)
	 AddTool("JKZTZD_ItMw_2H_Axe_L_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Axe_L_01", 2);
	SetCraftScience("JKZTZD_ItMw_2H_Axe_L_01", "Кузнец", 1);
	SetenergyPenalty("JKZTZD_ItMw_2H_Axe_L_01", 10);
	
	
	AddItemCategory ("Кузнец (Инструменты)", "JKZTZD_ItMw_1h_Bau_Axe"); ---- Серп
	SetCraftAmount("JKZTZD_ItMw_1h_Bau_Axe", 1);
	 AddIngre("JKZTZD_ItMw_1h_Bau_Axe", "OOLTYB_ItMi_Nugget", 5);
	 AddIngre("JKZTZD_ItMw_1h_Bau_Axe", "OOLTYB_ITMI_WOOD", 5)
	 AddTool("JKZTZD_ItMw_1h_Bau_Axe", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Bau_Axe", 2);
	SetCraftScience("JKZTZD_ItMw_1h_Bau_Axe", "Кузнец", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Bau_Axe", 10);
	

	AddItemCategory ("Кузнец (Инструменты)", "JKZTZD_ItMw_1H_Mace_L_04"); ---- Кузнечный молот
	SetCraftAmount("JKZTZD_ItMw_1H_Mace_L_04", 1);
	 AddIngre("JKZTZD_ItMw_1H_Mace_L_04", "OOLTYB_ItMi_Nugget", 5);
	 AddIngre("JKZTZD_ItMw_1H_Mace_L_04", "OOLTYB_ITMI_WOOD", 5)
	 AddTool("JKZTZD_ItMw_1H_Mace_L_04", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Mace_L_04", 2);
	SetCraftScience("JKZTZD_ItMw_1H_Mace_L_04", "Кузнец", 1);
	SetenergyPenalty("JKZTZD_ItMw_1H_Mace_L_04", 10);
	
	
	AddItemCategory ("Кузнец (Инструменты)", "OOLTYB_ItMi_PaN"); --- Сковородка
	SetCraftAmount("OOLTYB_ItMi_PaN", 1);
	 AddIngre("OOLTYB_ItMi_Pan", "OOLTYB_ItMi_Nugget", 5);
	 AddIngre("OOLTYB_ItMi_Pan", "OOLTYB_ITMI_WOOD", 5)
	 AddTool("OOLTYB_ItMi_Pan", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ItMi_Pan", 2);
	SetCraftScience("OOLTYB_ItMi_Pan", "Кузнец", 1);
	SetenergyPenalty("OOLTYB_ItMi_Pan", 10);
	
	
	AddItemCategory ("Кузнец (Инструменты)", "ooltyb_itmi_saw"); ---- Пила
	SetCraftAmount("ooltyb_itmi_saw", 1);
	 AddIngre("ooltyb_itmi_saw", "OOLTYB_ItMi_Nugget", 5);
	 AddIngre("ooltyb_itmi_saw", "OOLTYB_ITMI_WOOD", 5)
	 AddTool("ooltyb_itmi_saw", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("ooltyb_itmi_saw", 2);
	SetCraftScience("ooltyb_itmi_saw", "Кузнец", 1);
	SetenergyPenalty("ooltyb_itmi_saw", 10);	

	
	AddItemCategory ("Кузнец (Инструменты)", "OOLTYB_ITMI_SCISSORS"); ---- Ножницы
	SetCraftAmount("OOLTYB_ITMI_SCISSORS", 1);
	 AddIngre("OOLTYB_ITMI_SCISSORS", "OOLTYB_ItMi_Nugget", 5);
	 AddIngre("OOLTYB_ITMI_SCISSORS", "OOLTYB_ITMI_WOOD", 5)
	 AddTool("OOLTYB_ITMI_SCISSORS", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ITMI_SCISSORS", 2);
	SetCraftScience("OOLTYB_ITMI_SCISSORS", "Кузнец", 1);
	SetenergyPenalty("OOLTYB_ITMI_SCISSORS", 10);		


	AddItemCategory ("Кузнец (Инструменты)", "jkztzd_itmw_1h_knife_01"); ---- Нож
	SetCraftAmount("jkztzd_itmw_1h_knife_01", 1);
	 AddIngre("jkztzd_itmw_1h_knife_01", "OOLTYB_ItMi_Nugget", 5);
	 AddIngre("jkztzd_itmw_1h_knife_01", "OOLTYB_ITMI_WOOD", 5)
	 AddTool("jkztzd_itmw_1h_knife_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("jkztzd_itmw_1h_knife_01", 2);
	SetCraftScience("jkztzd_itmw_1h_knife_01", "Кузнец", 1);
	SetenergyPenalty("jkztzd_itmw_1h_knife_01", 10);	
	
	
	AddItemCategory ("Кузнец (Инструменты)", "YVNZMZ_ITMI_NEEDLE"); --- Игла OOLTYB_ITMI_blank5
	SetCraftAmount("YVNZMZ_ITMI_NEEDLE", 1);
	 AddIngre("YVNZMZ_ITMI_NEEDLE", "OOLTYB_ItMi_Nugget", 5);
	 AddTool("YVNZMZ_ITMI_NEEDLE", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YVNZMZ_ITMI_NEEDLE", 2);
	SetCraftScience("YVNZMZ_ITMI_NEEDLE", "Кузнец", 1);
	SetenergyPenalty("YVNZMZ_ITMI_NEEDLE", 10);	

	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА


	AddItemCategory ("(О)Кузнец (Без уровня)", "JKZTZD_ItMw_1h_Vlk_DaggeR"); ---- Кинжал
	SetCraftAmount("JKZTZD_ItMw_1h_Vlk_DaggeR", 1);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_DaggeR", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("JKZTZD_ItMw_1h_Vlk_DaggeR", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Vlk_DaggeR", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Vlk_DaggeR", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Vlk_DaggeR", 10);


    AddItemCategory ("(О)Кузнец (Без уровня)", "JKZTZD_ItMw_1H_Sword_L_03"); ---- Волчий нож
	SetCraftAmount("JKZTZD_ItMw_1H_Sword_L_03", 1);
	 AddIngre("JKZTZD_ItMw_1H_Sword_L_03", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("JKZTZD_ItMw_1H_Sword_L_03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Sword_L_03", 10);
	SetCraftScience("JKZTZD_ItMw_1H_Sword_L_03", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1H_Sword_L_03", 10);
	
	AddItemCategory ("(О)Кузнец (Без уровня)", "JKZTZD_ItMw_2h_Bau_Axe"); ---- Топор лесоруба
	SetCraftAmount("JKZTZD_ItMw_2h_Bau_Axe", 1);
	 AddIngre("JKZTZD_ItMw_2h_Bau_Axe", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("JKZTZD_ItMw_2h_Bau_Axe", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2h_Bau_Axe", 10);
	SetCraftScience("JKZTZD_ItMw_2h_Bau_Axe", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_2h_Bau_Axe", 10);
	
	AddItemCategory ("(О)Кузнец (Без уровня)", "JKZTZD_ItMw_Nagelkeule2"); ---- Тяжелая дубина с шипами
	SetCraftAmount("JKZTZD_ItMw_Nagelkeule2", 1);
	 AddIngre("JKZTZD_ItMw_Nagelkeule2", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("JKZTZD_ItMw_Nagelkeule2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Nagelkeule2", 10);
	SetCraftScience("JKZTZD_ItMw_Nagelkeule2", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Nagelkeule2", 10);
	
	AddItemCategory ("(О)Кузнец (Без уровня)", "JKZTZD_ItMw_Sense"); ---- Малая коса
	SetCraftAmount("JKZTZD_ItMw_Sense", 1);
	 AddIngre("JKZTZD_ItMw_Sense", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("JKZTZD_ItMw_Sense", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Sense", 10);
	SetCraftScience("JKZTZD_ItMw_Sense", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Sense", 10);

	AddItemCategory ("(О)Кузнец (Без уровня)", "JKZTZD_ItMw_ShortSword1"); --- Короткий меч ополчения
	SetCraftAmount("JKZTZD_ItMw_ShortSword1", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword1", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("JKZTZD_ItMw_ShortSword1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword1", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword1", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword1", 10);


	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_ShortSword2"); --- Военный короткий меч
	SetCraftAmount("JKZTZD_ItMw_ShortSword2", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword2", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_ShortSword2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword2", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword2", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword2", 25);


	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_1h_Vlk_SworD"); ---- Шпага
	SetCraftAmount("JKZTZD_ItMw_1h_Vlk_SworD", 1);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_SworD", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_1h_Vlk_SworD", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Vlk_SworD", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Vlk_SworD", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Vlk_SworD", 25);


	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_1h_Sld_AxE"); ---- Солдатский топор
	SetCraftAmount("JKZTZD_ItMw_1h_Sld_AxE", 1);
	 AddIngre("JKZTZD_ItMw_1h_Sld_AxE", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_1h_Sld_AxE", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Sld_AxE", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Sld_AxE", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Sld_AxE", 25);


	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_ShortSword3"); --- Короткий меч
	SetCraftAmount("JKZTZD_ItMw_ShortSword3", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword3", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_ShortSword3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword3", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword3", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword3", 25);


	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_ShortSword4"); --- Волчий зуб
	SetCraftAmount("JKZTZD_ItMw_ShortSword4", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword4", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_ShortSword4", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword4", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword4", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword4", 25);
	
	
	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_ShortSword5"); ---- Изысканный короткий меч
	SetCraftAmount("JKZTZD_ItMw_ShortSword5", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword5", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_ShortSword5", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword5", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword5", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword5", 25);

	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_SchiffsaxT"); --- корабельный топор
	SetCraftAmount("JKZTZD_ItMw_SchiffsaxT", 1);
     AddIngre("JKZTZD_ItMw_SchiffsaxT", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_SchiffsaxT", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_SchiffsaxT", 10);
	SetCraftScience("JKZTZD_ItMw_SchiffsaxT", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_SchiffsaxT", 25);

	
	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_1H_Common_01"); --- Простой меч
	SetCraftAmount("JKZTZD_ItMw_1H_Common_01", 1);
	 AddIngre("JKZTZD_ItMw_1H_Common_01", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_1H_Common_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Common_01", 10);
	SetCraftScience("JKZTZD_ItMw_1H_Common_01", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1H_Common_01", 25);
	
	
	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_Franciss"); ---- Хороший кинжал
	SetCraftAmount("JKZTZD_ItMw_Franciss", 1);
	 AddIngre("JKZTZD_ItMw_Franciss", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_Franciss", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Franciss", 10);
	SetCraftScience("JKZTZD_ItMw_Franciss", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Franciss", 25);
	
	
	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_Addon_PIR1hAxE"); ---- Абордажный топор
	SetCraftAmount("JKZTZD_ItMw_Addon_PIR1hAxE", 1);
	 AddIngre("JKZTZD_ItMw_Addon_PIR1hAxE", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_Addon_PIR1hAxE", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Addon_PIR1hAxE", 10);
	SetCraftScience("JKZTZD_ItMw_Addon_PIR1hAxE", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Addon_PIR1hAxE", 25);	
	
	
	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_HellebardE");  ---  Короткая алебадра
	SetCraftAmount("JKZTZD_ItMw_HellebardE", 1);
     AddIngre("JKZTZD_ItMw_HellebardE", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_HellebardE", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_HellebardE", 10);
	SetCraftScience("JKZTZD_ItMw_HellebardE", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_HellebardE", 25);


	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_Stabkeule");  ---  Палица
	SetCraftAmount("JKZTZD_ItMw_Stabkeule", 1);
     AddIngre("JKZTZD_ItMw_Stabkeule", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_Stabkeule", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Stabkeule", 10);
	SetCraftScience("JKZTZD_ItMw_Stabkeule", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Stabkeule", 25);	
	
	
	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_Zweihaender1"); ---- легкий двуручный меч
	SetCraftAmount("JKZTZD_ItMw_Zweihaender1", 1);
     AddIngre("JKZTZD_ItMw_Zweihaender1", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_Zweihaender1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Zweihaender1", 10);
	SetCraftScience("JKZTZD_ItMw_Zweihaender1", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Zweihaender1", 25);	


	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_Streitaxt1"); --- Легкий боевой топор
	SetCraftAmount("JKZTZD_ItMw_Streitaxt1", 1);
     AddIngre("JKZTZD_ItMw_Streitaxt1", "OOLTYB_ITMI_S_IGNOT", 2);;
	 AddTool("JKZTZD_ItMw_Streitaxt1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Streitaxt1", 10);
	SetCraftScience("JKZTZD_ItMw_Streitaxt1", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Streitaxt1", 25);


	AddItemCategory ("(О)Кузнец (1 уровень)", "JKZTZD_ItMw_Folteraxt"); --- Топор палача
	SetCraftAmount("JKZTZD_ItMw_Folteraxt", 1);
     AddIngre("JKZTZD_ItMw_Folteraxt", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_Folteraxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Folteraxt", 10);
	SetCraftScience("JKZTZD_ItMw_Folteraxt", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Folteraxt", 25);	
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_1h_Mil_SworD"); --- Грубый палаш
	SetCraftAmount("JKZTZD_ItMw_1h_Mil_SworD", 1);
	 AddIngre("JKZTZD_ItMw_1h_Mil_SworD", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_1h_Mil_SworD", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Mil_SworD", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Mil_SworD", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_1h_Mil_SworD", 50);	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_1h_Sld_Sword"); --- Военный меч
	SetCraftAmount("JKZTZD_ItMw_1h_Sld_Sword", 1);
	 AddIngre("JKZTZD_ItMw_1h_Sld_Sword", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_1h_Sld_Sword", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Sld_Sword", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Sld_Sword", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_1h_Sld_Sword", 50);		
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Kriegskeule"); --- Военная дубина
	SetCraftAmount("JKZTZD_ItMw_Kriegskeule", 1);
	 AddIngre("JKZTZD_ItMw_Kriegskeule", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Kriegskeule", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Kriegskeule", 10);
	SetCraftScience("JKZTZD_ItMw_Kriegskeule", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Kriegskeule", 50);	

	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Kriegshammer1"); --- Боевой молот
	SetCraftAmount("JKZTZD_ItMw_Kriegshammer1", 1);
	 AddIngre("JKZTZD_ItMw_Kriegshammer1", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Kriegshammer1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Kriegshammer1", 10);
	SetCraftScience("JKZTZD_ItMw_Kriegshammer1", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Kriegshammer1", 50);	
	

	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Piratensaebel"); --- Пиратская абордажная сабля
	SetCraftAmount("JKZTZD_ItMw_Piratensaebel", 1);
	 AddIngre("JKZTZD_ItMw_Piratensaebel", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Piratensaebel", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Piratensaebel", 10);
	SetCraftScience("JKZTZD_ItMw_Piratensaebel", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Piratensaebel", 50);		
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Schwert"); --- Грубый длинный меч
	SetCraftAmount("JKZTZD_ItMw_Schwert", 1);
	 AddIngre("JKZTZD_ItMw_Schwert", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Schwert", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert", 10);
	SetCraftScience("JKZTZD_ItMw_Schwert", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schwert", 50);		


	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Steinbrecher"); --- Дробитель камней
	SetCraftAmount("JKZTZD_ItMw_Steinbrecher", 1);
	 AddIngre("JKZTZD_ItMw_Steinbrecher", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Steinbrecher", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Steinbrecher", 10);
	SetCraftScience("JKZTZD_ItMw_Steinbrecher", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Steinbrecher", 50);		
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Spicker"); --- Раскалыватель черепов
	SetCraftAmount("JKZTZD_ItMw_Spicker", 1);
	 AddIngre("JKZTZD_ItMw_Spicker", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Spicker", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Spicker", 10);
	SetCraftScience("JKZTZD_ItMw_Spicker", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Spicker", 50);		
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Schwert1"); --- Изысканный меч
	SetCraftAmount("JKZTZD_ItMw_Schwert1", 1);
	 AddIngre("JKZTZD_ItMw_Schwert1", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Schwert1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert1", 10);
	SetCraftScience("JKZTZD_ItMw_Schwert1", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schwert1", 50);		
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Schwert2"); --- Длинный меч
	SetCraftAmount("JKZTZD_ItMw_Schwert2", 1);
	 AddIngre("JKZTZD_ItMw_Schwert2", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Schwert2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert2", 10);
	SetCraftScience("JKZTZD_ItMw_Schwert2", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schwert2", 50);		
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Schwert3"); --- Грубый полуторный меч
	SetCraftAmount("JKZTZD_ItMw_Schwert3", 1);
	 AddIngre("JKZTZD_ItMw_Schwert3", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Schwert3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert3", 10);
	SetCraftScience("JKZTZD_ItMw_Schwert3", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schwert3", 50);		
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Rapier"); --- Рапира
	SetCraftAmount("JKZTZD_ItMw_Rapier", 1);
	 AddIngre("JKZTZD_ItMw_Rapier", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Rapier", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Rapier", 10);
	SetCraftScience("JKZTZD_ItMw_Rapier", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Rapier", 50);		
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Rubinklinge"); --- Рубиновый клинок
	SetCraftAmount("JKZTZD_ItMw_Rubinklinge", 1);
	 AddIngre("JKZTZD_ItMw_Rubinklinge", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Rubinklinge", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Rubinklinge", 10);
	SetCraftScience("JKZTZD_ItMw_Rubinklinge", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Rubinklinge", 50);		


	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_1H_Special_01"); --- Длинный рудный меч
	SetCraftAmount("JKZTZD_ItMw_1H_Special_01", 1);
	 AddIngre("JKZTZD_ItMw_1H_Special_01", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_1H_Special_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Special_01", 10);
	SetCraftScience("JKZTZD_ItMw_1H_Special_01", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_1H_Special_01", 50);	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Addon_PIR1hm"); --- Абордажный нож
	SetCraftAmount("JKZTZD_ItMw_Addon_PIR1hm", 1);
	 AddIngre("JKZTZD_ItMw_Addon_PIR1hm", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Addon_PIR1hm", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Addon_PIR1hm", 10);
	SetCraftScience("JKZTZD_ItMw_Addon_PIR1hm", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Addon_PIR1hm", 50);
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMW_Hacker_01"); --- Мачете
	SetCraftAmount("JKZTZD_ItMW_Hacker_01", 1);
	 AddIngre("JKZTZD_ItMW_Hacker_01", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMW_Hacker_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMW_Hacker_01", 10);
	SetCraftScience("JKZTZD_ItMW_Hacker_01", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMW_Hacker_01", 50);	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_2h_Sld_Axe"); --- Тяжелый солдатский топор
	SetCraftAmount("JKZTZD_ItMw_2h_Sld_Axe", 1);
	 AddIngre("JKZTZD_ItMw_2h_Sld_Axe", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_2h_Sld_Axe", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2h_Sld_Axe", 10);
	SetCraftScience("JKZTZD_ItMw_2h_Sld_Axe", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_2h_Sld_Axe", 50);	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_2h_Sld_Sword"); --- Солдатский двуручный меч
	SetCraftAmount("JKZTZD_ItMw_2h_Sld_Sword", 1);
	 AddIngre("JKZTZD_ItMw_2h_Sld_Sword", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_2h_Sld_Sword", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2h_Sld_Sword", 10);
	SetCraftScience("JKZTZD_ItMw_2h_Sld_Sword", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_2h_Sld_Sword", 50);	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_2h_Pal_Sword"); --- Изыскнный двуручный меч
	SetCraftAmount("JKZTZD_ItMw_2h_Pal_Sword", 1);
	 AddIngre("JKZTZD_ItMw_2h_Pal_Sword", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_2h_Pal_Sword", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2h_Pal_Sword", 10);
	SetCraftScience("JKZTZD_ItMw_2h_Pal_Sword", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_2h_Pal_Sword", 50);	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Zweihaender2"); --- Двуручный меч
	SetCraftAmount("JKZTZD_ItMw_Zweihaender2", 1);
	 AddIngre("JKZTZD_ItMw_Zweihaender2", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Zweihaender2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Zweihaender2", 10);
	SetCraftScience("JKZTZD_ItMw_Zweihaender2", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Zweihaender2", 50);	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Streitaxt2"); --- Боевой топор
	SetCraftAmount("JKZTZD_ItMw_Streitaxt2", 1);
	 AddIngre("JKZTZD_ItMw_Streitaxt2", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Streitaxt2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Streitaxt2", 10);
	SetCraftScience("JKZTZD_ItMw_Streitaxt2", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Streitaxt2", 50);	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Zweihaender4"); --- Тяжелый двуручный меч
	SetCraftAmount("JKZTZD_ItMw_Zweihaender4", 1);
	 AddIngre("JKZTZD_ItMw_Zweihaender4", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Zweihaender4", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Zweihaender4", 10);
	SetCraftScience("JKZTZD_ItMw_Zweihaender4", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Zweihaender4", 50);
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMw_Schlachtaxt"); --- Военный топор
	SetCraftAmount("JKZTZD_ItMw_Schlachtaxt", 1);
	 AddIngre("JKZTZD_ItMw_Schlachtaxt", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMw_Schlachtaxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schlachtaxt", 10);
	SetCraftScience("JKZTZD_ItMw_Schlachtaxt", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schlachtaxt", 50);
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "JKZTZD_ItMW_Hacker_03"); --- Гигантское мачете
	SetCraftAmount("JKZTZD_ItMW_Hacker_03", 1);
	 AddIngre("JKZTZD_ItMW_Hacker_03", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("JKZTZD_ItMW_Hacker_03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMW_Hacker_03", 10);
	SetCraftScience("JKZTZD_ItMW_Hacker_03", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMW_Hacker_03", 50);

	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Morgenstern"); --- Булава с шипами
	SetCraftAmount("JKZTZD_ItMw_Morgenstern", 1);
	 AddIngre("JKZTZD_ItMw_Morgenstern", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_Morgenstern", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_Morgenstern", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_Morgenstern", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_Morgenstern", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Morgenstern", 20);
	SetCraftScience("JKZTZD_ItMw_Morgenstern", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Morgenstern", 100);	
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Doppelaxt"); --- Двойной топор
	SetCraftAmount("JKZTZD_ItMw_Doppelaxt", 1);
	 AddIngre("JKZTZD_ItMw_Doppelaxt", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddIngre("JKZTZD_ItMw_Doppelaxt", "OOLTYB_ItMiSwordraw", 3);
	 AddIngre("JKZTZD_ItMw_Doppelaxt", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_Doppelaxt", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_Doppelaxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Doppelaxt", 20);
	SetCraftScience("JKZTZD_ItMw_Doppelaxt", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Doppelaxt", 100);	
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_1h_Pal_Sword"); --- Меч офицера
	SetCraftAmount("JKZTZD_ItMw_1h_Pal_Sword", 1);
	 AddIngre("JKZTZD_ItMw_1h_Pal_Sword", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_1h_Pal_Sword", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_1h_Pal_Sword", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_1h_Pal_Sword", "OOLTYB_ItMi_Aquamarine", 1);
	 AddAlterIngre("JKZTZD_ItMw_1h_Pal_Sword", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddAlterIngre("JKZTZD_ItMw_1h_Pal_Sword", "OOLTYB_ItMiSwordraw", 4);
	 AddAlterIngre("JKZTZD_ItMw_1h_Pal_Sword", "OOLTYB_ITMI_HANDLE", 1);
	 AddAlterIngre("JKZTZD_ItMw_1h_Pal_Sword", "OOLTYB_ItMi_Ruby", 1);
	 AddTool("JKZTZD_ItMw_1h_Pal_Sword", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Pal_Sword", 20);
	SetCraftScience("JKZTZD_ItMw_1h_Pal_Sword", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_1h_Pal_Sword", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Bartaxt"); --- Короткий бердыш
	SetCraftAmount("JKZTZD_ItMw_Bartaxt", 1);
	 AddIngre("JKZTZD_ItMw_Bartaxt", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddIngre("JKZTZD_ItMw_Bartaxt", "OOLTYB_ItMiSwordraw", 3);
	 AddIngre("JKZTZD_ItMw_Bartaxt", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_Bartaxt", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_Bartaxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Bartaxt", 20);
	SetCraftScience("JKZTZD_ItMw_Bartaxt", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Bartaxt", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Schwert4"); --- Изысканный длинный меч
	SetCraftAmount("JKZTZD_ItMw_Schwert4", 1);
	 AddIngre("JKZTZD_ItMw_Schwert4", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_Schwert4", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_Schwert4", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_Schwert4", "OOLTYB_ItMi_Aquamarine", 1);
	 AddAlterIngre("JKZTZD_ItMw_Schwert4", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddAlterIngre("JKZTZD_ItMw_Schwert4", "OOLTYB_ItMiSwordraw", 4);
	 AddAlterIngre("JKZTZD_ItMw_Schwert4", "OOLTYB_ITMI_HANDLE", 1);
	 AddAlterIngre("JKZTZD_ItMw_Schwert4", "OOLTYB_ItMi_Ruby", 1);
	 AddTool("JKZTZD_ItMw_Schwert4", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert4", 20);
	SetCraftScience("JKZTZD_ItMw_Schwert4", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Schwert4", 100);			
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Streitkolben"); --- Булава
	SetCraftAmount("JKZTZD_ItMw_Streitkolben", 1);
	 AddIngre("JKZTZD_ItMw_Streitkolben", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_Streitkolben", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_Streitkolben", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_Streitkolben", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_Streitkolben", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Streitkolben", 20);
	SetCraftScience("JKZTZD_ItMw_Streitkolben", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Streitkolben", 100);	
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Runenschwert"); --- Лунный меч
	SetCraftAmount("JKZTZD_ItMw_Runenschwert", 1);
	 AddIngre("JKZTZD_ItMw_Runenschwert", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_Runenschwert", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_Runenschwert", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_Runenschwert", "OOLTYB_ItMi_Aquamarine", 1);
	 AddAlterIngre("JKZTZD_ItMw_Runenschwert", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddAlterIngre("JKZTZD_ItMw_Runenschwert", "OOLTYB_ItMiSwordraw", 4);
	 AddAlterIngre("JKZTZD_ItMw_Runenschwert", "OOLTYB_ITMI_HANDLE", 1);
	 AddAlterIngre("JKZTZD_ItMw_Runenschwert", "OOLTYB_ItMi_Ruby", 1);
	 AddTool("JKZTZD_ItMw_Runenschwert", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Runenschwert", 20);
	SetCraftScience("JKZTZD_ItMw_Runenschwert", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Runenschwert", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Rabenschnabel"); --- Клюв ворона
	SetCraftAmount("JKZTZD_ItMw_Rabenschnabel", 1);
	 AddIngre("JKZTZD_ItMw_Rabenschnabel", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_Rabenschnabel", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_Rabenschnabel", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_Rabenschnabel", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_Rabenschnabel", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Rabenschnabel", 20);
	SetCraftScience("JKZTZD_ItMw_Rabenschnabel", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Rabenschnabel", 100);	
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Schwert5"); --- Изысканный полуторный меч
	SetCraftAmount("JKZTZD_ItMw_Schwert5", 1);
	 AddIngre("JKZTZD_ItMw_Schwert5", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_Schwert5", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_Schwert5", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_Schwert5", "OOLTYB_ItMi_Aquamarine", 1);
	 AddAlterIngre("JKZTZD_ItMw_Schwert5", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddAlterIngre("JKZTZD_ItMw_Schwert5", "OOLTYB_ItMiSwordraw", 4);
	 AddAlterIngre("JKZTZD_ItMw_Schwert5", "OOLTYB_ITMI_HANDLE", 1);
	 AddAlterIngre("JKZTZD_ItMw_Schwert5", "OOLTYB_ItMi_Ruby", 1);
	 AddTool("JKZTZD_ItMw_Schwert5", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert5", 20);
	SetCraftScience("JKZTZD_ItMw_Schwert5", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Schwert5", 100);
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Inquisitor"); --- Инквизитор
	SetCraftAmount("JKZTZD_ItMw_Inquisitor", 1);
	 AddIngre("JKZTZD_ItMw_Inquisitor", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_Inquisitor", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_Inquisitor", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_Inquisitor", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_Inquisitor", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Inquisitor", 20);
	SetCraftScience("JKZTZD_ItMw_Inquisitor", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Inquisitor", 100);	
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_ElBastardo"); --- Эль-бастардо
	SetCraftAmount("JKZTZD_ItMw_ElBastardo", 1);
	 AddIngre("JKZTZD_ItMw_ElBastardo", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddIngre("JKZTZD_ItMw_ElBastardo", "OOLTYB_ItMiSwordraw", 3);
	 AddIngre("JKZTZD_ItMw_ElBastardo", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_ElBastardo", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_ElBastardo", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ElBastardo", 20);
	SetCraftScience("JKZTZD_ItMw_ElBastardo", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_ElBastardo", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Kriegshammer2"); --- Тяжелый боевой молот
	SetCraftAmount("JKZTZD_ItMw_Kriegshammer2", 1);
	 AddIngre("JKZTZD_ItMw_Kriegshammer2", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_Kriegshammer2", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_Kriegshammer2", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_Kriegshammer2", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_Kriegshammer2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Kriegshammer2", 20);
	SetCraftScience("JKZTZD_ItMw_Kriegshammer2", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Kriegshammer2", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Meisterdegen"); --- Шпага мастера
	SetCraftAmount("JKZTZD_ItMw_Meisterdegen", 1);
	 AddIngre("JKZTZD_ItMw_Meisterdegen", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_Meisterdegen", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_Meisterdegen", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_Meisterdegen", "OOLTYB_ItMi_Aquamarine", 1);
	 AddAlterIngre("JKZTZD_ItMw_Meisterdegen", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddAlterIngre("JKZTZD_ItMw_Meisterdegen", "OOLTYB_ItMiSwordraw", 4);
	 AddAlterIngre("JKZTZD_ItMw_Meisterdegen", "OOLTYB_ITMI_HANDLE", 1);
	 AddAlterIngre("JKZTZD_ItMw_Meisterdegen", "OOLTYB_ItMi_Ruby", 1);
	 AddTool("JKZTZD_ItMw_Meisterdegen", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Meisterdegen", 20);
	SetCraftScience("JKZTZD_ItMw_Meisterdegen", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Meisterdegen", 100);	
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Orkschlaecht"); --- Убийца орков
	SetCraftAmount("JKZTZD_ItMw_Orkschlaecht", 1);
	 AddIngre("JKZTZD_ItMw_Orkschlaecht", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_Orkschlaecht", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_Orkschlaecht", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_Orkschlaecht", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_Orkschlaecht", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Orkschlaecht", 20);
	SetCraftScience("JKZTZD_ItMw_Orkschlaecht", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Orkschlaecht", 100);			
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_1H_Blessed_01"); --- Одноручный рудный клинок
	SetCraftAmount("JKZTZD_ItMw_1H_Blessed_01", 1);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_01", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_01", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_01", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_01", "OOLTYB_ItMi_Aquamarine", 1);
	 AddAlterIngre("JKZTZD_ItMw_1H_Blessed_01", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddAlterIngre("JKZTZD_ItMw_1H_Blessed_01", "OOLTYB_ItMiSwordraw", 4);
	 AddAlterIngre("JKZTZD_ItMw_1H_Blessed_01", "OOLTYB_ITMI_HANDLE", 1);
	 AddAlterIngre("JKZTZD_ItMw_1H_Blessed_01", "OOLTYB_ItMi_Ruby", 1);
	 AddTool("JKZTZD_ItMw_1H_Blessed_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Blessed_01", 20);
	SetCraftScience("JKZTZD_ItMw_1H_Blessed_01", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_1H_Blessed_01", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_1H_Special_02"); --- Полуторный рудный меч
	SetCraftAmount("JKZTZD_ItMw_1H_Special_02", 1);
	 AddIngre("JKZTZD_ItMw_1H_Special_02", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_1H_Special_02", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_1H_Special_02", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_1H_Special_02", "OOLTYB_ItMi_Aquamarine", 1);
	 AddAlterIngre("JKZTZD_ItMw_1H_Special_02", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddAlterIngre("JKZTZD_ItMw_1H_Special_02", "OOLTYB_ItMiSwordraw", 4);
	 AddAlterIngre("JKZTZD_ItMw_1H_Special_02", "OOLTYB_ITMI_HANDLE", 1);
	 AddAlterIngre("JKZTZD_ItMw_1H_Special_02", "OOLTYB_ItMi_Ruby", 1);
	 AddTool("JKZTZD_ItMw_1H_Special_02", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Special_02", 20);
	SetCraftScience("JKZTZD_ItMw_1H_Special_02", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_1H_Special_02", 100);			
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_1H_Special_03"); --- Рудный боевой клинок
	SetCraftAmount("JKZTZD_ItMw_1H_Special_03", 1);
	 AddIngre("JKZTZD_ItMw_1H_Special_03", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_1H_Special_03", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_1H_Special_03", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_1H_Special_03", "OOLTYB_ItMi_Aquamarine", 1);
	 AddAlterIngre("JKZTZD_ItMw_1H_Special_03", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddAlterIngre("JKZTZD_ItMw_1H_Special_03", "OOLTYB_ItMiSwordraw", 4);
	 AddAlterIngre("JKZTZD_ItMw_1H_Special_03", "OOLTYB_ITMI_HANDLE", 1);
	 AddAlterIngre("JKZTZD_ItMw_1H_Special_03", "OOLTYB_ItMi_Ruby", 1);
	 AddTool("JKZTZD_ItMw_1H_Special_03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Special_03", 20);
	SetCraftScience("JKZTZD_ItMw_1H_Special_03", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_1H_Special_03", 100);	
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Addon_Betty"); --- Бетти
	SetCraftAmount("JKZTZD_ItMw_Addon_Betty", 1);
	 AddIngre("JKZTZD_ItMw_Addon_Betty", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_Addon_Betty", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_Addon_Betty", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_Addon_Betty", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_Addon_Betty", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Addon_Betty", 20);
	SetCraftScience("JKZTZD_ItMw_Addon_Betty", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Addon_Betty", 100);


	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Krummschwert"); --- Абордажная сабля
	SetCraftAmount("JKZTZD_ItMw_Krummschwert", 1);
	 AddIngre("JKZTZD_ItMw_Krummschwert", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_Krummschwert", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_Krummschwert", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_Krummschwert", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_Krummschwert", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Krummschwert", 20);
	SetCraftScience("JKZTZD_ItMw_Krummschwert", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Krummschwert", 100);
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Barbarenstr"); --- Боевой топор варваров
	SetCraftAmount("JKZTZD_ItMw_Barbarenstr", 1);
	 AddIngre("JKZTZD_ItMw_Barbarenstr", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddIngre("JKZTZD_ItMw_Barbarenstr", "OOLTYB_ItMiSwordraw", 3);
	 AddIngre("JKZTZD_ItMw_Barbarenstr", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_Barbarenstr", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_Barbarenstr", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Barbarenstr", 20);
	SetCraftScience("JKZTZD_ItMw_Barbarenstr", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Barbarenstr", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Berserkeraxt"); --- Топор берсеркера
	SetCraftAmount("JKZTZD_ItMw_Berserkeraxt", 1);
	 AddIngre("JKZTZD_ItMw_Berserkeraxt", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddIngre("JKZTZD_ItMw_Berserkeraxt", "OOLTYB_ItMiSwordraw", 3);
	 AddIngre("JKZTZD_ItMw_Berserkeraxt", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_Berserkeraxt", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_Berserkeraxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Berserkeraxt", 20);
	SetCraftScience("JKZTZD_ItMw_Berserkeraxt", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Berserkeraxt", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Sturmbringer"); --- Верный друг
	SetCraftAmount("JKZTZD_ItMw_Sturmbringer", 1);
	 AddIngre("JKZTZD_ItMw_Sturmbringer", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_Sturmbringer", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_Sturmbringer", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_Sturmbringer", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_Sturmbringer", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Sturmbringer", 20);
	SetCraftScience("JKZTZD_ItMw_Sturmbringer", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Sturmbringer", 100);	


	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_2H_Blessed_01"); --- Грубый рудный клинок
	SetCraftAmount("JKZTZD_ItMw_2H_Blessed_01", 1);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_01", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_01", "OOLTYB_ItMiSwordraw", 4);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_01", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_01", "OOLTYB_ItMi_Aquamarine", 1);
	 AddAlterIngre("JKZTZD_ItMw_2H_Blessed_01", "OOLTYB_ITMI_S_IGNOT", 6);
	 AddAlterIngre("JKZTZD_ItMw_2H_Blessed_01", "OOLTYB_ItMiSwordraw", 4);
	 AddAlterIngre("JKZTZD_ItMw_2H_Blessed_01", "OOLTYB_ITMI_HANDLE", 1);
	 AddAlterIngre("JKZTZD_ItMw_2H_Blessed_01", "OOLTYB_ItMi_Ruby", 1);
	 AddTool("JKZTZD_ItMw_2H_Blessed_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Blessed_01", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Blessed_01", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Blessed_01", 100);	


	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_2H_Blessed_02"); --- Меч ордена
	SetCraftAmount("JKZTZD_ItMw_2H_Blessed_02", 1);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_02", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_02", "OOLTYB_ItMiSwordraw", 3);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_02", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_02", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_2H_Blessed_02", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Blessed_02", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Blessed_02", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Blessed_02", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_2H_Special_02"); --- Тяжелый рудный двуручник
	SetCraftAmount("JKZTZD_ItMw_2H_Special_02", 1);
	 AddIngre("JKZTZD_ItMw_2H_Special_02", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddIngre("JKZTZD_ItMw_2H_Special_02", "OOLTYB_ItMiSwordraw", 3);
	 AddIngre("JKZTZD_ItMw_2H_Special_02", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_2H_Special_02", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_2H_Special_02", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Special_02", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Special_02", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Special_02", 100);		
	

	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_Addon_PIR2hAx"); --- Крушитель досок
	SetCraftAmount("JKZTZD_ItMw_Addon_PIR2hAx", 1);
	 AddIngre("JKZTZD_ItMw_Addon_PIR2hAx", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddIngre("JKZTZD_ItMw_Addon_PIR2hAx", "OOLTYB_ItMiSwordraw", 3);
	 AddIngre("JKZTZD_ItMw_Addon_PIR2hAx", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_Addon_PIR2hAx", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("JKZTZD_ItMw_Addon_PIR2hAx", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Addon_PIR2hAx", 20);
	SetCraftScience("JKZTZD_ItMw_Addon_PIR2hAx", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Addon_PIR2hAx", 100);		

	AddItemCategory ("(О)Кузнец (3 уровень)", "JKZTZD_ItMw_2H_Special_01"); --- Королевский клинок
	SetCraftAmount("JKZTZD_ItMw_2H_Special_01", 1);
	 AddIngre("JKZTZD_ItMw_2H_Special_01", "OOLTYB_ITMI_S_IGNOT", 8);
	 AddIngre("JKZTZD_ItMw_2H_Special_01", "OOLTYB_ItMiSwordraw", 8);
	 AddIngre("JKZTZD_ItMw_2H_Special_01", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_2H_Special_01", "OOLTYB_ITMI_DLEATHER", 2);
	 AddIngre("JKZTZD_ItMw_2H_Special_01", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_2H_Special_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Special_01", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Special_01", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Special_01", 100);	
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА	


	AddItemCategory ("(О)Кузнец (4 уровень)", "JKZTZD_ItMw_1H_Blessed_02"); --- Освященный рудный клинок
	SetCraftAmount("JKZTZD_ItMw_1H_Blessed_02", 1);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "OOLTYB_ITMI_S_IGNOT", 8);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "OOLTYB_ItMiSwordraw", 8);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "OOLTYB_ITMI_DLEATHER", 2);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_1H_Blessed_02", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Blessed_02", 20);
	SetCraftScience("JKZTZD_ItMw_1H_Blessed_02", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_1H_Blessed_02", 100);		


	AddItemCategory ("(О)Кузнец (4 уровень)", "JKZTZD_ItMw_Zweihaender3"); --- Сила рун
	SetCraftAmount("JKZTZD_ItMw_Zweihaender3", 1);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "OOLTYB_ITMI_S_IGNOT", 8);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "OOLTYB_ItMiSwordraw", 8);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "OOLTYB_ITMI_DLEATHER", 2);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_Zweihaender3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Zweihaender3", 20);
	SetCraftScience("JKZTZD_ItMw_Zweihaender3", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Zweihaender3", 100);
	
	
	AddItemCategory ("(О)Кузнец (4 уровень)", "JKZTZD_ItMw_Drachenschne"); --- Гроза драконов
	SetCraftAmount("JKZTZD_ItMw_Drachenschne", 1);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "OOLTYB_ITMI_S_IGNOT", 8);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "OOLTYB_ItMiSwordraw", 8);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "OOLTYB_ITMI_DLEATHER", 2);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_Drachenschne", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Drachenschne", 20);
	SetCraftScience("JKZTZD_ItMw_Drachenschne", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Drachenschne", 100);	
	
	
	AddItemCategory ("(О)Кузнец (4 уровень)", "JKZTZD_ItMw_2H_Blessed_03"); --- Святой палач
	SetCraftAmount("JKZTZD_ItMw_2H_Blessed_03", 1);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "OOLTYB_ITMI_S_IGNOT", 8);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "OOLTYB_ItMiSwordraw", 8);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "OOLTYB_ITMI_DLEATHER", 2);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_2H_Blessed_03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Blessed_03", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Blessed_03", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Blessed_03", 100);	
	
		
	AddItemCategory ("(О)Кузнец (4 уровень)", "JKZTZD_ItMw_2H_Special03"); --- Тяжелый рудный боевой клинок
	SetCraftAmount("JKZTZD_ItMw_2H_Special03", 1);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "OOLTYB_ITMI_S_IGNOT", 8);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "OOLTYB_ItMiSwordraw", 8);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "OOLTYB_ITMI_DLEATHER", 2);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_2H_Special03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Special03", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Special03", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Special03", 100);	
	
	
	AddItemCategory ("(О)Кузнец (4 уровень)", "JKZTZD_ItMw_2H_Special_04"); --- Двуручный Убийца Драконов
	SetCraftAmount("JKZTZD_ItMw_2H_Special_04", 1);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "OOLTYB_ITMI_S_IGNOT", 8);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "OOLTYB_ItMiSwordraw", 8);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "OOLTYB_ITMI_DLEATHER", 2);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_2H_Special_04", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Special_04", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Special_04", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Special_04", 100);	
	
	
	AddItemCategory ("(О)Кузнец (4 уровень)", "JKZTZD_ItMw_Drachenschne1"); --- Огромный меч
	SetCraftAmount("JKZTZD_ItMw_Drachenschne1", 1);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "OOLTYB_ITMI_S_IGNOT", 8);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "OOLTYB_ItMiSwordraw", 8);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "OOLTYB_ITMI_DLEATHER", 2);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_Drachenschne1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Drachenschne1", 20);
	SetCraftScience("JKZTZD_ItMw_Drachenschne1", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Drachenschne1", 100);	
	

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА


	AddItemCategory ("Плотник (Расходники)", "OOLTYB_ITMI_OBRABOTDER"); --- Обработанная древесина
	SetCraftAmount("OOLTYB_ITMI_OBRABOTDER", 1);
	 AddIngre("OOLTYB_ITMI_OBRABOTDER", "OOLTYB_ITMI_WOOD", 20);
	 AddIngre("OOLTYB_ITMI_OBRABOTDER", "OOLTYB_ItMi_Coal", 5);
	 AddTool("OOLTYB_ITMI_OBRABOTDER", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ITMI_OBRABOTDER", 5);
	SetCraftScience("OOLTYB_ITMI_OBRABOTDER", "Плотник", 1);
	SetenergyPenalty("OOLTYB_ITMI_OBRABOTDER", 25);	


	AddItemCategory ("Плотник (Расходники)", "OOLTYB_ITMI_HANDLE"); --- Рукоять
	SetCraftAmount("OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("OOLTYB_ITMI_HANDLE", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddTool("OOLTYB_ITMI_HANDLE", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ITMI_HANDLE", 10);
	SetCraftScience("OOLTYB_ITMI_HANDLE", "Плотник", 1);
	SetenergyPenalty("OOLTYB_ITMI_HANDLE", 50);	


	AddItemCategory ("Плотник (Расходники)", "OOLTYB_ItMi_FlasK"); --- Мензурка
	SetCraftAmount("OOLTYB_ItMi_FlasK", 40);
	 AddIngre("OOLTYB_ItMi_FlasK", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddTool("OOLTYB_ItMi_FlasK", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ItMi_FlasK", 5);
	SetCraftScience("OOLTYB_ItMi_FlasK", "Плотник", 1);
	SetenergyPenalty("OOLTYB_ItMi_FlasK", 25);	
	
	
	AddItemCategory ("Плотник (Расходники)", "JKZTZD_ItRw_Arrow"); --- Стрела
	SetCraftAmount("JKZTZD_ItRw_Arrow", 40);
	 AddIngre("JKZTZD_ItRw_Arrow", "OOLTYB_ITMI_WOOD", 10);
	 AddIngre("JKZTZD_ItRw_Arrow", "OOLTYB_ItMi_Nugget", 5);
	 AddAlterIngre("JKZTZD_ItRw_Arrow", "JKZTZD_ItMw_1h_Bau_Mace", 1);
	 AddAlterIngre("JKZTZD_ItRw_Arrow", "OOLTYB_ItMi_Nugget", 5);
	 AddTool("JKZTZD_ItRw_Arrow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Arrow", 5);
	SetCraftScience("JKZTZD_ItRw_Arrow", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Arrow", 10);	
	
	
	AddItemCategory ("Плотник (Расходники)", "JKZTZD_ItRw_Bolt"); --- Болт
	SetCraftAmount("JKZTZD_ItRw_Bolt", 40);
	 AddIngre("JKZTZD_ItRw_Bolt", "OOLTYB_ITMI_WOOD", 10);
	 AddIngre("JKZTZD_ItRw_Bolt", "OOLTYB_ItMi_Nugget", 5);
	 AddAlterIngre("JKZTZD_ItRw_Bolt", "JKZTZD_ItMw_1h_Bau_Mace", 1);
	 AddAlterIngre("JKZTZD_ItRw_Bolt", "OOLTYB_ItMi_Nugget", 5);
	 AddTool("JKZTZD_ItRw_Bolt", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bolt", 5);
	SetCraftScience("JKZTZD_ItRw_Bolt", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Bolt", 10);		


	AddItemCategory ("Плотник (Расходники)", "ooltyb_itmi_paper"); --- Бумага
	SetCraftAmount("ooltyb_itmi_paper", 50);
	 AddIngre("ooltyb_itmi_paper", "OOLTYB_ITMI_WOOD", 25);
	SetCraftPenalty("ooltyb_itmi_paper", 5);
	SetCraftScience("ooltyb_itmi_paper", "Плотник", 1);
	SetenergyPenalty("ooltyb_itmi_paper", 10);	
	
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	
	AddItemCategory ("Плотник (1 уровень)", "OOLTYB_ITMI_FISHING"); --- Удочка
	SetCraftAmount("OOLTYB_ITMI_FISHING", 1);
	 AddIngre("OOLTYB_ITMI_FISHING", "JKZTZD_ItMw_1h_Bau_Mace", 1);
	 AddIngre("OOLTYB_ITMI_FISHING", "OOLTYB_ITMI_SHEEP", 1);
	 AddTool("OOLTYB_ITMI_FISHING", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ITMI_FISHING", 5);
	SetCraftScience("OOLTYB_ITMI_FISHING", "Плотник", 1);
	SetenergyPenalty("OOLTYB_ITMI_FISHING", 10);	

	
	AddItemCategory ("Плотник (1 уровень)", "OOLTYB_ItMi_Scoop"); --- Ложка
	SetCraftAmount("OOLTYB_ItMi_Scoop", 1);
	 AddIngre("OOLTYB_ItMi_Scoop", "OOLTYB_ITMI_WOOD", 10);
	 AddTool("OOLTYB_ItMi_Scoop", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ItMi_Scoop", 5);
	SetCraftScience("OOLTYB_ItMi_Scoop", "Плотник", 1);
	SetenergyPenalty("OOLTYB_ItMi_Scoop", 10);		
	

	AddItemCategory ("Плотник (Без уровня)", "JKZTZD_ItMw_1h_Vlk_Mace"); --- Трость
	SetCraftAmount("JKZTZD_ItMw_1h_Vlk_Mace", 1);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_Mace", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddTool("JKZTZD_ItMw_1h_Vlk_Mace", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_1h_Vlk_Mace", 5);
	SetCraftScience("JKZTZD_ItMw_1h_Vlk_Mace", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Vlk_Mace", 10);		


	AddItemCategory ("Плотник (Без уровня)", "JKZTZD_ItMw_1H_Mace_L_03"); --- Дубина
	SetCraftAmount("JKZTZD_ItMw_1H_Mace_L_03", 1);
	 AddIngre("JKZTZD_ItMw_1H_Mace_L_03", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddTool("JKZTZD_ItMw_1H_Mace_L_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_1H_Mace_L_03", 5);
	SetCraftScience("JKZTZD_ItMw_1H_Mace_L_03", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1H_Mace_L_03", 10);

AddItemCategory ("Плотник (Без уровня)", "JKZTZD_ItMw_Nagelknueppel"); --- Палица с шипами
	SetCraftAmount("JKZTZD_ItMw_Nagelknueppel", 1);
	 AddIngre("JKZTZD_ItMw_Nagelknueppel", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddTool("JKZTZD_ItMw_Nagelknueppel", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_Nagelknueppel", 5);
	SetCraftScience("JKZTZD_ItMw_Nagelknueppel", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Nagelknueppel", 10);

	AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItMw_1h_Nov_Mace"); --- Боевой посох
	SetCraftAmount("JKZTZD_ItMw_1h_Nov_Mace", 1);
	 AddIngre("JKZTZD_ItMw_1h_Nov_Mace", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItMw_1h_Nov_Mace", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_1h_Nov_Mace", 5);
	SetCraftScience("JKZTZD_ItMw_1h_Nov_Mace", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Nov_Mace", 25);
	
	
	AddItemCategory ("Плотник (Без уровня)", "JKZTZD_ItRw_Bow_L_01"); --- Короткий лук
	SetCraftAmount("JKZTZD_ItRw_Bow_L_01", 1);
	 AddIngre("JKZTZD_ItRw_Bow_L_01", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddTool("JKZTZD_ItRw_Bow_L_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_L_01", 5);
	SetCraftScience("JKZTZD_ItRw_Bow_L_01", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Bow_L_01", 25);	
	

	AddItemCategory ("Плотник (Без уровня)", "JKZTZD_ItRw_Crossbow_L_01"); --- Охотничий арбалет
	SetCraftAmount("JKZTZD_ItRw_Crossbow_L_01", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_L_01", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddTool("JKZTZD_ItRw_Crossbow_L_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_L_01", 5);
	SetCraftScience("JKZTZD_ItRw_Crossbow_L_01", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_L_01", 25);
	

	AddItemCategory ("Плотник (Без уровня)", "JKZTZD_ItMw_Nagelkeule"); --- Дубина с шипами
	SetCraftAmount("JKZTZD_ItMw_Nagelkeule", 1);
	 AddIngre("JKZTZD_ItMw_Nagelkeule", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddTool("JKZTZD_ItMw_Nagelkeule", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_Nagelkeule", 10);
	SetCraftScience("JKZTZD_ItMw_Nagelkeule", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Nagelkeule", 25);
	
	
	AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItMW_Addon2h"); --- Дубинка бури
	SetCraftAmount("JKZTZD_ItMW_Addon2h", 1);
	 AddIngre("JKZTZD_ItMW_Addon2h", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItMW_Addon2h", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMW_Addon2h", 10);
	SetCraftScience("JKZTZD_ItMW_Addon2h", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItMW_Addon2h", 25);
	
	
	AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItRw_Sld_Bow"); --- Солдатский лук
	SetCraftAmount("JKZTZD_ItRw_Sld_Bow", 1);
	 AddIngre("JKZTZD_ItRw_Sld_Bow", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Sld_Bow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Sld_Bow", 10);
	SetCraftScience("JKZTZD_ItRw_Sld_Bow", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Sld_Bow", 25);
	

	AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItRw_Bow_L_02"); --- Ивовый лук
	SetCraftAmount("JKZTZD_ItRw_Bow_L_02", 1);
	 AddIngre("JKZTZD_ItRw_Bow_L_02", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Bow_L_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_L_02", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_L_02", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Bow_L_02", 25);


	AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItRw_Mil_Crossbow"); --- Арбалет
	SetCraftAmount("JKZTZD_ItRw_Mil_Crossbow", 1);
	 AddIngre("JKZTZD_ItRw_Mil_Crossbow", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Mil_Crossbow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Mil_Crossbow", 10);
	SetCraftScience("JKZTZD_ItRw_Mil_Crossbow", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Mil_Crossbow", 25);	
	
	
	AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItRw_Crossbow_L_02"); --- Легкий арбалет
	SetCraftAmount("JKZTZD_ItRw_Crossbow_L_02", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_L_02", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Crossbow_L_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_L_02", 10);
	SetCraftScience("JKZTZD_ItRw_Crossbow_L_02", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_L_02", 25);	


	AddItemCategory ("Плотник (1 уровень)", "YFAUUN_ITSH_SHIELD_01"); --- Деревянный щит
	SetCraftAmount("YFAUUN_ITSH_SHIELD_01", 1);
	 AddIngre("YFAUUN_ITSH_SHIELD_01", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("YFAUUN_ITSH_SHIELD_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("YFAUUN_ITSH_SHIELD_01", 10);
	SetCraftScience("YFAUUN_ITSH_SHIELD_01", "Плотник", 1);
	SetenergyPenalty("YFAUUN_ITSH_SHIELD_01", 25);
	
	AddItemCategory ("Плотник (Без уровня)", "JKZTZD_ItMw_1h_Vlk_Mace"); --- Лютня
	SetCraftAmount("JKZTZD_ItMw_1h_Vlk_Mace", 1);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_Mace", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_Mace", "ZDPWLA_ItMi_Glue", 1);
	 AddTool("JKZTZD_ItMw_1h_Vlk_Mace", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_1h_Vlk_Mace", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Vlk_Mace", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Vlk_Mace", 25);

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА


	AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItMW_AddonKeu"); --- Дубинка ветра
	SetCraftAmount("JKZTZD_ItMW_AddonKeu", 1);
	 AddIngre("JKZTZD_ItMW_AddonKeu", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddTool("JKZTZD_ItMW_AddonKeu", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMW_AddonKeu", 10);
	SetCraftScience("JKZTZD_ItMW_AddonKeu", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItMW_AddonKeu", 50);


	AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Bow_L_03"); --- Охотничий лук
	SetCraftAmount("JKZTZD_ItRw_Bow_L_03", 1);
	 AddIngre("JKZTZD_ItRw_Bow_L_03", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddTool("JKZTZD_ItRw_Bow_L_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_L_03", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_L_03", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Bow_L_03", 50);
	
	
	AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Bow_L_04"); --- Вязовый лук
	SetCraftAmount("JKZTZD_ItRw_Bow_L_04", 1);
	 AddIngre("JKZTZD_ItRw_Bow_L_04", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddTool("JKZTZD_ItRw_Bow_L_04", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_L_04", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_L_04", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Bow_L_04", 50);
	
	
	AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Bow_M_01"); --- Композитный лук
	SetCraftAmount("JKZTZD_ItRw_Bow_M_01", 1);
	 AddIngre("JKZTZD_ItRw_Bow_M_01", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddTool("JKZTZD_ItRw_Bow_M_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_M_01", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_M_01", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Bow_M_01", 50);
	
	
	AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Bow_M_02"); --- Ясеневый лук
	SetCraftAmount("JKZTZD_ItRw_Bow_M_02", 1);
	 AddIngre("JKZTZD_ItRw_Bow_M_02", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddTool("JKZTZD_ItRw_Bow_M_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_M_02", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_M_02", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Bow_M_02", 50);
	
	
	AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Bow_M_03"); --- Длинный лук
	SetCraftAmount("JKZTZD_ItRw_Bow_M_03", 1);
	 AddIngre("JKZTZD_ItRw_Bow_M_03", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddTool("JKZTZD_ItRw_Bow_M_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_M_03", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_M_03", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Bow_M_03", 50);
	
	
	AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Bow_M_04"); --- Буковый лук
	SetCraftAmount("JKZTZD_ItRw_Bow_M_04", 1);
	 AddIngre("JKZTZD_ItRw_Bow_M_04", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddTool("JKZTZD_ItRw_Bow_M_04", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_M_04", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_M_04", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Bow_M_04", 50);


	AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Crossbow_M_01"); --- Арбалет ополчения
	SetCraftAmount("JKZTZD_ItRw_Crossbow_M_01", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_M_01", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddTool("JKZTZD_ItRw_Crossbow_M_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_M_01", 10);
	SetCraftScience("JKZTZD_ItRw_Crossbow_M_01", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_M_01", 50);	
	
	
	AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Crossbow_M_02"); --- Военный арбалет
	SetCraftAmount("JKZTZD_ItRw_Crossbow_M_02", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_M_02", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddTool("JKZTZD_ItRw_Crossbow_M_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_M_02", 10);
	SetCraftScience("JKZTZD_ItRw_Crossbow_M_02", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_M_02", 50);	
	
	
	AddItemCategory ("Плотник (2 уровень)", "YFAUUN_ITSH_SHIELD_02"); --- Круглый щит
	SetCraftAmount("YFAUUN_ITSH_SHIELD_02", 1);
	 AddIngre("YFAUUN_ITSH_SHIELD_02", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddTool("YFAUUN_ITSH_SHIELD_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("YFAUUN_ITSH_SHIELD_02", 10);
	SetCraftScience("YFAUUN_ITSH_SHIELD_02", "Плотник", 2);
	SetenergyPenalty("YFAUUN_ITSH_SHIELD_02", 50);	
	
	AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItMw_Richtstab"); --- Посох судьи
	SetCraftAmount("JKZTZD_ItMw_Richtstab", 1);
     AddIngre("JKZTZD_ItMw_Richtstab", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddTool("JKZTZD_ItMw_Richtstab", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_Richtstab", 10);
	SetCraftScience("JKZTZD_ItMw_Richtstab", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Richtstab", 50);	

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	AddItemCategory ("Плотник (3 уровень)", "JKZTZD_ItRw_Bow_H_01"); --- Костяной лук
	SetCraftAmount("JKZTZD_ItRw_Bow_H_01", 1);
	 AddIngre("JKZTZD_ItRw_Bow_H_01", "OOLTYB_ITMI_OBRABOTDER", 15);
	 AddIngre("JKZTZD_ItRw_Bow_H_01", "ZDPWLA_ItMi_Glue", 5);
	 AddTool("JKZTZD_ItRw_Bow_H_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_H_01", 20);
	SetCraftScience("JKZTZD_ItRw_Bow_H_01", "Плотник", 3);
	SetenergyPenalty("JKZTZD_ItRw_Bow_H_01", 100);


	AddItemCategory ("Плотник (3 уровень)", "JKZTZD_ItRw_Bow_H_02"); --- Дубовый лук
	SetCraftAmount("JKZTZD_ItRw_Bow_H_02", 1);
	 AddIngre("JKZTZD_ItRw_Bow_H_02", "OOLTYB_ITMI_OBRABOTDER", 15);
	 AddIngre("JKZTZD_ItRw_Bow_H_02", "ZDPWLA_ItMi_Glue", 5);
	 AddTool("JKZTZD_ItRw_Bow_H_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_H_02", 20);
	SetCraftScience("JKZTZD_ItRw_Bow_H_02", "Плотник", 3);
	SetenergyPenalty("JKZTZD_ItRw_Bow_H_02", 100);


	AddItemCategory ("Плотник (3 уровень)", "JKZTZD_ItRw_Bow_H_03"); --- Военный лук
	SetCraftAmount("JKZTZD_ItRw_Bow_H_03", 1);
	 AddIngre("JKZTZD_ItRw_Bow_H_03", "OOLTYB_ITMI_OBRABOTDER", 15);
	 AddIngre("JKZTZD_ItRw_Bow_H_03", "ZDPWLA_ItMi_Glue", 5);
	 AddTool("JKZTZD_ItRw_Bow_H_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_H_03", 20);
	SetCraftScience("JKZTZD_ItRw_Bow_H_03", "Плотник", 3);
	SetenergyPenalty("JKZTZD_ItRw_Bow_H_03", 100);
	
	
	AddItemCategory ("Плотник (3 уровень)", "JKZTZD_ItRw_Crossbow_H_01"); --- Тяжелый арбалет
	SetCraftAmount("JKZTZD_ItRw_Crossbow_H_01", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_01", "OOLTYB_ITMI_OBRABOTDER", 14);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_01", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_01", "OOLTYB_ITMI_LINKAGE", 2);
	 AddTool("JKZTZD_ItRw_Crossbow_H_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_H_01", 20);
	SetCraftScience("JKZTZD_ItRw_Crossbow_H_01", "Плотник", 3);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_H_01", 100);	
	
	
	AddItemCategory ("Плотник (3 уровень)", "YFAUUN_ITSH_SHIELD_03"); --- Железный щит
	SetCraftAmount("YFAUUN_ITSH_SHIELD_03", 1);
	 AddIngre("YFAUUN_ITSH_SHIELD_03", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddIngre("YFAUUN_ITSH_SHIELD_03", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("YFAUUN_ITSH_SHIELD_03", "OOLTYB_ItMiSwordraw", 2);
	 AddIngre("YFAUUN_ITSH_SHIELD_03", "OOLTYB_ITMI_DLEATHER", 3);
	 AddTool("YFAUUN_ITSH_SHIELD_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("YFAUUN_ITSH_SHIELD_03", 20);
	SetCraftScience("YFAUUN_ITSH_SHIELD_03", "Плотник", 3);
	SetenergyPenalty("YFAUUN_ITSH_SHIELD_03", 100);	
	
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА	
	
	
	AddItemCategory ("Плотник (4 уровень)", "JKZTZD_ItRw_Crossbow_H_02"); --- Арбалет охотника на драконов
	SetCraftAmount("JKZTZD_ItRw_Crossbow_H_02", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_02", "OOLTYB_ITMI_OBRABOTDER", 28);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_02", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_02", "OOLTYB_ITMI_LINKAGE", 4);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_02", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Crossbow_H_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_H_02", 20);
	SetCraftScience("JKZTZD_ItRw_Crossbow_H_02", "Плотник", 4);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_H_02", 100);	
	
	
	AddItemCategory ("Плотник (4 уровень)", "JKZTZD_ItRw_Addon_MagicCrossbow"); --- Магический арбалет
	SetCraftAmount("JKZTZD_ItRw_Addon_MagicCrossbow", 1);
	 AddIngre("JKZTZD_ItRw_Addon_MagicCrossbow", "OOLTYB_ITMI_OBRABOTDER", 28);
	 AddIngre("JKZTZD_ItRw_Addon_MagicCrossbow", "OOLTYB_ITMI_HANDLE", 2);
	 AddIngre("JKZTZD_ItRw_Addon_MagicCrossbow", "OOLTYB_ITMI_LINKAGE", 4);
	 AddIngre("JKZTZD_ItRw_Addon_MagicCrossbow", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Addon_MagicCrossbow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Addon_MagicCrossbow", 20);
	SetCraftScience("JKZTZD_ItRw_Addon_MagicCrossbow", "Плотник", 4);
	SetenergyPenalty("JKZTZD_ItRw_Addon_MagicCrossbow", 100);	
	
	
	AddItemCategory ("Плотник (4 уровень)", "JKZTZD_ItRw_Bow_H_04"); --- Драконий лук
	SetCraftAmount("JKZTZD_ItRw_Bow_H_04", 1);
	 AddIngre("JKZTZD_ItRw_Bow_H_04", "OOLTYB_ITMI_OBRABOTDER", 31);
	 AddIngre("JKZTZD_ItRw_Bow_H_04", "ZDPWLA_ItMi_Glue", 10);
	 AddIngre("JKZTZD_ItRw_Bow_H_04", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Bow_H_04", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_H_04", 20);
	SetCraftScience("JKZTZD_ItRw_Bow_H_04", "Плотник", 4);
	SetenergyPenalty("JKZTZD_ItRw_Bow_H_04", 100);	
	
	
	AddItemCategory ("Плотник (4 уровень)", "JKZTZD_ItRw_Addon_MagicBow"); --- Магический лук
	SetCraftAmount("JKZTZD_ItRw_Addon_MagicBow", 1);
	 AddIngre("JKZTZD_ItRw_Addon_MagicBow", "OOLTYB_ITMI_OBRABOTDER", 31);
	 AddIngre("JKZTZD_ItRw_Addon_MagicBow", "ZDPWLA_ItMi_Glue", 10);
	 AddIngre("JKZTZD_ItRw_Addon_MagicBow", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Addon_MagicBow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Addon_MagicBow", 20);
	SetCraftScience("JKZTZD_ItRw_Addon_MagicBow", "Плотник", 4);
	SetenergyPenalty("JKZTZD_ItRw_Addon_MagicBow", 100);	
	
	
	AddItemCategory ("Плотник (4 уровень)", "JKZTZD_ItRw_Addon_FireBow"); --- Огненный лук
	SetCraftAmount("JKZTZD_ItRw_Addon_FireBow", 1);
	 AddIngre("JKZTZD_ItRw_Addon_FireBow", "OOLTYB_ITMI_OBRABOTDER", 31);
	 AddIngre("JKZTZD_ItRw_Addon_FireBow", "ZDPWLA_ItMi_Glue", 10);
	 AddIngre("JKZTZD_ItRw_Addon_FireBow", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Addon_FireBow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Addon_FireBow", 20);
	SetCraftScience("JKZTZD_ItRw_Addon_FireBow", "Плотник", 4);
	SetenergyPenalty("JKZTZD_ItRw_Addon_FireBow", 100);	
	

	AddItemCategory ("Плотник (4 уровень)", "YFAUUN_ITSH_SHIELD_04"); --- Костяной щит
	SetCraftAmount("YFAUUN_ITSH_SHIELD_04", 1);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "OOLTYB_ITMI_OBRABOTDER", 8);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "OOLTYB_ItMiSwordraw", 6);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "OOLTYB_ITMI_DLEATHER", 6);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("YFAUUN_ITSH_SHIELD_04", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("YFAUUN_ITSH_SHIELD_04", 20);
	SetCraftScience("YFAUUN_ITSH_SHIELD_04", "Плотник", 4);
	SetenergyPenalty("YFAUUN_ITSH_SHIELD_04", 100);	
	
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА


	AddItemCategory ("Кожевник (Расходники)", "OOLTYB_ITMI_LEATHER"); --- Кожа
	SetCraftAmount("OOLTYB_ITMI_LEATHER", 1);
	 AddIngre("OOLTYB_ITMI_LEATHER", "OOLTYB_ItAt_WolfFur", 2);
	 AddAlterIngre("OOLTYB_ITMI_LEATHER", "OOLTYB_itat_LurkerSkin", 2);
	SetCraftPenalty("OOLTYB_ITMI_LEATHER", 5);
	SetCraftScience("OOLTYB_ITMI_LEATHER", "Кожевник", 1);
	SetenergyPenalty("OOLTYB_ITMI_LEATHER", 25);	

	AddItemCategory ("Кожевник (Расходники)", "OOLTYB_ITMI_QLEATHER"); --- Качественная кожа
	SetCraftAmount("OOLTYB_ITMI_QLEATHER", 1);
	 AddIngre("OOLTYB_ITMI_QLEATHER", "OOLTYB_ItAt_ShadowFur", 2);
	 AddAlterIngre("OOLTYB_ITMI_QLEATHER", "OOLTYB_ItAt_TrollFur", 1);
	SetCraftPenalty("OOLTYB_ITMI_QLEATHER", 10);
	SetCraftScience("OOLTYB_ITMI_QLEATHER", "Кожевник", 1);
	SetenergyPenalty("OOLTYB_ITMI_QLEATHER", 50);

--[[	AddItemCategory ("Кожевник (Расходники)", "OOLTYB_ITMI_QLEATHER"); --- Качественная кожа
	SetCraftAmount("OOLTYB_ITMI_QLEATHER", 2);
	 AddIngre("OOLTYB_ITMI_QLEATHER", "OOLTYB_ItAt_TrollFur", 1);
	SetCraftPenalty("OOLTYB_ITMI_QLEATHER", 10);
	SetCraftScience("OOLTYB_ITMI_QLEATHER", "Кожевник", 1);
	SetenergyPenalty("OOLTYB_ITMI_QLEATHER", 50);]]
	
	
	AddItemCategory ("Кожевник (Расходники)", "OOLTYB_ITMI_SLEATHER"); --- Клепаная кожа
	SetCraftAmount("OOLTYB_ITMI_SLEATHER", 1);
	 AddIngre("OOLTYB_ITMI_SLEATHER", "OOLTYB_ITMI_QLEATHER", 1);
	 AddIngre("OOLTYB_ITMI_SLEATHER", "OOLTYB_ITMI_RIVET", 10);
	SetCraftPenalty("OOLTYB_ITMI_SLEATHER", 10);
	SetCraftScience("OOLTYB_ITMI_SLEATHER", "Кожевник", 1);
	SetenergyPenalty("OOLTYB_ITMI_SLEATHER", 50);
	
	
	AddItemCategory ("Кожевник (Расходники)", "OOLTYB_ITMI_DLEATHER"); --- Дубленая кожа
	SetCraftAmount("OOLTYB_ITMI_DLEATHER", 1);
	 AddIngre("OOLTYB_ITMI_DLEATHER", "OOLTYB_ITMI_QLEATHER", 1);
	 AddIngre("OOLTYB_ITMI_DLEATHER", "OOLTYB_ITMI_TAB", 1);
	SetCraftPenalty("OOLTYB_ITMI_DLEATHER", 10);
	SetCraftScience("OOLTYB_ITMI_DLEATHER", "Кожевник", 1);
	SetenergyPenalty("OOLTYB_ITMI_DLEATHER", 50);
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА	
	
	AddItemCategory ("Кожевник (Без уровня)", "YFAUUN_ITAR_WOODCUTTER"); --- Одежда лесоруба
	SetCraftAmount("YFAUUN_ITAR_WOODCUTTER", 1);
	 AddIngre("YFAUUN_ITAR_WOODCUTTER", "OOLTYB_ITMI_LEATHER", 1);
	 AddTool("YFAUUN_ITAR_WOODCUTTER", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_WOODCUTTER", 10);
	SetCraftScience("YFAUUN_ITAR_WOODCUTTER", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_WOODCUTTER", 10);
	
	AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ITAR_Leather_L"); --- Кожаные доспехи
	SetCraftAmount("YFAUUN_ITAR_Leather_L", 1);
	 AddIngre("YFAUUN_ITAR_Leather_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_Leather_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Leather_L", 10);
	SetCraftScience("YFAUUN_ITAR_Leather_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_Leather_L", 25);
	
	AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ITAR_BABE_LEATHER_L"); --- Женские кожаные доспехи
	SetCraftAmount("YFAUUN_ITAR_BABE_LEATHER_L", 1);
	 AddIngre("YFAUUN_ITAR_BABE_LEATHER_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_BABE_LEATHER_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BABE_LEATHER_L", 10);
	SetCraftScience("YFAUUN_ITAR_BABE_LEATHER_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_BABE_LEATHER_L", 25);
	
	AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ItAr_HNT_L"); --- Легкая охотничья одежда
	SetCraftAmount("YFAUUN_ItAr_HNT_L", 1);
	 AddIngre("YFAUUN_ItAr_HNT_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ItAr_HNT_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ItAr_HNT_L", 10);
	SetCraftScience("YFAUUN_ItAr_HNT_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ItAr_HNT_L", 25);

	AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ITAR_PIR_M_HORINIS"); --- Одежда моряка
	SetCraftAmount("YFAUUN_ITAR_PIR_M_HORINIS", 1);
	 AddIngre("YFAUUN_ITAR_PIR_M_HORINIS", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_PIR_M_HORINIS", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_PIR_M_HORINIS", 10);
	SetCraftScience("YFAUUN_ITAR_PIR_M_HORINIS", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_PIR_M_HORINIS", 25);

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_OLDCAMP_L"); --- Одежда Тени
	SetCraftAmount("YFAUUN_ITAR_OLDCAMP_L", 1);
	 AddIngre("YFAUUN_ITAR_OLDCAMP_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_OLDCAMP_L", "OOLTYB_ITMI_RECIPESWSL");
	 AddTool("YFAUUN_ITAR_OLDCAMP_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_OLDCAMP_L", 10);
	SetCraftScience("YFAUUN_ITAR_OLDCAMP_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_OLDCAMP_L", 25);
	
	
	AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_NEWCAMP_L"); --- Одежда вора
	SetCraftAmount("YFAUUN_ITAR_NEWCAMP_L", 1);
	 AddIngre("YFAUUN_ITAR_NEWCAMP_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_NEWCAMP_L", "OOLTYB_ITMI_RECIPETFNL");
	 AddTool("YFAUUN_ITAR_NEWCAMP_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWCAMP_L", 10);
	SetCraftScience("YFAUUN_ITAR_NEWCAMP_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_NEWCAMP_L", 25);

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_NEUTRAL11"); --- Укрепленные кожаные доспехи
	SetCraftAmount("YFAUUN_ITAR_NEUTRAL11", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRAL11", "OOLTYB_ITMI_LEATHER", 5);
	 AddTool("YFAUUN_ITAR_NEUTRAL11", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEUTRAL11", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRAL11", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRAL11", 50);

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_HUNTER3"); --- Одежда охотника
	SetCraftAmount("YFAUUN_ITAR_HUNTER3", 1);
	 AddIngre("YFAUUN_ITAR_HUNTER3", "OOLTYB_ITMI_LEATHER", 5);
	 AddTool("YFAUUN_ITAR_HUNTER3", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_HUNTER3", 10);
	SetCraftScience("YFAUUN_ITAR_HUNTER3", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_HUNTER3", 50);

		AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_PIR_L_Addon"); --- Одежда пирата
	SetCraftAmount("YFAUUN_ITAR_PIR_L_Addon", 1);
	 AddIngre("YFAUUN_ITAR_PIR_L_Addon", "OOLTYB_ITMI_LEATHER", 5);
	 AddTool("YFAUUN_ITAR_PIR_L_Addon", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_PIR_L_Addon", 10);
	SetCraftScience("YFAUUN_ITAR_PIR_L_Addon", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_PIR_L_Addon", 50);
		
	AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_WALKER"); --- Кожаный плащ
	SetCraftAmount("YFAUUN_ITAR_WALKER", 1);
	 AddIngre("YFAUUN_ITAR_WALKER", "OOLTYB_ITMI_LEATHER", 5);
	 AddTool("YFAUUN_ITAR_WALKER", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_WALKER", 10);
	SetCraftScience("YFAUUN_ITAR_WALKER", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_WALKER", 50);
	
	AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_PIR_M_HORINIS2"); --- Одежда авантюриста
	SetCraftAmount("YFAUUN_ITAR_PIR_M_HORINIS2", 1);
	 AddIngre("YFAUUN_ITAR_PIR_M_HORINIS2", "OOLTYB_ITMI_LEATHER", 5);
	 AddTool("YFAUUN_ITAR_PIR_M_HORINIS2", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_PIR_M_HORINIS2", 10);
	SetCraftScience("YFAUUN_ITAR_PIR_M_HORINIS2", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_PIR_M_HORINIS2", 50);

	AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ItAr_ALBINO"); --- Доспехи альбиноса
	SetCraftAmount("YFAUUN_ItAr_ALBINO", 1);
	 AddIngre("YFAUUN_ItAr_ALBINO", "OOLTYB_ITMI_LEATHER", 5);
	 AddTool("YFAUUN_ItAr_ALBINO", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ItAr_ALBINO", 10);
	SetCraftScience("YFAUUN_ItAr_ALBINO", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ItAr_ALBINO", 50);

	AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_TRAVELER"); ---Толстый кожаный плащ
	SetCraftAmount("YFAUUN_ITAR_TRAVELER", 1);
	 AddIngre("YFAUUN_ITAR_TRAVELER", "OOLTYB_ITMI_LEATHER", 5);
	 AddTool("YFAUUN_ITAR_TRAVELER", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_TRAVELER", 10);
	SetCraftScience("YFAUUN_ITAR_TRAVELER", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_TRAVELER", 50);

	AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_NEUTRAL"); --- Прочная одежда охотника
	SetCraftAmount("YFAUUN_ITAR_NEUTRAL", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRAL", "OOLTYB_ITMI_LEATHER", 5);
	 AddTool("YFAUUN_ITAR_NEUTRAL", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEUTRAL", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRAL", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRAL", 50);

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_REDSHAR"); --- Доспехи тени
	SetCraftAmount("YFAUUN_ITAR_REDSHAR", 1);
	 AddIngre("YFAUUN_ITAR_REDSHAR", "OOLTYB_ITMI_LEATHER", 5);
	 AddTool("YFAUUN_ITAR_REDSHAR", "OOLTYB_ITMI_RECIPESWSL");
	 AddTool("YFAUUN_ITAR_REDSHAR", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_REDSHAR", 10);
	SetCraftScience("YFAUUN_ITAR_REDSHAR", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_REDSHAR", 50);
	
	AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ORG_NEWCAMP_M"); --- Средние доспехи вора
	SetCraftAmount("YFAUUN_ORG_NEWCAMP_M", 1);
	 AddIngre("YFAUUN_ORG_NEWCAMP_M", "OOLTYB_ITMI_LEATHER", 5);
	 AddTool("YFAUUN_ORG_NEWCAMP_M", "OOLTYB_ITMI_RECIPETFNL");
	 AddTool("YFAUUN_ORG_NEWCAMP_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ORG_NEWCAMP_M", 10);
	SetCraftScience("YFAUUN_ORG_NEWCAMP_M", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ORG_NEWCAMP_M", 50);

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА



	AddItemCategory ("(Б)Кузнец (1 уровень)", "YFAUUN_ItAr_RANGER_H"); --- Кольчуга с кожаной курткой
	SetCraftAmount("YFAUUN_ItAr_RANGER_H", 1);
	 AddIngre("YFAUUN_ItAr_RANGER_H", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("YFAUUN_ItAr_RANGER_H", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_RANGER_H", 10);
	SetCraftScience("YFAUUN_ItAr_RANGER_H", "Бронник", 1);
	SetenergyPenalty("YFAUUN_ItAr_RANGER_H", 25);

	AddItemCategory ("(Б)Кузнец (1 уровень)", "YFAUUN_ItAr_GHRB"); --- Легкие доспехи
	SetCraftAmount("YFAUUN_ItAr_GHRB", 1);
	 AddIngre("YFAUUN_ItAr_GHRB", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("YFAUUN_ItAr_GHRB", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_GHRB", 10);
	SetCraftScience("YFAUUN_ItAr_GHRB", "Бронник", 1);
	SetenergyPenalty("YFAUUN_ItAr_GHRB", 25);

AddItemCategory ("(Б)Кузнец (1 уровень)", "YFAUUN_SLD_ARMOR_L3"); --- Наплечник наемника
	SetCraftAmount("YFAUUN_SLD_ARMOR_L3", 1);
	 AddIngre("YFAUUN_SLD_ARMOR_L3", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("YFAUUN_SLD_ARMOR_L3", "JKZTZD_ItMw_1H_Mace_L_04");
	 AddTool("YFAUUN_SLD_ARMOR_L3", "OOLTYB_ITMI_RECIPEMYNL");
	SetCraftPenalty("YFAUUN_SLD_ARMOR_L3", 10);
	SetCraftScience("YFAUUN_SLD_ARMOR_L3", "Бронник", 1);
	SetenergyPenalty("YFAUUN_SLD_ARMOR_L3", 25);
	
	AddItemCategory ("(Б)Кузнец (1 уровень)", "YFAUUN_ITAR_OLDCAMPG_L"); --- Легкие доспехи стражника
	SetCraftAmount("YFAUUN_ITAR_OLDCAMPG_L", 1);
	 AddIngre("YFAUUN_ITAR_OLDCAMPG_L", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("YFAUUN_ITAR_OLDCAMPG_L", "JKZTZD_ItMw_1H_Mace_L_04");
	 AddTool("YFAUUN_ITAR_OLDCAMPG_L", "OOLTYB_ITMI_RECIPEGDSL");
	SetCraftPenalty("YFAUUN_ITAR_OLDCAMPG_L", 10);
	SetCraftScience("YFAUUN_ITAR_OLDCAMPG_L", "Бронник", 1);
	SetenergyPenalty("YFAUUN_ITAR_OLDCAMPG_L", 25);

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА


	AddItemCategory ("(Б)Кузнец (2 уровень)", "YFAUUN_ITAR_CHAINMAIL"); --- Легкая кольчуга
	SetCraftAmount("YFAUUN_ITAR_CHAINMAIL", 1);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("YFAUUN_ITAR_CHAINMAIL", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_CHAINMAIL", 10);
	SetCraftScience("YFAUUN_ITAR_CHAINMAIL", "Бронник", 2);
	SetenergyPenalty("YFAUUN_ITAR_CHAINMAIL", 50);	

	AddItemCategory ("(Б)Кузнец (2 уровень)", "YFAUUN_GRD_ARMOR_H3"); --- Легкая кольчуга
	SetCraftAmount("YFAUUN_GRD_ARMOR_H3", 1);
	 AddIngre("YFAUUN_GRD_ARMOR_H3", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("YFAUUN_GRD_ARMOR_H3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_GRD_ARMOR_H3", 10);
	SetCraftScience("YFAUUN_GRD_ARMOR_H3", "Бронник", 2);
	SetenergyPenalty("YFAUUN_GRD_ARMOR_H3", 50);	


	AddItemCategory ("(Б)Кузнец (2 уровень)", "YFAUUN_ITAR_OLDCAMPG_L"); --- Легкие доспехи стражника
	SetCraftAmount("YFAUUN_ITAR_OLDCAMPG_L", 1);
	 AddIngre("YFAUUN_ITAR_OLDCAMPG_L", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("YFAUUN_ITAR_OLDCAMPG_L", "OOLTYB_ITMI_RECIPEGDSL");
	 AddTool("YFAUUN_ITAR_OLDCAMPG_L", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_OLDCAMPG_L", 10);
	SetCraftScience("YFAUUN_ITAR_OLDCAMPG_L", "Бронник", 2);
	SetenergyPenalty("YFAUUN_ITAR_OLDCAMPG_L", 50);

	
	AddItemCategory ("(Б)Кузнец (2 уровень)", "YFAUUN_ITAR_NEWCAMPM_L"); --- Легкие доспехи наемника
	SetCraftAmount("YFAUUN_ITAR_NEWCAMPM_L", 1);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_L", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("YFAUUN_ITAR_NEWCAMPM_L", "OOLTYB_ITMI_RECIPEMYNL");
	 AddTool("YFAUUN_ITAR_NEWCAMPM_L", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_NEWCAMPM_L", 10);
	SetCraftScience("YFAUUN_ITAR_NEWCAMPM_L", "Бронник", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEWCAMPM_L", 50);

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ItAr_LARM_M"); --- Кольчуга с наплечниками
	SetCraftAmount("YFAUUN_ItAr_LARM_M", 1);
	 AddIngre("YFAUUN_ItAr_LARM_M", "OOLTYB_ITMI_S_IGNOT", 5);
	 AddTool("YFAUUN_ItAr_LARM_M", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_LARM_M", 10);
	SetCraftScience("YFAUUN_ItAr_LARM_M", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ItAr_LARM_M", 50);

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА



	AddItemCategory ("Портной (Расходники)", "OOLTYB_ITMI_WHOOL_HOLST"); --- Сукно
	SetCraftAmount("OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddIngre("OOLTYB_ITMI_WHOOL_HOLST", "OOLTYB_ITMI_SHEEP", 10);
	 AddTool("OOLTYB_ITMI_WHOOL_HOLST", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("OOLTYB_ITMI_WHOOL_HOLST", 5);
	SetCraftScience("OOLTYB_ITMI_WHOOL_HOLST", "Портной", 1);
	SetenergyPenalty("OOLTYB_ITMI_WHOOL_HOLST", 25);
	
	
	AddItemCategory ("Портной (Расходники)", "OOLTYB_ITMI_BINT"); --- Бинт
	SetCraftAmount("OOLTYB_ITMI_BINT", 4);
	 AddIngre("OOLTYB_ITMI_BINT", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("OOLTYB_ITMI_BINT", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("OOLTYB_ITMI_BINT", 5);
	SetCraftScience("OOLTYB_ITMI_BINT", "Портной", 1);
	SetenergyPenalty("OOLTYB_ITMI_BINT", 25);	
	
	AddItemCategory ("Портной (Без уровня)", "ooltyb_itmi_palatka"); --- Палатка
	SetCraftAmount("ooltyb_itmi_palatka", 1);
	 AddIngre("ooltyb_itmi_palatka", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("ooltyb_itmi_palatka", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ooltyb_itmi_palatka", 5);
	SetCraftScience("ooltyb_itmi_palatka", "Портной", 1);
	SetenergyPenalty("ooltyb_itmi_palatka", 25);
	
	AddItemCategory ("Портной (Без уровня)", "yfauun_itar_torba"); --- Сумка
	SetCraftAmount("yfauun_itar_torba", 1);
	 AddIngre("yfauun_itar_torba", "ooltyb_itmi_sheep", 10);
	 AddTool("yfauun_itar_torba", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_torba", 5);
	SetCraftScience("yfauun_itar_torba", "Портной", 1);
	SetenergyPenalty("yfauun_itar_torba", 5);
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_Smith"); --- Одежда кузнеца
	SetCraftAmount("YFAUUN_ITAR_Smith", 1);
	 AddIngre("YFAUUN_ITAR_Smith", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_Smith", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Smith", 10);
	SetCraftScience("YFAUUN_ITAR_Smith", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Smith", 10);


	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_Barkeeper"); --- Одежда трактирщика
	SetCraftAmount("YFAUUN_ITAR_Barkeeper", 1);
	 AddIngre("YFAUUN_ITAR_Barkeeper", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_Barkeeper", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Barkeeper", 10);
	SetCraftScience("YFAUUN_ITAR_Barkeeper", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Barkeeper", 10);


	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_Bau_L"); --- Одежда крестьянина
	SetCraftAmount("YFAUUN_ITAR_Bau_L", 1);
	 AddIngre("YFAUUN_ITAR_Bau_L", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_Bau_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Bau_L", 10);
	SetCraftScience("YFAUUN_ITAR_Bau_L", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Bau_L", 10);


	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_BAU_A"); --- Зеленая одежда крестьянина
	SetCraftAmount("YFAUUN_ITAR_BAU_A", 1);
	 AddIngre("YFAUUN_ITAR_BAU_A", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_BAU_A", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BAU_A", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_A", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_A", 10);


	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_BAU_B"); --- Красная одежда крестьянина
	SetCraftAmount("YFAUUN_ITAR_BAU_B", 1);
	 AddIngre("YFAUUN_ITAR_BAU_B", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_BAU_B", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BAU_B", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_B", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_B", 10);

	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_Prisoner"); --- Штаны рудокопа
	SetCraftAmount("YFAUUN_ITAR_Prisoner", 1);
	 AddIngre("YFAUUN_ITAR_Prisoner", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_Prisoner", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Prisoner", 10);
	SetCraftScience("YFAUUN_ITAR_Prisoner", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Prisoner", 10);

	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_STANI"); --- Штаны моряка
	SetCraftAmount("YFAUUN_ITAR_STANI", 1);
	 AddIngre("YFAUUN_ITAR_STANI", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_STANI", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_STANI", 10);
	SetCraftScience("YFAUUN_ITAR_STANI", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_STANI", 10);

	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_SAILOR"); --- Зеленая одежда рабочего
	SetCraftAmount("YFAUUN_ITAR_SAILOR", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_SAILOR", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR", 10);

	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_SAILOR1"); --- Голубая одежда рабочего
	SetCraftAmount("YFAUUN_ITAR_SAILOR1", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR1", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_SAILOR1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR1", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR1", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR1", 10);

	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_SAILOR2"); --- Коричневая одежда рабочего
	SetCraftAmount("YFAUUN_ITAR_SAILOR2", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR2", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_SAILOR2", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR2", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR2", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR2", 10);

	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_SAILOR3"); --- Черная одежда рабочего
	SetCraftAmount("YFAUUN_ITAR_SAILOR3", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR3", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_SAILOR3", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR3", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR3", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR3", 10);

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_UNDERARMOR"); --- Поддоспешник
	SetCraftAmount("YFAUUN_ITAR_UNDERARMOR", 1);
	 AddIngre("YFAUUN_ITAR_UNDERARMOR", "OOLTYB_ITMI_WHOOL_HOLST", 2);
	SetCraftPenalty("YFAUUN_ITAR_UNDERARMOR", 10);
	SetCraftScience("YFAUUN_ITAR_UNDERARMOR", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_UNDERARMOR", 25);

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_VAV"); --- Одеяние алхимика
	SetCraftAmount("YFAUUN_ITAR_VAV", 1);
	 AddIngre("YFAUUN_ITAR_VAV", "OOLTYB_ITMI_WHOOL_HOLST", 2);
	SetCraftPenalty("YFAUUN_ITAR_VAV", 10);
	SetCraftScience("YFAUUN_ITAR_VAV", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_VAV", 25);
	
	AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_DARKROBE"); --- Плащ из плотной ткани
	SetCraftAmount("YFAUUN_ITAR_DARKROBE", 1);
	 AddIngre("YFAUUN_ITAR_DARKROBE", "OOLTYB_ITMI_WHOOL_HOLST", 2);
	SetCraftPenalty("YFAUUN_ITAR_DARKROBE", 10);
	SetCraftScience("YFAUUN_ITAR_DARKROBE", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_DARKROBE", 25);

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_NEUTRAL22"); --- Бригантина
	SetCraftAmount("YFAUUN_ITAR_NEUTRAL22", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRAL22", "OOLTYB_ITMI_WHOOL_HOLST", 5);
	SetCraftPenalty("YFAUUN_ITAR_NEUTRAL22", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRAL22", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRAL22", 50);

	AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_Vlk_L"); --- Коричневый дублет
	SetCraftAmount("YFAUUN_ITAR_Vlk_L", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_L", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_Vlk_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_L", 10);
	SetCraftScience("YFAUUN_ITAR_Vlk_L", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_L", 50);

		AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_BAU_C"); --- Красная одежда фермера
	SetCraftAmount("YFAUUN_ITAR_BAU_C", 1);
	 AddIngre("YFAUUN_ITAR_BAU_C", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_BAU_C", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BAU_C", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_C", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_C", 25);

	AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_BAU_M"); --- Одежда фермера
	SetCraftAmount("YFAUUN_ITAR_BAU_M", 1);
	 AddIngre("YFAUUN_ITAR_BAU_M", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_BAU_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BAU_M", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_M", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_M", 25);

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_BauBabe_L"); --- Бежевое платье
	SetCraftAmount("YFAUUN_ITAR_BauBabe_L", 1);
	 AddIngre("YFAUUN_ITAR_BauBabe_L", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_BauBabe_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BauBabe_L", 10);
	SetCraftScience("YFAUUN_ITAR_BauBabe_L", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_BauBabe_L", 50);


	AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_BauBabe_M"); --- Зеленое платье
	SetCraftAmount("YFAUUN_ITAR_BauBabe_M", 1);
	 AddIngre("YFAUUN_ITAR_BauBabe_M", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_BauBabe_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BauBabe_M", 10);
	SetCraftScience("YFAUUN_ITAR_BauBabe_M", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_BauBabe_M", 25);

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_Vlk_H"); --- Бежевый дублет
	SetCraftAmount("YFAUUN_ITAR_Vlk_H", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_H", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_Vlk_H", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_H", 10);
	SetCraftScience("YFAUUN_ITAR_Vlk_H", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_H", 50);

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_Vlk_Khr01"); --- Короткий дублет
	SetCraftAmount("YFAUUN_ITAR_Vlk_Khr01", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_Khr01", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_Vlk_Khr01", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_Khr01", 10);
	SetCraftScience("YFAUUN_ITAR_Vlk_Khr01", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_Khr01", 50);

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_D"); --- Синий дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_D", 1);
	 AddIngre("YFAUUN_ITAR_VLK_D", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_VLK_D", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_D", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_D", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_D", 50);

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_Y"); --- Черный дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_Y", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Y", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_VLK_Y", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Y", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_Y", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Y", 50);

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_P"); --- Коричневый плащ
	SetCraftAmount("YFAUUN_ITAR_VLK_P", 1);
	 AddIngre("YFAUUN_ITAR_VLK_P", "OOLTYB_ITMI_WHOOL_HOLST", 2);
	 AddTool("YFAUUN_ITAR_VLK_P", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_P", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_P", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_P", 50);

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_N"); --- Черный плащ
	SetCraftAmount("YFAUUN_ITAR_VLK_N", 1);
	 AddIngre("YFAUUN_ITAR_VLK_N", "OOLTYB_ITMI_WHOOL_HOLST", 2);
	 AddTool("YFAUUN_ITAR_VLK_N", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_N", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_N", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_N", 50);

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_Q"); --- Желтый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_Q", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Q", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_VLK_Q", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Q", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_Q", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Q", 50);

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_W"); --- Серый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_W", 1);
	 AddIngre("YFAUUN_ITAR_VLK_W", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_VLK_W", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_W", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_W", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_W", 50);

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_Y1"); --- Красный дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_Y1", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Y1", "OOLTYB_ITMI_WHOOL_HOLST", 1);
	 AddTool("YFAUUN_ITAR_VLK_Y1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Y1", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_Y1", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Y1", 50);
	
	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_VLK_F"); --- Белый плащ
	SetCraftAmount("YFAUUN_ITAR_VLK_F", 1);
	 AddIngre("YFAUUN_ITAR_VLK_F", "OOLTYB_ITMI_WHOOL_HOLST", 2);
	 AddTool("YFAUUN_ITAR_VLK_F", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_F", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_F", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_VLK_F", 100);

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_VLK_E"); --- Бежевый плащ
	SetCraftAmount("YFAUUN_ITAR_VLK_E", 1);
	 AddIngre("YFAUUN_ITAR_VLK_E", "OOLTYB_ITMI_WHOOL_HOLST", 2);
	 AddTool("YFAUUN_ITAR_VLK_E", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_E", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_E", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_VLK_E", 100);

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_Judge"); --- Мантия судьи
	SetCraftAmount("YFAUUN_ITAR_Judge", 1);
	 AddIngre("YFAUUN_ITAR_Judge", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_Judge", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Judge", 20);
	SetCraftScience("YFAUUN_ITAR_Judge", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_Judge", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_Vlk_M"); --- Розовый стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_Vlk_M", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_M", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_Vlk_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_M", 20);
	SetCraftScience("YFAUUN_ITAR_Vlk_M", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_M", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VlkBabe_L"); --- Голубое платье
	SetCraftAmount("YFAUUN_ITAR_VlkBabe_L", 1);
	 AddIngre("YFAUUN_ITAR_VlkBabe_L", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_VlkBabe_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VlkBabe_L", 20);
	SetCraftScience("YFAUUN_ITAR_VlkBabe_L", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VlkBabe_L", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VlkBabe_M"); --- белое платье
	SetCraftAmount("YFAUUN_ITAR_VlkBabe_M", 1);
	 AddIngre("YFAUUN_ITAR_VlkBabe_M", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_VlkBabe_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VlkBabe_M", 20);
	SetCraftScience("YFAUUN_ITAR_VlkBabe_M", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VlkBabe_M", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VlkBabe_H"); --- Черное платье
	SetCraftAmount("YFAUUN_ITAR_VlkBabe_H", 1);
	 AddIngre("YFAUUN_ITAR_VlkBabe_H", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_VlkBabe_H", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VlkBabe_H", 20);
	SetCraftScience("YFAUUN_ITAR_VlkBabe_H", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VlkBabe_H", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_BauBabe_N"); --- Сиреневое платье
	SetCraftAmount("YFAUUN_ITAR_BauBabe_N", 1);
	 AddIngre("YFAUUN_ITAR_BauBabe_N", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_BauBabe_N", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BauBabe_N", 20);
	SetCraftScience("YFAUUN_ITAR_BauBabe_N", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_BauBabe_N", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VLK_J"); --- Стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_J", 1);
	 AddIngre("YFAUUN_ITAR_VLK_J", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_VLK_J", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_J", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_J", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VLK_J", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VLK_Z"); --- Бежевый стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_Z", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Z", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_VLK_Z", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Z", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_Z", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Z", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VLK_A"); --- Серый стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_A", 1);
	 AddIngre("YFAUUN_ITAR_VLK_A", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_VLK_A", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_A", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_A", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VLK_A", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VLK_C"); --- Темно-зеленый стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_C", 1);
	 AddIngre("YFAUUN_ITAR_VLK_C", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_VLK_C", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_C", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_C", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VLK_C", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VLK_A"); --- Серый стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_A", 1);
	 AddIngre("YFAUUN_ITAR_VLK_A", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_VLK_A", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_A", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_A", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VLK_A", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VLKBABE_S"); --- Красное платье
	SetCraftAmount("YFAUUN_ITAR_VLKBABE_S", 1);
	 AddIngre("YFAUUN_ITAR_VLKBABE_S", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_VLKBABE_S", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLKBABE_S", 20);
	SetCraftScience("YFAUUN_ITAR_VLKBABE_S", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VLKBABE_S", 100);

--Серый стеганый дублет

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_NEWPLAT_05"); --- Дорогое красное платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_05", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_05", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_NEWPLAT_05", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_05", 20);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_05", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_05", 100);

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_NEWPLAT_04"); --- Дворянское черное платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_04", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_04", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_NEWPLAT_04", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_04", 20);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_04", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_04", 100);

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_NEWPLAT_03"); --- Дворянское зеленое платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_03", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_03", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_NEWPLAT_03", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_03", 20);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_03", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_03", 100);

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_NEWPLAT_02"); --- Дворянское красное платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_02", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_02", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_NEWPLAT_02", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_02", 20);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_02", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_02", 100);

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_NEWPLAT_01"); --- Дворянское голубое платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_01", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_01", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_NEWPLAT_01", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_01", 20);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_01", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_01", 100);

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_BURG4"); --- Хорошая одежда горожанина
	SetCraftAmount("YFAUUN_ITAR_BURG4", 1);
	 AddIngre("YFAUUN_ITAR_BURG4", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_BURG4", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BURG4", 20);
	SetCraftScience("YFAUUN_ITAR_BURG4", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_BURG4", 100);

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_Governor"); --- Богатая красная одежда горожанина
	SetCraftAmount("YFAUUN_ITAR_Governor", 1);
	 AddIngre("YFAUUN_ITAR_Governor", "OOLTYB_ITMI_WHOOL_HOLST", 6);
	 AddTool("YFAUUN_ITAR_Governor", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Governor", 20);
	SetCraftScience("YFAUUN_ITAR_Governor", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_Governor", 100);

---------------------------------------------------------------------------------------------------------------------------------------------------------------

	AddItemCategory ("(С) 1-й Круг", "IHPIWN_ItSc_Firebolt"); ----- огненная стрела
	SetCraftAmount("IHPIWN_ItSc_Firebolt", 1);
	 AddIngre("IHPIWN_ItSc_Firebolt", "ooltyb_itmi_magicore", 1);
	 AddIngre("IHPIWN_ItSc_Firebolt", "OOLTYB_ITMI_parchment", 2);
    AddTool("IHPIWN_ItSc_Firebolt", "MHAHGH_ITWr_Addon_MCELIXIER_01");
	AddTool("IHPIWN_ItSc_LightHeal", "MHAHGH_ITWR_Addon_Runemaking_KDF_CIRC1");
	SetCraftPenalty("IHPIWN_ItSc_Firebolt", 5);
	SetCraftScience("IHPIWN_ItSc_Firebolt", "Магия", 1);
	SetenergyPenalty("IHPIWN_ItSc_Firebolt", 10);
	
	AddItemCategory ("(С) 1-й Круг", "IHPIWN_ItSc_Icebolt"); ----- ледяная стрела
	SetCraftAmount("IHPIWN_ItSc_Icebolt", 1);
	 AddIngre("IHPIWN_ItSc_Icebolt", "ooltyb_itmi_magicore", 1);
	 AddIngre("IHPIWN_ItSc_Icebolt", "ooltyb_itmi_paper", 2);
    AddTool("IHPIWN_ItSc_Icebolt", "MHAHGH_ITWr_Addon_MCELIXIER_01");
	AddTool("IHPIWN_ItSc_LightHeal", "MHAHGH_ITWR_Addon_Runemaking_KDW_CIRC1");
	SetCraftPenalty("IHPIWN_ItSc_Icebolt", 5);
	SetCraftScience("IHPIWN_ItSc_Icebolt", "Магия", 1);
	SetenergyPenalty("IHPIWN_ItSc_Icebolt", 10);
	
	AddItemCategory ("(С) 1-й Круг", "IHPIWN_ItSc_LightHeal"); ----- легкое лечение
	SetCraftAmount("IHPIWN_ItSc_LightHeal", 1);
	 AddIngre("IHPIWN_ItSc_LightHeal", "ooltyb_itmi_magicore", 1);
	 AddIngre("IHPIWN_ItSc_LightHeal", "ooltyb_itmi_paper", 2);
    AddTool("IHPIWN_ItSc_LightHeal", "MHAHGH_ITWr_Addon_MCELIXIER_01");
	SetCraftPenalty("IHPIWN_ItSc_LightHeal", 5);
	SetCraftScience("IHPIWN_ItSc_LightHeal", "Магия", 1);
	SetenergyPenalty("IHPIWN_ItSc_LightHeal", 10);
	
	AddItemCategory ("(С) 1-й Круг", "IHPIWN_ItSc_Light"); ----- свет
	SetCraftAmount("IHPIWN_ItSc_Light", 1);
	 AddIngre("IHPIWN_ItSc_Light", "ooltyb_itmi_magicore", 1);
	 AddIngre("IHPIWN_ItSc_Light", "ooltyb_itmi_paper", 2);
    AddTool("IHPIWN_ItSc_Light", "MHAHGH_ITWr_Addon_MCELIXIER_01");
	SetCraftPenalty("IHPIWN_ItSc_Light", 5);
	SetCraftScience("IHPIWN_ItSc_Light", "Магия", 1);
	SetenergyPenalty("IHPIWN_ItSc_Light", 10);
	
	AddItemCategory ("(С) 1-й Круг", "IHPIWN_ItSc_Zap"); ----- вспышка
	SetCraftAmount("IHPIWN_ItSc_Zap", 1);
	 AddIngre("IHPIWN_ItSc_Zap", "ooltyb_itmi_magicore", 1);
	 AddIngre("IHPIWN_ItSc_Zap", "ooltyb_itmi_paper", 2);
    AddTool("IHPIWN_ItSc_Zap", "MHAHGH_ITWr_Addon_MCELIXIER_01");
	SetCraftPenalty("IHPIWN_ItSc_Zap", 5);
	SetCraftScience("IHPIWN_ItSc_Zap", "Магия", 1);
	SetenergyPenalty("IHPIWN_ItSc_Zap", 10);
	
	------- 2 круг свитки
	
	AddItemCategory ("(С) 2-й Круг", "IHPIWN_ItSc_InstantFireball"); ----- огненный шар
	SetCraftAmount("IHPIWN_ItSc_InstantFireball", 1);
	 AddIngre("IHPIWN_ItSc_InstantFireball", "ooltyb_itmi_magicore", 2);
	 AddIngre("IHPIWN_ItSc_InstantFireball", "ooltyb_itmi_paper", 4);
    AddTool("IHPIWN_ItSc_InstantFireball", "MHAHGH_ITWr_Addon_MCELIXIER_01");
	AddTool("IHPIWN_ItSc_InstantFireball", "MHAHGH_ITWR_Addon_Runemaking_KDF_CIRC2");
	SetCraftPenalty("IHPIWN_ItSc_InstantFireball", 5);
	SetCraftScience("IHPIWN_ItSc_InstantFireball", "Магия", 2);
	SetenergyPenalty("IHPIWN_ItSc_InstantFireball", 10);
	
	AddItemCategory ("(С) 2-й Круг", "IHPIWN_ItSc_Icelance"); ----- ледяное копье
	SetCraftAmount("IHPIWN_ItSc_Icelance", 1);
	 AddIngre("IHPIWN_ItSc_Icelance", "ooltyb_itmi_magicore", 2);
	 AddIngre("IHPIWN_ItSc_Icelance", "OOLTYB_ITMI_parchment", 4);
    AddTool("IHPIWN_ItSc_Icelance", "MHAHGH_ITWr_Addon_MCELIXIER_01");
	AddTool("IHPIWN_ItSc_Icelance","MHAHGH_ITWR_Addon_Runemaking_KDW_CIRC2");
	SetCraftPenalty("IHPIWN_ItSc_Icelance", 5);
	SetCraftScience("IHPIWN_ItSc_Icelance", "Магия", 2);
	SetenergyPenalty("IHPIWN_ItSc_Icelance", 10);
	
	----- руны 1 круг
	
	AddItemCategory ("(Р) 1-й Круг", "ooltyb_itmi_runeblank"); ----- заготовка руны 1 круг
	SetCraftAmount("ooltyb_itmi_runeblank", 1);
	 AddIngre("ooltyb_itmi_runeblank", "OOLTYB_ITMI_NUGGET", 50);
    AddTool("ooltyb_itmi_runeblank", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_runeblank", 15);
	SetCraftScience("ooltyb_itmi_runeblank", "Магия", 2);
	SetenergyPenalty("ooltyb_itmi_runeblank", 50);
	
	AddItemCategory ("(Р) 1-й Круг", "SAQTSH_ItRu_Icebolt"); ----- ледяная стрела
	SetCraftAmount("SAQTSH_ItRu_Icebolt", 1);
	 AddIngre("SAQTSH_ItRu_Icebolt", "ooltyb_itmi_runeblank", 1);
	 AddIngre("SAQTSH_ItRu_Icebolt", "IHPIWN_ItSc_Icebolt", 1);
	 AddIngre("SAQTSH_ItRu_Icebolt", "OOLTYB_ItMi_AquamarinE", 1);
    AddTool("SAQTSH_ItRu_Icebolt", "MHAHGH_ITWr_Addon_MCELIXIER_01");
	AddTool("SAQTSH_ItRu_Icebolt","MHAHGH_ITWR_Addon_Runemaking_KDW_CIRC1"); 
	AddTool("SAQTSH_ItRu_Icebolt","ooltyb_itmi_pliers"); 
	SetCraftPenalty("SAQTSH_ItRu_Icebolt", 15);
	SetCraftScience("SAQTSH_ItRu_Icebolt", "Магия", 2);
	SetenergyPenalty("SAQTSH_ItRu_Icebolt", 50);
	
	AddItemCategory ("(Р) 1-й Круг", "SAQTSH_ItRu_FireBolt"); ----- огненная стрела
	SetCraftAmount("SAQTSH_ItRu_FireBolt", 1);
	 AddIngre("SAQTSH_ItRu_FireBolt", "ooltyb_itmi_runeblank", 1);
	 AddIngre("SAQTSH_ItRu_FireBolt", "IHPIWN_ItSc_Firebolt", 1);
	 AddIngre("SAQTSH_ItRu_FireBolt", "ooltyb_itmi_rubin", 1);
    AddTool("SAQTSH_ItRu_FireBolt", "MHAHGH_ITWr_Addon_MCELIXIER_01");
	AddTool("SAQTSH_ItRu_FireBolt","MHAHGH_ITWR_Addon_Runemaking_KDF_CIRC1");
	AddTool("SAQTSH_ItRu_FireBolt","ooltyb_itmi_pliers"); 
	SetCraftPenalty("SAQTSH_ItRu_FireBolt", 15);
	SetCraftScience("SAQTSH_ItRu_FireBolt", "Магия", 2);
	SetenergyPenalty("SAQTSH_ItRu_FireBolt", 50);
	
	AddItemCategory ("(Р) 1-й Круг", "SAQTSH_ItRu_Light"); ----- свет
	SetCraftAmount("SAQTSH_ItRu_Light", 1);
	 AddIngre("SAQTSH_ItRu_Light", "ooltyb_itmi_runeblank", 1);
	 AddIngre("SAQTSH_ItRu_Light", "IHPIWN_ItSc_Light", 1);
    AddTool("SAQTSH_ItRu_Light", "MHAHGH_ITWr_Addon_MCELIXIER_01");
	AddTool("SAQTSH_ItRu_Light","ooltyb_itmi_pliers"); 
	SetCraftPenalty("SAQTSH_ItRu_Light", 15);
	SetCraftScience("SAQTSH_ItRu_Light", "Магия", 2);
	SetenergyPenalty("SAQTSH_ItRu_Light", 50);
	
	AddItemCategory ("(Р) 1-й Круг", "SAQTSH_ItRu_LightHeal"); ----- легкое лечение
	SetCraftAmount("SAQTSH_ItRu_LightHeal", 1);
	 AddIngre("SAQTSH_ItRu_LightHeal", "ooltyb_itmi_runeblank", 1);
	 AddIngre("SAQTSH_ItRu_LightHeal", "IHPIWN_ItSc_LightHeal", 1);
	 AddIngre("SAQTSH_ItRu_LightHeal", "ooltyb_itmi_quartz", 1);
    AddTool("SAQTSH_ItRu_LightHeal", "MHAHGH_ITWr_Addon_MCELIXIER_01");
	AddTool("SAQTSH_ItRu_LightHeal","ooltyb_itmi_pliers"); 
	SetCraftPenalty("SAQTSH_ItRu_LightHeal", 15);
	SetCraftScience("SAQTSH_ItRu_LightHeal", "Магия", 2);
	SetenergyPenalty("SAQTSH_ItRu_LightHeal", 50);
	
	-----руны 2 круг
	
	AddItemCategory ("(Р) 2-й Круг", "SAQTSH_ItRu_InstantFireball"); ----- огненный шар
	SetCraftAmount("SAQTSH_ItRu_InstantFireball", 1);
	 AddIngre("SAQTSH_ItRu_InstantFireball", "ooltyb_itmi_runeblank", 1);
	 AddIngre("SAQTSH_ItRu_InstantFireball", "SAQTSH_ItRu_InstantFireball", 1);
    AddTool("SAQTSH_ItRu_InstantFireball", "MHAHGH_ITWr_Addon_MCELIXIER_01");
	AddTool("SAQTSH_ItRu_InstantFireball","MHAHGH_ITWR_Addon_Runemaking_KDF_CIRC2");
    AddTool("SAQTSH_ItRu_InstantFireball","ooltyb_itmi_pliers"); 	
	SetCraftPenalty("SAQTSH_ItRu_InstantFireball", 15);
	SetCraftScience("SAQTSH_ItRu_InstantFireball", "Магия", 3);
	SetenergyPenalty("SAQTSH_ItRu_InstantFireball", 50);
	
	AddItemCategory ("(Р) 2-й Круг", "SAQTSH_ItRu_Icelance"); ----- ледяное копье
	SetCraftAmount("SAQTSH_ItRu_Icelance", 1);
	 AddIngre("SAQTSH_ItRu_Icelance", "ooltyb_itmi_runeblank", 1);
	 AddIngre("SAQTSH_ItRu_Icelance", "IHPIWN_ItSc_Icelance", 3);
    AddTool("SAQTSH_ItRu_Icelance", "MHAHGH_ITWr_Addon_MCELIXIER_01");
	AddTool("SAQTSH_ItRu_Icelance","ooltyb_itmi_pliers");
    AddTool("SAQTSH_ItRu_Icelance","MHAHGH_ITWR_Addon_Runemaking_KDW_CIRC2"); 	
	SetCraftPenalty("SAQTSH_ItRu_Icelance", 15);
	SetCraftScience("SAQTSH_ItRu_Icelance", "Магия", 1);
	SetenergyPenalty("SAQTSH_ItRu_Icelance", 50);
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	
	--CheckCraftBase();
	SetTimer("SavePenaltyList", 10*60*1000, 1);
	
	repeat
		GUI_Craft_cat_bg = CreateTexture(200, 200, 2400, 7000, "MENU_INGAME.TGA");
	until GUI_Craft_cat_bg ~= 0;
	repeat
		GUI_Craft_it_bg = CreateTexture(2400, 200, 5500, 7000, "MENU_INGAME.TGA");
	until GUI_Craft_it_bg ~= 0;
	repeat
		GUI_Craft_add_bg = CreateTexture(5475, 200, 8100, 7000, "MENU_INGAME.TGA");
	until GUI_Craft_add_bg ~= 0;
	repeat
		GUI_Craft_exit_bg = CreateTexture(2400, 7000, 5500, 7500, "MENU_INGAME.TGA");
	until GUI_Craft_exit_bg ~= 0;
	repeat
		GUI_Craft_produce_bg = CreateTexture(5475, 7000, 8100, 7500, "MENU_INGAME.TGA");
	until GUI_Craft_produce_bg ~= 0;
	repeat
		GUI_Craft_ptime_bg = CreateTexture(200, 7000, 2400, 7500, "MENU_INGAME.TGA");
	until GUI_Craft_ptime_bg ~= 0;
end

GUI_Craft_cat_bg = 0;
GUI_Craft_it_bg = 0;
GUI_Craft_add_bg = 0;
GUI_Craft_exit_bg = 0;
GUI_Craft_produce_bg = 0;
GUI_Craft_ptime_bg = 0;


function CheckCraftBase()
	--for k, v in pairs(CraftCategory) do
		local k = "Без профессии"
		print("Category: "..k);
		for ki, vi in pairs(CraftCategory[k].items) do
			print(vi);
			--for kci, vci in pairs(CraftItem[vi]) do
				print("Amount: "..CraftItem[vi].amount);
				for kii, vii in pairs(CraftItem[vi].tools) do
					print("Tool:"..kii);
				end
				for kii, vii in pairs(CraftItem[vi].ing) do
					print("Ingredient:"..kii);
					print("Ingredient amount: "..CraftItem[vi].ing[kii].amount);
				end
			--end
		end
	--end
end

local GUI_Craft = {};

function DestroyCraftGUI(pid)
	if GUI_Craft[pid] ~= nil then
		for k, v in pairs(GUI_Craft[pid].cat) do
			for ki, vi in pairs(GUI_Craft[pid].cat[k].items) do
				if GUI_Craft[pid].cat[k].items[ki].draw ~= nil then
					DestroyPlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].draw);
				end
				if GUI_Craft[pid].cat[k].items[ki].addition ~= nil then
					for kii, vii in pairs(GUI_Craft[pid].cat[k].items[ki].addition) do
						if GUI_Craft[pid].cat[k].items[ki].addition ~= nil then
							DestroyPlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].addition[kii]);
						end
					end
				end
			end
		end
		
		if GUI_Craft[pid].ptime_draw ~= nil then
			DestroyPlayerDraw(pid, GUI_Craft[pid].ptime_draw);
		end
		
		DestroyPlayerDraw(pid, GUI_Craft[pid].cat_cur);

		DestroyPlayerDraw(pid, GUI_Craft[pid].it_cur);
		DestroyPlayerDraw(pid, GUI_Craft[pid].cat_title);
		DestroyPlayerDraw(pid, GUI_Craft[pid].it_title);
		DestroyPlayerDraw(pid, GUI_Craft[pid].add_title);
		DestroyPlayerDraw(pid, GUI_Craft[pid].exit_draw);
		DestroyPlayerDraw(pid, GUI_Craft[pid].produce_draw);
		GUI_Craft[pid] = nil;
	end
end

function GenerateCraftGUI(pid)
	if GUI_Craft[pid] ~= nil then
		DestroyCraftGUI(pid);
		GUI_Craft[pid] = nil;
	end
	
	GUI_Craft[pid] = {}
	GUI_Craft[pid].current_cat = 0;
	GUI_Craft[pid].current_item = 0;
	GUI_Craft[pid].level = -1;
	
	
	GUI_Craft[pid].cat_title = CreatePlayerDraw(pid, 500, 50, "Категория", "Font_Old_20_White_Hi.TGA", 255, 165, 0);
	
	GUI_Craft[pid].it_title = CreatePlayerDraw(pid, 2900, 50, "Предмет", "Font_Old_20_White_Hi.TGA", 255, 165, 0);
	GUI_Craft[pid].add_title = CreatePlayerDraw(pid, 5775, 50, "Требования", "Font_Old_20_White_Hi.TGA", 255, 165, 0);
	
	GUI_Craft[pid].exit_draw = CreatePlayerDraw(pid, 2900, 7200, "Выйти (K)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			
	GUI_Craft[pid].produce_draw = CreatePlayerDraw(pid, 5775, 7200, "Изготовить (Enter)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			
			
	GUI_Craft[pid].cat_cur = CreatePlayerDraw(pid, 525, 500, '>', "Font_Old_10_White_Hi.TGA", 255, 13, 13);
	GUI_Craft[pid].it_cur = CreatePlayerDraw(pid, 525, 500, '>', "Font_Old_10_White_Hi.TGA", 255, 13, 13);
	
	if CraftPenalty[GetPlayerName(pid)] ~= nil then
		GUI_Craft[pid].ptime_draw = CreatePlayerDraw(pid, 500, 7200, string.format("Штраф крафта: %d минут", CraftPenalty[GetPlayerName(pid)]), "Font_Old_10_White_Hi.TGA", 255, 255, 0);
	end
			
	GUI_Craft[pid].cat = {};
	local i = 0;
	
	GameTextForPlayer(pid, 1500, 7500, "Загрузка. Подождите...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 1000);
	for k, v in pairs(CraftCategory) do
		if CraftCategory[k].acquire_workspace ~= true then
			if CraftCategory[k].science ~= nil then
				if GetScienceLevel(pid, CraftCategory[k].science) > 0 then
					GUI_Craft[pid].cat[i] = {};
					--GUI_Craft[pid].cat[i].name = CraftCategory[k];
					GUI_Craft[pid].cat[i].items = {};
					GUI_Craft[pid].cat[i].draw = CreatePlayerDraw(pid, 545, 500 + 300*i, k, "Font_Old_10_White_Hi.TGA", 240, 230, 140);
					
					local j = 0;
					
					for ki, vi in pairs(CraftCategory[k].items) do
						GUI_Craft[pid].cat[i].items[j] = {};
						GUI_Craft[pid].cat[i].items[j].instance = CraftCategory[k].items[ki];
						--GUI_Craft[pid].cat[i].items[j].draw = CreatePlayerDraw(pid, 2545, 500 + 300*j, string.format("%s x%d", GetItemName(CraftCategory[k].items[ki]), CraftItem[CraftCategory[k].items[ki]].amount), "Font_Old_10_White_Hi.TGA", 240, 230, 140);
						
						--[[GUI_Craft[pid].cat[i].items[j].addition = {};
						local k = 0;
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Инструменты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;
						
						if tLen(CraftItem[vi].tools) > 0 then
							for kii, vii in pairs(CraftItem[vi].tools) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, " - "..GetItemName(kii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Ингредиенты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						for kii, vii in pairs(CraftItem[vi].ing) do				
							table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[vi].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
							k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Альтернативные инг.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						if tLen(CraftItem[vi].altering) > 0 then
							for kii, vii in pairs(CraftItem[vi].altering) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, GetItemName(CraftItem[vi].altering), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф времени: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d минут", CraftItem[vi].penalty), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
						k = k + 1;	
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф выносливости: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;							
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ед.", CraftItem[vi].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
						k = k + 1;
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Навыки: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						if tLen(CraftItem[vi].science) > 0 then
							for kii, vii in pairs(CraftItem[vi].science) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s Ур.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end]]
						
						j = j + 1;
					end
					
					i = i + 1;
				end
			else
					GUI_Craft[pid].cat[i] = {};
					--GUI_Craft[pid].cat[i].name = CraftCategory[k];
					GUI_Craft[pid].cat[i].items = {};
					GUI_Craft[pid].cat[i].draw = CreatePlayerDraw(pid, 545, 500 + 300*i, k, "Font_Old_10_White_Hi.TGA", 240, 230, 140);
					
					local j = 0;
					
					for ki, vi in pairs(CraftCategory[k].items) do
						GUI_Craft[pid].cat[i].items[j] = {};
						GUI_Craft[pid].cat[i].items[j].instance = CraftCategory[k].items[ki];
						--GUI_Craft[pid].cat[i].items[j].draw = CreatePlayerDraw(pid, 2545, 500 + 300*j, string.format("%s x%d", GetItemName(CraftCategory[k].items[ki]), CraftItem[CraftCategory[k].items[ki]].amount), "Font_Old_10_White_Hi.TGA", 240, 230, 140);
						
						--[[GUI_Craft[pid].cat[i].items[j].addition = {};
						local k = 0;
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Инструменты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;
						
						if tLen(CraftItem[vi].tools) > 0 then
							for kii, vii in pairs(CraftItem[vi].tools) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, " - "..GetItemName(kii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Ингредиенты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						for kii, vii in pairs(CraftItem[vi].ing) do				
							table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[vi].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
							k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Альтернативные инг.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						if tLen(CraftItem[vi].altering) > 0 then
							for kii, vii in pairs(CraftItem[vi].altering) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, GetItemName(CraftItem[vi].altering), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф времени: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
												
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d минут", CraftItem[vi].penalty), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
						k = k + 1;	
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф выносливости: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;							
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ед.", CraftItem[vi].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
						k = k + 1;
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Навыки: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						if tLen(CraftItem[vi].science) > 0 then
							for kii, vii in pairs(CraftItem[vi].science) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s Ур.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end]]
						
						j = j + 1;
					end
					
					i = i + 1;
			end
		else
			for wk in pairs(Workspace) do
				if WorkspaceReachable(pid, wk) == 1 and WorkspaceHasCategory(wk, k) == 1 then
					if CraftCategory[k].science ~= nil then
						if GetScienceLevel(pid, CraftCategory[k].science) > 0 then
							GUI_Craft[pid].cat[i] = {};
							--GUI_Craft[pid].cat[i].name = CraftCategory[k];
							GUI_Craft[pid].cat[i].items = {};
							GUI_Craft[pid].cat[i].draw = CreatePlayerDraw(pid, 545, 500 + 300*i, k, "Font_Old_10_White_Hi.TGA", 240, 230, 140);
							
							local j = 0;
							
							for ki, vi in pairs(CraftCategory[k].items) do
								GUI_Craft[pid].cat[i].items[j] = {};
								GUI_Craft[pid].cat[i].items[j].instance = CraftCategory[k].items[ki];
								--GUI_Craft[pid].cat[i].items[j].draw = CreatePlayerDraw(pid, 2545, 500 + 300*j, string.format("%s x%d", GetItemName(CraftCategory[k].items[ki]), CraftItem[CraftCategory[k].items[ki]].amount), "Font_Old_10_White_Hi.TGA", 240, 230, 140);
								
								--[[GUI_Craft[pid].cat[i].items[j].addition = {};
								local k = 0;
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Инструменты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;
								
								if tLen(CraftItem[vi].tools) > 0 then
									for kii, vii in pairs(CraftItem[vi].tools) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, " - "..GetItemName(kii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Ингредиенты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								for kii, vii in pairs(CraftItem[vi].ing) do				
									table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[vi].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
									k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Альтернативные инг.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								if tLen(CraftItem[vi].altering) > 0 then
									for kii, vii in pairs(CraftItem[vi].altering) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, GetItemName(CraftItem[vi].altering), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф времени: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d минут", CraftItem[vi].penalty), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;	
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф выносливости: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;							
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ед.", CraftItem[vi].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;

								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Навыки: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								if tLen(CraftItem[vi].science) > 0 then
									for kii, vii in pairs(CraftItem[vi].science) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s Ур.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end]]
								
								j = j + 1;
							end
							
							i = i + 1;
						end
					else
							GUI_Craft[pid].cat[i] = {};
							--GUI_Craft[pid].cat[i].name = CraftCategory[k];
							GUI_Craft[pid].cat[i].items = {};
							GUI_Craft[pid].cat[i].draw = CreatePlayerDraw(pid, 545, 500 + 300*i, k, "Font_Old_10_White_Hi.TGA", 240, 230, 140);
							
							local j = 0;
							
							for ki, vi in pairs(CraftCategory[k].items) do
								GUI_Craft[pid].cat[i].items[j] = {};
								GUI_Craft[pid].cat[i].items[j].instance = CraftCategory[k].items[ki];
								--GUI_Craft[pid].cat[i].items[j].draw = CreatePlayerDraw(pid, 2545, 500 + 300*j, string.format("%s x%d", GetItemName(CraftCategory[k].items[ki]), CraftItem[CraftCategory[k].items[ki]].amount), "Font_Old_10_White_Hi.TGA", 240, 230, 140);
								
								--[[GUI_Craft[pid].cat[i].items[j].addition = {};
								local k = 0;
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Инструменты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;
								
								if tLen(CraftItem[vi].tools) > 0 then
									for kii, vii in pairs(CraftItem[vi].tools) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, " - "..GetItemName(kii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Ингредиенты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								for kii, vii in pairs(CraftItem[vi].ing) do				
									table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[vi].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
									k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Альтернативные инг.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								if tLen(CraftItem[vi].altering) > 0 then
									for kii, vii in pairs(CraftItem[vi].altering) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, GetItemName(CraftItem[vi].altering), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф времени: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d минут", CraftItem[vi].penalty), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;	
								
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф выносливости: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;							
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ед.", CraftItem[vi].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Навыки: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								if tLen(CraftItem[vi].science) > 0 then
									for kii, vii in pairs(CraftItem[vi].science) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s Ур.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end]]
								
								j = j + 1;
							end
							
							i = i + 1;
					end
				end
			end
		end
	end
end

function ShowCraftGUI(pid)
	Player[pid].onGUI = true;
	ShowChat(pid, 0);
	FreezePlayer(pid, 1);
	GUI_Craft[pid].level = 0;
	
	GameTextForPlayer(pid, 1500, 7500, "Загружаю список каталогов...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 500);
	for k, v in pairs(GUI_Craft[pid].cat) do
		ShowPlayerDraw(pid, GUI_Craft[pid].cat[k].draw);
	end
	
	if CraftPenalty[GetPlayerName(pid)] ~= nil then
		ShowPlayerDraw(pid, GUI_Craft[pid].ptime_draw);
		ShowTexture(pid, GUI_Craft_ptime_bg);
	end
	
	ShowPlayerDraw(pid, GUI_Craft[pid].cat_cur);
	ShowPlayerDraw(pid, GUI_Craft[pid].cat_title);
	ShowPlayerDraw(pid, GUI_Craft[pid].it_title);
	ShowPlayerDraw(pid, GUI_Craft[pid].add_title);
	ShowPlayerDraw(pid, GUI_Craft[pid].exit_draw);
	ShowTexture(pid, GUI_Craft_exit_bg);
	ShowTexture(pid, GUI_Craft_cat_bg);
	ShowTexture(pid, GUI_Craft_it_bg);
	ShowTexture(pid, GUI_Craft_add_bg);
	ShowCategoryGUI(pid);
	
end

function ShowCategoryGUI(pid)
if GUI_Craft[pid].current_cat ~= nil then
if GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items ~= nil then
	GameTextForPlayer(pid, 1500, 7500, "Загружаю список предметов каталога...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 500);
	for k, v in pairs(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items) do
		GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].draw = CreatePlayerDraw(pid, 2545, 500 + 300*k, string.format("%s x%d", GetItemName(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].instance), CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].instance].amount), "Font_Old_10_White_Hi.TGA", 240, 230, 140);
		ShowPlayerDraw(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].draw);
	end
end
end
	
end

function ShowItemAddition(pid)
	GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition = {};
	
	local k = 0;
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Инструменты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;
	
	local count = 0;			
	for _ in pairs(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].tools) do
		count = count + 1;
	end

	if count > 0 then
		for kii, vii in pairs(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].tools) do
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, " - "..GetItemName(kii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		k = k + 1;
		end
	else
		table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		k = k + 1;
	end
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Ингредиенты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;	
								
	for kii, vii in pairs(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].ing) do				
		table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		k = k + 1;
	end
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Альтернативные инг.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;	
												
	if tCount(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].altering) > 0 then
		for kii, vii in pairs(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].altering) do
			table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].altering[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
			k = k + 1;
		end
	else
		table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		k = k + 1;
	end
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф времени: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;	
								
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d минут", CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].penalty), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
	k = k + 1;	
								
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф выносливости: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;							
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ед.", CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
	k = k + 1;
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Навыки: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;	
								
	if tCount(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].science) > 0 then
		for kii, vii in pairs(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].science) do
			table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s Ур.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
			k = k + 1;
		end
	else
		table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		k = k + 1;
	end
								
	for k, v in pairs(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition) do
		ShowPlayerDraw(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition[k]);
	end
	ShowPlayerDraw(pid, GUI_Craft[pid].produce_draw);
	ShowTexture(pid, GUI_Craft_produce_bg);
end


function HideItemAddition(pid)
	if GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition ~= nil then
		for k, v in pairs(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition) do
			HidePlayerDraw(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition[k]);
			DestroyPlayerDraw(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition[k]);
			GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition[k] = nil;
		end
		GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition = nil;
	end
end

function HideCategoriesInfo(pid)
	GameTextForPlayer(pid, 1500, 7500, "Обнуляю список вещей каталога...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 500);
	for k, v in pairs(GUI_Craft[pid].cat) do
		for ki, vi in pairs(GUI_Craft[pid].cat[k].items) do
			if GUI_Craft[pid].cat[k].items[ki].draw ~= nil then
				HidePlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].draw);
				DestroyPlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].draw);
				GUI_Craft[pid].cat[k].items[ki].draw = nil;
			end
			if GUI_Craft[pid].cat[k].items[ki].addition ~= nil then
				for kii, vii in pairs(GUI_Craft[pid].cat[k].items[ki].addition) do
					if GUI_Craft[pid].cat[k].items[ki].addition ~= nil then
						HidePlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].addition[kii]);
						DestroyPlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].addition[kii]);
					end
				end
				GUI_Craft[pid].cat[k].items[ki].addition = nil;
			end
		end
	end
	
	GUI_Craft[pid].current_item = 0;
end

function HideCraftGUI(pid)
	if GUI_Craft[pid] ~= nil then
		GameTextForPlayer(pid, 1500, 7500, "Закрываю каталог...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 500);
		for k, v in pairs(GUI_Craft[pid].cat) do
			HidePlayerDraw(pid, GUI_Craft[pid].cat[k].draw);
			for ki, vi in pairs(GUI_Craft[pid].cat[k].items) do
				if GUI_Craft[pid].cat[k].items[ki].draw ~= nil then
					HidePlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].draw);
					DestroyPlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].draw);
					GUI_Craft[pid].cat[k].items[ki].draw = nil;
				end
				if GUI_Craft[pid].cat[k].items[ki].addition ~= nil then
					for kii, vii in pairs(GUI_Craft[pid].cat[k].items[ki].addition) do
						if GUI_Craft[pid].cat[k].items[ki].addition ~= nil then
							HidePlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].addition[kii]);
							DestroyPlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].addition[kii]);
						end
					end
					GUI_Craft[pid].cat[k].items[ki].addition = nil;
				end
			end
		end
		
		if CraftPenalty[GetPlayerName(pid)] ~= nil and GUI_Craft[pid].ptime_draw ~= nil then
			HidePlayerDraw(pid, GUI_Craft[pid].ptime_draw);
			HideTexture(pid, GUI_Craft_ptime_bg);
		end
		
		HidePlayerDraw(pid, GUI_Craft[pid].cat_cur);
		HidePlayerDraw(pid, GUI_Craft[pid].it_cur);
		HidePlayerDraw(pid, GUI_Craft[pid].cat_title);
		HidePlayerDraw(pid, GUI_Craft[pid].it_title);
		HidePlayerDraw(pid, GUI_Craft[pid].add_title);
		HidePlayerDraw(pid, GUI_Craft[pid].exit_draw);
		HidePlayerDraw(pid, GUI_Craft[pid].produce_draw);
		HideTexture(pid, GUI_Craft_exit_bg);
		HideTexture(pid, GUI_Craft_produce_bg);
		HideTexture(pid, GUI_Craft_cat_bg);
		HideTexture(pid, GUI_Craft_it_bg);
		HideTexture(pid, GUI_Craft_add_bg);
		
		GUI_Craft[pid].current_item = 0;
		GUI_Craft[pid].current_cat = 0;
		GUI_Craft[pid].level = -1;
		ShowChat(pid, 1);
		FreezePlayer(pid, 0);
		Player[pid].onGUI = false;
	end
end

function CraftGUIMoveUp(pid)
	if(GUI_Craft[pid].level == 0) then
		if(GUI_Craft[pid].current_cat > 0) then
			HideCategoriesInfo(pid);
			GUI_Craft[pid].current_cat = GUI_Craft[pid].current_cat - 1;
			ShowCategoryGUI(pid);
			GUI_Craft[pid].current_item = 0;
		end
	elseif(GUI_Craft[pid].level == 1) then
		if(GUI_Craft[pid].current_item > 0) then
			HideItemAddition(pid);
			GUI_Craft[pid].current_item = GUI_Craft[pid].current_item - 1;
			ShowItemAddition(pid);
		end
	end
end

function CraftGUIMoveDown(pid)
	if(GUI_Craft[pid].level == 0) then
		if(GUI_Craft[pid].current_cat < tLen(GUI_Craft[pid].cat)) then
			HideCategoriesInfo(pid);
			GUI_Craft[pid].current_cat = GUI_Craft[pid].current_cat + 1;
			ShowCategoryGUI(pid);
			GUI_Craft[pid].current_item = 0;
		end
	elseif(GUI_Craft[pid].level == 1) then
		if(GUI_Craft[pid].current_item < tLen(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items)) then
			HideItemAddition(pid);
			GUI_Craft[pid].current_item = GUI_Craft[pid].current_item + 1;
			ShowItemAddition(pid);
		end
	end
end


function CraftGUILevel(pid, level)
	GUI_Craft[pid].level = level;
	HideCategoriesInfo(pid);
	ShowCategoryGUI(pid);
	if level == 1 then
		HideItemAddition(pid);
		ShowItemAddition(pid);
		ShowPlayerDraw(pid, GUI_Craft[pid].it_cur);
	elseif level == 0 then
		HidePlayerDraw(pid, GUI_Craft[pid].it_cur);
		HidePlayerDraw(pid, GUI_Craft[pid].produce_draw);
		HideTexture(pid, GUI_Craft_produce_bg);
	end
end

function UpdateCraftCursor(pid)
	if GUI_Craft[pid].level == 0 then
		UpdatePlayerDraw(pid, GUI_Craft[pid].cat_cur, 450, 500 + 300*GUI_Craft[pid].current_cat, '>>', "Font_Old_10_White_Hi.TGA", 255, 13, 13);
	--elseif GUI_Craft[pid].level == 1 then
		--UpdatePlayerDraw(pid, GUI_Craft[pid].it_cur, 2450, 500 + 300*GUI_Craft[pid].current_item, '>>', "Font_Old_10_White_Hi.TGA", 255, 13, 13);
	end
		UpdatePlayerDraw(pid, GUI_Craft[pid].it_cur, 2450, 1100, '>>', "Font_Old_10_White_Hi.TGA", 255, 13, 13);
		for k in pairs(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items) do
			--GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].instance = CraftCategory[k].items[ki];
			--GUI_Craft[pid].cat[i].items[j].draw = CreatePlayerDraw(pid, 2545, 500 + 300*j, string.format("%s x%d", GetItemName(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].instance), CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].instance].amount), "Font_Old_10_White_Hi.TGA", 240, 230, 140);
						
			if GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].draw ~= nil then
				UpdatePlayerDraw(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].draw, 2545, 500 + 300*(2 + k - GUI_Craft[pid].current_item), string.format("%s x%d", GetItemName(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].instance), CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].instance].amount), "Font_Old_10_White_Hi.TGA", 240, 230, 140);
				if (k - GUI_Craft[pid].current_item) < -2 or (k - GUI_Craft[pid].current_item) > 17 then
					HidePlayerDraw(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].draw);
				else
					ShowPlayerDraw(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].draw);			
				end
			end
		
		end
	--end
end

function ProceedAlterCraft(pid, instance)
	if CheckTools(pid, instance) == true and Checkenergy(pid, instance) == true and CheckScience(pid, instance) == true and CheckAlterIng(pid, instance) == true and CraftPenalty[GetPlayerName(pid)] == nil then
		for k, v in pairs(CraftItem[instance].altering) do
			DeleteItem(pid, k, CraftItem[instance].altering[k].amount);
		end
		
		GiveItem(pid, instance,  CraftItem[instance].amount);
		if  CraftItem[instance].penalty > 0 then
			HideCraftGUI(pid);
			CraftPenalty[GetPlayerName(pid)] =  CraftItem[instance].penalty;
			Player[pid].energy = Player[pid].energy - CraftItem[instance].energy;
			UpdateEnergyBar(pid);
			SavePlayer(pid);
			SaveItems(pid);
			PenaltyTimer[GetPlayerName(pid)] = SetTimerEx("DecreasePenalty", 60*1000, 1, GetPlayerName(pid));
		PlayAnimation(pid, "T_1HSINSPECT");
		SendPlayerMessage(pid, 255, 255, 255, GetPlayerName(pid).." изготовил предмет: "..GetItemName(instance));
			_logCraft(pid, instance,  CraftItem[instance].amount);

		if CraftItem[instance].exp > 0 then
			local skill = CraftItem[instance].exp_skill;
			if skill ~= nil then
				_craftGiveEXP(pid, skill, CraftItem[instance].exp);
			end
		end

		end
	else
		PlayAnimation(pid, "T_DONTKNOW");
	end

end


function Checkenergy(pid, instance)
		if CraftItem[instance].energy <= Player[pid].energy then
		return true;
	else
		GameTextForPlayer(pid, 1500, 7500, "Недостаточно выносливости","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
		return false;
	end
end

function CheckScience(pid, instance)
	local count = 0;
	for _ in pairs(CraftItem[instance].science) do
			count = count + 1
	end

	local matches = 0;
	local items = getPlayerItems(pid);
	local max_matches = count;
	if max_matches > 0 then
		for k in pairs(CraftItem[instance].science) do
			if GetScienceLevel(pid, k) >= CraftItem[instance].science[k] then
				matches = matches + 1;
			end
		end
	end
	
	if matches == max_matches then
		return true;
	end
	
	GameTextForPlayer(pid, 1500, 7500, "Недостаточный уровень навыка","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);

	return false;
end

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function _craftExpSkillConnect(id)

	Player[id].scraft_povar = {0, 0};
	Player[id].scraft_plotnik = {0, 0};
	Player[id].scraft_bronnik = {0, 0};
	Player[id].scraft_oryjeynik = {0, 0};
	Player[id].scraft_magic = {0, 0};
	Player[id].scraft_portnoy = {0, 0};
	Player[id].scraft_alhimic = {0, 0};
	Player[id].scraft_kozhevnik = {0, 0};
	Player[id].scraft_kyznec = {0, 0};

end

function _craftSaveEXP(id)

	local file = io.open("Database/Players/Craft/"..Player[id].nickname..".txt", "w+");
	file:write(GetScienceLevel(id, "Повар").." "..Player[id].scraft_povar[2].."\n");
	file:write(GetScienceLevel(id, "Плотник").." "..Player[id].scraft_plotnik[2].."\n");
	file:write(GetScienceLevel(id, "Бронник").." "..Player[id].scraft_bronnik[2].."\n");
	file:write(GetScienceLevel(id, "Оружейник").." "..Player[id].scraft_oryjeynik[2].."\n");
	file:write(GetScienceLevel(id, "Портной").." "..Player[id].scraft_portnoy[2].."\n");
	file:write(GetScienceLevel(id, "Алхимия").." "..Player[id].scraft_alhimic[2].."\n");
	file:write(GetScienceLevel(id, "Кожевник").." "..Player[id].scraft_kozhevnik[2].."\n");
	file:write(GetScienceLevel(id, "Кузнец").." "..Player[id].scraft_kyznec[2].."\n");
	file:close();

end

function _craftReadEXP(id)

	local file = io.open("Database/Players/Craft/"..Player[id].nickname..".txt", "r");
	if file then

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_povar = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_plotnik = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_bronnik = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_oryjeynik = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_portnoy = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_alhimic = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_kozhevnik = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_kyznec = {lvl, exp};
		end
		
	else
		_craftSaveEXP(id);
	end

end

CRAFT_POVAR_LEVELS = {1000, 2000};
CRAFT_PLOTNIK_LEVELS = {1000, 2000};
CRAFT_BRONNIK_LEVELS = {1000, 2000};
CRAFT_ORYJEYNIK_LEVELS = {1000, 2000};
CRAFT_PORTNOY_LEVELS = {1000, 2000};
CRAFT_ALHIMIC_LEVELS = {1000, 2000};
CRAFT_KOZHEVNIK_LEVELS = {1000, 2000};
CRAFT_KYZNEC_LEVELS = {1000, 2000};

function _craftGiveEXP(id, skill, exp)

	--#######################################################################################################
	if skill == "Повар" then

			Player[id].scraft_povar[2] = Player[id].scraft_povar[2] + exp;
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_POVAR_LEVELS) do
				if Player[id].scraft_povar[1] == i then
					nexp = v;
				end
			end

			if Player[id].scraft_povar[2] >= nexp then
				if Player[id].scraft_povar[1] == 1 or Player[id].scraft_povar[1] == 2 then
					Player[id].scraft_povar[1] = Player[id].scraft_povar[1] + 1; Player[id].scraft_povar[2] = 0;
					AddScience(id, "Повар", Player[id].scraft_povar[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень повара повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				end
			end
		--#######################################################################################################
	elseif skill == "Плотник" then

			Player[id].scraft_plotnik[2] = Player[id].scraft_plotnik[2] + exp;
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_PLOTNIK_LEVELS) do
				if Player[id].scraft_plotnik[1] == i then
					nexp = v;
				end
			end

			if Player[id].scraft_plotnik[2] >= nexp then
				if Player[id].scraft_plotnik[1] == 1 or Player[id].scraft_plotnik[1] == 2 then
					Player[id].scraft_plotnik[1] = Player[id].scraft_plotnik[1] + 1; Player[id].scraft_plotnik[2] = 0;
					AddScience(id, "Плотник", Player[id].scraft_plotnik[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень плотника повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				end
			end
		--#######################################################################################################
	elseif skill == "Портной" then

			Player[id].scraft_portnoy[2] = Player[id].scraft_portnoy[2] + exp;
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_PORTNOY_LEVELS) do
				if Player[id].scraft_portnoy[1] == i then
					nexp = v;
				end
			end

			if Player[id].scraft_portnoy[2] >= nexp then
				if Player[id].scraft_portnoy[1] == 1 or Player[id].scraft_portnoy[1] == 2 then
					Player[id].scraft_portnoy[1] = Player[id].scraft_portnoy[1] + 1; Player[id].scraft_portnoy[2] = 0;
					AddScience(id, "Портной", Player[id].scraft_portnoy[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень портного повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				end
			end

		--#######################################################################################################
	elseif skill == "Оружейник" then

			Player[id].scraft_oryjeynik[2] = Player[id].scraft_oryjeynik[2] + exp;
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_ORYJEYNIK_LEVELS) do
				if Player[id].scraft_oryjeynik[1] == i then
					nexp = v;
				end
			end

			if Player[id].scraft_oryjeynik[2] >= nexp then
				if Player[id].scraft_oryjeynik[1] == 1 or Player[id].scraft_oryjeynik[1] == 2 then
					Player[id].scraft_oryjeynik[1] = Player[id].scraft_oryjeynik[1] + 1; Player[id].scraft_oryjeynik[2] = 0;
					AddScience(id, "Оружейник", Player[id].scraft_oryjeynik[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень оружейника повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				end
			end

		--#######################################################################################################
	elseif skill == "Бронник" then

			Player[id].scraft_bronnik[2] = Player[id].scraft_bronnik[2] + exp;
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_BRONNIK_LEVELS) do
				if Player[id].scraft_bronnik[1] == i then
					nexp = v;
				end
			end

			if Player[id].scraft_bronnik[2] >= nexp then
				if Player[id].scraft_bronnik[1] == 1 or Player[id].scraft_bronnik[1] == 2 then
					Player[id].scraft_bronnik[1] = Player[id].scraft_bronnik[1] + 1; Player[id].scraft_bronnik[2] = 0;
					AddScience(id, "Бронник", Player[id].scraft_bronnik[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень бронника повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				end
			end

		--#######################################################################################################
	elseif skill == "Кожевник" then

			Player[id].scraft_kozhevnik[2] = Player[id].scraft_kozhevnik[2] + exp;
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_KOZHEVNIK_LEVELS) do
				if Player[id].scraft_kozhevnik[1] == i then
					nexp = v;
				end
			end

			if Player[id].scraft_kozhevnik[2] >= nexp then
				if Player[id].scraft_kozhevnik[1] == 1 or Player[id].scraft_kozhevnik[1] == 2 then
					Player[id].scraft_kozhevnik[1] = Player[id].scraft_kozhevnik[1] + 1; Player[id].scraft_kozhevnik[2] = 0;
					AddScience(id, "Кожевник", Player[id].scraft_kozhevnik[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень кожевника повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				end
			end

		--#######################################################################################################
	elseif skill == "Кузнец" then

			Player[id].scraft_kyznec[2] = Player[id].scraft_kyznec[2] + exp;
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_KYZNEC_LEVELS) do
				if Player[id].scraft_kyznec[1] == i then
					nexp = v;
				end
			end

			if Player[id].scraft_kyznec[2] >= nexp then
				if Player[id].scraft_kyznec[1] == 1 or Player[id].scraft_kyznec[1] == 2 then
					Player[id].scraft_kyznec[1] = Player[id].scraft_kyznec[1] + 1; Player[id].scraft_kyznec[2] = 0;
					AddScience(id, "Кузнец", Player[id].scraft_kyznec[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень кузнеца повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				end
			end

		--#######################################################################################################
	elseif skill == "Алхимик" then

			Player[id].scraft_alhimic[2] = Player[id].scraft_alhimic[2] + exp;
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_ALHIMIC_LEVELS) do
				if Player[id].scraft_alhimic[1] == i then
					nexp = v;
				end
			end

			if Player[id].scraft_alhimic[2] >= nexp then
				if Player[id].scraft_alhimic[1] == 1 or Player[id].scraft_alhimic[1] == 2 then
					Player[id].scraft_alhimic[1] = Player[id].scraft_alhimic[1] + 1; Player[id].scraft_alhimic[2] = 0;
					AddScience(id, "Алхимик", Player[id].scraft_alhimic[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень алхимика повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				end
			end

		--#######################################################################################################
	end

	_craftSaveEXP(id);

end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

function ProceedCraft(pid, instance)
	if CheckTools(pid, instance) == true and Checkenergy(pid, instance) == true and CheckScience(pid, instance) == true and CheckIng(pid, instance) == true and CraftPenalty[GetPlayerName(pid)] == nil then
		for k, v in pairs(CraftItem[instance].ing) do
			DeleteItem(pid, k, CraftItem[instance].ing[k].amount);
		end

		GiveItem(pid, instance,  CraftItem[instance].amount);
		SaveItems(pid);
		if  CraftItem[instance].penalty > 0 then
			HideCraftGUI(pid);
			CraftPenalty[GetPlayerName(pid)] =  CraftItem[instance].penalty;
			Player[pid].energy = Player[pid].energy - CraftItem[instance].energy;
			UpdateEnergyBar(pid);
			SavePlayer(pid);
			PenaltyTimer[GetPlayerName(pid)] = SetTimerEx("DecreasePenalty", 60*1000, 1, GetPlayerName(pid));
		end
		local name = GetPlayerName(pid)
		PlayAnimation(pid, "T_1HSINSPECT");
		SendPlayerMessage(pid, 255, 255, 255, GetPlayerName(pid).." изготовил предмет: "..GetItemName(instance));
		_logCraft(pid, instance,  CraftItem[instance].amount);

		if CraftItem[instance].exp > 0 then
			local skill = CraftItem[instance].exp_skill;
			if skill ~= nil then
				_craftGiveEXP(pid, skill, CraftItem[instance].exp);
			end
		end

	else
		PlayAnimation(pid, "T_DONTKNOW");
	end
end

function CheckTools(pid, instance)
	local count = 0;
	for _ in pairs(CraftItem[instance].tools) do
			count = count + 1
	end

	local matches = 0;
	local items = getPlayerItems(pid);
	local max_matches = count;
	if max_matches > 0 then
		if items then
			for key in pairs(items) do
				if CraftItem[instance].tools[items[key].instance] ~= nil then
					matches = matches + 1;
				end
			end
		end
	end
	
	if matches == max_matches then
		return true;
	end
	
	GameTextForPlayer(pid,  1500, 7500, "Нет необходимых инструментов","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
	return false;
end

function CheckIng(pid, instance)

	 local count = 0;
	for _ in pairs(CraftItem[instance].ing) do
			count = count + 1
	end

	local matches = 0;
	local items = getPlayerItems(pid);
	local max_matches = count;
	--local max_matches = tLen(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item]].ing);
	
	if max_matches > 0 then
		if items then
			for key in pairs(items) do
				if CraftItem[instance].ing[items[key].instance] ~= nil then
					if CraftItem[instance].ing[items[key].instance].amount <=  items[key].amount then
						matches = matches + 1;
					end
				end
			end
		end
	else
		return false;
	end
	
	if matches == max_matches then
		return true;
	end
	
	GameTextForPlayer(pid,  1500, 7500, "Недостаточно ресурсов","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
	return false;
end

function CheckAlterIng(pid, instance)


	local matches = 0;
	local items = getPlayerItems(pid);
	local max_matches = tLen(CraftItem[instance].altering);
	if max_matches > 0 then
		if items then
			for key in pairs(items) do
				if CraftItem[instance].altering[items[key].instance] ~= nil then
					if CraftItem[instance].altering[items[key].instance].amount <=  items[key].amount then
						matches = matches + 1;
					end
				end
			end
		end
	else
		GameTextForPlayer(pid,  1500, 7500, "Альтернативных ингредиентов не существует для этого крафта", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
		return false;
	end
	
	if matches == max_matches then
		return true;
	end
	
	GameTextForPlayer(pid,  1500, 7500, "Недостаточно альтернативных ресурсов", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
	return false;
end

function CheckCraftGUI (pid, keydown, keyup)

	if Player[pid].loggedIn == true then

		if keydown == KEY_K then
			if GUI_Craft[pid] == nil and Player[pid].onGUI == false then
				GUIPlayerinfoInit(pid, pid);
				ShowDLPlayerinfo(pid);
				HideDLPlayerinfo(pid);
				DestroyDLPlayerinfo(pid);
				GenerateCraftGUI(pid);
				ShowCraftGUI(pid);
			else
				HideCraftGUI(pid);
				DestroyCraftGUI(pid);
			end
		end
		if GUI_Craft[pid] ~= nil then
			if keydown == KEY_LEFT and GUI_Craft[pid].level >= 0 then
				if GUI_Craft[pid].level == 1 then
					CraftGUILevel(pid, 0);
				end
			elseif keydown == KEY_RETURN and GUI_Craft[pid].level == 1  then
				ProceedCraft(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance);
			elseif keydown == KEY_RSHIFT and GUI_Craft[pid].level == 1 then
				ProceedAlterCraft(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance);
			elseif keydown == KEY_RIGHT and GUI_Craft[pid].level >= 0 then
				if GUI_Craft[pid].level == 0 then
					CraftGUILevel(pid, 1);
				end
			elseif keydown == KEY_DOWN and GUI_Craft[pid].level >= 0  then
				CraftGUIMoveDown(pid);
			elseif keydown == KEY_UP and GUI_Craft[pid].level >= 0  then
				CraftGUIMoveUp(pid);
			end
		end
		
		if GUI_Craft[pid] ~= nil then
			if GUI_Craft[pid].level >= 0 then
				UpdateCraftCursor(pid)
			end
		end
	end
end