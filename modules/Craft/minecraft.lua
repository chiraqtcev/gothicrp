
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
	AddWorkspaceCategory(size, "(Р) 3-й Круг");
	AddWorkspaceCategory(size, "(Р) 4-й Круг");
	AddWorkspaceCategory(size, "(С) 3-й Круг");
	AddWorkspaceCategory(size, "(С) 4-й Круг");
	AddWorkspaceCategory(size, "Робы магов");
	AddWorkspaceCategory(size, "Зачарователь");
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
		CraftItem[instance].exp_skill = {};
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
	table.insert(CraftItem[instance].exp_skill, tostring(skill));
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
	ToggleWorkspace("(Р) 3-й Круг");
	ToggleWorkspace("(Р) 4-й Круг");
	ToggleWorkspace("(С) 1-й Круг");
	ToggleWorkspace("(С) 2-й Круг");
	ToggleWorkspace("(С) 3-й Круг");
	ToggleWorkspace("(С) 4-й Круг");
	ToggleWorkspace("Робы магов");
	ToggleWorkspace("Зачарователь");

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
	AddCategoryScience("(С) 3-й Круг", "Магия");
	AddCategoryScience("(С) 4-й Круг", "Магия");
	AddCategoryScience("(Р) 1-й Круг", "Магия");
	AddCategoryScience("(Р) 2-й Круг", "Магия");
	AddCategoryScience("(Р) 3-й Круг", "Магия");
	AddCategoryScience("(Р) 4-й Круг", "Магия");
	AddCategoryScience("Робы магов", "Портной");
	AddCategoryScience("Зачарователь", "Зачарователь");
	
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
	
	AddItemCategory ("Без профессии", "uhaxlk_itfo_friedmeat"); ----- Жареное мясо
	SetCraftAmount("uhaxlk_itfo_friedmeat", 3);
     AddIngre("uhaxlk_itfo_friedmeat", "uhaxlk_itfo_rawmeat", 3);
    SetCraftPenalty("uhaxlk_itfo_friedmeat", 5);
	SetCraftScience("uhaxlk_itfo_friedmeat", "Без профессии", 0);
	SetenergyPenalty("uhaxlk_itfo_friedmeat", 50);

	AddItemCategory ("Без профессии", "uhaxlk_itfo_friedfish"); ----- Жареная рыба
	SetCraftAmount("uhaxlk_itfo_friedfish", 3);
     AddIngre("uhaxlk_itfo_friedfish", "uhaxlk_itfo_fish", 3);
	SetCraftPenalty("uhaxlk_itfo_friedfish", 5);
	SetCraftScience("uhaxlk_itfo_friedfish", "Без профессии", 0);
	SetenergyPenalty("uhaxlk_itfo_friedfish", 50);
	
	AddItemCategory ("Без профессии", "uhaxlk_itfo_honey"); ----- Мед
	SetCraftAmount("uhaxlk_itfo_honey", 2);
     AddIngre("uhaxlk_itfo_honey", "AIXOPT_ItMi_HoneyComb", 1);
	SetCraftPenalty("uhaxlk_itfo_honey", 5);
	SetCraftScience("uhaxlk_itfo_honey", "Без профессии", 0);
	SetenergyPenalty("uhaxlk_itfo_honey", 25);
	
	AddItemCategory ("Без профессии", "ZDPWLA_ItFo_Addon_Shellflesh"); ----- Мясо моллюска
	SetCraftAmount("ZDPWLA_ItFo_Addon_Shellflesh", 2);
     AddIngre("ZDPWLA_ItFo_Addon_Shellflesh", "uhaxlk_itat_clamflesh", 1);
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
	 AddIngre("ZDPWLA_ItFo_PoorSoup", "hfdpun_itpl_temp_herb", 3);
	SetCraftPenalty("ZDPWLA_ItFo_PoorSoup", 10);
	SetCraftScience("ZDPWLA_ItFo_PoorSoup", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFo_PoorSoup", 100);
	
	AddItemCategory ("Без профессии", "ZDPWLA_ItFo_MushroomOffal"); ----- Грибная требуха
    SetCraftAmount("ZDPWLA_ItFo_MushroomOffal", 3);
     AddIngre("ZDPWLA_ItFo_MushroomOffal", "hfdpun_itpl_mushroom_02", 1);
     AddIngre("ZDPWLA_ItFo_MushroomOffal", "hfdpun_itpl_mushroom_01", 5);
    SetCraftPenalty("ZDPWLA_ItFo_MushroomOffal", 10);
    SetCraftScience("ZDPWLA_ItFo_MushroomOffal", "Без профессии", 0);
    SetenergyPenalty("ZDPWLA_ItFo_MushroomOffal", 100);
	
	AddItemCategory ("Без профессии", "ZDPWLA_ItFo_GrapeJuice"); ----- Виноградный сок
	SetCraftAmount("ZDPWLA_ItFo_GrapeJuice", 2);
     AddIngre("ZDPWLA_ItFo_GrapeJuice", "uhaxlk_itfo_wineberry", 5);
	 AddIngre("ZDPWLA_ItFo_GrapeJuice", "aixopt_itmi_flask", 2);
	SetCraftPenalty("ZDPWLA_ItFo_GrapeJuice", 5);
	SetCraftScience("ZDPWLA_ItFo_GrapeJuice", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFo_GrapeJuice", 25);
	
	AddItemCategory ("Без профессии", "aixopt_itmi_flour"); ----- мука
	SetCraftAmount("aixopt_itmi_flour", 1);
     AddIngre("aixopt_itmi_flour", "aixopt_itmi_wheat", 45);
	 AddAlterIngre("aixopt_itmi_flour", "zdpwla_itfo_millet", 45);
	SetCraftPenalty("aixopt_itmi_flour", 5);
	SetCraftScience("aixopt_itmi_flour", "Без профессии", 0);
	SetenergyPenalty("aixopt_itmi_flour", 10);
	
	AddItemCategory ("Без профессии", "aixopt_itmi_joint"); ----- Самокрутка с табаком
	SetCraftAmount("aixopt_itmi_joint", 5);
     AddIngre("aixopt_itmi_joint", "aixopt_itmi_apfeltabak", 2);
	SetCraftPenalty("aixopt_itmi_joint", 5);
	SetCraftScience("aixopt_itmi_joint", "Без профессии", 0);
	SetenergyPenalty("aixopt_itmi_joint", 25);
	
	AddItemCategory ("Без профессии", "aixopt_itmi_coal"); ----- Уголь
	SetCraftAmount("aixopt_itmi_coal", 15);
     AddIngre("aixopt_itmi_coal", "aixopt_itmi_rawwood", 30);
	SetCraftPenalty("aixopt_itmi_coal", 5);
	SetCraftScience("aixopt_itmi_coal", "Без профессии", 0);
	SetenergyPenalty("aixopt_itmi_coal", 25);
	
	AddItemCategory ("Без профессии", "OOLTYB_ITMI_Stroy"); ---- Строительные материалы
	SetCraftAmount("OOLTYB_ITMI_Stroy", 2);
	 AddIngre("OOLTYB_ITMI_Stroy", "aixopt_itmi_ironingot", 1);
	 AddIngre("OOLTYB_ITMI_Stroy", "aixopt_itmi_craftwood", 1);
     AddIngre("OOLTYB_ITMI_Stroy", "aixopt_itmi_linen", 1);
	 AddIngre("OOLTYB_ITMI_Stroy", "aixopt_itmi_skin", 1);
	SetCraftPenalty("OOLTYB_ITMI_Stroy", 10);
	SetCraftScience("aixopt_itmi_coal", "Без профессии", 0);
	SetenergyPenalty("OOLTYB_ITMI_Stroy", 25);
	
	AddItemCategory ("Без профессии", "itlstorch"); ---- Факел
	SetCraftAmount("itlstorch", 15);
	 AddIngre("itlstorch", "aixopt_itmi_pitch", 1);
	 AddIngre("itlstorch", "gkwqdz_itmw_1h_bau_mace", 1);
	SetCraftPenalty("itlstorch", 1);
	SetCraftScience("aixopt_itmi_coal", "Без профессии", 0);
	SetenergyPenalty("itlstorch", 10);
	
	AddItemCategory ("Без профессии", "yfauun_itar_koszyk"); ---- Корзинка для зерна
	SetCraftAmount("yfauun_itar_koszyk", 1);
	 AddIngre("yfauun_itar_koszyk", "zdpwla_itfo_rice", 1);
	 AddIngre("yfauun_itar_koszyk", "zdpwla_itpl_weed", 1);
	SetCraftPenalty("yfauun_itar_koszyk", 1);
	SetCraftScience("aixopt_itmi_coal", "Без профессии", 0);
	SetenergyPenalty("yfauun_itar_koszyk", 10);
	
	AddItemCategory ("Без профессии", "yfauun_itar_koszyk2"); ---- Корзинка для руды
	SetCraftAmount("yfauun_itar_koszyk2", 1);
	 AddIngre("yfauun_itar_koszyk2", "aixopt_itmi_ironnugget", 1);
	SetCraftPenalty("yfauun_itar_koszyk2", 1);
	SetCraftScience("aixopt_itmi_coal", "Без профессии", 0);
	SetenergyPenalty("yfauun_itar_koszyk2", 10);
	
	AddItemCategory ("Без профессии", "yfauun_itar_koszyk3"); ---- Корзинка для травы
	SetCraftAmount("yfauun_itar_koszyk3", 1);
	 AddIngre("yfauun_itar_koszyk3", "hfdpun_itpl_temp_herb", 1);
	SetCraftPenalty("yfauun_itar_koszyk3", 1);
	SetCraftScience("aixopt_itmi_coal", "Без профессии", 0);
	SetenergyPenalty("yfauun_itar_koszyk3", 10);
	
--ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА	
		
	
	AddItemCategory ("Повар (1 уровень)", "uhaxlk_itfo_sausage"); ----- Колбаса
	SetCraftAmount("uhaxlk_itfo_sausage", 5);
	 AddIngre("uhaxlk_itfo_sausage", "uhaxlk_itfo_rawmeat", 9);
	 AddIngre("uhaxlk_itfo_sausage", "aixopt_itat_fat", 1);
    AddTool("uhaxlk_itfo_sausage", "gkwqdz_itmw_huntknife");
	SetCraftPenalty("uhaxlk_itfo_sausage", 5);
	SetCraftScience("uhaxlk_itfo_sausage", "Повар", 1);
	SetenergyPenalty("uhaxlk_itfo_sausage", 25);
	SetCraftEXP("uhaxlk_itfo_sausage", 25)
	SetCraftEXP_SKILL("uhaxlk_itfo_sausage", "Повар")
	
	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_MarinMushroom"); ----- Маринованные грибы
	SetCraftAmount("ZDPWLA_ItFo_MarinMushroom", 20);
	 AddIngre("ZDPWLA_ItFo_MarinMushroom", "hfdpun_itpl_mushroom_01", 5);
	 AddIngre("ZDPWLA_ItFo_MarinMushroom", "hfdpun_itpl_mushroom_02", 1);
	 AddIngre("ZDPWLA_ItFo_MarinMushroom", "ZDPWLA_ItMi_Vinegar", 1);
	 AddIngre("ZDPWLA_ItFo_MarinMushroom", "aixopt_itmi_flask", 20);
    AddTool("ZDPWLA_ItFo_MarinMushroom", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ItFo_MarinMushroom", 5);
	SetCraftScience("ZDPWLA_ItFo_MarinMushroom", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_MarinMushroom", 50);	
	SetCraftEXP("ZDPWLA_ItFo_MarinMushroom", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_MarinMushroom", "Повар")

	AddItemCategory ("Повар (1 уровень)", "uhaxlk_itfo_bread"); ----- Хлеб
	SetCraftAmount("uhaxlk_itfo_bread", 20);
	 AddIngre("uhaxlk_itfo_bread", "aixopt_itmi_dough", 1);
    AddTool("uhaxlk_itfo_bread", "aixopt_itmi_scoop");
	SetCraftPenalty("uhaxlk_itfo_bread", 5);
	SetCraftScience("uhaxlk_itfo_bread", "Повар", 1);
	SetenergyPenalty("uhaxlk_itfo_bread", 50);
	SetCraftEXP("uhaxlk_itfo_bread", 50)
	SetCraftEXP_SKILL("uhaxlk_itfo_bread", "Повар")

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_Addon_MeatSoup"); ----- Мясная похлебка
	SetCraftAmount("ZDPWLA_ItFo_Addon_MeatSoup", 5);
	 AddIngre("ZDPWLA_ItFo_Addon_MeatSoup", "uhaxlk_itfo_rawmeat", 15);
	 AddIngre("ZDPWLA_ItFo_Addon_MeatSoup", "aixopt_itmi_wheat", 35);
	 AddIngre("ZDPWLA_ItFo_Addon_MeatSoup", "aixopt_itmi_flask", 5);
    AddTool("ZDPWLA_ItFo_Addon_MeatSoup", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Addon_MeatSoup", 5);
	SetCraftScience("ZDPWLA_ItFo_Addon_MeatSoup", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_Addon_MeatSoup", 50);
	SetCraftEXP("ZDPWLA_ItFo_Addon_MeatSoup", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Addon_MeatSoup", "Повар")

	AddItemCategory ("Повар (1 уровень)", "uhaxlk_itfo_fishBatter"); ----- Рыба в кляре
	SetCraftAmount("uhaxlk_itfo_fishBatter", 20);
	 AddIngre("uhaxlk_itfo_fishBatter", "uhaxlk_itfo_fish", 27);
	 AddIngre("uhaxlk_itfo_fishBatter", "aixopt_itmi_flour", 1);
    AddTool("uhaxlk_itfo_fishBatter", "aixopt_itmi_pan");
	SetCraftPenalty("uhaxlk_itfo_fishBatter", 10);
	SetCraftScience("uhaxlk_itfo_fishBatter", "Повар", 1);
	SetenergyPenalty("uhaxlk_itfo_fishBatter", 100);
	SetCraftEXP("uhaxlk_itfo_fishBatter", 100)
	SetCraftEXP_SKILL("uhaxlk_itfo_fishBatter", "Повар")

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ITFO_MEATBUGRAGOUT"); ----- Рагу из жуков
	SetCraftAmount("ZDPWLA_ITFO_MEATBUGRAGOUT", 5);
	 AddIngre("ZDPWLA_ITFO_MEATBUGRAGOUT", "OOLTYB_ItAt_Meatbugflesh", 11);
	 AddIngre("ZDPWLA_ITFO_MEATBUGRAGOUT", "aixopt_itmi_wheat", 30);
	 AddIngre("ZDPWLA_ITFO_MEATBUGRAGOUT", "aixopt_itmi_flask", 5);
    AddTool("ZDPWLA_ITFO_MEATBUGRAGOUT", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ITFO_MEATBUGRAGOUT", 10);
	SetCraftScience("ZDPWLA_ITFO_MEATBUGRAGOUT", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ITFO_MEATBUGRAGOUT", 50);
	SetCraftEXP("ZDPWLA_ITFO_MEATBUGRAGOUT", 50)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_MEATBUGRAGOUT", "Повар")

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ITFO_BERRYSALAD"); ----- Ягодный салат
	SetCraftAmount("ZDPWLA_ITFO_BERRYSALAD", 5);
	 AddIngre("ZDPWLA_ITFO_BERRYSALAD", "hfdpun_itpl_forestberry", 4);
	 AddIngre("ZDPWLA_ITFO_BERRYSALAD", "uhaxlk_itfo_wineberry", 2);
	 AddIngre("ZDPWLA_ITFO_BERRYSALAD", "hfdpun_itpl_blueplant", 2);
	 AddIngre("ZDPWLA_ITFO_BERRYSALAD", "aixopt_itmi_flask", 5);
    AddTool("ZDPWLA_ITFO_BERRYSALAD", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ITFO_BERRYSALAD", 5);
	SetCraftScience("ZDPWLA_ITFO_BERRYSALAD", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ITFO_BERRYSALAD", 25);
	SetCraftEXP("ZDPWLA_ITFO_BERRYSALAD", 25)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_BERRYSALAD", "Повар")

	AddItemCategory ("Повар (1 уровень)", "uhaxlk_itfo_cheese"); ----- Сыр
	SetCraftAmount("uhaxlk_itfo_cheese", 10);
	 AddIngre("uhaxlk_itfo_cheese", "uhaxlk_itfo_milk", 13);
    AddTool("uhaxlk_itfo_cheese", "aixopt_itmi_scoop");
	SetCraftPenalty("uhaxlk_itfo_cheese", 5);
	SetCraftScience("uhaxlk_itfo_cheese", "Повар", 1);
	SetenergyPenalty("uhaxlk_itfo_cheese", 25);
	SetCraftEXP("uhaxlk_itfo_cheese", 25)
	SetCraftEXP_SKILL("uhaxlk_itfo_cheese", "Повар")

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ITFO_TEA"); ----- Чай
	SetCraftAmount("ZDPWLA_ITFO_TEA", 10);
	 AddIngre("ZDPWLA_ITFO_TEA", "hfdpun_itpl_mana_herb_01", 2);
	 AddIngre("ZDPWLA_ITFO_TEA", "hfdpun_itpl_temp_herb", 4);
	 AddIngre("ZDPWLA_ITFO_TEA", "aixopt_itmi_flask", 10);
    AddTool("ZDPWLA_ITFO_TEA", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ITFO_TEA", 2);
	SetCraftScience("ZDPWLA_ITFO_TEA", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ITFO_TEA", 25);
	SetCraftEXP("ZDPWLA_ITFO_TEA", 25)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_TEA", "Повар")

	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_Mors"); ----- Морс
	SetCraftAmount("ZDPWLA_ItFo_Mors", 10);
	 AddIngre("ZDPWLA_ItFo_Mors", "hfdpun_itpl_forestberry", 10);
	 AddIngre("ZDPWLA_ItFo_Mors", "aixopt_itmi_flask", 10);
    AddTool("ZDPWLA_ItFo_Mors", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Mors", 5);
	SetCraftScience("ZDPWLA_ItFo_Mors", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_Mors", 25);
	SetCraftEXP("ZDPWLA_ItFo_Mors", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Mors", "Повар")


	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ITFO_ACORNBOOZE"); ----- Желудевка
	SetCraftAmount("ZDPWLA_ITFO_ACORNBOOZE", 20);
	 AddIngre("ZDPWLA_ITFO_ACORNBOOZE", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	 AddIngre("ZDPWLA_ITFO_ACORNBOOZE", "hfdpun_itfo_plants_towerwood_01", 8);
	 AddIngre("ZDPWLA_ITFO_ACORNBOOZE", "aixopt_itmi_flask", 20);
    AddTool("ZDPWLA_ITFO_ACORNBOOZE", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ITFO_ACORNBOOZE", 20);
	SetCraftScience("ZDPWLA_ITFO_ACORNBOOZE", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ITFO_ACORNBOOZE", 100);
	SetCraftEXP("ZDPWLA_ITFO_ACORNBOOZE", 100)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_ACORNBOOZE", "Повар")
	
	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ITFO_SOUP"); ----- Суп из кореньев
	SetCraftAmount("ZDPWLA_ITFO_SOUP", 10);
	 AddIngre("ZDPWLA_ITFO_SOUP", "hfdpun_itfo_plants_stoneroot_01", 1);
	 AddIngre("ZDPWLA_ITFO_SOUP", "hfdpun_itpl_mana_herb_03", 1);
	 AddIngre("ZDPWLA_ITFO_SOUP", "hfdpun_itpl_strength_herb_01", 1);
	 AddIngre("ZDPWLA_ITFO_SOUP", "aixopt_itmi_flask", 10);
    AddTool("ZDPWLA_ITFO_SOUP", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ITFO_SOUP", 20);
	SetCraftScience("ZDPWLA_ITFO_SOUP", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ITFO_SOUP", 100);	
	SetCraftEXP("ZDPWLA_ITFO_SOUP", 100)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_SOUP", "Повар")
	
	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_Medovuha"); ----- Медовуха
	SetCraftAmount("ZDPWLA_ItFo_Medovuha", 59);
	 AddIngre("ZDPWLA_ItFo_Medovuha", "uhaxlk_itfo_honey", 7);
	 AddIngre("ZDPWLA_ItFo_Medovuha", "hfdpun_itpl_forestberry", 15);
	 AddIngre("ZDPWLA_ItFo_Medovuha", "aixopt_itmi_flask", 59);
    AddTool("ZDPWLA_ItFo_Medovuha", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Medovuha", 20);
	SetCraftScience("ZDPWLA_ItFo_Medovuha", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_Medovuha", 100);
	SetCraftEXP("ZDPWLA_ItFo_Medovuha", 100)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Medovuha", "Повар")	
	
	
	AddItemCategory ("Повар (1 уровень)", "aixopt_itmi_spice"); ----- Специи
	SetCraftAmount("aixopt_itmi_spice", 1);
	 AddIngre("aixopt_itmi_spice", "hfdpun_itpl_dex_herb_01", 1);
	 AddIngre("aixopt_itmi_spice", "hfdpun_itpl_blueplant", 15);
	 AddAlterIngre("aixopt_itmi_spice", "hfdpun_itfo_plants_trollberrys_01", 1)
	 AddAlterIngre("aixopt_itmi_spice", "HFDPUN_ITPL_RIVERMIRT", 4)
	SetCraftPenalty("aixopt_itmi_spice", 10);
	SetCraftScience("aixopt_itmi_spice", "Повар", 1);
	SetenergyPenalty("aixopt_itmi_spice", 50);
	SetCraftEXP("aixopt_itmi_spice", 50)
	SetCraftEXP_SKILL("aixopt_itmi_spice", "Повар")


	AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItMi_Vinegar"); ----- Уксус
	SetCraftAmount("ZDPWLA_ItMi_Vinegar", 5);
	 AddIngre("ZDPWLA_ItMi_Vinegar", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	 AddIngre("ZDPWLA_ItMi_Vinegar", "uhaxlk_itfo_wineberry", 10);
	 AddIngre("ZDPWLA_ItMi_Vinegar", "aixopt_itmi_flask", 5);
	SetCraftPenalty("ZDPWLA_ItMi_Vinegar", 5);
	SetCraftScience("ZDPWLA_ItMi_Vinegar", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItMi_Vinegar", 25);	
	SetCraftEXP("ZDPWLA_ItMi_Vinegar", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItMi_Vinegar", "Повар")
	
	
	AddItemCategory ("Повар (1 уровень)", "aixopt_itmi_dough"); ----- Тесто
	SetCraftAmount("aixopt_itmi_dough", 1);
	 AddIngre("aixopt_itmi_dough", "aixopt_itmi_flour", 1);
	 AddIngre("aixopt_itmi_dough", "uhaxlk_itfo_egg", 1);
	 AddIngre("aixopt_itmi_dough", "uhaxlk_itfo_milk", 5);
	SetCraftPenalty("aixopt_itmi_dough", 5);
	SetCraftScience("aixopt_itmi_dough", "Повар", 1);
	SetenergyPenalty("aixopt_itmi_dough", 25);
	SetCraftEXP("aixopt_itmi_dough", 25)
	SetCraftEXP_SKILL("aixopt_itmi_dough", "Повар")	
	
	
	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ITFO_BARBECUE"); ----- Шашлык
	SetCraftAmount("ZDPWLA_ITFO_BARBECUE", 13);
	 AddIngre("ZDPWLA_ITFO_BARBECUE", "uhaxlk_itfo_rawmeat", 18);
	 AddIngre("ZDPWLA_ITFO_BARBECUE", "aixopt_itmi_coal", 5);
	 AddIngre("ZDPWLA_ITFO_BARBECUE", "gkwqdz_ItMw_1h_Bau_Mace", 2);
    AddTool("ZDPWLA_ITFO_BARBECUE", "gkwqdz_itmw_huntknife");
	SetCraftPenalty("ZDPWLA_ITFO_BARBECUE", 10);
	SetCraftScience("ZDPWLA_ITFO_BARBECUE", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ITFO_BARBECUE", 50);
	SetCraftEXP("ZDPWLA_ITFO_BARBECUE", 100)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_BARBECUE", "Повар")		
	
	
	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_MushroomCutlet"); ----- Грибная котлета
    SetCraftAmount("ZDPWLA_ItFo_MushroomCutlet", 32);
     AddIngre("ZDPWLA_ItFo_MushroomCutlet", "ZDPWLA_ItFo_MushroomOffal", 3);
     AddIngre("ZDPWLA_ItFo_MushroomCutlet", "HFDPUN_ITPL_RIVERMIRT", 7);
     AddIngre("ZDPWLA_ItFo_MushroomCutlet", "aixopt_itmi_dough", 1);
    AddTool("ZDPWLA_ItFo_MushroomCutlet", "aixopt_itmi_pan");
    SetCraftPenalty("ZDPWLA_ItFo_MushroomCutlet", 10);
    SetCraftScience("ZDPWLA_ItFo_MushroomCutlet", "Повар", 2);
    SetenergyPenalty("ZDPWLA_ItFo_MushroomCutlet", 100);
    SetCraftEXP("ZDPWLA_ItFo_MushroomCutlet", 200)
    SetCraftEXP_SKILL("ZDPWLA_ItFo_MushroomCutlet", "Повар")	
	

	AddItemCategory ("Повар (2 уровень)", "uhaxlk_itfo_fishSouP"); ----- Уха
	SetCraftAmount("uhaxlk_itfo_fishSouP", 13);
     AddIngre("uhaxlk_itfo_fishSouP", "uhaxlk_itfo_fish", 30);
     AddIngre("uhaxlk_itfo_fishSouP", "HFDPUN_ITPL_RIVERMIRT", 4);
	 AddIngre("uhaxlk_itfo_fishSouP", "aixopt_itmi_flask", 13);
	 AddTool("uhaxlk_itfo_fishSouP", "aixopt_itmi_scoop");
	SetCraftPenalty("uhaxlk_itfo_fishSouP", 10);
	SetCraftScience("uhaxlk_itfo_fishSouP", "Повар", 2);
	SetenergyPenalty("uhaxlk_itfo_fishSouP", 100);
	SetCraftEXP("uhaxlk_itfo_fishSouP", 200)
	SetCraftEXP_SKILL("uhaxlk_itfo_fishSouP", "Повар")	
	

	AddItemCategory ("Повар (2 уровень)", "uhaxlk_itfo_wine"); ----- Вино
	SetCraftAmount("uhaxlk_itfo_wine", 31);
     AddIngre("uhaxlk_itfo_wine", "ZDPWLA_ItFo_GrapeJuice", 10);
	 AddIngre("uhaxlk_itfo_wine", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
     AddIngre("uhaxlk_itfo_wine", "aixopt_itmi_flask", 21);
	 AddTool("uhaxlk_itfo_wine", "aixopt_itmi_scoop");
	SetCraftPenalty("uhaxlk_itfo_wine", 20);
	SetCraftScience("uhaxlk_itfo_wine", "Повар", 2);
	SetenergyPenalty("uhaxlk_itfo_wine", 100);
	SetCraftEXP("uhaxlk_itfo_wine", 200)
	SetCraftEXP_SKILL("uhaxlk_itfo_wine", "Повар")	


	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_HoneyMeat"); ----- Мясо в медовом соусе
	SetCraftAmount("ZDPWLA_ItFo_HoneyMeat", 30);
     AddIngre("ZDPWLA_ItFo_HoneyMeat", "uhaxlk_itfo_rawmeat", 20);
	 AddIngre("ZDPWLA_ItFo_HoneyMeat", "uhaxlk_itfo_honey", 8);
     AddIngre("ZDPWLA_ItFo_HoneyMeat", "hfdpun_itfo_plants_trollberrys_01", 1);
	 AddTool("ZDPWLA_ItFo_HoneyMeat", "aixopt_itmi_pan");
	SetCraftPenalty("ZDPWLA_ItFo_HoneyMeat", 10);
	SetCraftScience("ZDPWLA_ItFo_HoneyMeat", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_HoneyMeat", 100);
	SetCraftEXP("ZDPWLA_ItFo_HoneyMeat", 200)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_HoneyMeat", "Повар")	


	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ITFO_MEATBUGPATE"); ----- Паштет из жуков
	SetCraftAmount("ZDPWLA_ITFO_MEATBUGPATE", 13);
     AddIngre("ZDPWLA_ITFO_MEATBUGPATE", "OOLTYB_ItAt_Meatbugflesh", 8);
	 AddIngre("ZDPWLA_ITFO_MEATBUGPATE", "ZDPWLA_ItMi_Vinegar", 1);
     AddIngre("ZDPWLA_ITFO_MEATBUGPATE", "HFDPUN_ITPL_SILTMIRT", 2);
	 AddTool("ZDPWLA_ITFO_MEATBUGPATE", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ITFO_MEATBUGPATE", 10);
	SetCraftScience("ZDPWLA_ITFO_MEATBUGPATE", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ITFO_MEATBUGPATE", 50);
	SetCraftEXP("ZDPWLA_ITFO_MEATBUGPATE", 100)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_MEATBUGPATE", "Повар")	
	

	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_AcornBread"); ----- Желудевый хлеб
	SetCraftAmount("ZDPWLA_ItFo_AcornBread", 52);
     AddIngre("ZDPWLA_ItFo_AcornBread", "aixopt_itmi_dough", 1);
	 AddIngre("ZDPWLA_ItFo_AcornBread", "hfdpun_itfo_plants_towerwood_01", 6);
     AddIngre("ZDPWLA_ItFo_AcornBread", "HFDPUN_ITPL_RIVERMIRT", 2);
	 AddTool("ZDPWLA_ItFo_AcornBread", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ItFo_AcornBread", 20);
	SetCraftScience("ZDPWLA_ItFo_AcornBread", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_AcornBread", 100);
	SetCraftEXP("ZDPWLA_ItFo_AcornBread", 200)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_AcornBread", "Повар")	


	AddItemCategory ("Повар (2 уровень)", "uhaxlk_itfo_booze"); ----- Джин
	SetCraftAmount("uhaxlk_itfo_booze", 26);
     AddIngre("uhaxlk_itfo_booze", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
     AddIngre("uhaxlk_itfo_booze", "hfdpun_itfo_plants_stoneroot_01", 1);
     AddIngre("uhaxlk_itfo_booze", "hfdpun_itpl_blueplant", 20);
     AddIngre("uhaxlk_itfo_booze", "aixopt_itmi_flask", 26);
	 AddTool("uhaxlk_itfo_booze", "aixopt_itmi_scoop");
	SetCraftPenalty("uhaxlk_itfo_booze", 10);
	SetCraftScience("uhaxlk_itfo_booze", "Повар", 2);
	SetenergyPenalty("uhaxlk_itfo_booze", 100);
	SetCraftEXP("uhaxlk_itfo_booze", 200)
	SetCraftEXP_SKILL("uhaxlk_itfo_booze", "Повар")


	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_BerryLiqueur"); ----- Ягодная наливка
	SetCraftAmount("ZDPWLA_ItFo_BerryLiqueur", 26);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "hfdpun_itpl_forestberry", 25);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "hfdpun_itpl_dex_herb_01", 1);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "aixopt_itmi_flask", 26);
	 AddTool("ZDPWLA_ItFo_BerryLiqueur", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ItFo_BerryLiqueur", 10);
	SetCraftScience("ZDPWLA_ItFo_BerryLiqueur", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_BerryLiqueur", 100);
	SetCraftEXP("ZDPWLA_ItFo_BerryLiqueur", 200)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_BerryLiqueur", "Повар")


	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ITFO_SEASALAD"); ----- Морской салат
	SetCraftAmount("ZDPWLA_ITFO_SEASALAD", 57);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "HFDPUN_ITPL_SILTMIRT", 4);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "ZDPWLA_ItMi_Vinegar", 1);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "ZDPWLA_ItFo_Addon_Shellflesh", 5);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "aixopt_itmi_flask", 57);
	 AddTool("ZDPWLA_ITFO_SEASALAD", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ITFO_SEASALAD", 10);
	SetCraftScience("ZDPWLA_ITFO_SEASALAD", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ITFO_SEASALAD", 100);
	SetCraftEXP("ZDPWLA_ITFO_SEASALAD", 200)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_SEASALAD", "Повар")


	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_MBlinchik"); ----- Блины с медом
	SetCraftAmount("ZDPWLA_ItFo_MBlinchik", 58);
	 AddIngre("ZDPWLA_ItFo_MBlinchik", "aixopt_itmi_dough", 2);
	 AddIngre("ZDPWLA_ItFo_MBlinchik", "uhaxlk_itfo_honey", 6);
	 AddIngre("ZDPWLA_ItFo_MBlinchik", "hfdpun_itpl_blueplant", 1);
	 AddTool("ZDPWLA_ItFo_MBlinchik", "aixopt_itmi_pan");
	SetCraftPenalty("ZDPWLA_ItFo_MBlinchik", 20);
	SetCraftScience("ZDPWLA_ItFo_MBlinchik", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_MBlinchik", 100);
	SetCraftEXP("ZDPWLA_ItFo_MBlinchik", 200)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_MBlinchik", "Повар")
	
	AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_Bomber"); ----- Бомбер
	SetCraftAmount("ZDPWLA_ItFo_Bomber", 13);
     AddIngre("ZDPWLA_ItFo_Bomber", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 3);
     AddIngre("ZDPWLA_ItFo_Bomber", "hfdpun_itpl_strength_herb_01", 1);
     AddIngre("ZDPWLA_ItFo_Bomber", "hfdpun_itpl_mana_herb_03", 1);
     AddIngre("ZDPWLA_ItFo_Bomber", "aixopt_itmi_flask", 13);
	 AddTool("ZDPWLA_ItFo_Bomber", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Bomber", 20);
	SetCraftScience("ZDPWLA_ItFo_Bomber", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_Bomber", 100);
	SetCraftEXP("ZDPWLA_ItFo_Bomber", 200)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Bomber", "Повар")
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Casserole"); ----- Фермерская запеканка
	SetCraftAmount("ZDPWLA_ItFo_Casserole", 11);
	 AddIngre("ZDPWLA_ItFo_Casserole", "uhaxlk_itfo_bread", 12);
	 AddIngre("ZDPWLA_ItFo_Casserole", "uhaxlk_itfo_cheese", 12);
	 AddIngre("ZDPWLA_ItFo_Casserole", "uhaxlk_itfo_rawmeat", 20);
	 AddTool("ZDPWLA_ItFo_Casserole", "aixopt_itmi_pan");
	SetCraftPenalty("ZDPWLA_ItFo_Casserole", 10);
	SetCraftScience("ZDPWLA_ItFo_Casserole", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Casserole", 50);
	
	
	AddItemCategory ("Повар (3 уровень)", "uhaxlk_itfo_wineStew"); ----- Тушеное мясо в вине
	SetCraftAmount("uhaxlk_itfo_wineStew", 18);
	 AddIngre("uhaxlk_itfo_wineStew", "uhaxlk_itfo_wine", 4);
	 AddIngre("uhaxlk_itfo_wineStew", "uhaxlk_itfo_rawmeat", 25);
	 AddIngre("uhaxlk_itfo_wineStew", "aixopt_itmi_spice", 1);
	 AddIngre("uhaxlk_itfo_wineStew", "aixopt_itmi_flask", 18);
	 AddTool("uhaxlk_itfo_wineStew", "aixopt_itmi_pan");
	SetCraftPenalty("uhaxlk_itfo_wineStew", 10);
	SetCraftScience("uhaxlk_itfo_wineStew", "Повар", 3);
	SetenergyPenalty("uhaxlk_itfo_wineStew", 100);		
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ITFO_FRIEDEGG"); ----- Яичница с колбасой
	SetCraftAmount("ZDPWLA_ITFO_FRIEDEGG", 9);
	 AddIngre("ZDPWLA_ITFO_FRIEDEGG", "uhaxlk_itfo_egg", 2);
	 AddIngre("ZDPWLA_ITFO_FRIEDEGG", "uhaxlk_itfo_sausage", 4);
	 AddIngre("ZDPWLA_ITFO_FRIEDEGG", "aixopt_itmi_flask", 8);
	 AddTool("ZDPWLA_ITFO_FRIEDEGG", "aixopt_itmi_pan");
	SetCraftPenalty("ZDPWLA_ITFO_FRIEDEGG", 5);
	SetCraftScience("ZDPWLA_ITFO_FRIEDEGG", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ITFO_FRIEDEGG", 25);		
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Bacon"); ----- Окорок
	SetCraftAmount("ZDPWLA_ItFo_Bacon", 32);
	 AddIngre("ZDPWLA_ItFo_Bacon", "uhaxlk_itfo_rawmeat", 20);
	 AddIngre("ZDPWLA_ItFo_Bacon", "aixopt_itmi_coal", 10);
	 AddIngre("ZDPWLA_ItFo_Bacon", "aixopt_itmi_spice", 1);
	 AddTool("ZDPWLA_ItFo_Bacon", "gkwqdz_itmw_huntknife");
	SetCraftPenalty("ZDPWLA_ItFo_Bacon", 10);
	SetCraftScience("ZDPWLA_ItFo_Bacon", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Bacon", 100);	
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_SmokedFish"); ----- Копченая рыба
	SetCraftAmount("ZDPWLA_ItFo_SmokedFish", 32);
	 AddIngre("ZDPWLA_ItFo_SmokedFish", "uhaxlk_itfo_fish", 20);
	 AddIngre("ZDPWLA_ItFo_SmokedFish", "aixopt_itmi_coal", 5);
	 AddIngre("ZDPWLA_ItFo_SmokedFish", "aixopt_itmi_spice", 1);
	 AddTool("ZDPWLA_ItFo_SmokedFish", "aixopt_itmi_pan");
	SetCraftPenalty("ZDPWLA_ItFo_SmokedFish", 10);
	SetCraftScience("ZDPWLA_ItFo_SmokedFish", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_SmokedFish", 100);		
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ITFO_HONEYBISCUIT"); ----- Медовое печенье
	SetCraftAmount("ZDPWLA_ITFO_HONEYBISCUIT", 180);
	 AddIngre("ZDPWLA_ITFO_HONEYBISCUIT", "aixopt_itmi_dough", 2);
	 AddIngre("ZDPWLA_ITFO_HONEYBISCUIT", "uhaxlk_itfo_honey", 8);
	 AddTool("ZDPWLA_ITFO_HONEYBISCUIT", "aixopt_itmi_pan");
	SetCraftPenalty("ZDPWLA_ITFO_HONEYBISCUIT", 20);
	SetCraftScience("ZDPWLA_ITFO_HONEYBISCUIT", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ITFO_HONEYBISCUIT", 100);			
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_BerryPie"); ----- Ягодный пирог
	SetCraftAmount("ZDPWLA_ItFo_BerryPie", 32);
	 AddIngre("ZDPWLA_ItFo_BerryPie", "aixopt_itmi_dough", 1);
	 AddIngre("ZDPWLA_ItFo_BerryPie", "hfdpun_itpl_forestberry", 10);
	 AddIngre("ZDPWLA_ItFo_BerryPie", "uhaxlk_itfo_wineberry", 5);
	 AddTool("ZDPWLA_ItFo_BerryPie", "aixopt_itmi_pan");
	SetCraftPenalty("ZDPWLA_ItFo_BerryPie", 10);
	SetCraftScience("ZDPWLA_ItFo_BerryPie", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_BerryPie", 50);		


	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_BeafPie"); ----- Пирог со шкварками
	SetCraftAmount("ZDPWLA_ItFo_BeafPie", 64);
	 AddIngre("ZDPWLA_ItFo_BeafPie", "aixopt_itmi_dough", 1);
	 AddIngre("ZDPWLA_ItFo_BeafPie", "aixopt_itat_fat", 3);
	 AddIngre("ZDPWLA_ItFo_BeafPie", "aixopt_itmi_spice", 1);
	 AddTool("ZDPWLA_ItFo_BeafPie", "aixopt_itmi_pan");
	SetCraftPenalty("ZDPWLA_ItFo_BeafPie", 20);
	SetCraftScience("ZDPWLA_ItFo_BeafPie", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_BeafPie", 100);	


	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_MagicSoup"); ----- Волшебный суп
	SetCraftAmount("ZDPWLA_ItFo_MagicSoup", 25);
	 AddIngre("ZDPWLA_ItFo_MagicSoup", "ZDPWLA_ItMi_Vinegar", 1);
	 AddIngre("ZDPWLA_ItFo_MagicSoup", "HFDPUN_ITPL_MUHOMOR", 4);
	 AddIngre("ZDPWLA_ItFo_MagicSoup", "ZDPWLA_ItFo_MushroomOffal", 9);
	 AddIngre("ZDPWLA_ItFo_MagicSoup", "aixopt_itmi_flask", 25);
	 AddTool("ZDPWLA_ItFo_MagicSoup", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ItFo_MagicSoup", 20);
	SetCraftScience("ZDPWLA_ItFo_MagicSoup", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_MagicSoup", 100);	
	
	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Addon_FireSteW"); ----- Пламенная нарезка
	SetCraftAmount("ZDPWLA_ItFo_Addon_FireSteW", 16);
	 AddIngre("ZDPWLA_ItFo_Addon_FireSteW", "aixopt_itat_waranfiretongue", 1); 
	 AddIngre("ZDPWLA_ItFo_Addon_FireSteW", "hfdpun_itpl_mana_herb_01", 3);
     AddIngre("ZDPWLA_ItFo_Addon_FireSteW", "ZDPWLA_ItMi_Vinegar", 1);	 
	 AddTool("ZDPWLA_ItFo_Addon_FireSteW", "aixopt_itmi_pan");
	SetCraftPenalty("ZDPWLA_ItFo_Addon_FireSteW", 10);
	SetCraftScience("ZDPWLA_ItFo_Addon_FireSteW", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Addon_FireSteW", 50);

	
	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ITFO_SHAURMA"); ----- Амброзия в лаваше
	SetCraftAmount("ZDPWLA_ITFO_SHAURMA", 16);
	 AddIngre("ZDPWLA_ITFO_SHAURMA", "aixopt_itmi_dough", 1); 
	 AddIngre("ZDPWLA_ITFO_SHAURMA", "aixopt_itmi_spice", 1);
     AddIngre("ZDPWLA_ITFO_SHAURMA", "uhaxlk_itfo_rawmeat", 16);	 
	 AddTool("ZDPWLA_ITFO_SHAURMA", "gkwqdz_itmw_huntknife");
	SetCraftPenalty("ZDPWLA_ITFO_SHAURMA", 20);
	SetCraftScience("ZDPWLA_ITFO_SHAURMA", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ITFO_SHAURMA", 100);
	

	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Managa"); ----- Манага
	SetCraftAmount("ZDPWLA_ItFo_Managa", 32);
	 AddIngre("ZDPWLA_ItFo_Managa", "uhaxlk_itfo_milk", 10);
	 AddIngre("ZDPWLA_ItFo_Managa", "hfdpun_itpl_swampherb", 15);
	 AddIngre("ZDPWLA_ItFo_Managa", "aixopt_itmi_spice", 1);
	 AddIngre("ZDPWLA_ItFo_Managa", "aixopt_itmi_flask", 32);
	 AddTool("ZDPWLA_ItFo_Managa", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Managa", 10);
	SetCraftScience("ZDPWLA_ItFo_Managa", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Managa", 100);	


	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Baron"); ----- Победа Дорра
	SetCraftAmount("ZDPWLA_ItFo_Baron", 32);
	 AddIngre("ZDPWLA_ItFo_Baron", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	 AddIngre("ZDPWLA_ItFo_Baron", "aixopt_itmi_spice", 1);
	 AddIngre("ZDPWLA_ItFo_Baron", "uhaxlk_itfo_milk", 15);
	 AddIngre("ZDPWLA_ItFo_Baron", "aixopt_itmi_flask", 32);
	 AddTool("ZDPWLA_ItFo_Baron", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Baron", 20);
	SetCraftScience("ZDPWLA_ItFo_Baron", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Baron", 100);	


	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Freedom"); ----- Глоток свободы
	SetCraftAmount("ZDPWLA_ItFo_Freedom", 17);
	 AddIngre("ZDPWLA_ItFo_Freedom", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	 AddIngre("ZDPWLA_ItFo_Freedom", "hfdpun_itpl_swampherb", 12);
	 AddIngre("ZDPWLA_ItFo_Freedom", "uhaxlk_itfo_honey", 4);
	 AddIngre("ZDPWLA_ItFo_Freedom", "aixopt_itmi_flask", 17);
	 AddTool("ZDPWLA_ItFo_Freedom", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Freedom", 10);
	SetCraftScience("ZDPWLA_ItFo_Freedom", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Freedom", 50);	


	AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_OysterSoup"); ----- Суп из устриц
	SetCraftAmount("ZDPWLA_ItFo_OysterSoup", 18);
	 AddIngre("ZDPWLA_ItFo_OysterSoup", "ZDPWLA_ItFo_Addon_Shellflesh", 2);
	 AddIngre("ZDPWLA_ItFo_OysterSoup", "ZDPWLA_ItMi_Vinegar", 1);
	 AddIngre("ZDPWLA_ItFo_OysterSoup", "aixopt_itmi_spice", 1);
	 AddIngre("ZDPWLA_ItFo_OysterSoup", "HFDPUN_ITPL_SILTMIRT", 5);
	 AddIngre("ZDPWLA_ItFo_OysterSoup", "aixopt_itmi_flask", 18);
	 AddTool("ZDPWLA_ItFo_OysterSoup", "aixopt_itmi_scoop");
	SetCraftPenalty("ZDPWLA_ItFo_OysterSoup", 20);
	SetCraftScience("ZDPWLA_ItFo_OysterSoup", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_OysterSoup", 100);	


--ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА


	AddItemCategory ("Алхимия (1 уровень)", "aixopt_itmi_joint_1");  ----- Зеленый послушник
	SetCraftAmount("aixopt_itmi_joint_1", 5);
	 AddIngre("aixopt_itmi_joint_1", "hfdpun_itpl_swampherb", 4);
	 AddTool("aixopt_itmi_joint_1", "AIXOPT_ItMi_UNIQUERECIPE");
	SetCraftPenalty("aixopt_itmi_joint_1", 5);
	SetCraftScience("aixopt_itmi_joint_1", "Алхимия", 1);
	SetenergyPenalty("aixopt_itmi_joint_1", 25);
	SetCraftEXP("aixopt_itmi_joint_1", 25)
	SetCraftEXP_SKILL("aixopt_itmi_joint_1", "Алхимия")

	AddItemCategory ("Алхимия (1 уровень)", "OOLTYB_ITMI_PRIPARKA");  ----- Лечебная припарка
	SetCraftAmount("OOLTYB_ITMI_PRIPARKA", 10);
	 AddIngre("OOLTYB_ITMI_PRIPARKA", "hfdpun_itpl_health_herb_01", 1);
	 AddIngre("OOLTYB_ITMI_PRIPARKA", "hfdpun_itfo_plants_mountainmoss_01", 1);
	 AddIngre("OOLTYB_ITMI_PRIPARKA", "aixopt_itat_fat", 1);
	 AddTool("OOLTYB_ITMI_PRIPARKA", "aixopt_itmi_scoop");
	SetCraftPenalty("OOLTYB_ITMI_PRIPARKA", 10);
	SetCraftScience("OOLTYB_ITMI_PRIPARKA", "Алхимия", 1);
	SetenergyPenalty("OOLTYB_ITMI_PRIPARKA", 50);
	SetCraftEXP("OOLTYB_ITMI_PRIPARKA", 50)
	SetCraftEXP_SKILL("OOLTYB_ITMI_PRIPARKA", "Алхимия")


	AddItemCategory ("Алхимия (1 уровень)", "cjcpgp_ItPo_Health_01");  ----- Лечебная эссенция
	SetCraftAmount("cjcpgp_ItPo_Health_01", 20);
	AddIngre("cjcpgp_ItPo_Health_01", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	AddIngre("cjcpgp_ItPo_Health_01", "hfdpun_itpl_health_herb_01", 8);
    AddIngre("cjcpgp_ItPo_Health_01", "aixopt_itmi_flask", 20);
	SetCraftPenalty("cjcpgp_ItPo_Health_01", 20);
	SetCraftScience("cjcpgp_ItPo_Health_01", "Алхимия", 1);
	SetenergyPenalty("cjcpgp_ItPo_Health_01", 100);
	SetCraftEXP("cjcpgp_ItPo_Health_01", 100)
	SetCraftEXP_SKILL("cjcpgp_ItPo_Health_01", "Алхимия")


	AddItemCategory ("Алхимия (1 уровень)", "cjcpgp_ItPo_Mana_01"); ---- Эссенция маны
	SetCraftAmount("cjcpgp_ItPo_Mana_01", 10);
	AddIngre("cjcpgp_ItPo_Mana_01", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	AddIngre("cjcpgp_ItPo_Mana_01", "hfdpun_itpl_mana_herb_01", 8);
	AddIngre("cjcpgp_ItPo_Mana_01", "aixopt_itmi_flask", 10);
	SetCraftPenalty("cjcpgp_ItPo_Mana_01", 20);
	SetCraftScience("cjcpgp_ItPo_Mana_01", "Алхимия", 1);
	SetenergyPenalty("cjcpgp_ItPo_Mana_01", 100);
	SetCraftEXP("cjcpgp_ItPo_Mana_01", 100)
	SetCraftEXP_SKILL("cjcpgp_ItPo_Mana_01", "Алхимия")


	AddItemCategory ("Алхимия (1 уровень)", "aixopt_itmi_tanning");  ---- Дубильный состав
	SetCraftAmount("aixopt_itmi_tanning", 2);
	AddIngre("aixopt_itmi_tanning", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	AddIngre("aixopt_itmi_tanning", "hfdpun_itfo_plants_towerwood_01", 5);
	SetCraftPenalty("aixopt_itmi_tanning", 10);
	SetCraftScience("aixopt_itmi_tanning", "Алхимия", 1);
	SetenergyPenalty("aixopt_itmi_tanning", 50);
	SetCraftEXP("aixopt_itmi_tanning", 50)
	SetCraftEXP_SKILL("aixopt_itmi_tanning", "Алхимия")
	

	AddItemCategory ("Алхимия (1 уровень)", "AIXOPT_ItMi_ALCHEMY_ALCOHOL");  ---- Спирт
	SetCraftAmount("AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	AddIngre("AIXOPT_ItMi_ALCHEMY_ALCOHOL", "hfdpun_itpl_temp_herb", 12);
	AddIngre("AIXOPT_ItMi_ALCHEMY_ALCOHOL", "aixopt_itmi_flask", 1);
	AddAlterIngre("AIXOPT_ItMi_ALCHEMY_ALCOHOL", "hfdpun_itpl_blueplant", 12);
	AddAlterIngre("AIXOPT_ItMi_ALCHEMY_ALCOHOL", "aixopt_itmi_flask", 1);
	SetCraftPenalty("AIXOPT_ItMi_ALCHEMY_ALCOHOL", 5);
	SetCraftScience("AIXOPT_ItMi_ALCHEMY_ALCOHOL", "Алхимия", 1);
	SetenergyPenalty("AIXOPT_ItMi_ALCHEMY_ALCOHOL", 20);
	SetCraftEXP("AIXOPT_ItMi_ALCHEMY_ALCOHOL", 20)
	SetCraftEXP_SKILL("AIXOPT_ItMi_ALCHEMY_ALCOHOL", "Алхимия")


	AddItemCategory ("Алхимия (1 уровень)", "aixopt_itmi_acid");  ---- Кислота
	SetCraftAmount("aixopt_itmi_acid", 2);
	AddIngre("aixopt_itmi_acid", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	AddIngre("aixopt_itmi_acid", "aixopt_itmi_sulfur", 5);
	SetCraftPenalty("aixopt_itmi_acid", 10);
	SetCraftScience("aixopt_itmi_acid", "Алхимия", 1);
	SetenergyPenalty("aixopt_itmi_acid", 50);
	SetCraftEXP("aixopt_itmi_acid", 50)
	SetCraftEXP_SKILL("aixopt_itmi_acid", "Алхимия")



	AddItemCategory ("Алхимия (1 уровень)", "aixopt_itmi_glue");  ---- Клей
	SetCraftAmount("aixopt_itmi_glue", 2);
	AddIngre("aixopt_itmi_glue", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	AddIngre("aixopt_itmi_glue", "aixopt_itmi_sulfur", 1);
	AddIngre("aixopt_itmi_glue", "aixopt_itmi_pitch", 3);	
	SetCraftPenalty("aixopt_itmi_glue", 10);
	SetCraftScience("aixopt_itmi_glue", "Алхимия", 1);
	SetenergyPenalty("aixopt_itmi_glue", 50);
	SetCraftEXP("aixopt_itmi_glue", 50)
	SetCraftEXP_SKILL("aixopt_itmi_glue", "Алхимия")


	AddItemCategory ("Алхимия (1 уровень)", "aixopt_itmi_dye");  ---- Краска
	SetCraftAmount("aixopt_itmi_dye", 2);
	AddIngre("aixopt_itmi_dye", "uhaxlk_itat_clamflesh", 2);
	AddIngre("aixopt_itmi_dye", "hfdpun_itfo_plants_nightshadow_02", 3);
	AddIngre("aixopt_itmi_dye", "hfdpun_itfo_plants_nightshadow_01", 3);	
	AddIngre("aixopt_itmi_dye", "uhaxlk_itfo_egg", 2);
	SetCraftPenalty("aixopt_itmi_dye", 10);
	SetCraftScience("aixopt_itmi_dye", "Алхимия", 1);
	SetenergyPenalty("aixopt_itmi_dye", 50);
	SetCraftEXP("aixopt_itmi_dye", 50)
	SetCraftEXP_SKILL("aixopt_itmi_dye", "Алхимия")


	AddItemCategory ("Алхимия (1 уровень)", "aixopt_itmi_alchbasis"); ----- Алхимическая основа
	SetCraftAmount("aixopt_itmi_alchbasis", 1);
	AddIngre("aixopt_itmi_alchbasis", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	AddIngre("aixopt_itmi_alchbasis", "HFDPUN_ITPL_SILTMIRT", 3);
	AddIngre("aixopt_itmi_alchbasis", "hfdpun_itfo_plants_stoneroot_01", 1);
	AddIngre("aixopt_itmi_alchbasis", "hfdpun_itfo_plants_nightshadow_01", 3);
	AddIngre("aixopt_itmi_alchbasis", "hfdpun_itpl_strength_herb_01", 1);
	AddIngre("aixopt_itmi_alchbasis", "hfdpun_itfo_plants_trollberrys_01", 1);
	AddAlterIngre("aixopt_itmi_alchbasis", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	AddAlterIngre("aixopt_itmi_alchbasis", "hfdpun_itpl_blueplant", 12);
    AddAlterIngre("aixopt_itmi_alchbasis", "hfdpun_itpl_perm_herb", 1);
	AddAlterIngre("aixopt_itmi_alchbasis", "hfdpun_itpl_dex_herb_01", 1);
	AddAlterIngre("aixopt_itmi_alchbasis", "hfdpun_itfo_plants_nightshadow_02", 3);
	AddAlterIngre("aixopt_itmi_alchbasis", "hfdpun_itfo_plants_mountainmoss_01", 2)
	SetCraftPenalty("aixopt_itmi_alchbasis", 10);
	SetCraftScience("aixopt_itmi_alchbasis", "Алхимия", 1);
	SetenergyPenalty("aixopt_itmi_alchbasis", 50);
	SetCraftEXP("aixopt_itmi_alchbasis", 50)
	SetCraftEXP_SKILL("aixopt_itmi_alchbasis", "Алхимия")


	AddItemCategory ("Алхимия (1 уровень)", "aixopt_itmi_alchsub"); ----- Алхимический субстрат
	SetCraftAmount("aixopt_itmi_alchsub", 1);
	AddIngre("aixopt_itmi_alchsub", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	AddIngre("aixopt_itmi_alchsub", "aixopt_itat_bugmandibles", 1);
	AddIngre("aixopt_itmi_alchsub", "aixopt_itat_sting", 1);
	AddIngre("aixopt_itmi_alchsub", "aixopt_itat_waranfiretongue", 1);
	AddIngre("aixopt_itmi_alchsub", "hfdpun_itfo_plants_stoneroot_01", 1);
	AddIngre("aixopt_itmi_alchsub", "hfdpun_itpl_perm_herb", 1);
	AddAlterIngre("aixopt_itmi_alchsub", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	AddAlterIngre("aixopt_itmi_alchsub", "aixopt_itat_crawlermandibles", 1);
    AddAlterIngre("aixopt_itmi_alchsub", "aixopt_itat_wing", 1);
	AddAlterIngre("aixopt_itmi_alchsub", "HFDPUN_ITPL_MUHOMOR", 1);
	AddAlterIngre("aixopt_itmi_alchsub", "hfdpun_itpl_strength_herb_01", 1);
	AddAlterIngre("aixopt_itmi_alchsub", "HFDPUN_ITPL_RIVERMIRT", 4)
	SetCraftPenalty("aixopt_itmi_alchsub", 10);
	SetCraftScience("aixopt_itmi_alchsub", "Алхимия", 1);
	SetenergyPenalty("aixopt_itmi_alchsub", 50);
	SetCraftEXP("aixopt_itmi_alchsub", 50)
	SetCraftEXP_SKILL("aixopt_itmi_alchsub", "Алхимия")


	AddItemCategory ("Алхимия (2 уровень)", "aixopt_itmi_joint_2");  ----- Северный темный
	SetCraftAmount("aixopt_itmi_joint_2", 6);
	 AddIngre("aixopt_itmi_joint_2", "hfdpun_itpl_swampherb", 3);
	 AddIngre("aixopt_itmi_joint_2", "hfdpun_itfo_plants_mountainmoss_01", 1);
	 AddTool("aixopt_itmi_joint_2", "aixopt_itmi_jointrecipe_01");
	SetCraftPenalty("aixopt_itmi_joint_2", 10);
	SetCraftScience("aixopt_itmi_joint_2", "Алхимия", 2);
	SetenergyPenalty("aixopt_itmi_joint_2", 50);
	SetCraftEXP("aixopt_itmi_joint_2", 100)
	SetCraftEXP_SKILL("aixopt_itmi_joint_2", "Алхимия")


	AddItemCategory ("Алхимия (2 уровень)", "OOLTYB_ITMI_APTEKA");  ----- Аптечка
	SetCraftAmount("OOLTYB_ITMI_APTEKA", 5);
	 AddIngre("OOLTYB_ITMI_APTEKA", "OOLTYB_ITMI_PRIPARKA", 1);
	 AddIngre("OOLTYB_ITMI_APTEKA", "OOLTYB_ITMI_BINT", 1);
	 AddIngre("OOLTYB_ITMI_APTEKA", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	 AddTool("OOLTYB_ITMI_APTEKA", "gkwqdz_itmw_huntknife");
	SetCraftPenalty("OOLTYB_ITMI_APTEKA", 10);
	SetCraftScience("OOLTYB_ITMI_APTEKA", "Алхимия", 2);
	SetenergyPenalty("OOLTYB_ITMI_APTEKA", 50);
	SetCraftEXP("OOLTYB_ITMI_APTEKA", 100)
	SetCraftEXP_SKILL("OOLTYB_ITMI_APTEKA", "Алхимия")


	AddItemCategory ("Алхимия (2 уровень)", "cjcpgp_ItPo_Health_02"); ----- Лечебный экстракт
	SetCraftAmount("cjcpgp_ItPo_Health_02", 30);
	AddIngre("cjcpgp_ItPo_Health_02", "aixopt_itmi_alchbasis", 1);
	AddIngre("cjcpgp_ItPo_Health_02", "hfdpun_itpl_health_herb_02", 5);
	AddIngre("cjcpgp_ItPo_Health_02", "aixopt_itmi_flask", 30);
	AddAlterIngre("cjcpgp_ItPo_Health_02", "aixopt_itmi_alchsub", 1);
	AddAlterIngre("cjcpgp_ItPo_Health_02", "hfdpun_itpl_health_herb_02", 5);
	AddAlterIngre("cjcpgp_ItPo_Health_02", "aixopt_itmi_flask", 30);
	SetCraftPenalty("cjcpgp_ItPo_Health_02", 20);
	SetCraftScience("cjcpgp_ItPo_Health_02", "Алхимия", 2);
	SetenergyPenalty("cjcpgp_ItPo_Health_02", 100);
	SetCraftEXP("cjcpgp_ItPo_Health_02", 200)
	SetCraftEXP_SKILL("cjcpgp_ItPo_Health_02", "Алхимия")


	AddItemCategory ("Алхимия (2 уровень)", "cjcpgp_ItPo_Mana_02"); --- Экстракт маны
	SetCraftAmount("cjcpgp_ItPo_Mana_02", 15);
	AddIngre("cjcpgp_ItPo_Mana_02", "aixopt_itmi_alchbasis", 1);
	AddIngre("cjcpgp_ItPo_Mana_02", "hfdpun_itpl_mana_herb_02", 5);
	AddIngre("cjcpgp_ItPo_Mana_02", "aixopt_itmi_flask", 15);
	AddAlterIngre("cjcpgp_ItPo_Mana_02", "aixopt_itmi_alchsub", 1);
	AddAlterIngre("cjcpgp_ItPo_Mana_02", "hfdpun_itpl_mana_herb_02", 5);
	AddAlterIngre("cjcpgp_ItPo_Mana_02", "aixopt_itmi_flask", 15);
	SetCraftPenalty("cjcpgp_ItPo_Mana_02", 20);
	SetCraftScience("cjcpgp_ItPo_Mana_02", "Алхимия", 2);
	SetenergyPenalty("cjcpgp_ItPo_Mana_02", 100);
	SetCraftEXP("cjcpgp_ItPo_Mana_02", 200)
	SetCraftEXP_SKILL("cjcpgp_ItPo_Mana_02", "Алхимия")


	AddItemCategory ("Алхимия (3 уровень)", "aixopt_itmi_joint_3");  ----- Мечта рудокопа
	SetCraftAmount("aixopt_itmi_joint_3", 7);
	 AddIngre("aixopt_itmi_joint_3", "hfdpun_itpl_swampherb", 8);
	 AddIngre("aixopt_itmi_joint_3", "HFDPUN_ITPL_MUHOMOR", 1);
	 AddTool("aixopt_itmi_joint_3", "aixopt_itmi_jointrecipe_01");
	SetCraftPenalty("aixopt_itmi_joint_3", 20);
	SetCraftScience("aixopt_itmi_joint_3", "Алхимия", 3);
	SetenergyPenalty("aixopt_itmi_joint_3", 100);
	
	
	AddItemCategory ("Алхимия (3 уровень)", "ZDPWLA_ItFo_Opus");  ----- Опус Максима
	SetCraftAmount("ZDPWLA_ItFo_Opus", 15);
	 AddIngre("ZDPWLA_ItFo_Opus", "aixopt_itmi_alchbasis", 1);
	 AddIngre("ZDPWLA_ItFo_Opus", "aixopt_itmi_alchsub", 1);
	 AddIngre("cjcpgp_ItPo_Health_03", "aixopt_itmi_flask", 15);
	 AddTool("ZDPWLA_ItFo_Opus", "OOLTYB_ITMI_OPUSRECIPE");
	SetCraftPenalty("ZDPWLA_ItFo_Opus", 20);
	SetCraftScience("ZDPWLA_ItFo_Opus", "Алхимия", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Opus", 100);	


	AddItemCategory ("Алхимия (3 уровень)", "cjcpgp_ItPo_Health_03"); ---- Лечебный эликсир
	SetCraftAmount("cjcpgp_ItPo_Health_03", 20);
	AddIngre("cjcpgp_ItPo_Health_03", "aixopt_itmi_alchbasis", 1);
	AddIngre("cjcpgp_ItPo_Health_03", "hfdpun_itpl_health_herb_03", 5);
	AddIngre("cjcpgp_ItPo_Health_03", "aixopt_itmi_flask", 20);
	AddAlterIngre("cjcpgp_ItPo_Health_03", "aixopt_itmi_alchsub", 1);
	AddAlterIngre("cjcpgp_ItPo_Health_03", "hfdpun_itpl_health_herb_03", 5);
	AddAlterIngre("cjcpgp_ItPo_Health_03", "aixopt_itmi_flask", 20);
	SetCraftPenalty("cjcpgp_ItPo_Health_03", 20);
	SetCraftScience("cjcpgp_ItPo_Health_03", "Алхимия", 3);
	SetenergyPenalty("cjcpgp_ItPo_Health_03", 100);


	AddItemCategory ("Алхимия (3 уровень)", "cjcpgp_ItPo_Mana_03"); ---- Эликсир маны
	SetCraftAmount("cjcpgp_ItPo_Mana_03", 10);
	AddIngre("cjcpgp_ItPo_Mana_03", "aixopt_itmi_alchbasis", 1);
	AddIngre("cjcpgp_ItPo_Mana_03", "hfdpun_itpl_mana_herb_03", 5);
	AddIngre("cjcpgp_ItPo_Mana_03", "aixopt_itmi_flask", 10);
	AddAlterIngre("cjcpgp_ItPo_Mana_03", "aixopt_itmi_alchsub", 1);
	AddAlterIngre("cjcpgp_ItPo_Mana_03", "hfdpun_itpl_mana_herb_03", 5);
	AddAlterIngre("cjcpgp_ItPo_Mana_03", "aixopt_itmi_flask", 10);
	SetCraftPenalty("cjcpgp_ItPo_Mana_03", 20);
	SetCraftScience("cjcpgp_ItPo_Mana_03", "Алхимия", 3);
	SetenergyPenalty("cjcpgp_ItPo_Mana_03", 100);
	

	AddItemCategory ("Алхимия (3 уровень)", "cjcpgp_itpo_poison_sleep");  ---- Снотворное
	SetCraftAmount("cjcpgp_itpo_poison_sleep", 1);
	AddIngre("cjcpgp_itpo_poison_sleep", "hfdpun_itpl_swampherb", 6);
	AddIngre("cjcpgp_itpo_poison_sleep", "hfdpun_itfo_plants_nightshadow_02", 5);
	AddIngre("cjcpgp_itpo_poison_sleep", "aixopt_itmi_flask", 1);
	SetCraftPenalty("cjcpgp_itpo_poison_sleep", 20);
	SetCraftScience("cjcpgp_itpo_poison_sleep", "Алхимия", 3);
	SetenergyPenalty("cjcpgp_itpo_poison_sleep", 100);

	
	AddItemCategory ("Алхимия (3 уровень)", "cjcpgp_itpo_poison_kill");  ---- Яд
	SetCraftAmount("cjcpgp_itpo_poison_kill", 1);
	AddIngre("cjcpgp_itpo_poison_kill", "aixopt_itat_sharkteeth", 1);
	AddIngre("cjcpgp_itpo_poison_kill", "aixopt_itat_sting", 1);
	AddIngre("cjcpgp_itpo_poison_kill", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 1);
	SetCraftPenalty("cjcpgp_itpo_poison_kill", 20);
	SetCraftScience("cjcpgp_itpo_poison_kill", "Алхимия", 3);
	SetenergyPenalty("cjcpgp_itpo_poison_kill", 100);
	
	
	AddItemCategory ("Алхимия (3 уровень)", "cjcpgp_ITPO_ANTIDOTE");  ---- Антидот
	SetCraftAmount("cjcpgp_ITPO_ANTIDOTE", 1);
	AddIngre("cjcpgp_ITPO_ANTIDOTE", "aixopt_itat_sharkteeth", 5);
	AddIngre("cjcpgp_ITPO_ANTIDOTE", "aixopt_itat_sting", 1);
	AddIngre("cjcpgp_ITPO_ANTIDOTE", "hfdpun_itpl_health_herb_03", 5);
	AddIngre("cjcpgp_ITPO_ANTIDOTE", "AIXOPT_ItMi_ALCHEMY_ALCOHOL", 3);
	SetCraftPenalty("cjcpgp_ITPO_ANTIDOTE", 20);
	SetCraftScience("cjcpgp_ITPO_ANTIDOTE", "Алхимия", 3);
	SetenergyPenalty("cjcpgp_ITPO_ANTIDOTE", 100);


--АААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААаа

	
	AddItemCategory ("Кузнец (Расходники)", "aixopt_itmi_ironingot"); ----- Слиток
	SetCraftAmount("aixopt_itmi_ironingot", 1);
	 AddIngre("aixopt_itmi_ironingot", "aixopt_itmi_ironnugget", 20);
	 AddIngre("aixopt_itmi_ironingot", "aixopt_itmi_coal", 5);
	 AddTool("aixopt_itmi_ironingot", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("aixopt_itmi_ironingot", 5);
	SetCraftScience("aixopt_itmi_ironingot", "Кузнец", 1);
	SetenergyPenalty("aixopt_itmi_ironingot", 25);
	SetCraftEXP("aixopt_itmi_ironingot", 25)
	SetCraftEXP_SKILL("aixopt_itmi_ironingot", "Бронник")
	SetCraftEXP("aixopt_itmi_ironingot", 25)
	SetCraftEXP_SKILL("aixopt_itmi_ironingot", "Оружейник")
	
	
	
	AddItemCategory ("Кузнец (Расходники)", "aixopt_itmi_rivet"); ----- Заклепка
	SetCraftAmount("aixopt_itmi_rivet", 10);
	 AddIngre("aixopt_itmi_rivet", "aixopt_itmi_ironingot", 1);
	 AddTool("aixopt_itmi_rivet", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("aixopt_itmi_rivet", 10);
	SetCraftScience("aixopt_itmi_rivet", "Кузнец", 1);
	SetenergyPenalty("aixopt_itmi_rivet", 25);
	SetCraftEXP("aixopt_itmi_rivet", 25)
	SetCraftEXP_SKILL("aixopt_itmi_rivet", "Бронник")
	SetCraftEXP("aixopt_itmi_rivet", 25)
	SetCraftEXP_SKILL("aixopt_itmi_rivet", "Оружейник")
	

	AddItemCategory ("Кузнец (Расходники)", "aixopt_itmi_jewelery"); ----- Бижутерия
	SetCraftAmount("aixopt_itmi_jewelery", 1);
	 AddIngre("aixopt_itmi_jewelery", "aixopt_itmi_ironingot", 1);
	 AddIngre("aixopt_itmi_jewelery", "aixopt_itmi_goldnugget", 2);
	 AddAlterIngre("aixopt_itmi_jewelery", "aixopt_itmi_ironingot", 1);
	 AddAlterIngre("aixopt_itmi_jewelery", "aixopt_itmi_silvernugget", 2);
	 AddTool("aixopt_itmi_jewelery", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("aixopt_itmi_jewelery", 10);
	SetCraftScience("aixopt_itmi_jewelery", "Кузнец", 1);
	SetenergyPenalty("aixopt_itmi_jewelery", 50);
	SetCraftEXP("aixopt_itmi_jewelery", 50)
	SetCraftEXP_SKILL("aixopt_itmi_jewelery", "Бронник")
	SetCraftEXP("aixopt_itmi_jewelery", 50)
	SetCraftEXP_SKILL("aixopt_itmi_jewelery", "Оружейник")
	
	
	AddItemCategory ("Кузнец (Расходники)", "aixopt_itmirawsteel"); ----- Обработанная сталь
	SetCraftAmount("aixopt_itmirawsteel", 1);
	 AddIngre("aixopt_itmirawsteel", "aixopt_itmi_ironingot", 1);
	 AddIngre("aixopt_itmirawsteel", "aixopt_itmi_acid", 1);
	 AddTool("aixopt_itmirawsteel", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("aixopt_itmirawsteel", 10);
	SetCraftScience("aixopt_itmirawsteel", "Кузнец", 1);
	SetenergyPenalty("aixopt_itmirawsteel", 50);
	SetCraftEXP("aixopt_itmirawsteel", 50)
	SetCraftEXP_SKILL("aixopt_itmirawsteel", "Бронник")
	SetCraftEXP("aixopt_itmirawsteel", 50)
	SetCraftEXP_SKILL("aixopt_itmirawsteel", "Оружейник")	
	
	
	AddItemCategory ("Кузнец (Расходники)", "aixopt_itmi_linkage"); --- Рычажный механизм
	SetCraftAmount("aixopt_itmi_linkage", 1);
	 AddIngre("aixopt_itmi_linkage", "aixopt_itmi_ironingot", 4);
	 AddTool("aixopt_itmi_linkage", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("aixopt_itmi_linkage", 10);
	SetCraftScience("aixopt_itmi_linkage", "Кузнец", 1);
	SetenergyPenalty("aixopt_itmi_linkage", 50);
	SetCraftEXP("aixopt_itmi_linkage", 50)
	SetCraftEXP_SKILL("aixopt_itmi_linkage", "Бронник")
	SetCraftEXP("aixopt_itmi_linkage", 50)
	SetCraftEXP_SKILL("aixopt_itmi_linkage", "Оружейник")
	
	
	-- AddItemCategory ("Кузнец (Расходники)", "ooltyb_itmi_rudecoin"); --- Рудная фишка
 --    SetCraftAmount("ooltyb_itmi_rudecoin", 10);
 --     AddIngre("ooltyb_itmi_rudecoin", "ooltyb_itmi_magicore", 1);
 --     AddTool("ooltyb_itmi_rudecoin", "OOLTYB_ITMI_CHIPRECIPE");
 --     AddTool("ooltyb_itmi_rudecoin", "gkwqdz_ItMw_1H_Mace_L_04");
 --    SetCraftPenalty("ooltyb_itmi_rudecoin", 5);
 --    SetCraftScience("ooltyb_itmi_rudecoin", "Кузнец", 1);
 --    SetenergyPenalty("ooltyb_itmi_rudecoin", 10);
 --    SetCraftEXP("ooltyb_itmi_rudecoin", 10)
 --    SetCraftEXP_SKILL("ooltyb_itmi_rudecoin", "Бронник")
 --    SetCraftEXP("ooltyb_itmi_rudecoin", 10)
 --    SetCraftEXP_SKILL("ooltyb_itmi_rudecoin", "Оружейник")
	
	AddItemCategory ("Кузнец (Расходники)", "aixopt_itmi_lock"); --- Замок
	SetCraftAmount("aixopt_itmi_lock", 1);
	 AddIngre("aixopt_itmi_lock", "aixopt_itmi_ironingot", 1);
	 AddTool("aixopt_itmi_lock", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("aixopt_itmi_lock", 5);
	SetCraftScience("aixopt_itmi_lock", "Кузнец", 1);
	SetenergyPenalty("aixopt_itmi_lock", 25);
	SetCraftEXP("aixopt_itmi_lock", 25)
	SetCraftEXP_SKILL("aixopt_itmi_lock", "Бронник")
	SetCraftEXP("aixopt_itmi_lock", 25)
	SetCraftEXP_SKILL("aixopt_itmi_lock", "Оружейник")
	
	AddItemCategory ("Кузнец (Расходники)", "aixopt_itmi_keydummy"); --- Болванка ключей
	SetCraftAmount("aixopt_itmi_keydummy", 5);
	 AddIngre("aixopt_itmi_keydummy", "aixopt_itmi_ironingot", 1);
	 AddTool("aixopt_itmi_keydummy", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("aixopt_itmi_keydummy", 5);
	SetCraftScience("aixopt_itmi_keydummy", "Кузнец", 1);
	SetenergyPenalty("aixopt_itmi_keydummy", 25);
	SetCraftEXP("aixopt_itmi_keydummy", 25)
	SetCraftEXP_SKILL("aixopt_itmi_keydummy", "Бронник")
	SetCraftEXP("aixopt_itmi_keydummy", 25)
	SetCraftEXP_SKILL("aixopt_itmi_keydummy", "Оружейник")
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	AddItemCategory ("Кузнец (Инструменты)", "qbduuo_itke_lockpick"); --- Отмычка
	SetCraftAmount("qbduuo_itke_lockpick", 3);
	 AddIngre("qbduuo_itke_lockpick", "aixopt_itmi_ironingot", 1);
	 AddTool("qbduuo_itke_lockpick", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("qbduuo_itke_lockpick", 5);
	SetCraftScience("qbduuo_itke_lockpick", "Кузнец", 1);
	SetenergyPenalty("qbduuo_itke_lockpick", 25);
	SetCraftEXP("qbduuo_itke_lockpick", 25)
	SetCraftEXP_SKILL("qbduuo_itke_lockpick", "Бронник")
	SetCraftEXP("qbduuo_itke_lockpick", 25)
	SetCraftEXP_SKILL("qbduuo_itke_lockpick", "Оружейник")

	AddItemCategory ("Кузнец (Инструменты)", "gkwqdz_ItMw_1h_Vlk_AxE"); ---- Топорик
	SetCraftAmount("gkwqdz_ItMw_1h_Vlk_AxE", 1);
	 AddIngre("gkwqdz_ItMw_1h_Vlk_Axe", "aixopt_itmi_ironnugget", 5);
	 AddIngre("gkwqdz_ItMw_1h_Vlk_Axe", "aixopt_itmi_rawwood", 5)
	 AddTool("gkwqdz_ItMw_1h_Vlk_Axe", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1h_Vlk_Axe", 2);
	SetCraftScience("gkwqdz_ItMw_1h_Vlk_Axe", "Кузнец", 1);
	SetenergyPenalty("gkwqdz_ItMw_1h_Vlk_Axe", 10);
	SetCraftEXP("gkwqdz_ItMw_1h_Vlk_Axe", 10)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1h_Vlk_Axe", "Бронник")
	SetCraftEXP("gkwqdz_ItMw_1h_Vlk_Axe", 10)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1h_Vlk_Axe", "Оружейник")	
	

	AddItemCategory ("Кузнец (Инструменты)", "aixopt_itmi_bucket"); ---- Ведро
	SetCraftAmount("aixopt_itmi_bucket", 1);
	 AddIngre("aixopt_itmi_bucket", "aixopt_itmi_ironnugget", 5);
	 AddIngre("aixopt_itmi_bucket", "aixopt_itmi_rawwood", 5)
	 AddTool("aixopt_itmi_bucket", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("aixopt_itmi_bucket", 2);
	SetCraftScience("aixopt_itmi_bucket", "Кузнец", 1);
	SetenergyPenalty("aixopt_itmi_bucket", 10);
	SetCraftEXP("aixopt_itmi_bucket", 10)
	SetCraftEXP_SKILL("aixopt_itmi_bucket", "Бронник")
	SetCraftEXP("aixopt_itmi_bucket", 10)
	SetCraftEXP_SKILL("aixopt_itmi_bucket", "Оружейник")


	AddItemCategory ("Кузнец (Инструменты)", "gkwqdz_itmw_pickaxe"); ---- Кирка
	SetCraftAmount("gkwqdz_itmw_pickaxe", 1);
	 AddIngre("gkwqdz_itmw_pickaxe", "aixopt_itmi_ironnugget", 5);
	 AddIngre("gkwqdz_itmw_pickaxe", "aixopt_itmi_rawwood", 5)
	 AddTool("gkwqdz_itmw_pickaxe", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_itmw_pickaxe", 2);
	SetCraftScience("gkwqdz_itmw_pickaxe", "Кузнец", 1);
	SetenergyPenalty("gkwqdz_itmw_pickaxe", 10);
	SetCraftEXP("gkwqdz_itmw_pickaxe", 10)
	SetCraftEXP_SKILL("gkwqdz_itmw_pickaxe", "Бронник")
	SetCraftEXP("gkwqdz_itmw_pickaxe", 10)
	SetCraftEXP_SKILL("gkwqdz_itmw_pickaxe", "Оружейник")
	
	
	AddItemCategory ("Кузнец (Инструменты)", "gkwqdz_itmw_sickle"); ---- Серп
	SetCraftAmount("gkwqdz_itmw_sickle", 1);
	 AddIngre("gkwqdz_itmw_sickle", "aixopt_itmi_ironnugget", 5);
	 AddIngre("gkwqdz_itmw_sickle", "aixopt_itmi_rawwood", 5)
	 AddTool("gkwqdz_itmw_sickle", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_itmw_sickle", 2);
	SetCraftScience("gkwqdz_itmw_sickle", "Кузнец", 1);
	SetenergyPenalty("gkwqdz_itmw_sickle", 10);
	SetCraftEXP("gkwqdz_itmw_sickle", 10)
	SetCraftEXP_SKILL("gkwqdz_itmw_sickle", "Бронник")
	SetCraftEXP("gkwqdz_itmw_sickle", 10)
	SetCraftEXP_SKILL("gkwqdz_itmw_sickle", "Оружейник")
	

	AddItemCategory ("Кузнец (Инструменты)", "gkwqdz_ItMw_1H_Mace_L_04"); ---- Кузнечный молот
	SetCraftAmount("gkwqdz_ItMw_1H_Mace_L_04", 1);
	 AddIngre("gkwqdz_ItMw_1H_Mace_L_04", "aixopt_itmi_ironnugget", 5);
	 AddIngre("gkwqdz_ItMw_1H_Mace_L_04", "aixopt_itmi_rawwood", 5)
	 AddTool("gkwqdz_ItMw_1H_Mace_L_04", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1H_Mace_L_04", 2);
	SetCraftScience("gkwqdz_ItMw_1H_Mace_L_04", "Кузнец", 1);
	SetenergyPenalty("gkwqdz_ItMw_1H_Mace_L_04", 10);
	SetCraftEXP("gkwqdz_ItMw_1H_Mace_L_04", 10)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1H_Mace_L_04", "Бронник")
	SetCraftEXP("gkwqdz_ItMw_1H_Mace_L_04", 10)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1H_Mace_L_04", "Оружейник")
	
	
	AddItemCategory ("Кузнец (Инструменты)", "aixopt_itmi_pan"); --- Сковородка
	SetCraftAmount("aixopt_itmi_pan", 1);
	 AddIngre("aixopt_itmi_pan", "aixopt_itmi_ironnugget", 5);
	 AddIngre("aixopt_itmi_pan", "aixopt_itmi_rawwood", 5)
	 AddTool("aixopt_itmi_pan", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("aixopt_itmi_pan", 2);
	SetCraftScience("aixopt_itmi_pan", "Кузнец", 1);
	SetenergyPenalty("aixopt_itmi_pan", 10);
	SetCraftEXP("aixopt_itmi_pan", 10)
	SetCraftEXP_SKILL("aixopt_itmi_pan", "Бронник")
	SetCraftEXP("aixopt_itmi_pan", 10)
	SetCraftEXP_SKILL("aixopt_itmi_pan", "Оружейник")
	
	
	AddItemCategory ("Кузнец (Инструменты)", "aixopt_itmi_saw"); ---- Пила
	SetCraftAmount("aixopt_itmi_saw", 1);
	 AddIngre("aixopt_itmi_saw", "aixopt_itmi_ironnugget", 5);
	 AddIngre("aixopt_itmi_saw", "aixopt_itmi_rawwood", 5)
	 AddTool("aixopt_itmi_saw", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("aixopt_itmi_saw", 2);
	SetCraftScience("aixopt_itmi_saw", "Кузнец", 1);
	SetenergyPenalty("aixopt_itmi_saw", 10);
	SetCraftEXP("aixopt_itmi_saw", 10)
	SetCraftEXP_SKILL("aixopt_itmi_saw", "Бронник")
	SetCraftEXP("aixopt_itmi_saw", 10)
	SetCraftEXP_SKILL("aixopt_itmi_saw", "Оружейник")	

	
	AddItemCategory ("Кузнец (Инструменты)", "AIXOPT_ItMi_Scissors"); ---- Ножницы
	SetCraftAmount("AIXOPT_ItMi_Scissors", 1);
	 AddIngre("AIXOPT_ItMi_Scissors", "aixopt_itmi_ironnugget", 5);
	 AddIngre("AIXOPT_ItMi_Scissors", "aixopt_itmi_rawwood", 5)
	 AddTool("AIXOPT_ItMi_Scissors", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("AIXOPT_ItMi_Scissors", 2);
	SetCraftScience("AIXOPT_ItMi_Scissors", "Кузнец", 1);
	SetenergyPenalty("AIXOPT_ItMi_Scissors", 10);
	SetCraftEXP("AIXOPT_ItMi_Scissors", 10)
	SetCraftEXP_SKILL("AIXOPT_ItMi_Scissors", "Бронник")
	SetCraftEXP("AIXOPT_ItMi_Scissors", 10)
	SetCraftEXP_SKILL("AIXOPT_ItMi_Scissors", "Оружейник")	


	AddItemCategory ("Кузнец (Инструменты)", "gkwqdz_itmw_huntknife"); ---- Нож
	SetCraftAmount("gkwqdz_itmw_huntknife", 1);
	 AddIngre("gkwqdz_itmw_huntknife", "aixopt_itmi_ironnugget", 5);
	 AddIngre("gkwqdz_itmw_huntknife", "aixopt_itmi_rawwood", 5)
	 AddTool("gkwqdz_itmw_huntknife", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_itmw_huntknife", 2);
	SetCraftScience("gkwqdz_itmw_huntknife", "Кузнец", 1);
	SetenergyPenalty("gkwqdz_itmw_huntknife", 10);
	SetCraftEXP("gkwqdz_itmw_huntknife", 10)
	SetCraftEXP_SKILL("gkwqdz_itmw_huntknife", "Бронник")
	SetCraftEXP("gkwqdz_itmw_huntknife", 10)
	SetCraftEXP_SKILL("gkwqdz_itmw_huntknife", "Оружейник")		
	
	
	AddItemCategory ("Кузнец (Инструменты)", "AIXOPT_ItMi_Needle"); --- Игла OOLTYB_ITMI_blank5
	SetCraftAmount("AIXOPT_ItMi_Needle", 1);
	 AddIngre("AIXOPT_ItMi_Needle", "aixopt_itmi_ironnugget", 5);
	 AddTool("AIXOPT_ItMi_Needle", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("AIXOPT_ItMi_Needle", 2);
	SetCraftScience("AIXOPT_ItMi_Needle", "Кузнец", 1);
	SetenergyPenalty("AIXOPT_ItMi_Needle", 10);	
	SetCraftEXP("AIXOPT_ItMi_Needle", 10)
	SetCraftEXP_SKILL("AIXOPT_ItMi_Needle", "Бронник")
	SetCraftEXP("AIXOPT_ItMi_Needle", 10)
	SetCraftEXP_SKILL("AIXOPT_ItMi_Needle", "Оружейник")	

	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА


	AddItemCategory ("(О)Кузнец (Без уровня)", "gkwqdz_ItMw_1h_Vlk_DaggeR"); ---- Кинжал
	SetCraftAmount("gkwqdz_ItMw_1h_Vlk_DaggeR", 1);
	 AddIngre("gkwqdz_ItMw_1h_Vlk_DaggeR", "aixopt_itmi_ironingot", 1);
	 AddTool("gkwqdz_ItMw_1h_Vlk_DaggeR", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1h_Vlk_DaggeR", 10);
	SetCraftScience("gkwqdz_ItMw_1h_Vlk_DaggeR", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_1h_Vlk_DaggeR", 10);
	SetCraftEXP("gkwqdz_ItMw_1h_Vlk_DaggeR", 10)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1h_Vlk_DaggeR", "Оружейник")


    AddItemCategory ("(О)Кузнец (Без уровня)", "gkwqdz_ItMw_1H_Sword_L_03"); ---- Волчий нож
	SetCraftAmount("gkwqdz_ItMw_1H_Sword_L_03", 1);
	 AddIngre("gkwqdz_ItMw_1H_Sword_L_03", "aixopt_itmi_ironingot", 1);
	 AddTool("gkwqdz_ItMw_1H_Sword_L_03", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1H_Sword_L_03", 10);
	SetCraftScience("gkwqdz_ItMw_1H_Sword_L_03", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_1H_Sword_L_03", 10);
	SetCraftEXP("gkwqdz_ItMw_1H_Sword_L_03", 10)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1H_Sword_L_03", "Оружейник")
	
	AddItemCategory ("(О)Кузнец (Без уровня)", "gkwqdz_itmw_lumberjack"); ---- Топор лесоруба
	SetCraftAmount("gkwqdz_itmw_lumberjack", 1);
	 AddIngre("gkwqdz_itmw_lumberjack", "aixopt_itmi_ironingot", 1);
	 AddTool("gkwqdz_itmw_lumberjack", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_itmw_lumberjack", 10);
	SetCraftScience("gkwqdz_itmw_lumberjack", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_itmw_lumberjack", 10);
	SetCraftEXP("gkwqdz_itmw_lumberjack", 10)
	SetCraftEXP_SKILL("gkwqdz_itmw_lumberjack", "Оружейник")
	
	AddItemCategory ("(О)Кузнец (Без уровня)", "gkwqdz_ItMw_Nagelkeule2"); ---- Тяжелая дубина с шипами
	SetCraftAmount("gkwqdz_ItMw_Nagelkeule2", 1);
	 AddIngre("gkwqdz_ItMw_Nagelkeule2", "aixopt_itmi_ironingot", 1);
	 AddTool("gkwqdz_ItMw_Nagelkeule2", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Nagelkeule2", 10);
	SetCraftScience("gkwqdz_ItMw_Nagelkeule2", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_Nagelkeule2", 10);
	SetCraftEXP("gkwqdz_ItMw_Nagelkeule2", 10)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Nagelkeule2", "Оружейник")
	
	AddItemCategory ("(О)Кузнец (Без уровня)", "gkwqdz_ItMw_Sense"); ---- Малая коса
	SetCraftAmount("gkwqdz_ItMw_Sense", 1);
	 AddIngre("gkwqdz_ItMw_Sense", "aixopt_itmi_ironingot", 1);
	 AddTool("gkwqdz_ItMw_Sense", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Sense", 10);
	SetCraftScience("gkwqdz_ItMw_Sense", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_Sense", 10);
	SetCraftEXP("gkwqdz_ItMw_Sense", 10)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Sense", "Оружейник")

	AddItemCategory ("(О)Кузнец (Без уровня)", "gkwqdz_ItMw_ShortSword1"); --- Короткий меч ополчения
	SetCraftAmount("gkwqdz_ItMw_ShortSword1", 1);
	 AddIngre("gkwqdz_ItMw_ShortSword1", "aixopt_itmi_ironingot", 1);
	 AddTool("gkwqdz_ItMw_ShortSword1", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_ShortSword1", 10);
	SetCraftScience("gkwqdz_ItMw_ShortSword1", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_ShortSword1", 10);
	SetCraftEXP("gkwqdz_ItMw_ShortSword1", 10)
	SetCraftEXP_SKILL("gkwqdz_ItMw_ShortSword1", "Оружейник")


	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_ItMw_ShortSword2"); --- Военный короткий меч
	SetCraftAmount("gkwqdz_ItMw_ShortSword2", 1);
	 AddIngre("gkwqdz_ItMw_ShortSword2", "aixopt_itmi_ironingot", 2);
	 AddTool("gkwqdz_ItMw_ShortSword2", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_ShortSword2", 10);
	SetCraftScience("gkwqdz_ItMw_ShortSword2", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_ShortSword2", 25);
	SetCraftEXP("gkwqdz_ItMw_ShortSword2", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_ShortSword2", "Оружейник")


	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_ItMw_1h_Vlk_SworD"); ---- Шпага
	SetCraftAmount("gkwqdz_ItMw_1h_Vlk_SworD", 1);
	 AddIngre("gkwqdz_ItMw_1h_Vlk_SworD", "aixopt_itmi_ironingot", 2);
	 AddTool("gkwqdz_ItMw_1h_Vlk_SworD", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1h_Vlk_SworD", 10);
	SetCraftScience("gkwqdz_ItMw_1h_Vlk_SworD", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_1h_Vlk_SworD", 25);
	SetCraftEXP("gkwqdz_ItMw_1h_Vlk_SworD", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1h_Vlk_SworD", "Оружейник")


	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_ItMw_1h_Sld_AxE"); ---- Солдатский топор
	SetCraftAmount("gkwqdz_ItMw_1h_Sld_AxE", 1);
	 AddIngre("gkwqdz_ItMw_1h_Sld_AxE", "aixopt_itmi_ironingot", 2);
	 AddTool("gkwqdz_ItMw_1h_Sld_AxE", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1h_Sld_AxE", 10);
	SetCraftScience("gkwqdz_ItMw_1h_Sld_AxE", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_1h_Sld_AxE", 25);
	SetCraftEXP("gkwqdz_ItMw_1h_Sld_AxE", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1h_Sld_AxE", "Оружейник")


	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_ItMw_ShortSword3"); --- Короткий меч
	SetCraftAmount("gkwqdz_ItMw_ShortSword3", 1);
	 AddIngre("gkwqdz_ItMw_ShortSword3", "aixopt_itmi_ironingot", 2);
	 AddTool("gkwqdz_ItMw_ShortSword3", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_ShortSword3", 10);
	SetCraftScience("gkwqdz_ItMw_ShortSword3", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_ShortSword3", 25);
	SetCraftEXP("gkwqdz_ItMw_ShortSword3", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_ShortSword3", "Оружейник")


	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_ItMw_ShortSword4"); --- Волчий зуб
	SetCraftAmount("gkwqdz_ItMw_ShortSword4", 1);
	 AddIngre("gkwqdz_ItMw_ShortSword4", "aixopt_itmi_ironingot", 2);
	 AddTool("gkwqdz_ItMw_ShortSword4", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_ShortSword4", 10);
	SetCraftScience("gkwqdz_ItMw_ShortSword4", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_ShortSword4", 25);
	SetCraftEXP("gkwqdz_ItMw_ShortSword4", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_ShortSword4", "Оружейник")
	
	
	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_ItMw_ShortSword5"); ---- Изысканный короткий меч
	SetCraftAmount("gkwqdz_ItMw_ShortSword5", 1);
	 AddIngre("gkwqdz_ItMw_ShortSword5", "aixopt_itmi_ironingot", 2);
	 AddTool("gkwqdz_ItMw_ShortSword5", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_ShortSword5", 10);
	SetCraftScience("gkwqdz_ItMw_ShortSword5", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_ShortSword5", 25);
	SetCraftEXP("gkwqdz_ItMw_ShortSword5", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_ShortSword5", "Оружейник")

	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_ItMw_SchiffsaxT"); --- корабельный топор
	SetCraftAmount("gkwqdz_ItMw_SchiffsaxT", 1);
     AddIngre("gkwqdz_ItMw_SchiffsaxT", "aixopt_itmi_ironingot", 2);
	 AddTool("gkwqdz_ItMw_SchiffsaxT", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_SchiffsaxT", 10);
	SetCraftScience("gkwqdz_ItMw_SchiffsaxT", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_SchiffsaxT", 25);
	SetCraftEXP("gkwqdz_ItMw_SchiffsaxT", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_SchiffsaxT", "Оружейник")
	
	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_ItMw_1H_Common_01"); --- Простой меч
	SetCraftAmount("gkwqdz_ItMw_1H_Common_01", 1);
	 AddIngre("gkwqdz_ItMw_1H_Common_01", "aixopt_itmi_ironingot", 2);
	 AddTool("gkwqdz_ItMw_1H_Common_01", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1H_Common_01", 10);
	SetCraftScience("gkwqdz_ItMw_1H_Common_01", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_1H_Common_01", 25);
	SetCraftEXP("gkwqdz_ItMw_1H_Common_01", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1H_Common_01", "Оружейник")
	
	
	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_itmw_finedagger"); ---- Хороший кинжал
	SetCraftAmount("gkwqdz_itmw_finedagger", 1);
	 AddIngre("gkwqdz_itmw_finedagger", "aixopt_itmi_ironingot", 2);
	 AddTool("gkwqdz_itmw_finedagger", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_itmw_finedagger", 10);
	SetCraftScience("gkwqdz_itmw_finedagger", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_itmw_finedagger", 25);
	SetCraftEXP("gkwqdz_itmw_finedagger", 50)
	SetCraftEXP_SKILL("gkwqdz_itmw_finedagger", "Оружейник")
	
	
	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_ItMw_Addon_PIR1hAxE"); ---- Абордажный топор
	SetCraftAmount("gkwqdz_ItMw_Addon_PIR1hAxE", 1);
	 AddIngre("gkwqdz_ItMw_Addon_PIR1hAxE", "aixopt_itmi_ironingot", 2);
	 AddTool("gkwqdz_ItMw_Addon_PIR1hAxE", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Addon_PIR1hAxE", 10);
	SetCraftScience("gkwqdz_ItMw_Addon_PIR1hAxE", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_Addon_PIR1hAxE", 25);
	SetCraftEXP("gkwqdz_ItMw_Addon_PIR1hAxE", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Addon_PIR1hAxE", "Оружейник")
	
	
	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_ItMw_HellebardE");  ---  Короткая алебадра
	SetCraftAmount("gkwqdz_ItMw_HellebardE", 1);
     AddIngre("gkwqdz_ItMw_HellebardE", "aixopt_itmi_ironingot", 2);
	 AddTool("gkwqdz_ItMw_HellebardE", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_HellebardE", 10);
	SetCraftScience("gkwqdz_ItMw_HellebardE", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_HellebardE", 25);
	SetCraftEXP("gkwqdz_ItMw_HellebardE", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_HellebardE", "Оружейник")


	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_ItMw_Stabkeule");  ---  Палица
	SetCraftAmount("gkwqdz_ItMw_Stabkeule", 1);
     AddIngre("gkwqdz_ItMw_Stabkeule", "aixopt_itmi_ironingot", 2);
	 AddTool("gkwqdz_ItMw_Stabkeule", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Stabkeule", 10);
	SetCraftScience("gkwqdz_ItMw_Stabkeule", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_Stabkeule", 25);
	SetCraftEXP("gkwqdz_ItMw_Stabkeule", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Stabkeule", "Оружейник")	
	
	
	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_ItMw_Zweihaender1"); ---- легкий двуручный меч
	SetCraftAmount("gkwqdz_ItMw_Zweihaender1", 1);
     AddIngre("gkwqdz_ItMw_Zweihaender1", "aixopt_itmi_ironingot", 2);
	 AddTool("gkwqdz_ItMw_Zweihaender1", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Zweihaender1", 10);
	SetCraftScience("gkwqdz_ItMw_Zweihaender1", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_Zweihaender1", 25);
	SetCraftEXP("gkwqdz_ItMw_Zweihaender1", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Zweihaender1", "Оружейник")		


	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_ItMw_Streitaxt1"); --- Легкий боевой топор
	SetCraftAmount("gkwqdz_ItMw_Streitaxt1", 1);
     AddIngre("gkwqdz_ItMw_Streitaxt1", "aixopt_itmi_ironingot", 2);;
	 AddTool("gkwqdz_ItMw_Streitaxt1", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Streitaxt1", 10);
	SetCraftScience("gkwqdz_ItMw_Streitaxt1", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_Streitaxt1", 25);
	SetCraftEXP("gkwqdz_ItMw_Streitaxt1", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Streitaxt1", "Оружейник")		


	AddItemCategory ("(О)Кузнец (1 уровень)", "gkwqdz_ItMw_Folteraxt"); --- Топор палача
	SetCraftAmount("gkwqdz_ItMw_Folteraxt", 1);
     AddIngre("gkwqdz_ItMw_Folteraxt", "aixopt_itmi_ironingot", 2);
	 AddTool("gkwqdz_ItMw_Folteraxt", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Folteraxt", 10);
	SetCraftScience("gkwqdz_ItMw_Folteraxt", "Оружейник", 1);
	SetenergyPenalty("gkwqdz_ItMw_Folteraxt", 25);	
	SetCraftEXP("gkwqdz_ItMw_Folteraxt", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Folteraxt", "Оружейник")
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_1h_Mil_SworD"); --- Грубый палаш
	SetCraftAmount("gkwqdz_ItMw_1h_Mil_SworD", 1);
	 AddIngre("gkwqdz_ItMw_1h_Mil_SworD", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_1h_Mil_SworD", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1h_Mil_SworD", 10);
	SetCraftScience("gkwqdz_ItMw_1h_Mil_SworD", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_1h_Mil_SworD", 50);
	SetCraftEXP("gkwqdz_ItMw_1h_Mil_SworD", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1h_Mil_SworD", "Оружейник")	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_1h_Sld_Sword"); --- Военный меч
	SetCraftAmount("gkwqdz_ItMw_1h_Sld_Sword", 1);
	 AddIngre("gkwqdz_ItMw_1h_Sld_Sword", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_1h_Sld_Sword", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1h_Sld_Sword", 10);
	SetCraftScience("gkwqdz_ItMw_1h_Sld_Sword", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_1h_Sld_Sword", 50);
	SetCraftEXP("gkwqdz_ItMw_1h_Sld_Sword", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1h_Sld_Sword", "Оружейник")	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Kriegskeule"); --- Военная дубина
	SetCraftAmount("gkwqdz_ItMw_Kriegskeule", 1);
	 AddIngre("gkwqdz_ItMw_Kriegskeule", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Kriegskeule", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Kriegskeule", 10);
	SetCraftScience("gkwqdz_ItMw_Kriegskeule", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Kriegskeule", 50);
	SetCraftEXP("gkwqdz_ItMw_Kriegskeule", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Kriegskeule", "Оружейник")	

	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Kriegshammer1"); --- Боевой молот
	SetCraftAmount("gkwqdz_ItMw_Kriegshammer1", 1);
	 AddIngre("gkwqdz_ItMw_Kriegshammer1", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Kriegshammer1", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Kriegshammer1", 10);
	SetCraftScience("gkwqdz_ItMw_Kriegshammer1", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Kriegshammer1", 50);
	SetCraftEXP("gkwqdz_ItMw_Kriegshammer1", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Kriegshammer1", "Оружейник")	
	

	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Piratensaebel"); --- Пиратская абордажная сабля
	SetCraftAmount("gkwqdz_ItMw_Piratensaebel", 1);
	 AddIngre("gkwqdz_ItMw_Piratensaebel", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Piratensaebel", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Piratensaebel", 10);
	SetCraftScience("gkwqdz_ItMw_Piratensaebel", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Piratensaebel", 50);
	SetCraftEXP("gkwqdz_ItMw_Piratensaebel", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Piratensaebel", "Оружейник")	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Schwert"); --- Грубый длинный меч
	SetCraftAmount("gkwqdz_ItMw_Schwert", 1);
	 AddIngre("gkwqdz_ItMw_Schwert", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Schwert", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Schwert", 10);
	SetCraftScience("gkwqdz_ItMw_Schwert", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Schwert", 50);
	SetCraftEXP("gkwqdz_ItMw_Schwert", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Schwert", "Оружейник")		


	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Steinbrecher"); --- Дробитель камней
	SetCraftAmount("gkwqdz_ItMw_Steinbrecher", 1);
	 AddIngre("gkwqdz_ItMw_Steinbrecher", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Steinbrecher", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Steinbrecher", 10);
	SetCraftScience("gkwqdz_ItMw_Steinbrecher", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Steinbrecher", 50);
	SetCraftEXP("gkwqdz_ItMw_Steinbrecher", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Steinbrecher", "Оружейник")		
	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Spicker"); --- Раскалыватель черепов
	SetCraftAmount("gkwqdz_ItMw_Spicker", 1);
	 AddIngre("gkwqdz_ItMw_Spicker", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Spicker", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Spicker", 10);
	SetCraftScience("gkwqdz_ItMw_Spicker", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Spicker", 50);
	SetCraftEXP("gkwqdz_ItMw_Spicker", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Spicker", "Оружейник")	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Schwert1"); --- Изысканный меч
	SetCraftAmount("gkwqdz_ItMw_Schwert1", 1);
	 AddIngre("gkwqdz_ItMw_Schwert1", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Schwert1", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Schwert1", 10);
	SetCraftScience("gkwqdz_ItMw_Schwert1", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Schwert1", 50);
	SetCraftEXP("gkwqdz_ItMw_Schwert1", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Schwert1", "Оружейник")	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Schwert2"); --- Длинный меч
	SetCraftAmount("gkwqdz_ItMw_Schwert2", 1);
	 AddIngre("gkwqdz_ItMw_Schwert2", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Schwert2", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Schwert2", 10);
	SetCraftScience("gkwqdz_ItMw_Schwert2", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Schwert2", 50);
	SetCraftEXP("gkwqdz_ItMw_Schwert2", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Schwert2", "Оружейник")	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Schwert3"); --- Грубый полуторный меч
	SetCraftAmount("gkwqdz_ItMw_Schwert3", 1);
	 AddIngre("gkwqdz_ItMw_Schwert3", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Schwert3", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Schwert3", 10);
	SetCraftScience("gkwqdz_ItMw_Schwert3", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Schwert3", 50);
	SetCraftEXP("gkwqdz_ItMw_Schwert3", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Schwert3", "Оружейник")	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Rapier"); --- Рапира
	SetCraftAmount("gkwqdz_ItMw_Rapier", 1);
	 AddIngre("gkwqdz_ItMw_Rapier", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Rapier", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Rapier", 10);
	SetCraftScience("gkwqdz_ItMw_Rapier", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Rapier", 50);
	SetCraftEXP("gkwqdz_ItMw_Rapier", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Rapier", "Оружейник")	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Rubinklinge"); --- Рубиновый клинок
	SetCraftAmount("gkwqdz_ItMw_Rubinklinge", 1);
	 AddIngre("gkwqdz_ItMw_Rubinklinge", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Rubinklinge", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Rubinklinge", 10);
	SetCraftScience("gkwqdz_ItMw_Rubinklinge", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Rubinklinge", 50);
	SetCraftEXP("gkwqdz_ItMw_Rubinklinge", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Rubinklinge", "Оружейник")	


	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_1H_Special_01"); --- Длинный рудный меч
	SetCraftAmount("gkwqdz_ItMw_1H_Special_01", 1);
	 AddIngre("gkwqdz_ItMw_1H_Special_01", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_1H_Special_01", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1H_Special_01", 10);
	SetCraftScience("gkwqdz_ItMw_1H_Special_01", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_1H_Special_01", 50);
	SetCraftEXP("gkwqdz_ItMw_1H_Special_01", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1H_Special_01", "Оружейник")		
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_itmw_addon_pir1hsword"); --- Абордажная сабля
	SetCraftAmount("gkwqdz_itmw_addon_pir1hsword", 1);
	 AddIngre("gkwqdz_itmw_addon_pir1hsword", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_itmw_addon_pir1hsword", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_itmw_addon_pir1hsword", 10);
	SetCraftScience("gkwqdz_itmw_addon_pir1hsword", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_itmw_addon_pir1hsword", 50);
	SetCraftEXP("gkwqdz_itmw_addon_pir1hsword", 150)
	SetCraftEXP_SKILL("gkwqdz_itmw_addon_pir1hsword", "Оружейник")	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_itmw_addon_hacker_1h_01"); --- Мачете
	SetCraftAmount("gkwqdz_itmw_addon_hacker_1h_01", 1);
	 AddIngre("gkwqdz_itmw_addon_hacker_1h_01", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_itmw_addon_hacker_1h_01", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_itmw_addon_hacker_1h_01", 10);
	SetCraftScience("gkwqdz_itmw_addon_hacker_1h_01", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_itmw_addon_hacker_1h_01", 50);
	SetCraftEXP("gkwqdz_itmw_addon_hacker_1h_01", 150)
	SetCraftEXP_SKILL("gkwqdz_itmw_addon_hacker_1h_01", "Оружейник")	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_2h_Sld_Axe"); --- Тяжелый солдатский топор
	SetCraftAmount("gkwqdz_ItMw_2h_Sld_Axe", 1);
	 AddIngre("gkwqdz_ItMw_2h_Sld_Axe", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_2h_Sld_Axe", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_2h_Sld_Axe", 10);
	SetCraftScience("gkwqdz_ItMw_2h_Sld_Axe", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_2h_Sld_Axe", 50);	
	SetCraftEXP("gkwqdz_ItMw_2h_Sld_Axe", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_2h_Sld_Axe", "Оружейник")
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_2h_Sld_Sword"); --- Солдатский двуручный меч
	SetCraftAmount("gkwqdz_ItMw_2h_Sld_Sword", 1);
	 AddIngre("gkwqdz_ItMw_2h_Sld_Sword", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_2h_Sld_Sword", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_2h_Sld_Sword", 10);
	SetCraftScience("gkwqdz_ItMw_2h_Sld_Sword", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_2h_Sld_Sword", 50);
	SetCraftEXP("gkwqdz_ItMw_2h_Sld_Sword", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_2h_Sld_Sword", "Оружейник")	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_2h_Pal_Sword"); --- Изыскнный двуручный меч
	SetCraftAmount("gkwqdz_ItMw_2h_Pal_Sword", 1);
	 AddIngre("gkwqdz_ItMw_2h_Pal_Sword", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_2h_Pal_Sword", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_2h_Pal_Sword", 10);
	SetCraftScience("gkwqdz_ItMw_2h_Pal_Sword", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_2h_Pal_Sword", 50);
	SetCraftEXP("gkwqdz_ItMw_2h_Pal_Sword", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_2h_Pal_Sword", "Оружейник")	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Zweihaender2"); --- Двуручный меч
	SetCraftAmount("gkwqdz_ItMw_Zweihaender2", 1);
	 AddIngre("gkwqdz_ItMw_Zweihaender2", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Zweihaender2", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Zweihaender2", 10);
	SetCraftScience("gkwqdz_ItMw_Zweihaender2", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Zweihaender2", 50);
	SetCraftEXP("gkwqdz_ItMw_Zweihaender2", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Zweihaender2", "Оружейник")	
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Streitaxt2"); --- Боевой топор
	SetCraftAmount("gkwqdz_ItMw_Streitaxt2", 1);
	 AddIngre("gkwqdz_ItMw_Streitaxt2", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Streitaxt2", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Streitaxt2", 10);
	SetCraftScience("gkwqdz_ItMw_Streitaxt2", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Streitaxt2", 50);	
	SetCraftEXP("gkwqdz_ItMw_Streitaxt2", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Streitaxt2", "Оружейник")
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Zweihaender4"); --- Тяжелый двуручный меч
	SetCraftAmount("gkwqdz_ItMw_Zweihaender4", 1);
	 AddIngre("gkwqdz_ItMw_Zweihaender4", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Zweihaender4", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Zweihaender4", 10);
	SetCraftScience("gkwqdz_ItMw_Zweihaender4", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Zweihaender4", 50);
	SetCraftEXP("gkwqdz_ItMw_Zweihaender4", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Zweihaender4", "Оружейник")
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_ItMw_Schlachtaxt"); --- Военный топор
	SetCraftAmount("gkwqdz_ItMw_Schlachtaxt", 1);
	 AddIngre("gkwqdz_ItMw_Schlachtaxt", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_ItMw_Schlachtaxt", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Schlachtaxt", 10);
	SetCraftScience("gkwqdz_ItMw_Schlachtaxt", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Schlachtaxt", 50);
	SetCraftEXP("gkwqdz_ItMw_Schlachtaxt", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Schlachtaxt", "Оружейник")
	
	
	AddItemCategory ("(О)Кузнец (2 уровень)", "gkwqdz_itmw_addon_hacker_2h_01"); --- Гигантское мачете
	SetCraftAmount("gkwqdz_itmw_addon_hacker_2h_01", 1);
	 AddIngre("gkwqdz_itmw_addon_hacker_2h_01", "aixopt_itmi_ironingot", 5);
	 AddTool("gkwqdz_itmw_addon_hacker_2h_01", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_itmw_addon_hacker_2h_01", 10);
	SetCraftScience("gkwqdz_itmw_addon_hacker_2h_01", "Оружейник", 2);
	SetenergyPenalty("gkwqdz_itmw_addon_hacker_2h_01", 50);
	SetCraftEXP("gkwqdz_itmw_addon_hacker_2h_01", 150)
	SetCraftEXP_SKILL("gkwqdz_itmw_addon_hacker_2h_01", "Оружейник")

	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Morgenstern"); --- Булава с шипами
	SetCraftAmount("gkwqdz_ItMw_Morgenstern", 1);
	 AddIngre("gkwqdz_ItMw_Morgenstern", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Morgenstern", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_Morgenstern", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_Morgenstern", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_Morgenstern", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Morgenstern", 20);
	SetCraftScience("gkwqdz_ItMw_Morgenstern", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Morgenstern", 100);	
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Doppelaxt"); --- Двойной топор
	SetCraftAmount("gkwqdz_ItMw_Doppelaxt", 1);
	 AddIngre("gkwqdz_ItMw_Doppelaxt", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Doppelaxt", "aixopt_itmirawsteel", 4);
	 AddIngre("gkwqdz_ItMw_Doppelaxt", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_Doppelaxt", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_Doppelaxt", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Doppelaxt", 20);
	SetCraftScience("gkwqdz_ItMw_Doppelaxt", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Doppelaxt", 100);	
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_1h_Pal_Sword"); --- Меч офицера
	SetCraftAmount("gkwqdz_ItMw_1h_Pal_Sword", 1);
	 AddIngre("gkwqdz_ItMw_1h_Pal_Sword", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_1h_Pal_Sword", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_1h_Pal_Sword", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_1h_Pal_Sword", "aixopt_itmi_aquamarine", 1);
	 AddAlterIngre("gkwqdz_ItMw_1h_Pal_Sword", "aixopt_itmi_ironingot", 10);
	 AddAlterIngre("gkwqdz_ItMw_1h_Pal_Sword", "aixopt_itmirawsteel", 5);
	 AddAlterIngre("gkwqdz_ItMw_1h_Pal_Sword", "aixopt_itmi_handle", 1);
	 AddAlterIngre("gkwqdz_ItMw_1h_Pal_Sword", "aixopt_itmi_rubin", 1);
	 AddTool("gkwqdz_ItMw_1h_Pal_Sword", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1h_Pal_Sword", 20);
	SetCraftScience("gkwqdz_ItMw_1h_Pal_Sword", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_1h_Pal_Sword", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Bartaxt"); --- Короткий бердыш
	SetCraftAmount("gkwqdz_ItMw_Bartaxt", 1);
	 AddIngre("gkwqdz_ItMw_Bartaxt", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Bartaxt", "aixopt_itmirawsteel", 4);
	 AddIngre("gkwqdz_ItMw_Bartaxt", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_Bartaxt", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_Bartaxt", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Bartaxt", 20);
	SetCraftScience("gkwqdz_ItMw_Bartaxt", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Bartaxt", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Schwert4"); --- Изысканный длинный меч
	SetCraftAmount("gkwqdz_ItMw_Schwert4", 1);
	 AddIngre("gkwqdz_ItMw_Schwert4", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Schwert4", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_Schwert4", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_Schwert4", "aixopt_itmi_aquamarine", 1);
	 AddAlterIngre("gkwqdz_ItMw_Schwert4", "aixopt_itmi_ironingot", 10);
	 AddAlterIngre("gkwqdz_ItMw_Schwert4", "aixopt_itmirawsteel", 5);
	 AddAlterIngre("gkwqdz_ItMw_Schwert4", "aixopt_itmi_handle", 1);
	 AddAlterIngre("gkwqdz_ItMw_Schwert4", "aixopt_itmi_rubin", 1);
	 AddTool("gkwqdz_ItMw_Schwert4", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Schwert4", 20);
	SetCraftScience("gkwqdz_ItMw_Schwert4", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Schwert4", 100);			
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Streitkolben"); --- Булава
	SetCraftAmount("gkwqdz_ItMw_Streitkolben", 1);
	 AddIngre("gkwqdz_ItMw_Streitkolben", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Streitkolben", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_Streitkolben", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_Streitkolben", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_Streitkolben", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Streitkolben", 20);
	SetCraftScience("gkwqdz_ItMw_Streitkolben", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Streitkolben", 100);	
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Runenschwert"); --- Лунный меч
	SetCraftAmount("gkwqdz_ItMw_Runenschwert", 1);
	 AddIngre("gkwqdz_ItMw_Runenschwert", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Runenschwert", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_Runenschwert", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_Runenschwert", "aixopt_itmi_aquamarine", 1);
	 AddAlterIngre("gkwqdz_ItMw_Runenschwert", "aixopt_itmi_ironingot", 10);
	 AddAlterIngre("gkwqdz_ItMw_Runenschwert", "aixopt_itmirawsteel", 5);
	 AddAlterIngre("gkwqdz_ItMw_Runenschwert", "aixopt_itmi_handle", 1);
	 AddAlterIngre("gkwqdz_ItMw_Runenschwert", "aixopt_itmi_rubin", 1);
	 AddTool("gkwqdz_ItMw_Runenschwert", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Runenschwert", 20);
	SetCraftScience("gkwqdz_ItMw_Runenschwert", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Runenschwert", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Rabenschnabel"); --- Клюв ворона
	SetCraftAmount("gkwqdz_ItMw_Rabenschnabel", 1);
	 AddIngre("gkwqdz_ItMw_Rabenschnabel", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Rabenschnabel", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_Rabenschnabel", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_Rabenschnabel", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_Rabenschnabel", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Rabenschnabel", 20);
	SetCraftScience("gkwqdz_ItMw_Rabenschnabel", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Rabenschnabel", 100);	
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Schwert5"); --- Изысканный полуторный меч
	SetCraftAmount("gkwqdz_ItMw_Schwert5", 1);
	 AddIngre("gkwqdz_ItMw_Schwert5", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Schwert5", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_Schwert5", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_Schwert5", "aixopt_itmi_aquamarine", 1);
	 AddAlterIngre("gkwqdz_ItMw_Schwert5", "aixopt_itmi_ironingot", 10);
	 AddAlterIngre("gkwqdz_ItMw_Schwert5", "aixopt_itmirawsteel", 5);
	 AddAlterIngre("gkwqdz_ItMw_Schwert5", "aixopt_itmi_handle", 1);
	 AddAlterIngre("gkwqdz_ItMw_Schwert5", "aixopt_itmi_rubin", 1);
	 AddTool("gkwqdz_ItMw_Schwert5", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Schwert5", 20);
	SetCraftScience("gkwqdz_ItMw_Schwert5", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Schwert5", 100);
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Inquisitor"); --- Инквизитор
	SetCraftAmount("gkwqdz_ItMw_Inquisitor", 1);
	 AddIngre("gkwqdz_ItMw_Inquisitor", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Inquisitor", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_Inquisitor", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_Inquisitor", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_Inquisitor", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Inquisitor", 20);
	SetCraftScience("gkwqdz_ItMw_Inquisitor", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Inquisitor", 100);	
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_ElBastardo"); --- Эль-бастардо
	SetCraftAmount("gkwqdz_ItMw_ElBastardo", 1);
	 AddIngre("gkwqdz_ItMw_ElBastardo", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_ElBastardo", "aixopt_itmirawsteel", 4);
	 AddIngre("gkwqdz_ItMw_ElBastardo", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_ElBastardo", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_ElBastardo", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_ElBastardo", 20);
	SetCraftScience("gkwqdz_ItMw_ElBastardo", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_ElBastardo", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Kriegshammer2"); --- Тяжелый боевой молот
	SetCraftAmount("gkwqdz_ItMw_Kriegshammer2", 1);
	 AddIngre("gkwqdz_ItMw_Kriegshammer2", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Kriegshammer2", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_Kriegshammer2", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_Kriegshammer2", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_Kriegshammer2", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Kriegshammer2", 20);
	SetCraftScience("gkwqdz_ItMw_Kriegshammer2", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Kriegshammer2", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Meisterdegen"); --- Шпага мастера
	SetCraftAmount("gkwqdz_ItMw_Meisterdegen", 1);
	 AddIngre("gkwqdz_ItMw_Meisterdegen", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Meisterdegen", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_Meisterdegen", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_Meisterdegen", "aixopt_itmi_aquamarine", 1);
	 AddAlterIngre("gkwqdz_ItMw_Meisterdegen", "aixopt_itmi_ironingot", 10);
	 AddAlterIngre("gkwqdz_ItMw_Meisterdegen", "aixopt_itmirawsteel", 5);
	 AddAlterIngre("gkwqdz_ItMw_Meisterdegen", "aixopt_itmi_handle", 1);
	 AddAlterIngre("gkwqdz_ItMw_Meisterdegen", "aixopt_itmi_rubin", 1);
	 AddTool("gkwqdz_ItMw_Meisterdegen", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Meisterdegen", 20);
	SetCraftScience("gkwqdz_ItMw_Meisterdegen", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Meisterdegen", 100);	
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Orkschlaechter"); --- Убийца орков
	SetCraftAmount("gkwqdz_ItMw_Orkschlaechter", 1);
	 AddIngre("gkwqdz_ItMw_Orkschlaechter", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Orkschlaechter", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_Orkschlaechter", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_Orkschlaechter", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_Orkschlaechter", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Orkschlaechter", 20);
	SetCraftScience("gkwqdz_ItMw_Orkschlaechter", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Orkschlaechter", 100);			
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_1H_Blessed_01"); --- Одноручный рудный клинок
	SetCraftAmount("gkwqdz_ItMw_1H_Blessed_01", 1);
	 AddIngre("gkwqdz_ItMw_1H_Blessed_01", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_1H_Blessed_01", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_1H_Blessed_01", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_1H_Blessed_01", "aixopt_itmi_aquamarine", 1);
	 AddAlterIngre("gkwqdz_ItMw_1H_Blessed_01", "aixopt_itmi_ironingot", 10);
	 AddAlterIngre("gkwqdz_ItMw_1H_Blessed_01", "aixopt_itmirawsteel", 5);
	 AddAlterIngre("gkwqdz_ItMw_1H_Blessed_01", "aixopt_itmi_handle", 1);
	 AddAlterIngre("gkwqdz_ItMw_1H_Blessed_01", "aixopt_itmi_rubin", 1);
	 AddTool("gkwqdz_ItMw_1H_Blessed_01", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1H_Blessed_01", 20);
	SetCraftScience("gkwqdz_ItMw_1H_Blessed_01", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_1H_Blessed_01", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_1H_Special_02"); --- Полуторный рудный меч
	SetCraftAmount("gkwqdz_ItMw_1H_Special_02", 1);
	 AddIngre("gkwqdz_ItMw_1H_Special_02", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_1H_Special_02", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_1H_Special_02", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_1H_Special_02", "aixopt_itmi_aquamarine", 1);
	 AddAlterIngre("gkwqdz_ItMw_1H_Special_02", "aixopt_itmi_ironingot", 10);
	 AddAlterIngre("gkwqdz_ItMw_1H_Special_02", "aixopt_itmirawsteel", 5);
	 AddAlterIngre("gkwqdz_ItMw_1H_Special_02", "aixopt_itmi_handle", 1);
	 AddAlterIngre("gkwqdz_ItMw_1H_Special_02", "aixopt_itmi_rubin", 1);
	 AddTool("gkwqdz_ItMw_1H_Special_02", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1H_Special_02", 20);
	SetCraftScience("gkwqdz_ItMw_1H_Special_02", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_1H_Special_02", 100);			
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_1H_Special_03"); --- Рудный боевой клинок
	SetCraftAmount("gkwqdz_ItMw_1H_Special_03", 1);
	 AddIngre("gkwqdz_ItMw_1H_Special_03", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_1H_Special_03", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_1H_Special_03", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_1H_Special_03", "aixopt_itmi_aquamarine", 1);
	 AddAlterIngre("gkwqdz_ItMw_1H_Special_03", "aixopt_itmi_ironingot", 10);
	 AddAlterIngre("gkwqdz_ItMw_1H_Special_03", "aixopt_itmirawsteel", 5);
	 AddAlterIngre("gkwqdz_ItMw_1H_Special_03", "aixopt_itmi_handle", 1);
	 AddAlterIngre("gkwqdz_ItMw_1H_Special_03", "aixopt_itmi_rubin", 1);
	 AddTool("gkwqdz_ItMw_1H_Special_03", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1H_Special_03", 20);
	SetCraftScience("gkwqdz_ItMw_1H_Special_03", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_1H_Special_03", 100);	
	
	
	-- AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Addon_Betty"); --- Бетти
	-- SetCraftAmount("gkwqdz_ItMw_Addon_Betty", 1);
	--  AddIngre("gkwqdz_ItMw_Addon_Betty", "aixopt_itmi_ironingot", 10);
	--  AddIngre("gkwqdz_ItMw_Addon_Betty", "aixopt_itmirawsteel", 5);
	--  AddIngre("gkwqdz_ItMw_Addon_Betty", "aixopt_itmi_handle", 1);
	--  AddIngre("gkwqdz_ItMw_Addon_Betty", "aixopt_itmi_skin", 1);
	--  AddTool("gkwqdz_ItMw_Addon_Betty", "gkwqdz_ItMw_1H_Mace_L_04");
	-- SetCraftPenalty("gkwqdz_ItMw_Addon_Betty", 20);
	-- SetCraftScience("gkwqdz_ItMw_Addon_Betty", "Оружейник", 3);
	-- SetenergyPenalty("gkwqdz_ItMw_Addon_Betty", 100);


	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Krummschwert"); --- Абордажная сабля
	SetCraftAmount("gkwqdz_ItMw_Krummschwert", 1);
	 AddIngre("gkwqdz_ItMw_Krummschwert", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Krummschwert", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_Krummschwert", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_Krummschwert", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_Krummschwert", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Krummschwert", 20);
	SetCraftScience("gkwqdz_ItMw_Krummschwert", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Krummschwert", 100);
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_itmw_barbarenstreitaxt"); --- Боевой топор варваров
	SetCraftAmount("gkwqdz_itmw_barbarenstreitaxt", 1);
	 AddIngre("gkwqdz_itmw_barbarenstreitaxt", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_itmw_barbarenstreitaxt", "aixopt_itmirawsteel", 4);
	 AddIngre("gkwqdz_itmw_barbarenstreitaxt", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_itmw_barbarenstreitaxt", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_itmw_barbarenstreitaxt", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_itmw_barbarenstreitaxt", 20);
	SetCraftScience("gkwqdz_itmw_barbarenstreitaxt", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_itmw_barbarenstreitaxt", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Berserkeraxt"); --- Топор берсеркера
	SetCraftAmount("gkwqdz_ItMw_Berserkeraxt", 1);
	 AddIngre("gkwqdz_ItMw_Berserkeraxt", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Berserkeraxt", "aixopt_itmirawsteel", 4);
	 AddIngre("gkwqdz_ItMw_Berserkeraxt", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_Berserkeraxt", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_Berserkeraxt", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Berserkeraxt", 20);
	SetCraftScience("gkwqdz_ItMw_Berserkeraxt", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Berserkeraxt", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Sturmbringer"); --- Несущий бурю
	SetCraftAmount("gkwqdz_ItMw_Sturmbringer", 1);
	 AddIngre("gkwqdz_ItMw_Sturmbringer", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Sturmbringer", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_Sturmbringer", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_Sturmbringer", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_Sturmbringer", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Sturmbringer", 20);
	SetCraftScience("gkwqdz_ItMw_Sturmbringer", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Sturmbringer", 100);	


	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_2H_Blessed_01"); --- Грубый рудный клинок
	SetCraftAmount("gkwqdz_ItMw_2H_Blessed_01", 1);
	 AddIngre("gkwqdz_ItMw_2H_Blessed_01", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_2H_Blessed_01", "aixopt_itmirawsteel", 5);
	 AddIngre("gkwqdz_ItMw_2H_Blessed_01", "aixopt_itmi_handle", 1);
	 AddIngre("gkwqdz_ItMw_2H_Blessed_01", "aixopt_itmi_aquamarine", 1);
	 AddAlterIngre("gkwqdz_ItMw_2H_Blessed_01", "aixopt_itmi_ironingot", 10);
	 AddAlterIngre("gkwqdz_ItMw_2H_Blessed_01", "aixopt_itmirawsteel", 5);
	 AddAlterIngre("gkwqdz_ItMw_2H_Blessed_01", "aixopt_itmi_handle", 1);
	 AddAlterIngre("gkwqdz_ItMw_2H_Blessed_01", "aixopt_itmi_rubin", 1);
	 AddTool("gkwqdz_ItMw_2H_Blessed_01", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_2H_Blessed_01", 20);
	SetCraftScience("gkwqdz_ItMw_2H_Blessed_01", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_2H_Blessed_01", 100);	


	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_2H_Blessed_02"); --- Меч ордена
	SetCraftAmount("gkwqdz_ItMw_2H_Blessed_02", 1);
	 AddIngre("gkwqdz_ItMw_2H_Blessed_02", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_2H_Blessed_02", "aixopt_itmirawsteel", 4);
	 AddIngre("gkwqdz_ItMw_2H_Blessed_02", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_2H_Blessed_02", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_2H_Blessed_02", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_2H_Blessed_02", 20);
	SetCraftScience("gkwqdz_ItMw_2H_Blessed_02", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_2H_Blessed_02", 100);		
	
	
	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_2H_Special_02"); --- Тяжелый рудный двуручник
	SetCraftAmount("gkwqdz_ItMw_2H_Special_02", 1);
	 AddIngre("gkwqdz_ItMw_2H_Special_02", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_2H_Special_02", "aixopt_itmirawsteel", 4);
	 AddIngre("gkwqdz_ItMw_2H_Special_02", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_2H_Special_02", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_2H_Special_02", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_2H_Special_02", 20);
	SetCraftScience("gkwqdz_ItMw_2H_Special_02", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_2H_Special_02", 100);		
	

	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_Addon_PIR2hAxe"); --- Крушитель досок
	SetCraftAmount("gkwqdz_ItMw_Addon_PIR2hAxe", 1);
	 AddIngre("gkwqdz_ItMw_Addon_PIR2hAxe", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_Addon_PIR2hAxe", "aixopt_itmirawsteel", 4);
	 AddIngre("gkwqdz_ItMw_Addon_PIR2hAxe", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_Addon_PIR2hAxe", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_Addon_PIR2hAxe", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Addon_PIR2hAxe", 20);
	SetCraftScience("gkwqdz_ItMw_Addon_PIR2hAxe", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Addon_PIR2hAxe", 100);		

	AddItemCategory ("(О)Кузнец (3 уровень)", "gkwqdz_ItMw_2H_Special_01"); --- Королевский клинок
	SetCraftAmount("gkwqdz_ItMw_2H_Special_01", 1);
	 AddIngre("gkwqdz_ItMw_2H_Special_01", "aixopt_itmi_ironingot", 10);
	 AddIngre("gkwqdz_ItMw_2H_Special_01", "aixopt_itmirawsteel", 4);
	 AddIngre("gkwqdz_ItMw_2H_Special_01", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_2H_Special_01", "aixopt_itmi_skin", 1);
	 AddTool("gkwqdz_ItMw_2H_Special_01", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_2H_Special_01", 20);
	SetCraftScience("gkwqdz_ItMw_2H_Special_01", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_2H_Special_01", 100);	
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА	


	AddItemCategory ("(О)Кузнец (4 уровень)", "gkwqdz_ItMw_1H_Blessed_02"); --- Освященный рудный клинок
	SetCraftAmount("gkwqdz_ItMw_1H_Blessed_02", 1);
	 AddIngre("gkwqdz_ItMw_1H_Blessed_02", "aixopt_itmi_ironingot", 8);
	 AddIngre("gkwqdz_ItMw_1H_Blessed_02", "aixopt_itmirawsteel", 8);
	 AddIngre("gkwqdz_ItMw_1H_Blessed_02", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_1H_Blessed_02", "aixopt_itmi_tannedskin", 2);
	 AddIngre("gkwqdz_ItMw_1H_Blessed_02", "AIXOPT_ItMi_UNIQUERECIPE", 1);
	 AddTool("gkwqdz_ItMw_1H_Blessed_02", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_1H_Blessed_02", 20);
	SetCraftScience("gkwqdz_ItMw_1H_Blessed_02", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_1H_Blessed_02", 100);		


	AddItemCategory ("(О)Кузнец (4 уровень)", "gkwqdz_ItMw_Zweihaender3"); --- Сила рун
	SetCraftAmount("gkwqdz_ItMw_Zweihaender3", 1);
	 AddIngre("gkwqdz_ItMw_Zweihaender3", "aixopt_itmi_ironingot", 8);
	 AddIngre("gkwqdz_ItMw_Zweihaender3", "aixopt_itmirawsteel", 8);
	 AddIngre("gkwqdz_ItMw_Zweihaender3", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_Zweihaender3", "aixopt_itmi_tannedskin", 2);
	 AddIngre("gkwqdz_ItMw_Zweihaender3", "AIXOPT_ItMi_UNIQUERECIPE", 1);
	 AddTool("gkwqdz_ItMw_Zweihaender3", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Zweihaender3", 20);
	SetCraftScience("gkwqdz_ItMw_Zweihaender3", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Zweihaender3", 100);
	
	
	AddItemCategory ("(О)Кузнец (4 уровень)", "gkwqdz_ItMw_Drachenschneide"); --- Гроза драконов
	SetCraftAmount("gkwqdz_ItMw_Drachenschneide", 1);
	 AddIngre("gkwqdz_ItMw_Drachenschneide", "aixopt_itmi_ironingot", 8);
	 AddIngre("gkwqdz_ItMw_Drachenschneide", "aixopt_itmirawsteel", 8);
	 AddIngre("gkwqdz_ItMw_Drachenschneide", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_Drachenschneide", "aixopt_itmi_tannedskin", 2);
	 AddIngre("gkwqdz_ItMw_Drachenschneide", "AIXOPT_ItMi_UNIQUERECIPE", 1);
	 AddTool("gkwqdz_ItMw_Drachenschneide", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Drachenschneide", 20);
	SetCraftScience("gkwqdz_ItMw_Drachenschneide", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Drachenschneide", 100);	
	
	
	AddItemCategory ("(О)Кузнец (4 уровень)", "gkwqdz_ItMw_2H_Blessed_03"); --- Святой палач
	SetCraftAmount("gkwqdz_ItMw_2H_Blessed_03", 1);
	 AddIngre("gkwqdz_ItMw_2H_Blessed_03", "aixopt_itmi_ironingot", 8);
	 AddIngre("gkwqdz_ItMw_2H_Blessed_03", "aixopt_itmirawsteel", 8);
	 AddIngre("gkwqdz_ItMw_2H_Blessed_03", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_2H_Blessed_03", "aixopt_itmi_tannedskin", 2);
	 AddIngre("gkwqdz_ItMw_2H_Blessed_03", "AIXOPT_ItMi_UNIQUERECIPE", 1);
	 AddTool("gkwqdz_ItMw_2H_Blessed_03", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_2H_Blessed_03", 20);
	SetCraftScience("gkwqdz_ItMw_2H_Blessed_03", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_2H_Blessed_03", 100);	
	
		
	AddItemCategory ("(О)Кузнец (4 уровень)", "gkwqdz_ItMw_2H_Special_03"); --- Тяжелый рудный боевой клинок
	SetCraftAmount("gkwqdz_ItMw_2H_Special03", 1);
	 AddIngre("gkwqdz_ItMw_2H_Special03", "aixopt_itmi_ironingot", 8);
	 AddIngre("gkwqdz_ItMw_2H_Special03", "aixopt_itmirawsteel", 8);
	 AddIngre("gkwqdz_ItMw_2H_Special03", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_2H_Special03", "aixopt_itmi_tannedskin", 2);
	 AddIngre("gkwqdz_ItMw_2H_Special03", "AIXOPT_ItMi_UNIQUERECIPE", 1);
	 AddTool("gkwqdz_ItMw_2H_Special03", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_2H_Special03", 20);
	SetCraftScience("gkwqdz_ItMw_2H_Special03", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_2H_Special03", 100);	
	
	
	AddItemCategory ("(О)Кузнец (4 уровень)", "gkwqdz_ItMw_2H_Special_04"); --- Двуручный Убийца Драконов
	SetCraftAmount("gkwqdz_ItMw_2H_Special_04", 1);
	 AddIngre("gkwqdz_ItMw_2H_Special_04", "aixopt_itmi_ironingot", 8);
	 AddIngre("gkwqdz_ItMw_2H_Special_04", "aixopt_itmirawsteel", 8);
	 AddIngre("gkwqdz_ItMw_2H_Special_04", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_2H_Special_04", "aixopt_itmi_tannedskin", 2);
	 AddIngre("gkwqdz_ItMw_2H_Special_04", "AIXOPT_ItMi_UNIQUERECIPE", 1);
	 AddTool("gkwqdz_ItMw_2H_Special_04", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_2H_Special_04", 20);
	SetCraftScience("gkwqdz_ItMw_2H_Special_04", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_2H_Special_04", 100);	
	
	
	AddItemCategory ("(О)Кузнец (4 уровень)", "gkwqdz_ItMw_Drachenschneide1"); --- Огромный меч
	SetCraftAmount("gkwqdz_ItMw_Drachenschneide1", 1);
	 AddIngre("gkwqdz_ItMw_Drachenschneide1", "aixopt_itmi_ironingot", 8);
	 AddIngre("gkwqdz_ItMw_Drachenschneide1", "aixopt_itmirawsteel", 8);
	 AddIngre("gkwqdz_ItMw_Drachenschneide1", "aixopt_itmi_handle", 2);
	 AddIngre("gkwqdz_ItMw_Drachenschneide1", "aixopt_itmi_tannedskin", 2);
	 AddIngre("gkwqdz_ItMw_Drachenschneide1", "AIXOPT_ItMi_UNIQUERECIPE", 1);
	 AddTool("gkwqdz_ItMw_Drachenschneide1", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("gkwqdz_ItMw_Drachenschneide1", 20);
	SetCraftScience("gkwqdz_ItMw_Drachenschneide1", "Оружейник", 3);
	SetenergyPenalty("gkwqdz_ItMw_Drachenschneide1", 100);	
	

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА


	AddItemCategory ("Плотник (Расходники)", "aixopt_itmi_craftwood"); --- Обработанная древесина
	SetCraftAmount("aixopt_itmi_craftwood", 1);
	 AddIngre("aixopt_itmi_craftwood", "aixopt_itmi_rawwood", 20);
	 AddIngre("aixopt_itmi_craftwood", "aixopt_itmi_coal", 5);
	 AddTool("aixopt_itmi_craftwood", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("aixopt_itmi_craftwood", 5);
	SetCraftScience("aixopt_itmi_craftwood", "Плотник", 1);
	SetenergyPenalty("aixopt_itmi_craftwood", 25);
	SetCraftEXP("aixopt_itmi_craftwood", 25)
	SetCraftEXP_SKILL("aixopt_itmi_craftwood", "Плотник")


	AddItemCategory ("Плотник (Расходники)", "aixopt_itmi_handle"); --- Рукоять
	SetCraftAmount("aixopt_itmi_handle", 1);
	 AddIngre("aixopt_itmi_handle", "aixopt_itmi_craftwood", 4);
	 AddTool("aixopt_itmi_handle", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("aixopt_itmi_handle", 10);
	SetCraftScience("aixopt_itmi_handle", "Плотник", 1);
	SetenergyPenalty("aixopt_itmi_handle", 50);
	SetCraftEXP("aixopt_itmi_handle", 50)
	SetCraftEXP_SKILL("aixopt_itmi_handle", "Плотник")


	AddItemCategory ("Плотник (Расходники)", "aixopt_itmi_flask"); --- Мензурка
	SetCraftAmount("aixopt_itmi_flask", 40);
	 AddIngre("aixopt_itmi_flask", "aixopt_itmi_craftwood", 1);
	 AddTool("aixopt_itmi_flask", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("aixopt_itmi_flask", 5);
	SetCraftScience("aixopt_itmi_flask", "Плотник", 1);
	SetenergyPenalty("aixopt_itmi_flask", 25);
	SetCraftEXP("aixopt_itmi_flask", 25)
	SetCraftEXP_SKILL("aixopt_itmi_flask", "Плотник")
	
	
	AddItemCategory ("Плотник (Расходники)", "ItRw_Arrow"); --- Стрела
	SetCraftAmount("ItRw_Arrow", 40);
	 AddIngre("ItRw_Arrow", "aixopt_itmi_rawwood", 10);
	 AddIngre("ItRw_Arrow", "aixopt_itmi_ironnugget", 5);
	 AddAlterIngre("ItRw_Arrow", "gkwqdz_ItMw_1h_Bau_Mace", 1);
	 AddAlterIngre("ItRw_Arrow", "aixopt_itmi_ironnugget", 5);
	 AddTool("ItRw_Arrow", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("ItRw_Arrow", 5);
	SetCraftScience("ItRw_Arrow", "Плотник", 1);
	SetenergyPenalty("ItRw_Arrow", 10);
	SetCraftEXP("ItRw_Arrow", 10)
	SetCraftEXP_SKILL("ItRw_Arrow", "Плотник")	
	
	
	AddItemCategory ("Плотник (Расходники)", "ItRw_Bolt"); --- Болт
	SetCraftAmount("ItRw_Bolt", 40);
	 AddIngre("ItRw_Bolt", "aixopt_itmi_rawwood", 10);
	 AddIngre("ItRw_Bolt", "aixopt_itmi_ironnugget", 5);
	 AddAlterIngre("ItRw_Bolt", "gkwqdz_ItMw_1h_Bau_Mace", 1);
	 AddAlterIngre("ItRw_Bolt", "aixopt_itmi_ironnugget", 5);
	 AddTool("ItRw_Bolt", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("ItRw_Bolt", 5);
	SetCraftScience("ItRw_Bolt", "Плотник", 1);
	SetenergyPenalty("ItRw_Bolt", 10);
	SetCraftEXP("ItRw_Bolt", 10)
	SetCraftEXP_SKILL("ItRw_Bolt", "Плотник")	


	AddItemCategory ("Плотник (Расходники)", "aixopt_itmi_paper"); --- Бумага
	SetCraftAmount("aixopt_itmi_paper", 50);
	 AddIngre("aixopt_itmi_paper", "aixopt_itmi_rawwood", 25);
	SetCraftPenalty("aixopt_itmi_paper", 5);
	SetCraftScience("aixopt_itmi_paper", "Плотник", 1);
	SetenergyPenalty("aixopt_itmi_paper", 10);
	SetCraftEXP("aixopt_itmi_paper", 10)
	SetCraftEXP_SKILL("aixopt_itmi_paper", "Плотник")	
	
	AddItemCategory ("Плотник (Расходники)", "aixopt_itmi_chest_01"); --- Сундук
	SetCraftAmount("aixopt_itmi_chest_01", 1);
	 AddIngre("aixopt_itmi_chest_01", "aixopt_itmi_craftwood", 1);
	 AddTool("aixopt_itmi_chest_01", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("aixopt_itmi_chest_01", 5);
	SetCraftScience("aixopt_itmi_chest_01", "Плотник", 1);
	SetenergyPenalty("aixopt_itmi_chest_01", 25);
	SetCraftEXP("aixopt_itmi_chest_01", 25)
	SetCraftEXP_SKILL("aixopt_itmi_chest_01", "Плотник")	
	
	AddItemCategory ("Плотник (Расходники)", "aixopt_itmi_chest_02"); --- кРЕПКИЙ сундук
	SetCraftAmount("aixopt_itmi_chest_02", 1);
	 AddIngre("aixopt_itmi_chest_02", "aixopt_itmi_craftwood", 2);
	 AddIngre("aixopt_itmi_chest_02", "aixopt_itmi_lock", 1);
	 AddTool("aixopt_itmi_chest_02", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("aixopt_itmi_chest_02", 5);
	SetCraftScience("aixopt_itmi_chest_02", "Плотник", 2);
	SetenergyPenalty("aixopt_itmi_chest_02", 25);
	SetCraftEXP("aixopt_itmi_chest_02", 25)
	SetCraftEXP_SKILL("aixopt_itmi_chest_02", "Плотник")
	
	AddItemCategory ("Плотник (Расходники)", "aixopt_itmi_chest_03"); --- прочный сундук
	SetCraftAmount("aixopt_itmi_chest_03", 1);
	 AddIngre("aixopt_itmi_chest_03", "aixopt_itmi_craftwood", 3);
	 AddIngre("aixopt_itmi_chest_03", "aixopt_itmi_lock", 1);
	 AddTool("aixopt_itmi_chest_03", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("aixopt_itmi_chest_03", 5);
	SetCraftScience("aixopt_itmi_chest_03", "Плотник", 3);
	SetenergyPenalty("aixopt_itmi_chest_03", 25);
	SetCraftEXP("aixopt_itmi_chest_03", 25)
	SetCraftEXP_SKILL("aixopt_itmi_chest_03", "Плотник")	
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	
	AddItemCategory ("Плотник (1 уровень)", "AIXOPT_ITMI_FISHINGROD"); --- Удочка
	SetCraftAmount("AIXOPT_ITMI_FISHINGROD", 1);
	 AddIngre("AIXOPT_ITMI_FISHINGROD", "gkwqdz_ItMw_1h_Bau_Mace", 1);
	 AddIngre("AIXOPT_ITMI_FISHINGROD", "aixopt_itmi_wool", 1);
	 AddTool("AIXOPT_ITMI_FISHINGROD", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("AIXOPT_ITMI_FISHINGROD", 5);
	SetCraftScience("AIXOPT_ITMI_FISHINGROD", "Плотник", 1);
	SetenergyPenalty("AIXOPT_ITMI_FISHINGROD", 10);
	SetCraftEXP("AIXOPT_ITMI_FISHINGROD", 25)
	SetCraftEXP_SKILL("AIXOPT_ITMI_FISHINGROD", "Плотник")	

	
	AddItemCategory ("Плотник (1 уровень)", "aixopt_itmi_scoop"); --- Ложка
	SetCraftAmount("aixopt_itmi_scoop", 1);
	 AddIngre("aixopt_itmi_scoop", "aixopt_itmi_rawwood", 10);
	 AddTool("aixopt_itmi_scoop", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("aixopt_itmi_scoop", 5);
	SetCraftScience("aixopt_itmi_scoop", "Плотник", 1);
	SetenergyPenalty("aixopt_itmi_scoop", 10);
	SetCraftEXP("aixopt_itmi_scoop", 10)
	SetCraftEXP_SKILL("aixopt_itmi_scoop", "Плотник")		
	

	AddItemCategory ("Плотник (Без уровня)", "gkwqdz_ItMw_1h_Vlk_Mace"); --- Трость
	SetCraftAmount("gkwqdz_ItMw_1h_Vlk_Mace", 1);
	 AddIngre("gkwqdz_ItMw_1h_Vlk_Mace", "aixopt_itmi_craftwood", 1);
	 AddTool("gkwqdz_ItMw_1h_Vlk_Mace", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("gkwqdz_ItMw_1h_Vlk_Mace", 5);
	SetCraftScience("gkwqdz_ItMw_1h_Vlk_Mace", "Плотник", 1);
	SetenergyPenalty("gkwqdz_ItMw_1h_Vlk_Mace", 10);
	SetCraftEXP("gkwqdz_ItMw_1h_Vlk_Mace", 10)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1h_Vlk_Mace", "Плотник")		


	AddItemCategory ("Плотник (Без уровня)", "gkwqdz_ItMw_1H_Mace_L_03"); --- Дубина
	SetCraftAmount("gkwqdz_ItMw_1H_Mace_L_03", 1);
	 AddIngre("gkwqdz_ItMw_1H_Mace_L_03", "aixopt_itmi_craftwood", 1);
	 AddTool("gkwqdz_ItMw_1H_Mace_L_03", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("gkwqdz_ItMw_1H_Mace_L_03", 5);
	SetCraftScience("gkwqdz_ItMw_1H_Mace_L_03", "Плотник", 1);
	SetenergyPenalty("gkwqdz_ItMw_1H_Mace_L_03", 10);
	SetCraftEXP("gkwqdz_ItMw_1H_Mace_L_03", 10)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1H_Mace_L_03", "Плотник")	

AddItemCategory ("Плотник (Без уровня)", "gkwqdz_ItMw_Nagelknueppel"); --- Палица с шипами
	SetCraftAmount("gkwqdz_ItMw_Nagelknueppel", 1);
	 AddIngre("gkwqdz_ItMw_Nagelknueppel", "aixopt_itmi_craftwood", 1);
	 AddTool("gkwqdz_ItMw_Nagelknueppel", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("gkwqdz_ItMw_Nagelknueppel", 5);
	SetCraftScience("gkwqdz_ItMw_Nagelknueppel", "Плотник", 1);
	SetenergyPenalty("gkwqdz_ItMw_Nagelknueppel", 10);
	SetCraftEXP("gkwqdz_ItMw_Nagelknueppel", 10)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Nagelknueppel", "Плотник")	

	AddItemCategory ("Плотник (1 уровень)", "gkwqdz_ItMw_1h_Nov_Mace"); --- Боевой посох
	SetCraftAmount("gkwqdz_ItMw_1h_Nov_Mace", 1);
	 AddIngre("gkwqdz_ItMw_1h_Nov_Mace", "aixopt_itmi_craftwood", 2);
	 AddTool("gkwqdz_ItMw_1h_Nov_Mace", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("gkwqdz_ItMw_1h_Nov_Mace", 5);
	SetCraftScience("gkwqdz_ItMw_1h_Nov_Mace", "Плотник", 1);
	SetenergyPenalty("gkwqdz_ItMw_1h_Nov_Mace", 25);
	SetCraftEXP("gkwqdz_ItMw_1h_Nov_Mace", 50)
	SetCraftEXP_SKILL("gkwqdz_ItMw_1h_Nov_Mace", "Плотник")
	
	
	AddItemCategory ("Плотник (Без уровня)", "eyqtds_itrw_bow_l_01"); --- Короткий лук
	SetCraftAmount("eyqtds_itrw_bow_l_01", 1);
	 AddIngre("eyqtds_itrw_bow_l_01", "aixopt_itmi_craftwood", 1);
	 AddTool("eyqtds_itrw_bow_l_01", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_bow_l_01", 5);
	SetCraftScience("eyqtds_itrw_bow_l_01", "Плотник", 1);
	SetenergyPenalty("eyqtds_itrw_bow_l_01", 25);
	SetCraftEXP("eyqtds_itrw_bow_l_01", 25)
	SetCraftEXP_SKILL("eyqtds_itrw_bow_l_01", "Плотник")	
	

	AddItemCategory ("Плотник (Без уровня)", "eyqtds_itrw_crossbow_l_01"); --- Охотничий арбалет
	SetCraftAmount("eyqtds_itrw_crossbow_l_01", 1);
	 AddIngre("eyqtds_itrw_crossbow_l_01", "aixopt_itmi_craftwood", 1);
	 AddTool("eyqtds_itrw_crossbow_l_01", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_crossbow_l_01", 5);
	SetCraftScience("eyqtds_itrw_crossbow_l_01", "Плотник", 1);
	SetenergyPenalty("eyqtds_itrw_crossbow_l_01", 25);
	SetCraftEXP("eyqtds_itrw_crossbow_l_01", 25)
	SetCraftEXP_SKILL("eyqtds_itrw_crossbow_l_01", "Плотник")
	

	AddItemCategory ("Плотник (Без уровня)", "gkwqdz_ItMw_Nagelkeule"); --- Дубина с шипами
	SetCraftAmount("gkwqdz_ItMw_Nagelkeule", 1);
	 AddIngre("gkwqdz_ItMw_Nagelkeule", "aixopt_itmi_craftwood", 1);
	 AddTool("gkwqdz_ItMw_Nagelkeule", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("gkwqdz_ItMw_Nagelkeule", 10);
	SetCraftScience("gkwqdz_ItMw_Nagelkeule", "Плотник", 1);
	SetenergyPenalty("gkwqdz_ItMw_Nagelkeule", 10);
	SetCraftEXP("gkwqdz_ItMw_Nagelkeule", 10)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Nagelkeule", "Плотник")
	
	
	AddItemCategory ("Плотник (1 уровень)", "GKWQDZ_ItMw_Addon_Keule_1h_01"); --- Дубинка бури
	SetCraftAmount("GKWQDZ_ItMw_Addon_Keule_1h_01", 1);
	 AddIngre("GKWQDZ_ItMw_Addon_Keule_1h_01", "aixopt_itmi_craftwood", 2);
	 AddTool("GKWQDZ_ItMw_Addon_Keule_1h_01", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("GKWQDZ_ItMw_Addon_Keule_1h_01", 10);
	SetCraftScience("GKWQDZ_ItMw_Addon_Keule_1h_01", "Плотник", 1);
	SetenergyPenalty("GKWQDZ_ItMw_Addon_Keule_1h_01", 25);
	SetCraftEXP("GKWQDZ_ItMw_Addon_Keule_1h_01", 50)
	SetCraftEXP_SKILL("GKWQDZ_ItMw_Addon_Keule_1h_01", "Плотник")
	
	
	AddItemCategory ("Плотник (1 уровень)", "eyqtds_itrw_sld_bow"); --- Солдатский лук
	SetCraftAmount("eyqtds_itrw_sld_bow", 1);
	 AddIngre("eyqtds_itrw_sld_bow", "aixopt_itmi_craftwood", 2);
	 AddTool("eyqtds_itrw_sld_bow", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_sld_bow", 10);
	SetCraftScience("eyqtds_itrw_sld_bow", "Плотник", 1);
	SetenergyPenalty("eyqtds_itrw_sld_bow", 25);
	SetCraftEXP("eyqtds_itrw_sld_bow", 50)
	SetCraftEXP_SKILL("eyqtds_itrw_sld_bow", "Плотник")
	

	AddItemCategory ("Плотник (1 уровень)", "eyqtds_itrw_bow_l_02"); --- Ивовый лук
	SetCraftAmount("eyqtds_itrw_bow_l_02", 1);
	 AddIngre("eyqtds_itrw_bow_l_02", "aixopt_itmi_craftwood", 2);
	 AddTool("eyqtds_itrw_bow_l_02", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_bow_l_02", 10);
	SetCraftScience("eyqtds_itrw_bow_l_02", "Плотник", 1);
	SetenergyPenalty("eyqtds_itrw_bow_l_02", 25);
	SetCraftEXP("eyqtds_itrw_bow_l_02", 50)
	SetCraftEXP_SKILL("eyqtds_itrw_bow_l_02", "Плотник")


	AddItemCategory ("Плотник (1 уровень)", "eyqtds_itrw_mil_crossbow"); --- Арбалет
	SetCraftAmount("eyqtds_itrw_mil_crossbow", 1);
	 AddIngre("eyqtds_itrw_mil_crossbow", "aixopt_itmi_craftwood", 2);
	 AddTool("eyqtds_itrw_mil_crossbow", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_mil_crossbow", 10);
	SetCraftScience("eyqtds_itrw_mil_crossbow", "Плотник", 1);
	SetenergyPenalty("eyqtds_itrw_mil_crossbow", 25);
	SetCraftEXP("eyqtds_itrw_mil_crossbow", 50)
	SetCraftEXP_SKILL("eyqtds_itrw_mil_crossbow", "Плотник")	
	
	
	AddItemCategory ("Плотник (1 уровень)", "eyqtds_itrw_crossbow_l_02"); --- Легкий арбалет
	SetCraftAmount("eyqtds_itrw_crossbow_l_02", 1);
	 AddIngre("eyqtds_itrw_crossbow_l_02", "aixopt_itmi_craftwood", 2);
	 AddTool("eyqtds_itrw_crossbow_l_02", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_crossbow_l_02", 10);
	SetCraftScience("eyqtds_itrw_crossbow_l_02", "Плотник", 1);
	SetenergyPenalty("eyqtds_itrw_crossbow_l_02", 25);
	SetCraftEXP("eyqtds_itrw_crossbow_l_02", 50)
	SetCraftEXP_SKILL("eyqtds_itrw_crossbow_l_02", "Плотник")	


	AddItemCategory ("Плотник (1 уровень)", "mcyzod_itsh_shield_01"); --- Деревянный щит
	SetCraftAmount("mcyzod_itsh_shield_01", 1);
	 AddIngre("mcyzod_itsh_shield_01", "aixopt_itmi_craftwood", 2);
	 AddTool("mcyzod_itsh_shield_01", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("mcyzod_itsh_shield_01", 10);
	SetCraftScience("mcyzod_itsh_shield_01", "Плотник", 1);
	SetenergyPenalty("mcyzod_itsh_shield_01", 25);
	SetCraftEXP("mcyzod_itsh_shield_01", 50)
	SetCraftEXP_SKILL("mcyzod_itsh_shield_01", "Плотник")
	
	AddItemCategory ("Плотник (Без уровня)", "aixopt_itmi_lute"); --- Лютня
	SetCraftAmount("aixopt_itmi_lute", 1);
	 AddIngre("aixopt_itmi_lute", "aixopt_itmi_craftwood", 1);
	 AddIngre("aixopt_itmi_lute", "aixopt_itmi_glue", 1);
	 AddTool("aixopt_itmi_lute", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("aixopt_itmi_lute", 10);
	SetCraftScience("aixopt_itmi_lute", "Плотник", 1);
	SetenergyPenalty("aixopt_itmi_lute", 25);
	SetCraftEXP("aixopt_itmi_lute", 25)
	SetCraftEXP_SKILL("aixopt_itmi_lute", "Плотник")

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА


	AddItemCategory ("Плотник (2 уровень)", "GKWQDZ_ItMw_Addon_Keule_2h_01"); --- Дубинка ветра
	SetCraftAmount("GKWQDZ_ItMw_Addon_Keule_2h_01", 1);
	 AddIngre("GKWQDZ_ItMw_Addon_Keule_2h_01", "aixopt_itmi_craftwood", 5);
	 AddTool("GKWQDZ_ItMw_Addon_Keule_2h_01", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("GKWQDZ_ItMw_Addon_Keule_2h_01", 10);
	SetCraftScience("GKWQDZ_ItMw_Addon_Keule_2h_01", "Плотник", 2);
	SetenergyPenalty("GKWQDZ_ItMw_Addon_Keule_2h_01", 50);
	SetCraftEXP("GKWQDZ_ItMw_Addon_Keule_2h_01", 150)
	SetCraftEXP_SKILL("GKWQDZ_ItMw_Addon_Keule_2h_01", "Плотник")


	AddItemCategory ("Плотник (2 уровень)", "eyqtds_itrw_bow_l_03"); --- Охотничий лук
	SetCraftAmount("eyqtds_itrw_bow_l_03", 1);
	 AddIngre("eyqtds_itrw_bow_l_03", "aixopt_itmi_craftwood", 5);
	 AddTool("eyqtds_itrw_bow_l_03", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_bow_l_03", 10);
	SetCraftScience("eyqtds_itrw_bow_l_03", "Плотник", 2);
	SetenergyPenalty("eyqtds_itrw_bow_l_03", 50);
	SetCraftEXP("eyqtds_itrw_bow_l_03", 150)
	SetCraftEXP_SKILL("eyqtds_itrw_bow_l_03", "Плотник")
	
	
	AddItemCategory ("Плотник (2 уровень)", "eyqtds_itrw_bow_l_04"); --- Вязовый лук
	SetCraftAmount("eyqtds_itrw_bow_l_04", 1);
	 AddIngre("eyqtds_itrw_bow_l_04", "aixopt_itmi_craftwood", 5);
	 AddTool("eyqtds_itrw_bow_l_04", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_bow_l_04", 10);
	SetCraftScience("eyqtds_itrw_bow_l_04", "Плотник", 2);
	SetenergyPenalty("eyqtds_itrw_bow_l_04", 50);
	SetCraftEXP("eyqtds_itrw_bow_l_04", 150)
	SetCraftEXP_SKILL("eyqtds_itrw_bow_l_04", "Плотник")
	
	
	AddItemCategory ("Плотник (2 уровень)", "eyqtds_itrw_bow_m_01"); --- Композитный лук
	SetCraftAmount("eyqtds_itrw_bow_m_01", 1);
	 AddIngre("eyqtds_itrw_bow_m_01", "aixopt_itmi_craftwood", 5);
	 AddTool("eyqtds_itrw_bow_m_01", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_bow_m_01", 10);
	SetCraftScience("eyqtds_itrw_bow_m_01", "Плотник", 2);
	SetenergyPenalty("eyqtds_itrw_bow_m_01", 50);
	SetCraftEXP("eyqtds_itrw_bow_m_01", 150)
	SetCraftEXP_SKILL("eyqtds_itrw_bow_m_01", "Плотник")
	
	
	AddItemCategory ("Плотник (2 уровень)", "eyqtds_itrw_bow_m_02"); --- Ясеневый лук
	SetCraftAmount("eyqtds_itrw_bow_m_02", 1);
	 AddIngre("eyqtds_itrw_bow_m_02", "aixopt_itmi_craftwood", 5);
	 AddTool("eyqtds_itrw_bow_m_02", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_bow_m_02", 10);
	SetCraftScience("eyqtds_itrw_bow_m_02", "Плотник", 2);
	SetenergyPenalty("eyqtds_itrw_bow_m_02", 50);
	SetCraftEXP("eyqtds_itrw_bow_m_02", 150)
	SetCraftEXP_SKILL("eyqtds_itrw_bow_m_02", "Плотник")
	
	
	AddItemCategory ("Плотник (2 уровень)", "eyqtds_itrw_bow_m_03"); --- Длинный лук
	SetCraftAmount("eyqtds_itrw_bow_m_03", 1);
	 AddIngre("eyqtds_itrw_bow_m_03", "aixopt_itmi_craftwood", 5);
	 AddTool("eyqtds_itrw_bow_m_03", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_bow_m_03", 10);
	SetCraftScience("eyqtds_itrw_bow_m_03", "Плотник", 2);
	SetenergyPenalty("eyqtds_itrw_bow_m_03", 50);
	SetCraftEXP("eyqtds_itrw_bow_m_03", 150)
	SetCraftEXP_SKILL("eyqtds_itrw_bow_m_03", "Плотник")
	
	
	AddItemCategory ("Плотник (2 уровень)", "eyqtds_itrw_bow_m_04"); --- Буковый лук
	SetCraftAmount("eyqtds_itrw_bow_m_04", 1);
	 AddIngre("eyqtds_itrw_bow_m_04", "aixopt_itmi_craftwood", 5);
	 AddTool("eyqtds_itrw_bow_m_04", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_bow_m_04", 10);
	SetCraftScience("eyqtds_itrw_bow_m_04", "Плотник", 2);
	SetenergyPenalty("eyqtds_itrw_bow_m_04", 50);
	SetCraftEXP("eyqtds_itrw_bow_m_04", 150)
	SetCraftEXP_SKILL("eyqtds_itrw_bow_m_04", "Плотник")


	AddItemCategory ("Плотник (2 уровень)", "eyqtds_itrw_crossbow_m_01"); --- Арбалет ополчения
	SetCraftAmount("eyqtds_itrw_crossbow_m_01", 1);
	 AddIngre("eyqtds_itrw_crossbow_m_01", "aixopt_itmi_craftwood", 5);
	 AddTool("eyqtds_itrw_crossbow_m_01", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_crossbow_m_01", 10);
	SetCraftScience("eyqtds_itrw_crossbow_m_01", "Плотник", 2);
	SetenergyPenalty("eyqtds_itrw_crossbow_m_01", 50);
	SetCraftEXP("eyqtds_itrw_crossbow_m_01", 150)
	SetCraftEXP_SKILL("eyqtds_itrw_crossbow_m_01", "Плотник")	
	
	
	AddItemCategory ("Плотник (2 уровень)", "eyqtds_itrw_crossbow_m_02"); --- Военный арбалет
	SetCraftAmount("eyqtds_itrw_crossbow_m_02", 1);
	 AddIngre("eyqtds_itrw_crossbow_m_02", "aixopt_itmi_craftwood", 5);
	 AddTool("eyqtds_itrw_crossbow_m_02", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_crossbow_m_02", 10);
	SetCraftScience("eyqtds_itrw_crossbow_m_02", "Плотник", 2);
	SetenergyPenalty("eyqtds_itrw_crossbow_m_02", 50);
	SetCraftEXP("eyqtds_itrw_crossbow_m_02", 150)
	SetCraftEXP_SKILL("eyqtds_itrw_crossbow_m_02", "Плотник")	
	
	
	AddItemCategory ("Плотник (2 уровень)", "mcyzod_itsh_shield_06"); --- Круглый щит
	SetCraftAmount("mcyzod_itsh_shield_06", 1);
	 AddIngre("mcyzod_itsh_shield_06", "aixopt_itmi_craftwood", 5);
	 AddTool("mcyzod_itsh_shield_06", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("mcyzod_itsh_shield_06", 10);
	SetCraftScience("mcyzod_itsh_shield_06", "Плотник", 2);
	SetenergyPenalty("mcyzod_itsh_shield_06", 50);
	SetCraftEXP("mcyzod_itsh_shield_06", 150)
	SetCraftEXP_SKILL("mcyzod_itsh_shield_06", "Плотник")		
	
	AddItemCategory ("Плотник (2 уровень)", "gkwqdz_ItMw_Richtstab"); --- Посох судьи
	SetCraftAmount("gkwqdz_ItMw_Richtstab", 1);
     AddIngre("gkwqdz_ItMw_Richtstab", "aixopt_itmi_craftwood", 5);
	 AddTool("gkwqdz_ItMw_Richtstab", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("gkwqdz_ItMw_Richtstab", 10);
	SetCraftScience("gkwqdz_ItMw_Richtstab", "Плотник", 2);
	SetenergyPenalty("gkwqdz_ItMw_Richtstab", 50);
	SetCraftEXP("gkwqdz_ItMw_Richtstab", 150)
	SetCraftEXP_SKILL("gkwqdz_ItMw_Richtstab", "Плотник")		

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	AddItemCategory ("Плотник (3 уровень)", "eyqtds_itrw_bow_h_01"); --- Костяной лук
	SetCraftAmount("eyqtds_itrw_bow_h_01", 1);
	 AddIngre("eyqtds_itrw_bow_h_01", "aixopt_itmi_craftwood", 15);
	 AddIngre("eyqtds_itrw_bow_h_01", "aixopt_itmi_glue", 8);
	 AddTool("eyqtds_itrw_bow_h_01", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_bow_h_01", 20);
	SetCraftScience("eyqtds_itrw_bow_h_01", "Плотник", 3);
	SetenergyPenalty("eyqtds_itrw_bow_h_01", 100);


	AddItemCategory ("Плотник (3 уровень)", "eyqtds_itrw_bow_h_02"); --- Дубовый лук
	SetCraftAmount("eyqtds_itrw_bow_h_02", 1);
	 AddIngre("eyqtds_itrw_bow_h_02", "aixopt_itmi_craftwood", 15);
	 AddIngre("eyqtds_itrw_bow_h_02", "aixopt_itmi_glue", 8);
	 AddTool("eyqtds_itrw_bow_h_02", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_bow_h_02", 20);
	SetCraftScience("eyqtds_itrw_bow_h_02", "Плотник", 3);
	SetenergyPenalty("eyqtds_itrw_bow_h_02", 100);


	AddItemCategory ("Плотник (3 уровень)", "eyqtds_itrw_bow_h_03"); --- Военный лук
	SetCraftAmount("eyqtds_itrw_bow_h_03", 1);
	 AddIngre("eyqtds_itrw_bow_h_03", "aixopt_itmi_craftwood", 15);
	 AddIngre("eyqtds_itrw_bow_h_03", "aixopt_itmi_glue", 8);
	 AddTool("eyqtds_itrw_bow_h_03", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_bow_h_03", 20);
	SetCraftScience("eyqtds_itrw_bow_h_03", "Плотник", 3);
	SetenergyPenalty("eyqtds_itrw_bow_h_03", 100);
	
	
	AddItemCategory ("Плотник (3 уровень)", "eyqtds_itrw_crossbow_h_01"); --- Тяжелый арбалет
	SetCraftAmount("eyqtds_itrw_crossbow_h_01", 1);
	 AddIngre("eyqtds_itrw_crossbow_h_01", "aixopt_itmi_craftwood", 16);
	 AddIngre("eyqtds_itrw_crossbow_h_01", "aixopt_itmi_handle", 1);
	 AddIngre("eyqtds_itrw_crossbow_h_01", "aixopt_itmi_linkage", 3);
	 AddTool("eyqtds_itrw_crossbow_h_01", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_crossbow_h_01", 20);
	SetCraftScience("eyqtds_itrw_crossbow_h_01", "Плотник", 3);
	SetenergyPenalty("eyqtds_itrw_crossbow_h_01", 100);	
	
	
	AddItemCategory ("Плотник (3 уровень)", "mcyzod_itsh_shield_03"); --- Железный щит
	SetCraftAmount("mcyzod_itsh_shield_03", 1);
	 AddIngre("mcyzod_itsh_shield_03", "aixopt_itmi_craftwood", 6);
	 AddIngre("mcyzod_itsh_shield_03", "aixopt_itmi_handle", 1);
	 AddIngre("mcyzod_itsh_shield_03", "aixopt_itmirawsteel", 3);
	 AddIngre("mcyzod_itsh_shield_03", "aixopt_itmi_tannedskin", 3);
	 AddTool("mcyzod_itsh_shield_03", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("mcyzod_itsh_shield_03", 20);
	SetCraftScience("mcyzod_itsh_shield_03", "Плотник", 3);
	SetenergyPenalty("mcyzod_itsh_shield_03", 100);	
	
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА	
	
	
	AddItemCategory ("Плотник (4 уровень)", "eyqtds_itrw_crossbow_h_02"); --- Осадный арбалет
	SetCraftAmount("eyqtds_itrw_crossbow_h_02", 1);
	 AddIngre("eyqtds_itrw_crossbow_h_02", "aixopt_itmi_craftwood", 28);
	 AddIngre("eyqtds_itrw_crossbow_h_02", "aixopt_itmi_handle", 2);
	 AddIngre("eyqtds_itrw_crossbow_h_02", "aixopt_itmi_linkage", 4);
	 AddIngre("eyqtds_itrw_crossbow_h_02", "AIXOPT_ItMi_UNIQUERECIPE", 1);
	 AddTool("eyqtds_itrw_crossbow_h_02", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_crossbow_h_02", 20);
	SetCraftScience("eyqtds_itrw_crossbow_h_02", "Плотник", 4);
	SetenergyPenalty("eyqtds_itrw_crossbow_h_02", 100);	
	
	
	AddItemCategory ("Плотник (4 уровень)", "eyqtds_itrw_magiccrossbow"); --- Магический арбалет
	SetCraftAmount("eyqtds_itrw_magiccrossbow", 1);
	 AddIngre("eyqtds_itrw_magiccrossbow", "aixopt_itmi_craftwood", 28);
	 AddIngre("eyqtds_itrw_magiccrossbow", "aixopt_itmi_handle", 2);
	 AddIngre("eyqtds_itrw_magiccrossbow", "aixopt_itmi_linkage", 4);
	 AddIngre("eyqtds_itrw_magiccrossbow", "AIXOPT_ItMi_UNIQUERECIPE", 1);
	 AddTool("eyqtds_itrw_magiccrossbow", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_magiccrossbow", 20);
	SetCraftScience("eyqtds_itrw_magiccrossbow", "Плотник", 4);
	SetenergyPenalty("eyqtds_itrw_magiccrossbow", 100);	
	
	
	AddItemCategory ("Плотник (4 уровень)", "eyqtds_itrw_bow_h_04"); --- Драконий лук
	SetCraftAmount("eyqtds_itrw_bow_h_04", 1);
	 AddIngre("eyqtds_itrw_bow_h_04", "aixopt_itmi_craftwood", 31);
	 AddIngre("eyqtds_itrw_bow_h_04", "aixopt_itmi_glue", 10);
	 AddIngre("eyqtds_itrw_bow_h_04", "AIXOPT_ItMi_UNIQUERECIPE", 1);
	 AddTool("eyqtds_itrw_bow_h_04", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_bow_h_04", 20);
	SetCraftScience("eyqtds_itrw_bow_h_04", "Плотник", 4);
	SetenergyPenalty("eyqtds_itrw_bow_h_04", 100);	
	
	
	AddItemCategory ("Плотник (4 уровень)", "eyqtds_itrw_magicbow"); --- Магический лук
	SetCraftAmount("eyqtds_itrw_magicbow", 1);
	 AddIngre("eyqtds_itrw_magicbow", "aixopt_itmi_craftwood", 31);
	 AddIngre("eyqtds_itrw_magicbow", "aixopt_itmi_glue", 10);
	 AddIngre("eyqtds_itrw_magicbow", "AIXOPT_ItMi_UNIQUERECIPE", 1);
	 AddTool("eyqtds_itrw_magicbow", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_magicbow", 20);
	SetCraftScience("eyqtds_itrw_magicbow", "Плотник", 4);
	SetenergyPenalty("eyqtds_itrw_magicbow", 100);	
	
	
	AddItemCategory ("Плотник (4 уровень)", "eyqtds_itrw_firebow"); --- Огненный лук
	SetCraftAmount("eyqtds_itrw_firebow", 1);
	 AddIngre("eyqtds_itrw_firebow", "aixopt_itmi_craftwood", 31);
	 AddIngre("eyqtds_itrw_firebow", "aixopt_itmi_glue", 10);
	 AddIngre("eyqtds_itrw_firebow", "AIXOPT_ItMi_UNIQUERECIPE", 1);
	 AddTool("eyqtds_itrw_firebow", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("eyqtds_itrw_firebow", 20);
	SetCraftScience("eyqtds_itrw_firebow", "Плотник", 4);
	SetenergyPenalty("eyqtds_itrw_firebow", 100);	
	

	AddItemCategory ("Плотник (4 уровень)", "mcyzod_itsh_shield_04"); --- Костяной щит
	SetCraftAmount("mcyzod_itsh_shield_04", 1);
	 AddIngre("mcyzod_itsh_shield_04", "aixopt_itmi_craftwood", 8);
	 AddIngre("mcyzod_itsh_shield_04", "aixopt_itmi_handle", 1);
	 AddIngre("mcyzod_itsh_shield_04", "aixopt_itmirawsteel", 6);
	 AddIngre("mcyzod_itsh_shield_04", "aixopt_itmi_tannedskin", 6);
	 AddIngre("mcyzod_itsh_shield_04", "AIXOPT_ItMi_UNIQUERECIPE", 1);
	 AddTool("mcyzod_itsh_shield_04", "gkwqdz_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("mcyzod_itsh_shield_04", 20);
	SetCraftScience("mcyzod_itsh_shield_04", "Плотник", 4);
	SetenergyPenalty("mcyzod_itsh_shield_04", 100);	
	
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА


	AddItemCategory ("Кожевник (Расходники)", "aixopt_itmi_skin"); --- Кожа
	SetCraftAmount("aixopt_itmi_skin", 1);
	 AddIngre("aixopt_itmi_skin", "aixopt_itat_wolffur", 2);
	 AddAlterIngre("aixopt_itmi_skin", "aixopt_itat_lurkerskin", 2);
	SetCraftPenalty("aixopt_itmi_skin", 5);
	SetCraftScience("aixopt_itmi_skin", "Кожевник", 1);
	SetenergyPenalty("aixopt_itmi_skin", 25);
	SetCraftEXP("aixopt_itmi_skin", 25)
	SetCraftEXP_SKILL("aixopt_itmi_skin", "Кожевник")


	AddItemCategory ("Кожевник (Расходники)", "aixopt_itmi_fineskin"); --- Качественная кожа
	SetCraftAmount("aixopt_itmi_fineskin", 1);
	 AddIngre("aixopt_itmi_fineskin", "aixopt_itat_shadowfur", 2);
	 AddAlterIngre("aixopt_itmi_fineskin", "aixopt_itat_trollfur", 1);
	SetCraftPenalty("aixopt_itmi_fineskin", 10);
	SetCraftScience("aixopt_itmi_fineskin", "Кожевник", 1);
	SetenergyPenalty("aixopt_itmi_fineskin", 50);
	SetCraftEXP("aixopt_itmi_fineskin", 50)
	SetCraftEXP_SKILL("aixopt_itmi_fineskin", "Кожевник")

--[[	AddItemCategory ("Кожевник (Расходники)", "aixopt_itmi_fineskin"); --- Качественная кожа
	SetCraftAmount("aixopt_itmi_fineskin", 2);
	 AddIngre("aixopt_itmi_fineskin", "aixopt_itat_trollfur", 1);
	SetCraftPenalty("aixopt_itmi_fineskin", 10);
	SetCraftScience("aixopt_itmi_fineskin", "Кожевник", 1);
	SetenergyPenalty("aixopt_itmi_fineskin", 50);]]
	
	
	AddItemCategory ("Кожевник (Расходники)", "aixopt_itmi_rivetskin"); --- Клепаная кожа
	SetCraftAmount("aixopt_itmi_rivetskin", 1);
	 AddIngre("aixopt_itmi_rivetskin", "aixopt_itmi_fineskin", 1);
	 AddIngre("aixopt_itmi_rivetskin", "aixopt_itmi_rivet", 10);
	SetCraftPenalty("aixopt_itmi_rivetskin", 10);
	SetCraftScience("aixopt_itmi_rivetskin", "Кожевник", 1);
	SetenergyPenalty("aixopt_itmi_rivetskin", 50);
	SetCraftEXP("aixopt_itmi_rivetskin", 50)
	SetCraftEXP_SKILL("aixopt_itmi_rivetskin", "Кожевник")
	
	
	AddItemCategory ("Кожевник (Расходники)", "aixopt_itmi_tannedskin"); --- Дубленая кожа
	SetCraftAmount("aixopt_itmi_tannedskin", 1);
	 AddIngre("aixopt_itmi_tannedskin", "aixopt_itmi_fineskin", 1);
	 AddIngre("aixopt_itmi_tannedskin", "aixopt_itmi_tanning", 1);
	SetCraftPenalty("aixopt_itmi_tannedskin", 10);
	SetCraftScience("aixopt_itmi_tannedskin", "Кожевник", 1);
	SetenergyPenalty("aixopt_itmi_tannedskin", 50);
	SetCraftEXP("aixopt_itmi_tannedskin", 50)
	SetCraftEXP_SKILL("aixopt_itmi_tannedskin", "Кожевник")
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА	
	
	AddItemCategory ("Кожевник (Без уровня)", "YFAUUN_ITAR_WOODCUTTER"); --- Одежда лесоруба
	SetCraftAmount("YFAUUN_ITAR_WOODCUTTER", 1);
	 AddIngre("YFAUUN_ITAR_WOODCUTTER", "aixopt_itmi_skin", 1);
	 AddTool("YFAUUN_ITAR_WOODCUTTER", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_WOODCUTTER", 10);
	SetCraftScience("YFAUUN_ITAR_WOODCUTTER", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_WOODCUTTER", 10);
	SetCraftEXP("YFAUUN_ITAR_WOODCUTTER", 10)
	SetCraftEXP_SKILL("YFAUUN_ITAR_WOODCUTTER", "Кожевник")
	
	AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ITAR_Leather_L"); --- Кожаные доспехи
	SetCraftAmount("YFAUUN_ITAR_Leather_L", 1);
	 AddIngre("YFAUUN_ITAR_Leather_L", "aixopt_itmi_skin", 2);
	 AddTool("YFAUUN_ITAR_Leather_L", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_Leather_L", 10);
	SetCraftScience("YFAUUN_ITAR_Leather_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_Leather_L", 25);
	SetCraftEXP("YFAUUN_ITAR_Leather_L", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Leather_L", "Кожевник")
	
	AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ITAR_BABE_LEATHER_L"); --- Женские кожаные доспехи
	SetCraftAmount("YFAUUN_ITAR_BABE_LEATHER_L", 1);
	 AddIngre("YFAUUN_ITAR_BABE_LEATHER_L", "aixopt_itmi_skin", 2);
	 AddTool("YFAUUN_ITAR_BABE_LEATHER_L", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_BABE_LEATHER_L", 10);
	SetCraftScience("YFAUUN_ITAR_BABE_LEATHER_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_BABE_LEATHER_L", 25);
	SetCraftEXP("YFAUUN_ITAR_BABE_LEATHER_L", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BABE_LEATHER_L", "Кожевник")
	
	AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ItAr_HNT_L"); --- Легкая охотничья одежда
	SetCraftAmount("YFAUUN_ItAr_HNT_L", 1);
	 AddIngre("YFAUUN_ItAr_HNT_L", "aixopt_itmi_skin", 2);
	 AddTool("YFAUUN_ItAr_HNT_L", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ItAr_HNT_L", 10);
	SetCraftScience("YFAUUN_ItAr_HNT_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ItAr_HNT_L", 25);
	SetCraftEXP("YFAUUN_ItAr_HNT_L", 50)
	SetCraftEXP_SKILL("YFAUUN_ItAr_HNT_L", "Кожевник")

	AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ITAR_PIR_M_HORINIS"); --- Одежда моряка
	SetCraftAmount("YFAUUN_ITAR_PIR_M_HORINIS", 1);
	 AddIngre("YFAUUN_ITAR_PIR_M_HORINIS", "aixopt_itmi_skin", 2);
	 AddTool("YFAUUN_ITAR_PIR_M_HORINIS", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_PIR_M_HORINIS", 10);
	SetCraftScience("YFAUUN_ITAR_PIR_M_HORINIS", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_PIR_M_HORINIS", 25);
	SetCraftEXP("YFAUUN_ITAR_PIR_M_HORINIS", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_PIR_M_HORINIS", "Кожевник")

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_OLDCAMP_L"); --- Одежда Тени
	SetCraftAmount("YFAUUN_ITAR_OLDCAMP_L", 1);
	 AddIngre("YFAUUN_ITAR_OLDCAMP_L", "aixopt_itmi_skin", 2);
	 AddTool("YFAUUN_ITAR_OLDCAMP_L", "OOLTYB_ITMI_RECIPESWSL");
	 AddTool("YFAUUN_ITAR_OLDCAMP_L", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_OLDCAMP_L", 10);
	SetCraftScience("YFAUUN_ITAR_OLDCAMP_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_OLDCAMP_L", 25);
	SetCraftEXP("YFAUUN_ITAR_OLDCAMP_L", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_OLDCAMP_L", "Кожевник")
	
	
	AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_NEWCAMP_L"); --- Одежда вора
	SetCraftAmount("YFAUUN_ITAR_NEWCAMP_L", 1);
	 AddIngre("YFAUUN_ITAR_NEWCAMP_L", "aixopt_itmi_skin", 2);
	 AddTool("YFAUUN_ITAR_NEWCAMP_L", "OOLTYB_ITMI_RECIPETFNL");
	 AddTool("YFAUUN_ITAR_NEWCAMP_L", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_NEWCAMP_L", 10);
	SetCraftScience("YFAUUN_ITAR_NEWCAMP_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_NEWCAMP_L", 25);
	SetCraftEXP("YFAUUN_ITAR_NEWCAMP_L", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWCAMP_L", "Кожевник")

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_NEUTRAL11"); --- Укрепленные кожаные доспехи
	SetCraftAmount("YFAUUN_ITAR_NEUTRAL11", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRAL11", "aixopt_itmi_skin", 5);
	 AddTool("YFAUUN_ITAR_NEUTRAL11", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_NEUTRAL11", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRAL11", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRAL11", 50);
	SetCraftEXP("YFAUUN_ITAR_NEUTRAL11", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEUTRAL11", "Кожевник")

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_HUNTER3"); --- Одежда охотника
	SetCraftAmount("YFAUUN_ITAR_HUNTER3", 1);
	 AddIngre("YFAUUN_ITAR_HUNTER3", "aixopt_itmi_skin", 5);
	 AddTool("YFAUUN_ITAR_HUNTER3", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_HUNTER3", 10);
	SetCraftScience("YFAUUN_ITAR_HUNTER3", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_HUNTER3", 50);
	SetCraftEXP("YFAUUN_ITAR_HUNTER3", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_HUNTER3", "Кожевник")

		AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_PIR_L_Addon"); --- Одежда пирата
	SetCraftAmount("YFAUUN_ITAR_PIR_L_Addon", 1);
	 AddIngre("YFAUUN_ITAR_PIR_L_Addon", "aixopt_itmi_skin", 5);
	 AddTool("YFAUUN_ITAR_PIR_L_Addon", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_PIR_L_Addon", 10);
	SetCraftScience("YFAUUN_ITAR_PIR_L_Addon", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_PIR_L_Addon", 50);
	SetCraftEXP("YFAUUN_ITAR_PIR_L_Addon", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_PIR_L_Addon", "Кожевник")
		
	AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_WALKER"); --- Кожаный плащ
	SetCraftAmount("YFAUUN_ITAR_WALKER", 1);
	 AddIngre("YFAUUN_ITAR_WALKER", "aixopt_itmi_skin", 5);
	 AddTool("YFAUUN_ITAR_WALKER", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_WALKER", 10);
	SetCraftScience("YFAUUN_ITAR_WALKER", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_WALKER", 50);
	SetCraftEXP("YFAUUN_ITAR_WALKER", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_WALKER", "Кожевник")
	
	AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_PIR_M_HORINIS2"); --- Одежда авантюриста
	SetCraftAmount("YFAUUN_ITAR_PIR_M_HORINIS2", 1);
	 AddIngre("YFAUUN_ITAR_PIR_M_HORINIS2", "aixopt_itmi_skin", 5);
	 AddTool("YFAUUN_ITAR_PIR_M_HORINIS2", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_PIR_M_HORINIS2", 10);
	SetCraftScience("YFAUUN_ITAR_PIR_M_HORINIS2", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_PIR_M_HORINIS2", 50);
	SetCraftEXP("YFAUUN_ITAR_PIR_M_HORINIS2", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_PIR_M_HORINIS2", "Кожевник")

	AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ItAr_ALBINO"); --- Доспехи альбиноса
	SetCraftAmount("YFAUUN_ItAr_ALBINO", 1);
	 AddIngre("YFAUUN_ItAr_ALBINO", "aixopt_itmi_skin", 5);
	 AddTool("YFAUUN_ItAr_ALBINO", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ItAr_ALBINO", 10);
	SetCraftScience("YFAUUN_ItAr_ALBINO", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ItAr_ALBINO", 50);
	SetCraftEXP("YFAUUN_ItAr_ALBINO", 150)
	SetCraftEXP_SKILL("YFAUUN_ItAr_ALBINO", "Кожевник")

	AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_TRAVELER"); ---Толстый кожаный плащ
	SetCraftAmount("YFAUUN_ITAR_TRAVELER", 1);
	 AddIngre("YFAUUN_ITAR_TRAVELER", "aixopt_itmi_skin", 5);
	 AddTool("YFAUUN_ITAR_TRAVELER", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_TRAVELER", 10);
	SetCraftScience("YFAUUN_ITAR_TRAVELER", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_TRAVELER", 50);
	SetCraftEXP("YFAUUN_ITAR_TRAVELER", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_TRAVELER", "Кожевник")

	AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_NEUTRAL"); --- Прочная одежда охотника
	SetCraftAmount("YFAUUN_ITAR_NEUTRAL", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRAL", "aixopt_itmi_skin", 5);
	 AddTool("YFAUUN_ITAR_NEUTRAL", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_NEUTRAL", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRAL", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRAL", 50);
	SetCraftEXP("YFAUUN_ITAR_NEUTRAL", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEUTRAL", "Кожевник")

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_REDSHAR"); --- Доспехи тени
	SetCraftAmount("YFAUUN_ITAR_REDSHAR", 1);
	 AddIngre("YFAUUN_ITAR_REDSHAR", "aixopt_itmi_skin", 5);
	 AddTool("YFAUUN_ITAR_REDSHAR", "OOLTYB_ITMI_RECIPESWSL");
	 AddTool("YFAUUN_ITAR_REDSHAR", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_REDSHAR", 10);
	SetCraftScience("YFAUUN_ITAR_REDSHAR", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_REDSHAR", 50);
	SetCraftEXP("YFAUUN_ITAR_REDSHAR", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_REDSHAR", "Кожевник")
	
	AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ORG_NEWCAMP_M"); --- Средние доспехи вора
	SetCraftAmount("YFAUUN_ORG_NEWCAMP_M", 1);
	 AddIngre("YFAUUN_ORG_NEWCAMP_M", "aixopt_itmi_skin", 5);
	 AddTool("YFAUUN_ORG_NEWCAMP_M", "OOLTYB_ITMI_RECIPETFNL");
	 AddTool("YFAUUN_ORG_NEWCAMP_M", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ORG_NEWCAMP_M", 10);
	SetCraftScience("YFAUUN_ORG_NEWCAMP_M", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ORG_NEWCAMP_M", 50);
	SetCraftEXP("YFAUUN_ORG_NEWCAMP_M", 150)
	SetCraftEXP_SKILL("YFAUUN_ORG_NEWCAMP_M", "Кожевник")

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_ORG_NEWCAMP_H"); --- Тяжелые доспехи вора 
	SetCraftAmount("YFAUUN_ORG_NEWCAMP_H", 1);
	 AddIngre("YFAUUN_ORG_NEWCAMP_H", "aixopt_itmi_skin", 10);
	 AddIngre("YFAUUN_ORG_NEWCAMP_H", "aixopt_itmi_dye", 1);
	 AddIngre("YFAUUN_ORG_NEWCAMP_H", "aixopt_itmi_rivetskin", 3);
	 AddIngre("YFAUUN_ORG_NEWCAMP_H", "aixopt_itmi_tannedskin", 3);
	 AddTool("YFAUUN_ORG_NEWCAMP_H", "OOLTYB_ITMI_RECIPETFNL");
	 AddTool("YFAUUN_ORG_NEWCAMP_H", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ORG_NEWCAMP_H", 10);
	SetCraftScience("YFAUUN_ORG_NEWCAMP_H", "Кожевник", 3);
	SetenergyPenalty("YFAUUN_ORG_NEWCAMP_H", 100);
	
	AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_ITAR_OLDCAMP_M"); --- Средние Доспехи призрака
	SetCraftAmount("YFAUUN_ITAR_OLDCAMP_M", 1);
	 AddIngre("YFAUUN_ITAR_OLDCAMP_M", "aixopt_itmi_skin", 10);
	 AddIngre("YFAUUN_ITAR_OLDCAMP_M", "aixopt_itmi_dye", 1);
	 AddIngre("YFAUUN_ITAR_OLDCAMP_M", "aixopt_itmi_rivetskin", 3);
	 AddIngre("YFAUUN_ITAR_OLDCAMP_M", "aixopt_itmi_tannedskin", 3);
	 AddTool("YFAUUN_ITAR_OLDCAMP_M", "OOLTYB_ITMI_RECIPESWSL");
	 AddTool("YFAUUN_ITAR_OLDCAMP_M", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_OLDCAMP_M", 10);
	SetCraftScience("YFAUUN_ITAR_OLDCAMP_M", "Кожевник", 3);
	SetenergyPenalty("YFAUUN_ITAR_OLDCAMP_M", 100);
	
	AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_ItAr_BDT_H"); --- тяжелая одежда из шкур с шарфом
	SetCraftAmount("YFAUUN_ItAr_BDT_H", 1);
	 AddIngre("YFAUUN_ItAr_BDT_H", "aixopt_itmi_skin", 10);
	 AddIngre("YFAUUN_ItAr_BDT_H", "aixopt_itmi_fineskin", 4);
	 AddIngre("YFAUUN_ItAr_BDT_H", "aixopt_itmi_linen", 3);
	 AddIngre("YFAUUN_ItAr_BDT_H", "aixopt_itmi_tannedskin", 4);
	 AddTool("YFAUUN_ItAr_BDT_H", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ItAr_BDT_H", 10);
	SetCraftScience("YFAUUN_ItAr_BDT_H", "Кожевник", 3);
	SetenergyPenalty("YFAUUN_ItAr_BDT_H", 100);
	
	AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_ItAr_COL"); --- доспехи колониста
	SetCraftAmount("YFAUUN_ItAr_COL", 1);
	 AddIngre("YFAUUN_ItAr_COL", "aixopt_itmi_skin", 10);
	 AddIngre("YFAUUN_ItAr_COL", "aixopt_itmi_fineskin", 4);
	 AddIngre("YFAUUN_ItAr_COL", "aixopt_itmi_linen", 3);
	 AddIngre("YFAUUN_ItAr_COL", "aixopt_itmi_rivetskin", 4);
	 AddTool("YFAUUN_ItAr_COL", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ItAr_COL", 10);
	SetCraftScience("YFAUUN_ItAr_COL", "Кожевник", 3);
	SetenergyPenalty("YFAUUN_ItAr_COL", 100);
	
	AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_ITAR_HUNTER4"); --- куртка охотника из качественных шкур
	SetCraftAmount("YFAUUN_ITAR_HUNTER4", 1);
	 AddIngre("YFAUUN_ITAR_HUNTER4", "aixopt_itmi_skin", 10);
	 AddIngre("YFAUUN_ITAR_HUNTER4", "aixopt_itmi_fineskin", 4);
	 AddIngre("YFAUUN_ITAR_HUNTER4", "aixopt_itmi_linen", 3);
	 AddIngre("YFAUUN_ITAR_HUNTER4", "aixopt_itmi_tannedskin", 4);
	 AddTool("YFAUUN_ITAR_HUNTER4", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_HUNTER4", 10);
	SetCraftScience("YFAUUN_ITAR_HUNTER4", "Кожевник", 3);
	SetenergyPenalty("YFAUUN_ITAR_HUNTER4", 100);
	
	AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_ITAR_NEUTRALM"); --- доспехи убийцы
	SetCraftAmount("YFAUUN_ITAR_NEUTRALM", 1);
	  AddIngre("YFAUUN_ITAR_NEUTRALM", "aixopt_itmi_skin", 10);
	 AddIngre("YFAUUN_ITAR_NEUTRALM", "aixopt_itmi_dye", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRALM", "aixopt_itmi_rivetskin", 3);
	 AddIngre("YFAUUN_ITAR_NEUTRALM", "aixopt_itmi_tannedskin", 3);
	 AddTool("YFAUUN_ITAR_NEUTRALM", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_NEUTRALM", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRALM", "Кожевник", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRALM", 100);
	
	--AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_ITAR_CRAWLER_L"); --- легкие доспехи из панцирных пластин
	--SetCraftAmount("YFAUUN_ITAR_CRAWLER_L", 1);
	 -- AddIngre("YFAUUN_ITAR_CRAWLER_L", "aixopt_itmi_skin", 15);
	 --AddIngre("YFAUUN_ITAR_CRAWLER_L", "yfauun_itar_underarmor", 1);
	 --AddIngre("YFAUUN_ITAR_CRAWLER_L", "aixopt_itmi_rivetskin", 3);
	-- AddIngre("YFAUUN_ITAR_CRAWLER_L", "aixopt_itmi_tannedskin", 3);
	-- AddTool("YFAUUN_ITAR_CRAWLER_L", "AIXOPT_ItMi_Needle");
	--SetCraftPenalty("YFAUUN_ITAR_CRAWLER_L", 10);
	--SetCraftScience("YFAUUN_ITAR_CRAWLER_L", "Кожевник", 3);
	--SetenergyPenalty("YFAUUN_ITAR_CRAWLER_L", 100);
	
	AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_ITAR_PIR_M_Addon"); --- доспехи пирата
	SetCraftAmount("YFAUUN_ITAR_PIR_M_Addon", 1);
	  AddIngre("YFAUUN_ITAR_PIR_M_Addon", "aixopt_itmi_skin", 10);
	 AddIngre("YFAUUN_ITAR_PIR_M_Addon", "aixopt_itmi_dye", 1);
	 AddIngre("YFAUUN_ITAR_PIR_M_Addon", "aixopt_itmi_rivetskin", 3);
	 AddIngre("YFAUUN_ITAR_PIR_M_Addon", "aixopt_itmi_tannedskin", 3);
	 AddTool("YFAUUN_ITAR_PIR_M_Addon", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_PIR_M_Addon", 10);
	SetCraftScience("YFAUUN_ITAR_PIR_M_Addon", "Кожевник", 3);
	SetenergyPenalty("YFAUUN_ITAR_PIR_M_Addon", 100);


-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА



	AddItemCategory ("(Б)Кузнец (1 уровень)", "YFAUUN_ItAr_RANGER_H"); --- Кольчуга с кожаной курткой
	SetCraftAmount("YFAUUN_ItAr_RANGER_H", 1);
	 AddIngre("YFAUUN_ItAr_RANGER_H", "aixopt_itmi_ironingot", 2);
	 AddTool("YFAUUN_ItAr_RANGER_H", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_RANGER_H", 10);
	SetCraftScience("YFAUUN_ItAr_RANGER_H", "Бронник", 1);
	SetenergyPenalty("YFAUUN_ItAr_RANGER_H", 25);
	SetCraftEXP("YFAUUN_ItAr_RANGER_H", 50)
	SetCraftEXP_SKILL("YFAUUN_ItAr_RANGER_H", "Бронник")

	AddItemCategory ("(Б)Кузнец (1 уровень)", "YFAUUN_ItAr_GHRB"); --- Легкие доспехи
	SetCraftAmount("YFAUUN_ItAr_GHRB", 1);
	 AddIngre("YFAUUN_ItAr_GHRB", "aixopt_itmi_ironingot", 2);
	 AddTool("YFAUUN_ItAr_GHRB", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_GHRB", 10);
	SetCraftScience("YFAUUN_ItAr_GHRB", "Бронник", 1);
	SetenergyPenalty("YFAUUN_ItAr_GHRB", 25);
	SetCraftEXP("YFAUUN_ItAr_GHRB", 50)
	SetCraftEXP_SKILL("YFAUUN_ItAr_GHRB", "Бронник")

AddItemCategory ("(Б)Кузнец (1 уровень)", "YFAUUN_SLD_ARMOR_L3"); --- Наплечник наемника
	SetCraftAmount("YFAUUN_SLD_ARMOR_L3", 1);
	 AddIngre("YFAUUN_SLD_ARMOR_L3", "aixopt_itmi_ironingot", 2);
	 AddTool("YFAUUN_SLD_ARMOR_L3", "gkwqdz_ItMw_1H_Mace_L_04");
	 AddTool("YFAUUN_SLD_ARMOR_L3", "OOLTYB_ITMI_RECIPEMYNL");
	SetCraftPenalty("YFAUUN_SLD_ARMOR_L3", 10);
	SetCraftScience("YFAUUN_SLD_ARMOR_L3", "Бронник", 1);
	SetenergyPenalty("yfauun_sld_armor_l3", 25);
	SetCraftEXP("YFAUUN_SLD_ARMOR_L3", 50)
	SetCraftEXP_SKILL("YFAUUN_SLD_ARMOR_L3", "Бронник")
	
	AddItemCategory ("(Б)Кузнец (1 уровень)", "YFAUUN_ITAR_OLDCAMPG_L"); --- Легкие доспехи стражника
	SetCraftAmount("YFAUUN_ITAR_OLDCAMPG_L", 1);
	 AddIngre("YFAUUN_ITAR_OLDCAMPG_L", "aixopt_itmi_ironingot", 2);
	 AddTool("YFAUUN_ITAR_OLDCAMPG_L", "gkwqdz_ItMw_1H_Mace_L_04");
	 AddTool("YFAUUN_ITAR_OLDCAMPG_L", "OOLTYB_ITMI_RECIPEGDSL");
	SetCraftPenalty("YFAUUN_ITAR_OLDCAMPG_L", 10);
	SetCraftScience("YFAUUN_ITAR_OLDCAMPG_L", "Бронник", 1);
	SetenergyPenalty("YFAUUN_ITAR_OLDCAMPG_L", 25);
	SetCraftEXP("YFAUUN_ITAR_OLDCAMPG_L", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_OLDCAMPG_L", "Бронник")

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА


	AddItemCategory ("(Б)Кузнец (2 уровень)", "YFAUUN_ITAR_CHAINMAIL"); --- Легкая кольчуга
	SetCraftAmount("YFAUUN_ITAR_CHAINMAIL", 1);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL", "aixopt_itmi_ironingot", 5);
	 AddTool("YFAUUN_ITAR_CHAINMAIL", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_CHAINMAIL", 10);
	SetCraftScience("YFAUUN_ITAR_CHAINMAIL", "Бронник", 2);
	SetenergyPenalty("YFAUUN_ITAR_CHAINMAIL", 50);
	SetCraftEXP("YFAUUN_ITAR_CHAINMAIL", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_CHAINMAIL", "Бронник")	


	AddItemCategory ("(Б)Кузнец (2 уровень)", "yfauun_itar_oldcampg_m"); --- Средние доспехи стражника
	SetCraftAmount("yfauun_itar_oldcampg_m", 1);
	 AddIngre("yfauun_itar_oldcampg_m", "aixopt_itmi_ironingot", 5);
	 AddTool("yfauun_itar_oldcampg_m", "OOLTYB_ITMI_RECIPEGDSL");
	 AddTool("yfauun_itar_oldcampg_m", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_oldcampg_m", 10);
	SetCraftScience("yfauun_itar_oldcampg_m", "Бронник", 2);
	SetenergyPenalty("yfauun_itar_oldcampg_m", 50);
	SetCraftEXP("yfauun_itar_oldcampg_m", 150)
	SetCraftEXP_SKILL("yfauun_itar_oldcampg_m", "Бронник")	

	
	AddItemCategory ("(Б)Кузнец (2 уровень)", "YFAUUN_ITAR_NEWCAMPM_L"); --- Легкие доспехи наемника
	SetCraftAmount("YFAUUN_ITAR_NEWCAMPM_L", 1);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_L", "aixopt_itmi_ironingot", 5);
	 AddTool("YFAUUN_ITAR_NEWCAMPM_L", "OOLTYB_ITMI_RECIPEMYNL");
	 AddTool("YFAUUN_ITAR_NEWCAMPM_L", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_NEWCAMPM_L", 10);
	SetCraftScience("YFAUUN_ITAR_NEWCAMPM_L", "Бронник", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEWCAMPM_L", 50);
	SetCraftEXP("YFAUUN_ITAR_NEWCAMPM_L", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWCAMPM_L", "Бронник")	

AddItemCategory ("(Б)Кузнец (2 уровень)", "YFAUUN_ItAr_LARM_M"); --- Кольчуга с наплечниками
	SetCraftAmount("YFAUUN_ItAr_LARM_M", 1);
	 AddIngre("YFAUUN_ItAr_LARM_M", "aixopt_itmi_ironingot", 5);
	 AddTool("YFAUUN_ItAr_LARM_M", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_LARM_M", 10);
	SetCraftScience("YFAUUN_ItAr_LARM_M", "Бронник", 2);
	SetenergyPenalty("YFAUUN_ItAr_LARM_M", 50);
	SetCraftEXP("YFAUUN_ItAr_LARM_M", 150)
	SetCraftEXP_SKILL("YFAUUN_ItAr_LARM_M", "Бронник")

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

AddItemCategory ("(Б)Кузнец (3 уровень)", "YFAUUN_ITAR_NEWCAMPM_M"); --- средние доспехи наемника
	SetCraftAmount("YFAUUN_ITAR_NEWCAMPM_M", 1);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_M", "aixopt_itmi_ironingot", 10);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_M", "aixopt_itmirawsteel", 4);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_M", "yfauun_itar_underarmor", 1);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_M", "aixopt_itmi_skin", 8);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_M", "aixopt_itmi_linen", 2);
	 AddTool("YFAUUN_ITAR_NEWCAMPM_M", "OOLTYB_ITMI_RECIPEMYNL");
	 AddTool("YFAUUN_ITAR_NEWCAMPM_M", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_NEWCAMPM_M", 10);
	SetCraftScience("YFAUUN_ITAR_NEWCAMPM_M", "Бронник", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEWCAMPM_M", 100);
	
	AddItemCategory ("(Б)Кузнец (3 уровень)", "yfauun_grd_armor_h"); --- Тяжелые доспехи стражника
	SetCraftAmount("yfauun_grd_armor_h", 1);
	 AddIngre("yfauun_grd_armor_h", "aixopt_itmi_ironingot", 10);
	 AddIngre("yfauun_grd_armor_h", "aixopt_itmirawsteel", 4);
	 AddIngre("yfauun_grd_armor_h", "yfauun_itar_underarmor", 1);
	 AddIngre("yfauun_grd_armor_h", "aixopt_itmi_skin", 8);
	 AddIngre("yfauun_grd_armor_h", "aixopt_itmi_linen", 2);
	 AddTool("yfauun_grd_armor_h", "OOLTYB_ITMI_RECIPEGDSL");
	 AddTool("yfauun_grd_armor_h", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_grd_armor_h", 10);
	SetCraftScience("yfauun_grd_armor_h", "Бронник", 3);
	SetenergyPenalty("yfauun_grd_armor_h", 100);
	
	AddItemCategory ("(Б)Кузнец (3 уровень)", "YFAUUN_ItAr_FKNGHT"); --- броня вольного рыцаря
	SetCraftAmount("YFAUUN_ItAr_FKNGHT", 1);
	 AddIngre("YFAUUN_ItAr_FKNGHT", "aixopt_itmi_ironingot", 10);
	 AddIngre("YFAUUN_ItAr_FKNGHT", "aixopt_itmirawsteel", 5);
	 AddIngre("YFAUUN_ItAr_FKNGHT", "yfauun_itar_underarmor", 1);
	 AddIngre("YFAUUN_ItAr_FKNGHT", "aixopt_itmi_dye", 1);
	 AddIngre("YFAUUN_ItAr_FKNGHT", "aixopt_itmi_fineskin", 1);
	 AddTool("YFAUUN_ItAr_FKNGHT", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_FKNGHT", 10);
	SetCraftScience("YFAUUN_ItAr_FKNGHT", "Бронник", 3);
	SetenergyPenalty("YFAUUN_ItAr_FKNGHT", 100);
	
	AddItemCategory ("(Б)Кузнец (3 уровень)", "YFAUUN_ItAr_HRB_H"); --- тяжелая кольчуга
	SetCraftAmount("YFAUUN_ItAr_HRB_H", 1);
	 AddIngre("YFAUUN_ItAr_HRB_H", "aixopt_itmi_ironingot", 10);
	 AddIngre("YFAUUN_ItAr_HRB_H", "aixopt_itmirawsteel", 4);
	 AddIngre("YFAUUN_ItAr_HRB_H", "yfauun_itar_underarmor", 1);
	 AddIngre("YFAUUN_ItAr_HRB_H", "aixopt_itmi_tannedskin", 2);
	 AddTool("YFAUUN_ItAr_HRB_H", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_HRB_H", 10);
	SetCraftScience("YFAUUN_ItAr_HRB_H", "Бронник", 3);
	SetenergyPenalty("YFAUUN_ItAr_HRB_H", 100);
	
	AddItemCategory ("(Б)Кузнец (3 уровень)", "YFAUUN_ITAR_CHAINMAIL2"); --- средняя кольчуга
	SetCraftAmount("YFAUUN_ITAR_CHAINMAIL2", 1);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL2", "aixopt_itmi_ironingot", 10);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL2", "aixopt_itmirawsteel", 4);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL2", "yfauun_itar_underarmor", 1);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL2", "aixopt_itmi_skin", 8);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL2", "aixopt_itmi_linen", 2);
	 AddTool("YFAUUN_ITAR_CHAINMAIL2", "gkwqdz_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_CHAINMAIL2", 10);
	SetCraftScience("YFAUUN_ITAR_CHAINMAIL2", "Бронник", 3);
	SetenergyPenalty("YFAUUN_ITAR_CHAINMAIL2", 100);
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	AddItemCategory ("Портной (1 уровень)", "yfauun_ithl_l_band"); --- Бандана 
    SetCraftAmount("yfauun_ithl_l_band", 1);
     AddIngre("yfauun_ithl_l_band", "aixopt_itmi_linen", 1);
    SetCraftPenalty("yfauun_ithl_l_band", 10);
    SetCraftScience("yfauun_ithl_l_band", "Портной", 1);
    SetenergyPenalty("yfauun_ithl_l_band", 25);
    SetCraftEXP("yfauun_ithl_l_band", 50)
    SetCraftEXP_SKILL("yfauun_ithl_l_band", "Портной")

	AddItemCategory ("Портной (Расходники)", "aixopt_itmi_linen"); --- Сукно
	SetCraftAmount("aixopt_itmi_linen", 1);
	 AddIngre("aixopt_itmi_linen", "aixopt_itmi_wool", 10);
	 AddTool("aixopt_itmi_linen", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("aixopt_itmi_linen", 5);
	SetCraftScience("aixopt_itmi_linen", "Портной", 1);
	SetenergyPenalty("aixopt_itmi_linen", 25);
	SetCraftEXP("aixopt_itmi_linen", 25)
	SetCraftEXP_SKILL("aixopt_itmi_linen", "Портной")
	
	
	AddItemCategory ("Портной (Расходники)", "OOLTYB_ITMI_BINT"); --- Бинт
	SetCraftAmount("OOLTYB_ITMI_BINT", 4);
	 AddIngre("OOLTYB_ITMI_BINT", "aixopt_itmi_linen", 1);
	 AddTool("OOLTYB_ITMI_BINT", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("OOLTYB_ITMI_BINT", 5);
	SetCraftScience("OOLTYB_ITMI_BINT", "Портной", 1);
	SetenergyPenalty("OOLTYB_ITMI_BINT", 25);
	SetCraftEXP("OOLTYB_ITMI_BINT", 25)
	SetCraftEXP_SKILL("OOLTYB_ITMI_BINT", "Портной")	
	
	AddItemCategory ("Портной (Без уровня)", "ooltyb_itmi_palatka"); --- Палатка
	SetCraftAmount("ooltyb_itmi_palatka", 1);
	 AddIngre("ooltyb_itmi_palatka", "aixopt_itmi_linen", 1);
	 AddTool("ooltyb_itmi_palatka", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("ooltyb_itmi_palatka", 5);
	SetCraftScience("ooltyb_itmi_palatka", "Портной", 1);
	SetenergyPenalty("ooltyb_itmi_palatka", 25);
	SetCraftEXP("ooltyb_itmi_palatka", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_palatka", "Портной")
	
	AddItemCategory ("Портной (Без уровня)", "yfauun_itar_torba"); --- Сумка
	SetCraftAmount("yfauun_itar_torba", 1);
	 AddIngre("yfauun_itar_torba", "aixopt_itmi_wool", 10);
	 AddTool("yfauun_itar_torba", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("yfauun_itar_torba", 5);
	SetCraftScience("yfauun_itar_torba", "Портной", 1);
	SetenergyPenalty("yfauun_itar_torba", 5);
	SetCraftEXP("yfauun_itar_torba", 5)
	SetCraftEXP_SKILL("yfauun_itar_torba", "Портной")
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_Smith"); --- Одежда кузнеца
	SetCraftAmount("YFAUUN_ITAR_Smith", 1);
	 AddIngre("YFAUUN_ITAR_Smith", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_Smith", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_Smith", 10);
	SetCraftScience("YFAUUN_ITAR_Smith", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Smith", 10);
	SetCraftEXP("YFAUUN_ITAR_Smith", 10)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Smith", "Портной")


	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_Barkeeper"); --- Одежда трактирщика
	SetCraftAmount("YFAUUN_ITAR_Barkeeper", 1);
	 AddIngre("YFAUUN_ITAR_Barkeeper", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_Barkeeper", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_Barkeeper", 10);
	SetCraftScience("YFAUUN_ITAR_Barkeeper", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Barkeeper", 10);
	SetCraftEXP("YFAUUN_ITAR_Barkeeper", 10)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Barkeeper", "Портной")


	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_Bau_L"); --- Одежда крестьянина
	SetCraftAmount("YFAUUN_ITAR_Bau_L", 1);
	 AddIngre("YFAUUN_ITAR_Bau_L", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_Bau_L", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_Bau_L", 10);
	SetCraftScience("YFAUUN_ITAR_Bau_L", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Bau_L", 10);
	SetCraftEXP("YFAUUN_ITAR_Bau_L", 10)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Bau_L", "Портной")


	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_BAU_A"); --- Зеленая одежда крестьянина
	SetCraftAmount("YFAUUN_ITAR_BAU_A", 1);
	 AddIngre("YFAUUN_ITAR_BAU_A", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_BAU_A", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_BAU_A", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_A", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_A", 10);
	SetCraftEXP("YFAUUN_ITAR_BAU_A", 10)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BAU_A", "Портной")


	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_BAU_B"); --- Красная одежда крестьянина
	SetCraftAmount("YFAUUN_ITAR_BAU_B", 1);
	 AddIngre("YFAUUN_ITAR_BAU_B", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_BAU_B", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_BAU_B", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_B", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_B", 10);
	SetCraftEXP("YFAUUN_ITAR_BAU_B", 10)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BAU_B", "Портной")

	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_Prisoner"); --- Штаны рудокопа
	SetCraftAmount("YFAUUN_ITAR_Prisoner", 1);
	 AddIngre("YFAUUN_ITAR_Prisoner", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_Prisoner", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_Prisoner", 10);
	SetCraftScience("YFAUUN_ITAR_Prisoner", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Prisoner", 10);
	SetCraftEXP("YFAUUN_ITAR_Prisoner", 10)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Prisoner", "Портной")

	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_STANI"); --- Штаны моряка
	SetCraftAmount("YFAUUN_ITAR_STANI", 1);
	 AddIngre("YFAUUN_ITAR_STANI", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_STANI", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_STANI", 10);
	SetCraftScience("YFAUUN_ITAR_STANI", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_STANI", 10);
	SetCraftEXP("YFAUUN_ITAR_STANI", 10)
	SetCraftEXP_SKILL("YFAUUN_ITAR_STANI", "Портной")

	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_SAILOR"); --- Зеленая одежда рабочего
	SetCraftAmount("YFAUUN_ITAR_SAILOR", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_SAILOR", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR", 10);
	SetCraftEXP("YFAUUN_ITAR_SAILOR", 10)
	SetCraftEXP_SKILL("YFAUUN_ITAR_SAILOR", "Портной")

	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_SAILOR1"); --- Голубая одежда рабочего
	SetCraftAmount("YFAUUN_ITAR_SAILOR1", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR1", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_SAILOR1", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR1", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR1", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR1", 10);
	SetCraftEXP("YFAUUN_ITAR_SAILOR1", 10)
	SetCraftEXP_SKILL("YFAUUN_ITAR_SAILOR1", "Портной")

	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_SAILOR2"); --- Коричневая одежда рабочего
	SetCraftAmount("YFAUUN_ITAR_SAILOR2", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR2", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_SAILOR2", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR2", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR2", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR2", 10);
	SetCraftEXP("YFAUUN_ITAR_SAILOR2", 10)
	SetCraftEXP_SKILL("YFAUUN_ITAR_SAILOR2", "Портной")

	AddItemCategory ("Портной (Без уровня)", "YFAUUN_ITAR_SAILOR3"); --- Черная одежда рабочего
	SetCraftAmount("YFAUUN_ITAR_SAILOR3", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR3", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_SAILOR3", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR3", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR3", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR3", 10);
	SetCraftEXP("YFAUUN_ITAR_SAILOR3", 10)
	SetCraftEXP_SKILL("YFAUUN_ITAR_SAILOR3", "Портной")

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_UNDERARMOR"); --- Поддоспешник
	SetCraftAmount("YFAUUN_ITAR_UNDERARMOR", 1);
	 AddIngre("YFAUUN_ITAR_UNDERARMOR", "aixopt_itmi_linen", 2);
	SetCraftPenalty("YFAUUN_ITAR_UNDERARMOR", 10);
	SetCraftScience("YFAUUN_ITAR_UNDERARMOR", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_UNDERARMOR", 25);
	SetCraftEXP("YFAUUN_ITAR_UNDERARMOR", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_UNDERARMOR", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_VAV"); --- Одеяние алхимика
	SetCraftAmount("YFAUUN_ITAR_VAV", 1);
	 AddIngre("YFAUUN_ITAR_VAV", "aixopt_itmi_linen", 2);
	SetCraftPenalty("YFAUUN_ITAR_VAV", 10);
	SetCraftScience("YFAUUN_ITAR_VAV", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_VAV", 25);
	SetCraftEXP("YFAUUN_ITAR_VAV", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VAV", "Портной")
	
	AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_DARKROBE"); --- Плащ из плотной ткани
	SetCraftAmount("YFAUUN_ITAR_DARKROBE", 1);
	 AddIngre("YFAUUN_ITAR_DARKROBE", "aixopt_itmi_linen", 2);
	SetCraftPenalty("YFAUUN_ITAR_DARKROBE", 10);
	SetCraftScience("YFAUUN_ITAR_DARKROBE", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_DARKROBE", 25);
	SetCraftEXP("YFAUUN_ITAR_DARKROBE", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_DARKROBE", "Портной")

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_NEUTRAL22"); --- Бригантина
	SetCraftAmount("YFAUUN_ITAR_NEUTRAL22", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRAL22", "aixopt_itmi_linen", 5);
	SetCraftPenalty("YFAUUN_ITAR_NEUTRAL22", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRAL22", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRAL22", 50);
	SetCraftEXP("YFAUUN_ITAR_NEUTRAL22", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEUTRAL22", "Портной")

	AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_Vlk_L"); --- Коричневый дублет
	SetCraftAmount("YFAUUN_ITAR_Vlk_L", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_L", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_Vlk_L", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_L", 10);
	SetCraftScience("YFAUUN_ITAR_Vlk_L", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_L", 25);
	SetCraftEXP("YFAUUN_ITAR_Vlk_L", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Vlk_L", "Портной")

		AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_BAU_C"); --- Красная одежда фермера
	SetCraftAmount("YFAUUN_ITAR_BAU_C", 1);
	 AddIngre("YFAUUN_ITAR_BAU_C", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_BAU_C", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_BAU_C", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_C", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_C", 25);
	SetCraftEXP("YFAUUN_ITAR_BAU_C", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BAU_C", "Портной")

	AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_BAU_M"); --- Одежда фермера
	SetCraftAmount("YFAUUN_ITAR_BAU_M", 1);
	 AddIngre("YFAUUN_ITAR_BAU_M", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_BAU_M", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_BAU_M", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_M", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_M", 25);
	SetCraftEXP("YFAUUN_ITAR_BAU_M", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BAU_M", "Портной")

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_BauBabe_L"); --- Бежевое платье
	SetCraftAmount("YFAUUN_ITAR_BauBabe_L", 1);
	 AddIngre("YFAUUN_ITAR_BauBabe_L", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_BauBabe_L", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_BauBabe_L", 10);
	SetCraftScience("YFAUUN_ITAR_BauBabe_L", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_BauBabe_L", 50);
	SetCraftEXP("YFAUUN_ITAR_BauBabe_L", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BauBabe_L", "Портной")


	AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_BauBabe_M"); --- Зеленое платье
	SetCraftAmount("YFAUUN_ITAR_BauBabe_M", 1);
	 AddIngre("YFAUUN_ITAR_BauBabe_M", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_BauBabe_M", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_BauBabe_M", 10);
	SetCraftScience("YFAUUN_ITAR_BauBabe_M", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BauBabe_M", 25);
	SetCraftEXP("YFAUUN_ITAR_BauBabe_M", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BauBabe_M", "Портной")

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_Vlk_H"); --- Бежевый дублет
	SetCraftAmount("YFAUUN_ITAR_Vlk_H", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_H", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_Vlk_H", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_H", 10);
	SetCraftScience("YFAUUN_ITAR_Vlk_H", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_H", 50);
	SetCraftEXP("YFAUUN_ITAR_Vlk_H", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Vlk_H", "Портной")

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_Vlk_Khr01"); --- Короткий дублет
	SetCraftAmount("YFAUUN_ITAR_Vlk_Khr01", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_Khr01", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_Vlk_Khr01", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_Khr01", 10);
	SetCraftScience("YFAUUN_ITAR_Vlk_Khr01", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_Khr01", 50);
	SetCraftEXP("YFAUUN_ITAR_Vlk_Khr01", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Vlk_Khr01", "Портной")

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_D"); --- Синий дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_D", 1);
	 AddIngre("YFAUUN_ITAR_VLK_D", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_VLK_D", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLK_D", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_D", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_D", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_D", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_D", "Портной")

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_Y"); --- Черный дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_Y", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Y", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_VLK_Y", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Y", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_Y", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Y", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_Y", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_Y", "Портной")

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_P"); --- Коричневый плащ
	SetCraftAmount("YFAUUN_ITAR_VLK_P", 1);
	 AddIngre("YFAUUN_ITAR_VLK_P", "aixopt_itmi_linen", 2);
	 AddTool("YFAUUN_ITAR_VLK_P", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLK_P", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_P", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_P", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_P", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_P", "Портной")

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_N"); --- Черный плащ
	SetCraftAmount("YFAUUN_ITAR_VLK_N", 1);
	 AddIngre("YFAUUN_ITAR_VLK_N", "aixopt_itmi_linen", 2);
	 AddTool("YFAUUN_ITAR_VLK_N", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLK_N", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_N", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_N", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_N", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_N", "Портной")

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_Q"); --- Желтый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_Q", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Q", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_VLK_Q", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Q", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_Q", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Q", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_Q", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_Q", "Портной")

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_W"); --- Серый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_W", 1);
	 AddIngre("YFAUUN_ITAR_VLK_W", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_VLK_W", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLK_W", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_W", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_W", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_W", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_W", "Портной")

	AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_Y1"); --- Красный дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_Y1", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Y1", "aixopt_itmi_linen", 1);
	 AddTool("YFAUUN_ITAR_VLK_Y1", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Y1", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_Y1", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Y1", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_Y1", 150)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_Y1", "Портной")
	
	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_VLK_F"); --- Белый плащ
	SetCraftAmount("YFAUUN_ITAR_VLK_F", 1);
	 AddIngre("YFAUUN_ITAR_VLK_F", "aixopt_itmi_linen", 2);
	 AddTool("YFAUUN_ITAR_VLK_F", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLK_F", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_F", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_VLK_F", 100);
	

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_VLK_E"); --- Бежевый плащ
	SetCraftAmount("YFAUUN_ITAR_VLK_E", 1);
	 AddIngre("YFAUUN_ITAR_VLK_E", "aixopt_itmi_linen", 2);
	 AddTool("YFAUUN_ITAR_VLK_E", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLK_E", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_E", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_VLK_E", 100);

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_Judge"); --- Мантия судьи
	SetCraftAmount("YFAUUN_ITAR_Judge", 1);
	 AddIngre("YFAUUN_ITAR_Judge", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_Judge", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_Judge", 20);
	SetCraftScience("YFAUUN_ITAR_Judge", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_Judge", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_Vlk_M"); --- Розовый стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_Vlk_M", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_M", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_Vlk_M", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_M", 20);
	SetCraftScience("YFAUUN_ITAR_Vlk_M", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_M", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VlkBabe_L"); --- Голубое платье
	SetCraftAmount("YFAUUN_ITAR_VlkBabe_L", 1);
	 AddIngre("YFAUUN_ITAR_VlkBabe_L", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_VlkBabe_L", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VlkBabe_L", 20);
	SetCraftScience("YFAUUN_ITAR_VlkBabe_L", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VlkBabe_L", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VlkBabe_M"); --- белое платье
	SetCraftAmount("YFAUUN_ITAR_VlkBabe_M", 1);
	 AddIngre("YFAUUN_ITAR_VlkBabe_M", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_VlkBabe_M", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VlkBabe_M", 20);
	SetCraftScience("YFAUUN_ITAR_VlkBabe_M", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VlkBabe_M", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VlkBabe_H"); --- Черное платье
	SetCraftAmount("YFAUUN_ITAR_VlkBabe_H", 1);
	 AddIngre("YFAUUN_ITAR_VlkBabe_H", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_VlkBabe_H", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VlkBabe_H", 20);
	SetCraftScience("YFAUUN_ITAR_VlkBabe_H", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VlkBabe_H", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_BauBabe_N"); --- Сиреневое платье
	SetCraftAmount("YFAUUN_ITAR_BauBabe_N", 1);
	 AddIngre("YFAUUN_ITAR_BauBabe_N", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_BauBabe_N", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_BauBabe_N", 20);
	SetCraftScience("YFAUUN_ITAR_BauBabe_N", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_BauBabe_N", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VLK_J"); --- Стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_J", 1);
	 AddIngre("YFAUUN_ITAR_VLK_J", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_VLK_J", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLK_J", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_J", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VLK_J", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VLK_Z"); --- Бежевый стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_Z", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Z", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_VLK_Z", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Z", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_Z", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Z", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VLK_A"); --- Серый стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_A", 1);
	 AddIngre("YFAUUN_ITAR_VLK_A", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_VLK_A", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLK_A", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_A", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VLK_A", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VLK_C"); --- Темно-зеленый стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_C", 1);
	 AddIngre("YFAUUN_ITAR_VLK_C", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_VLK_C", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLK_C", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_C", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VLK_C", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VLK_A"); --- Серый стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_A", 1);
	 AddIngre("YFAUUN_ITAR_VLK_A", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_VLK_A", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLK_A", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_A", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VLK_A", 100);

	AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VLKBABE_S"); --- Красное платье
	SetCraftAmount("YFAUUN_ITAR_VLKBABE_S", 1);
	 AddIngre("YFAUUN_ITAR_VLKBABE_S", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_VLKBABE_S", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_VLKBABE_S", 20);
	SetCraftScience("YFAUUN_ITAR_VLKBABE_S", "Портной", 4);
	SetenergyPenalty("YFAUUN_ITAR_VLKBABE_S", 100);

--Серый стеганый дублет

-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_NEWPLAT_05"); --- Дорогое красное платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_05", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_05", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_NEWPLAT_05", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_05", 20);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_05", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_05", 100);

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_NEWPLAT_04"); --- Дворянское черное платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_04", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_04", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_NEWPLAT_04", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_04", 20);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_04", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_04", 100);

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_NEWPLAT_03"); --- Дворянское зеленое платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_03", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_03", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_NEWPLAT_03", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_03", 20);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_03", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_03", 100);

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_NEWPLAT_02"); --- Дворянское красное платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_02", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_02", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_NEWPLAT_02", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_02", 20);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_02", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_02", 100);

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_NEWPLAT_01"); --- Дворянское голубое платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_01", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_01", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_NEWPLAT_01", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_01", 20);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_01", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_01", 100);

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_BURG4"); --- Хорошая одежда горожанина
	SetCraftAmount("YFAUUN_ITAR_BURG4", 1);
	 AddIngre("YFAUUN_ITAR_BURG4", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_BURG4", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_BURG4", 20);
	SetCraftScience("YFAUUN_ITAR_BURG4", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_BURG4", 100);

	AddItemCategory ("Портной (4 уровень)", "YFAUUN_ITAR_Governor"); --- Богатая красная одежда горожанина
	SetCraftAmount("YFAUUN_ITAR_Governor", 1);
	 AddIngre("YFAUUN_ITAR_Governor", "aixopt_itmi_linen", 6);
	 AddTool("YFAUUN_ITAR_Governor", "AIXOPT_ItMi_Needle");
	SetCraftPenalty("YFAUUN_ITAR_Governor", 20);
	SetCraftScience("YFAUUN_ITAR_Governor", "Портной", 5);
	SetenergyPenalty("YFAUUN_ITAR_Governor", 100);

-- робы магов

AddItemCategory ("Робы магов", "yfauun_itar_kdw_s"); --- Облачение послушника круга воды
	SetCraftAmount("yfauun_itar_kdw_s", 1);
	 AddIngre("yfauun_itar_kdw_s", "aixopt_itmi_linen", 2);
	 AddTool("yfauun_itar_kdw_s", "AIXOPT_ItMi_Needle");
	 AddTool("yfauun_itar_kdw_s", "ooltyb_itmi_recipe1");
	SetCraftPenalty("yfauun_itar_kdw_s", 5);
	SetCraftScience("yfauun_itar_kdw_s", "Портной", 1);
	SetenergyPenalty("yfauun_itar_kdw_s", 25);
	SetCraftEXP("yfauun_itar_kdw_s", 50)
	SetCraftEXP_SKILL("yfauun_itar_kdw_s", "Портной")
	
	AddItemCategory ("Робы магов", "yfauun_itar_nov_l"); --- послушник круга огня
	SetCraftAmount("yfauun_itar_nov_l", 1);
	 AddIngre("yfauun_itar_nov_l", "aixopt_itmi_linen", 2);
	 AddTool("yfauun_itar_nov_l", "AIXOPT_ItMi_Needle");
	 AddTool("yfauun_itar_nov_l", "ooltyb_itmi_recipe2");
	SetCraftPenalty("yfauun_itar_nov_l", 5);
	SetCraftScience("yfauun_itar_nov_l", "Портной", 1);
	SetenergyPenalty("yfauun_itar_nov_l", 25);
	SetCraftEXP("yfauun_itar_nov_l", 50)
	SetCraftEXP_SKILL("yfauun_itar_nov_l", "Портной")

AddItemCategory ("Робы магов", "YFAUUN_KDF_ARMOR_L"); --- роба ученика мага огня
	SetCraftAmount("YFAUUN_KDF_ARMOR_L", 1);
	 AddIngre("YFAUUN_KDF_ARMOR_L", "aixopt_itmi_linen", 4);
	 AddIngre("YFAUUN_KDF_ARMOR_L", "aixopt_itmi_dye", 1);
	 AddIngre("YFAUUN_KDF_ARMOR_L", "zdpwla_itmi_beltlm", 1);
	 AddTool("YFAUUN_KDF_ARMOR_L", "AIXOPT_ItMi_Needle");
	 AddTool("YFAUUN_KDF_ARMOR_L", "ooltyb_itmi_recipe2");
	SetCraftPenalty("YFAUUN_KDF_ARMOR_L", 5);
	SetCraftScience("YFAUUN_KDF_ARMOR_L", "Портной", 2);
	SetenergyPenalty("YFAUUN_KDF_ARMOR_L", 50);
	SetCraftEXP("YFAUUN_KDF_ARMOR_L", 150)
	SetCraftEXP_SKILL("YFAUUN_KDF_ARMOR_L", "Портной")

AddItemCategory ("Робы магов", "yfauun_itar_kdw_l"); --- роба ученика мага воды
	SetCraftAmount("yfauun_itar_kdw_l", 1);
	 AddIngre("yfauun_itar_kdw_l", "aixopt_itmi_linen", 4);
	 AddIngre("yfauun_itar_kdw_l", "aixopt_itmi_dye", 1);
	 AddIngre("yfauun_itar_kdw_l", "zdpwla_itmi_beltlm", 1);
	 AddTool("yfauun_itar_kdw_l", "AIXOPT_ItMi_Needle");
	 AddTool("yfauun_itar_kdw_l", "ooltyb_itmi_recipe1");
	SetCraftPenalty("yfauun_itar_kdw_l", 5);
	SetCraftScience("yfauun_itar_kdw_l", "Портной", 2);
	SetenergyPenalty("yfauun_itar_kdw_l", 50);
	SetCraftEXP("yfauun_itar_kdw_l", 150)
	SetCraftEXP_SKILL("yfauun_itar_kdw_l", "Портной")
	
	AddItemCategory ("Робы магов", "yfauun_itar_kdw_l_addon"); --- мантия мага воды
	SetCraftAmount("yfauun_itar_kdw_l_addon", 1);
	 AddIngre("yfauun_itar_kdw_l_addon", "aixopt_itmi_linen", 6);
	 AddIngre("yfauun_itar_kdw_l_addon", "aixopt_itmi_dye", 2);
	 AddIngre("yfauun_itar_kdw_l_addon", "zdpwla_itmi_belthm", 1);
	 AddIngre("yfauun_itar_kdw_l_addon", "aixopt_itmi_jewelery", 1);
	 AddTool("yfauun_itar_kdw_l_addon", "AIXOPT_ItMi_Needle");
	 AddTool("yfauun_itar_kdw_l_addon", "ooltyb_itmi_recipe1");
	SetCraftPenalty("yfauun_itar_kdw_l_addon", 5);
	SetCraftScience("yfauun_itar_kdw_l_addon", "Портной", 3);
	SetenergyPenalty("yfauun_itar_kdw_l_addon", 100);
	
	AddItemCategory ("Робы магов", "yfauun_itar_kdf_l"); --- мантия мага воды
	SetCraftAmount("yfauun_itar_kdf_l", 1);
	 AddIngre("yfauun_itar_kdf_l", "aixopt_itmi_linen", 6);
	 AddIngre("yfauun_itar_kdf_l", "aixopt_itmi_dye", 2);
	 AddIngre("yfauun_itar_kdf_l", "zdpwla_itmi_belthm", 1);
	 AddIngre("yfauun_itar_kdf_l", "aixopt_itmi_jewelery", 1);
	 AddTool("yfauun_itar_kdf_l", "AIXOPT_ItMi_Needle");
	 AddTool("yfauun_itar_kdf_l", "ooltyb_itmi_recipe2");
	SetCraftPenalty("yfauun_itar_kdf_l", 5);
	SetCraftScience("yfauun_itar_kdf_l", "Портной", 3);
	SetenergyPenalty("yfauun_itar_kdf_l", 100);
	
---------------------------------------------------------------------------------------------------------------------------------------------------------------

	AddItemCategory ("(С) 1-й Круг", "hymyrk_ItSc_Firebolt"); ----- огненная стрела
	SetCraftAmount("hymyrk_ItSc_Firebolt", 1);
	 AddIngre("hymyrk_ItSc_Firebolt", "ooltyb_itmi_magicore", 1);
	 AddIngre("hymyrk_ItSc_Firebolt", "aixopt_itmi_paper", 2);
    AddTool("hymyrk_ItSc_Firebolt", "ooltyb_itmi_kscf");
	AddTool("hymyrk_ItSc_Firebolt", "ooltyb_itmi_kft1");
	SetCraftPenalty("hymyrk_ItSc_Firebolt", 5);
	SetCraftScience("hymyrk_ItSc_Firebolt", "Магия", 1);
	SetenergyPenalty("hymyrk_ItSc_Firebolt", 10);
	
	AddItemCategory ("(С) 1-й Круг", "hymyrk_ItSc_LightHeal"); ----- легкое лечение
	SetCraftAmount("hymyrk_ItSc_LightHeal", 1);
	 AddIngre("hymyrk_ItSc_LightHeal", "ooltyb_itmi_magicore", 1);
	 AddIngre("hymyrk_ItSc_LightHeal", "aixopt_itmi_paper", 2);
    AddTool("hymyrk_ItSc_LightHeal", "ooltyb_itmi_kft1");
	SetCraftPenalty("hymyrk_ItSc_LightHeal", 5);
	SetCraftScience("hymyrk_ItSc_LightHeal", "Магия", 1);
	SetenergyPenalty("hymyrk_ItSc_LightHeal", 10);
	
	AddItemCategory ("(С) 1-й Круг", "hymyrk_ItSc_Light"); ----- свет
	SetCraftAmount("hymyrk_ItSc_Light", 1);
	 AddIngre("hymyrk_ItSc_Light", "ooltyb_itmi_magicore", 1);
	 AddIngre("hymyrk_ItSc_Light", "aixopt_itmi_paper", 2);
    AddTool("hymyrk_ItSc_Light", "ooltyb_itmi_kft1");
	SetCraftPenalty("hymyrk_ItSc_Light", 5);
	SetCraftScience("hymyrk_ItSc_Light", "Магия", 1);
	SetenergyPenalty("hymyrk_ItSc_Light", 10);
	
	AddItemCategory ("(С) 1-й Круг", "hymyrk_ItSc_Zap"); ----- вспышка
	SetCraftAmount("hymyrk_ItSc_Zap", 1);
	 AddIngre("hymyrk_ItSc_Zap", "ooltyb_itmi_magicore", 1);
	 AddIngre("hymyrk_ItSc_Zap", "aixopt_itmi_paper", 2);
    AddTool("hymyrk_ItSc_Zap", "ooltyb_itmi_kft1");
	AddTool("hymyrk_ItSc_Zap", "ooltyb_itmi_kscw");
	SetCraftPenalty("hymyrk_ItSc_Zap", 5);
	SetCraftScience("hymyrk_ItSc_Zap", "Магия", 1);
	SetenergyPenalty("hymyrk_ItSc_Zap", 10);
	
	------- 2 круг свитки
	
	AddItemCategory ("(С) 2-й Круг", "hymyrk_ItSc_InstantFireball"); ----- огненный шар
	SetCraftAmount("hymyrk_ItSc_InstantFireball", 1);
	 AddIngre("hymyrk_ItSc_InstantFireball", "ooltyb_itmi_magicore", 2);
	 AddIngre("hymyrk_ItSc_InstantFireball", "aixopt_itmi_paper", 4);
    AddTool("hymyrk_ItSc_InstantFireball", "ooltyb_itmi_kft1");
	AddTool("hymyrk_ItSc_InstantFireball", "ooltyb_itmi_kscf");
	SetCraftPenalty("hymyrk_ItSc_InstantFireball", 5);
	SetCraftScience("hymyrk_ItSc_InstantFireball", "Магия", 2);
	SetenergyPenalty("hymyrk_ItSc_InstantFireball", 10);
	
	AddItemCategory ("(С) 2-й Круг", "hymyrk_itsc_waterfist"); ----- кулак воды
	SetCraftAmount("hymyrk_itsc_waterfist", 1);
	 AddIngre("hymyrk_itsc_waterfist", "ooltyb_itmi_magicore", 2);
	 AddIngre("hymyrk_itsc_waterfist", "aixopt_itmi_paper", 4);
    AddTool("hymyrk_itsc_waterfist", "ooltyb_itmi_kft1");
	AddTool("hymyrk_itsc_waterfist","ooltyb_itmi_kscw");
	SetCraftPenalty("hymyrk_itsc_waterfist", 5);
	SetCraftScience("hymyrk_itsc_waterfist", "Магия", 2);
	SetenergyPenalty("hymyrk_itsc_waterfist", 10);
	
	------- 3 круг свитки
	
	AddItemCategory ("(С) 3-й Круг", "hymyrk_itsc_chargefireball"); ----- большой огненный шар
	SetCraftAmount("hymyrk_itsc_chargefireball", 1);
	 AddIngre("hymyrk_itsc_chargefireball", "ooltyb_itmi_magicore", 3);
	 AddIngre("hymyrk_itsc_chargefireball", "aixopt_itmi_paper", 8);
    AddTool("hymyrk_itsc_chargefireball", "ooltyb_itmi_kft2");
	AddTool("hymyrk_itsc_chargefireball", "ooltyb_itmi_kscf");
	SetCraftPenalty("hymyrk_itsc_chargefireball", 5);
	SetCraftScience("hymyrk_itsc_chargefireball", "Магия", 4);
	SetenergyPenalty("hymyrk_itsc_chargefireball", 25);
	
	AddItemCategory ("(С) 3-й Круг", "hymyrk_itsc_harmundead"); ----- уничтожение нежити
	SetCraftAmount("hymyrk_itsc_harmundead", 1);
	 AddIngre("hymyrk_itsc_harmundead", "ooltyb_itmi_magicore", 3);
	 AddIngre("hymyrk_itsc_harmundead", "aixopt_itmi_paper", 8);
    AddTool("hymyrk_itsc_harmundead", "ooltyb_itmi_kft2");
	AddTool("hymyrk_itsc_harmundead", "ooltyb_itmi_kscf");
	SetCraftPenalty("hymyrk_itsc_harmundead", 5);
	SetCraftScience("hymyrk_itsc_harmundead", "Магия", 4);
	SetenergyPenalty("hymyrk_itsc_harmundead", 25);
	
	AddItemCategory ("(С) 3-й Круг", "hymyrk_itsc_icebolt"); ----- ледяная стрела
	SetCraftAmount("hymyrk_itsc_icebolt", 1);
	 AddIngre("hymyrk_itsc_icebolt", "ooltyb_itmi_magicore", 3);
	 AddIngre("hymyrk_itsc_icebolt", "aixopt_itmi_paper", 8);
    AddTool("hymyrk_itsc_icebolt", "ooltyb_itmi_kft2");
	AddTool("hymyrk_itsc_icebolt", "ooltyb_itmi_kscw");
	SetCraftPenalty("hymyrk_itsc_icebolt", 5);
	SetCraftScience("hymyrk_itsc_icebolt", "Магия", 4);
	SetenergyPenalty("hymyrk_itsc_icebolt", 25);
	
	AddItemCategory ("(С) 3-й Круг", "hymyrk_itsc_icecube"); ----- ледяной блок
	SetCraftAmount("hymyrk_itsc_icecube", 1);
	 AddIngre("hymyrk_itsc_icecube", "ooltyb_itmi_magicore", 3);
	 AddIngre("hymyrk_itsc_icecube", "aixopt_itmi_paper", 8);
    AddTool("hymyrk_itsc_icecube", "ooltyb_itmi_kft2");
	AddTool("hymyrk_itsc_icecube", "ooltyb_itmi_kscw");
	SetCraftPenalty("hymyrk_itsc_icecube", 5);
	SetCraftScience("hymyrk_itsc_icecube", "Магия", 4);
	SetenergyPenalty("hymyrk_itsc_icecube", 25);
	
	AddItemCategory ("(С) 3-й Круг", "hymyrk_itsc_mediumheal"); ----- лечение средних ранений
	SetCraftAmount("hymyrk_itsc_mediumheal", 1);
	 AddIngre("hymyrk_itsc_mediumheal", "ooltyb_itmi_magicore", 3);
	 AddIngre("hymyrk_itsc_mediumheal", "aixopt_itmi_paper", 8);
    AddTool("hymyrk_itsc_mediumheal", "ooltyb_itmi_kft2");
	SetCraftPenalty("hymyrk_itsc_mediumheal", 5);
	SetCraftScience("hymyrk_itsc_mediumheal", "Магия", 4);
	SetenergyPenalty("hymyrk_itsc_mediumheal", 25);
	
	AddItemCategory ("(С) 3-й Круг", "hymyrk_itsc_sleep"); ----- сон
	SetCraftAmount("hymyrk_itsc_sleep", 1);
	 AddIngre("hymyrk_itsc_sleep", "ooltyb_itmi_magicore", 3);
	 AddIngre("hymyrk_itsc_sleep", "aixopt_itmi_paper", 8);
    AddTool("hymyrk_itsc_sleep", "ooltyb_itmi_kscs");
	AddTool("hymyrk_itsc_sleep", "ooltyb_itmi_kft2");
	SetCraftPenalty("hymyrk_itsc_sleep", 5);
	SetCraftScience("hymyrk_itsc_sleep", "Магия", 4);
	SetenergyPenalty("hymyrk_itsc_sleep", 25);
	
	------- 4 круг свитки
	
	AddItemCategory ("(С) 4-й Круг", "hymyrk_itsc_firestorm"); ----- огненный шторм
	SetCraftAmount("hymyrk_itsc_firestorm", 1);
	 AddIngre("hymyrk_itsc_firestorm", "ooltyb_itmi_magicore", 5);
	 AddIngre("hymyrk_itsc_firestorm", "aixopt_itmi_paper", 12);
    AddTool("hymyrk_itsc_firestorm", "ooltyb_itmi_kscf");
	AddTool("hymyrk_itsc_firestorm", "ooltyb_itmi_kft2");
	SetCraftPenalty("hymyrk_itsc_firestorm", 5);
	SetCraftScience("hymyrk_itsc_firestorm", "Магия", 5);
	SetenergyPenalty("hymyrk_itsc_firestorm", 25);
	
	AddItemCategory ("(С) 4-й Круг", "hymyrk_itsc_icelance"); ----- ледяное копье
	SetCraftAmount("hymyrk_itsc_icelance", 1);
	 AddIngre("hymyrk_itsc_icelance", "ooltyb_itmi_magicore", 5);
	 AddIngre("hymyrk_itsc_icelance", "aixopt_itmi_paper", 12);
    AddTool("hymyrk_itsc_icelance", "ooltyb_itmi_kscw");
	AddTool("hymyrk_itsc_icelance", "ooltyb_itmi_kft2");
	SetCraftPenalty("hymyrk_itsc_icelance", 5);
	SetCraftScience("hymyrk_itsc_icelance", "Магия", 5);
	SetenergyPenalty("hymyrk_itsc_icelance", 25);
	
	AddItemCategory ("(С) 4-й Круг", "hymyrk_itsc_thunderball"); ----- шаровая молния
	SetCraftAmount("hymyrk_itsc_thunderball", 1);
	 AddIngre("hymyrk_itsc_thunderball", "ooltyb_itmi_magicore", 5);
	 AddIngre("hymyrk_itsc_thunderball", "aixopt_itmi_paper", 12);
	AddTool("hymyrk_itsc_thunderball", "ooltyb_itmi_kft2");
	AddTool("hymyrk_itsc_thunderball", "ooltyb_itmi_kscw");
	SetCraftPenalty("hymyrk_itsc_thunderball", 5);
	SetCraftScience("hymyrk_itsc_thunderball", "Магия", 5);
	SetenergyPenalty("hymyrk_itsc_thunderball", 25);
	
	----- руны 1 круг
	
	AddItemCategory ("(Р) 1-й Круг", "ooltyb_itmi_runeblank"); ----- заготовка руны 1 круг
	SetCraftAmount("ooltyb_itmi_runeblank", 1);
	 AddIngre("ooltyb_itmi_runeblank", "aixopt_itmi_ironnugget", 50);
    AddTool("ooltyb_itmi_runeblank", "aixopt_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_runeblank", 15);
	SetCraftScience("ooltyb_itmi_runeblank", "Магия", 2);
	SetenergyPenalty("ooltyb_itmi_runeblank", 50);
	
	AddItemCategory ("(Р) 1-й Круг", "xthmqe_itru_zap"); ----- вспышка
	SetCraftAmount("xthmqe_itru_zap", 1);
	 AddIngre("xthmqe_itru_zap", "ooltyb_itmi_runeblank", 1);
	 AddIngre("xthmqe_itru_zap", "hymyrk_ItSc_Zap", 1);
	 AddIngre("xthmqe_itru_zap", "aixopt_itmi_quartz", 1);
    AddTool("xthmqe_itru_zap", "ooltyb_itmi_kft1");
	AddTool("xthmqe_itru_zap","ooltyb_itmi_kscw"); 
	AddTool("xthmqe_itru_zap","aixopt_itmi_pliers"); 
	SetCraftPenalty("xthmqe_itru_zap", 15);
	SetCraftScience("xthmqe_itru_zap", "Магия", 2);
	SetenergyPenalty("xthmqe_itru_zap", 50);
	
	AddItemCategory ("(Р) 1-й Круг", "xthmqe_ItRu_FireBolt"); ----- огненная стрела
	SetCraftAmount("xthmqe_ItRu_FireBolt", 1);
	 AddIngre("xthmqe_ItRu_FireBolt", "ooltyb_itmi_runeblank", 1);
	 AddIngre("xthmqe_ItRu_FireBolt", "hymyrk_ItSc_Firebolt", 1);
	 AddIngre("xthmqe_ItRu_FireBolt", "aixopt_itmi_rubin", 1);
    AddTool("xthmqe_ItRu_FireBolt", "ooltyb_itmi_kft1");
	AddTool("xthmqe_ItRu_FireBolt","ooltyb_itmi_kscf");
	AddTool("xthmqe_ItRu_FireBolt","aixopt_itmi_pliers"); 
	SetCraftPenalty("xthmqe_ItRu_FireBolt", 15);
	SetCraftScience("xthmqe_ItRu_FireBolt", "Магия", 2);
	SetenergyPenalty("xthmqe_ItRu_FireBolt", 50);
	
	AddItemCategory ("(Р) 1-й Круг", "xthmqe_ItRu_Light"); ----- свет
	SetCraftAmount("xthmqe_ItRu_Light", 1);
	 AddIngre("xthmqe_ItRu_Light", "ooltyb_itmi_runeblank", 1);
	 AddIngre("xthmqe_ItRu_Light", "hymyrk_ItSc_Light", 1);
	 AddIngre("xthmqe_ItRu_Light", "aixopt_itmi_rockcrystal", 1);
    AddTool("xthmqe_ItRu_Light", "ooltyb_itmi_kft1");
	AddTool("xthmqe_ItRu_Light","aixopt_itmi_pliers"); 
	SetCraftPenalty("xthmqe_ItRu_Light", 15);
	SetCraftScience("xthmqe_ItRu_Light", "Магия", 2);
	SetenergyPenalty("xthmqe_ItRu_Light", 50);
	
	AddItemCategory ("(Р) 1-й Круг", "xthmqe_ItRu_LightHeal"); ----- легкое лечение
	SetCraftAmount("xthmqe_ItRu_LightHeal", 1);
	 AddIngre("xthmqe_ItRu_LightHeal", "ooltyb_itmi_runeblank", 1);
	 AddIngre("xthmqe_ItRu_LightHeal", "hymyrk_ItSc_LightHeal", 1);
	 AddIngre("xthmqe_ItRu_LightHeal", "aixopt_itmi_rockcrystal", 1);
    AddTool("xthmqe_ItRu_LightHeal", "ooltyb_itmi_kft1");
	AddTool("xthmqe_ItRu_LightHeal","aixopt_itmi_pliers"); 
	SetCraftPenalty("xthmqe_ItRu_LightHeal", 15);
	SetCraftScience("xthmqe_ItRu_LightHeal", "Магия", 2);
	SetenergyPenalty("xthmqe_ItRu_LightHeal", 50);
	
	-----руны 2 круг
	
	AddItemCategory ("(Р) 2-й Круг", "ooltyb_itmi_mage2"); ----- заготовка руны 2 круг
	SetCraftAmount("ooltyb_itmi_mage2", 1);
	 AddIngre("ooltyb_itmi_mage2", "aixopt_itmi_ironnugget", 100);
	 AddIngre("ooltyb_itmi_mage2", "ooltyb_itmi_runeblank", 1);
    AddTool("ooltyb_itmi_mage2", "aixopt_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_mage2", 15);
	SetCraftScience("ooltyb_itmi_mage2", "Магия", 3);
	SetenergyPenalty("ooltyb_itmi_mage2", 50);
	
	AddItemCategory ("(Р) 2-й Круг", "xthmqe_ItRu_InstantFireball"); ----- огненный шар
	SetCraftAmount("xthmqe_ItRu_InstantFireball", 1);
	 AddIngre("xthmqe_ItRu_InstantFireball", "ooltyb_itmi_mage2", 1);
	 AddIngre("xthmqe_ItRu_InstantFireball", "hymyrk_ItSc_InstantFireball", 1);
	 AddIngre("xthmqe_ItRu_InstantFireball", "aixopt_itmi_rubin", 1);
    AddTool("xthmqe_ItRu_InstantFireball", "ooltyb_itmi_kft1");
	AddTool("xthmqe_ItRu_InstantFireball","ooltyb_itmi_kscf");
    AddTool("xthmqe_ItRu_InstantFireball","aixopt_itmi_pliers"); 	
	SetCraftPenalty("xthmqe_ItRu_InstantFireball", 15);
	SetCraftScience("xthmqe_ItRu_InstantFireball", "Магия", 3);
	SetenergyPenalty("xthmqe_ItRu_InstantFireball", 50);
	
	AddItemCategory ("(Р) 2-й Круг", "xthmqe_itru_waterfist"); ----- кулак воды
	SetCraftAmount("xthmqe_itru_waterfist", 1);
	 AddIngre("xthmqe_itru_waterfist", "ooltyb_itmi_mage2", 1);
	 AddIngre("xthmqe_itru_waterfist", "hymyrk_itsc_waterfist", 1);
	 AddIngre("xthmqe_itru_waterfist", "aixopt_itmi_aquamarine", 1);
    AddTool("xthmqe_itru_waterfist", "ooltyb_itmi_kft1");
	AddTool("xthmqe_itru_waterfist","aixopt_itmi_pliers");
    AddTool("xthmqe_itru_waterfist","ooltyb_itmi_kscw"); 	
	SetCraftPenalty("xthmqe_itru_waterfist", 15);
	SetCraftScience("xthmqe_itru_waterfist", "Магия", 3);
	SetenergyPenalty("xthmqe_itru_waterfist", 50);
	
	AddItemCategory ("(Р) 2-й Круг", "xthmqe_itru_lightfocheal"); ----- легкое лечение ранений таргет
	SetCraftAmount("xthmqe_itru_lightfocheal", 1);
	 AddIngre("xthmqe_itru_lightfocheal", "ooltyb_itmi_mage2", 1);
	 AddIngre("xthmqe_itru_lightfocheal", "hymyrk_ItSc_LightHeal", 2);
	  AddIngre("xthmqe_itru_lightfocheal", "aixopt_itmi_rockcrystal", 1);
    AddTool("xthmqe_itru_lightfocheal", "ooltyb_itmi_kft1");
	AddTool("xthmqe_itru_lightfocheal","aixopt_itmi_pliers");	
	SetCraftPenalty("xthmqe_itru_lightfocheal", 15);
	SetCraftScience("xthmqe_itru_lightfocheal", "Магия", 3);
	SetenergyPenalty("xthmqe_itru_lightfocheal", 50);
	
	-----руны 3 круг
	
	AddItemCategory ("(Р) 3-й Круг", "xthmqe_itru_chargefireball"); ----- большой огненный шар
	SetCraftAmount("xthmqe_itru_chargefireball", 1);
	 AddIngre("xthmqe_itru_chargefireball", "ooltyb_itmi_mage3", 1);
	 AddIngre("xthmqe_itru_chargefireball", "hymyrk_itsc_chargefireball", 1);
	  AddIngre("xthmqe_itru_chargefireball", "aixopt_itmi_rubin", 2);
    AddTool("xthmqe_itru_chargefireball", "ooltyb_itmi_kft2");
	AddTool("xthmqe_itru_chargefireball", "ooltyb_itmi_kscf");
	AddTool("xthmqe_itru_chargefireball","aixopt_itmi_pliers");	
	SetCraftPenalty("xthmqe_itru_chargefireball", 15);
	SetCraftScience("xthmqe_itru_chargefireball", "Магия", 4);
	SetenergyPenalty("xthmqe_itru_chargefireball", 100);
	
	AddItemCategory ("(Р) 3-й Круг", "xthmqe_itru_harmundead"); ----- уничтожение нежити
	SetCraftAmount("xthmqe_itru_harmundead", 1);
	 AddIngre("xthmqe_itru_harmundead", "ooltyb_itmi_mage3", 1);
	 AddIngre("xthmqe_itru_harmundead", "hymyrk_itsc_harmundead", 1);
	  AddIngre("xthmqe_itru_harmundead", "aixopt_itmi_quartz", 2);
    AddTool("xthmqe_itru_harmundead", "ooltyb_itmi_kft2");
	AddTool("xthmqe_itru_harmundead", "ooltyb_itmi_kscf");
	AddTool("xthmqe_itru_harmundead","aixopt_itmi_pliers");	
	SetCraftPenalty("xthmqe_itru_harmundead", 15);
	SetCraftScience("xthmqe_itru_harmundead", "Магия", 4);
	SetenergyPenalty("xthmqe_itru_harmundead", 100);
	
	AddItemCategory ("(Р) 3-й Круг", "xthmqe_itru_icebolt"); ----- ледяная стрела
	SetCraftAmount("xthmqe_itru_icebolt", 1);
	 AddIngre("xthmqe_itru_icebolt", "ooltyb_itmi_mage3", 1);
	 AddIngre("xthmqe_itru_icebolt", "hymyrk_itsc_icebolt", 1);
	  AddIngre("xthmqe_itru_icebolt", "aixopt_itmi_aquamarine", 2);
    AddTool("xthmqe_itru_icebolt", "ooltyb_itmi_kft2");
	AddTool("xthmqe_itru_icebolt", "ooltyb_itmi_kscw");
	AddTool("xthmqe_itru_icebolt","aixopt_itmi_pliers");	
	SetCraftPenalty("xthmqe_itru_icebolt", 15);
	SetCraftScience("xthmqe_itru_icebolt", "Магия", 4);
	SetenergyPenalty("xthmqe_itru_icebolt", 100);
	
	AddItemCategory ("(Р) 3-й Круг", "xthmqe_itru_icecube"); ----- ледяной блок
	SetCraftAmount("xthmqe_itru_icecube", 1);
	 AddIngre("xthmqe_itru_icecube", "ooltyb_itmi_mage3", 1);
	 AddIngre("xthmqe_itru_icecube", "hymyrk_itsc_icecube", 1);
	  AddIngre("xthmqe_itru_icecube", "aixopt_itmi_aquamarine", 2);
    AddTool("xthmqe_itru_icecube", "ooltyb_itmi_kft2");
	AddTool("xthmqe_itru_icecube", "ooltyb_itmi_kscw");
	AddTool("xthmqe_itru_icecube","aixopt_itmi_pliers");	
	SetCraftPenalty("xthmqe_itru_icecube", 15);
	SetCraftScience("xthmqe_itru_icecube", "Магия", 4);
	SetenergyPenalty("xthmqe_itru_icecube", 100);
	
	AddItemCategory ("(Р) 3-й Круг", "xthmqe_itru_mediumheal"); ----- лечение средних ранений
	SetCraftAmount("xthmqe_itru_mediumheal", 1);
	 AddIngre("xthmqe_itru_mediumheal", "ooltyb_itmi_mage3", 1);
	 AddIngre("xthmqe_itru_mediumheal", "hymyrk_itsc_mediumheal", 1);
	 AddIngre("xthmqe_itru_mediumheal", "aixopt_itmi_rockcrystal", 2);
    AddTool("xthmqe_itru_mediumheal", "ooltyb_itmi_kft2");
	AddTool("xthmqe_itru_mediumheal","aixopt_itmi_pliers");	
	SetCraftPenalty("xthmqe_itru_mediumheal", 15);
	SetCraftScience("xthmqe_itru_mediumheal", "Магия", 4);
	SetenergyPenalty("xthmqe_itru_mediumheal", 100);
	
	AddItemCategory ("(Р) 3-й Круг", "xthmqe_itru_sleep"); ----- сон
	SetCraftAmount("xthmqe_itru_sleep", 1);
	 AddIngre("xthmqe_itru_sleep", "ooltyb_itmi_mage3", 1);
	 AddIngre("xthmqe_itru_sleep", "hymyrk_itsc_sleep", 1);
	 AddIngre("xthmqe_itru_sleep", "aixopt_itmi_quartz", 2);
    AddTool("xthmqe_itru_sleep", "ooltyb_itmi_kft2");
	AddTool("xthmqe_itru_sleep", "ooltyb_itmi_kscs");
	AddTool("xthmqe_itru_sleep","aixopt_itmi_pliers");	
	SetCraftPenalty("xthmqe_itru_sleep", 15);
	SetCraftScience("xthmqe_itru_sleep", "Магия", 4);
	SetenergyPenalty("xthmqe_itru_sleep", 100);
	
	-----руны 4 круг
	
	AddItemCategory ("(Р) 4-й Круг", "xthmqe_itru_firestorm"); ----- малый огненный шторм
	SetCraftAmount("xthmqe_itru_firestorm", 1);
	 AddIngre("xthmqe_itru_firestorm", "ooltyb_itmi_mage4", 1);
	 AddIngre("xthmqe_itru_firestorm", "hymyrk_itsc_firestorm", 1);
	  AddIngre("xthmqe_itru_firestorm", "aixopt_itmi_rubin", 2);
    AddTool("xthmqe_itru_firestorm", "ooltyb_itmi_kft2");
	AddTool("xthmqe_itru_firestorm", "ooltyb_itmi_kscf");
	AddTool("xthmqe_itru_firestorm","aixopt_itmi_pliers");	
	SetCraftPenalty("xthmqe_itru_firestorm", 15);
	SetCraftScience("xthmqe_itru_firestorm", "Магия", 5);
	SetenergyPenalty("xthmqe_itru_firestorm", 100);
	
	AddItemCategory ("(Р) 4-й Круг", "xthmqe_itru_icelance"); ----- ледяное копье
	SetCraftAmount("xthmqe_itru_icelance", 1);
	 AddIngre("xthmqe_itru_icelance", "ooltyb_itmi_mage4", 1);
	 AddIngre("xthmqe_itru_icelance", "hymyrk_itsc_icelance", 1);
	  AddIngre("xthmqe_itru_icelance", "aixopt_itmi_aquamarine", 2);
    AddTool("xthmqe_itru_icelance", "ooltyb_itmi_kft2");
	AddTool("xthmqe_itru_icelance", "ooltyb_itmi_kscw");
	AddTool("xthmqe_itru_icelance","aixopt_itmi_pliers");	
	SetCraftPenalty("xthmqe_itru_icelance", 15);
	SetCraftScience("xthmqe_itru_icelance", "Магия", 5);
	SetenergyPenalty("xthmqe_itru_icelance", 100);
	
	AddItemCategory ("(Р) 4-й Круг", "xthmqe_itru_thunderball"); ----- шаровая молния
	SetCraftAmount("xthmqe_itru_thunderball", 1);
	 AddIngre("xthmqe_itru_thunderball", "ooltyb_itmi_mage4", 1);
	 AddIngre("xthmqe_itru_thunderball", "hymyrk_itsc_thunderball", 1);
	  AddIngre("xthmqe_itru_thunderball", "aixopt_itmi_quartz", 2);
    AddTool("xthmqe_itru_thunderball", "ooltyb_itmi_kft2");
	AddTool("xthmqe_itru_thunderball", "ooltyb_itmi_kscw");
	AddTool("xthmqe_itru_thunderball","aixopt_itmi_pliers");	
	SetCraftPenalty("xthmqe_itru_thunderball", 15);
	SetCraftScience("xthmqe_itru_thunderball", "Магия", 5);
	SetenergyPenalty("xthmqe_itru_thunderball", 100);
	
	AddItemCategory ("(Р) 4-й Круг", "xthmqe_itru_mediumfocheal"); ----- среднее лечение ранений таргет
	SetCraftAmount("xthmqe_itru_mediumfocheal", 1);
	 AddIngre("xthmqe_itru_mediumfocheal", "ooltyb_itmi_mage4", 1);
	 AddIngre("xthmqe_itru_mediumfocheal", "hymyrk_itsc_mediumheal", 2);
	  AddIngre("xthmqe_itru_mediumfocheal", "aixopt_itmi_rockcrystal", 2);
    AddTool("xthmqe_itru_mediumfocheal", "ooltyb_itmi_kft2");
	AddTool("xthmqe_itru_mediumfocheal","aixopt_itmi_pliers");	
	SetCraftPenalty("xthmqe_itru_mediumfocheal", 15);
	SetCraftScience("xthmqe_itru_mediumfocheal", "Магия", 5);
	SetenergyPenalty("xthmqe_itru_mediumfocheal", 100);
	
	-----Зачарователь 1 (2лвл надо 500 эксп, 3 лвл надо 1500 эксп
	
	AddItemCategory ("Зачарователь", "zdpwla_itmi_beltlm"); ----- рунный пояс ученика
	SetCraftAmount("zdpwla_itmi_beltlm", 1);
	 AddIngre("zdpwla_itmi_beltlm", "ooltyb_itmi_runeblank", 2);
	 AddIngre("zdpwla_itmi_beltlm", "aixopt_itmi_skin", 1);
	AddTool("zdpwla_itmi_beltlm","aixopt_itmi_pliers");	
	SetCraftPenalty("zdpwla_itmi_beltlm", 5);
	SetCraftScience("zdpwla_itmi_beltlm", "Зачарователь", 1);
	SetenergyPenalty("zdpwla_itmi_beltlm", 50);
	SetCraftEXP("zdpwla_itmi_beltlm", 100)
	SetCraftEXP_SKILL("zdpwla_itmi_beltlm", "Зачарователь")
	
	AddItemCategory ("Зачарователь", "zdpwla_itmi_belthm"); ----- рунный пояс мага
	SetCraftAmount("zdpwla_itmi_belthm", 1);
	 AddIngre("zdpwla_itmi_belthm", "ooltyb_itmi_mage3", 2);
	 AddIngre("zdpwla_itmi_belthm", "aixopt_itmi_skin", 2);
	AddTool("zdpwla_itmi_belthm","aixopt_itmi_pliers");	
	SetCraftPenalty("zdpwla_itmi_belthm", 5);
	SetCraftScience("zdpwla_itmi_belthm", "Зачарователь", 2);
	SetenergyPenalty("zdpwla_itmi_belthm", 100);
	SetCraftEXP("zdpwla_itmi_belthm", 300)
	SetCraftEXP_SKILL("zdpwla_itmi_belthm", "Зачарователь")
	
	AddItemCategory ("Зачарователь", "zdpwla_itmi_beltum"); ----- рунный пояс мастера
	SetCraftAmount("zdpwla_itmi_beltum", 1);
	 AddIngre("zdpwla_itmi_beltum", "ooltyb_itmi_mage5", 2);
	 AddIngre("zdpwla_itmi_beltum", "aixopt_itmi_tannedskin", 1);
	AddTool("zdpwla_itmi_beltum","aixopt_itmi_pliers");	
	SetCraftPenalty("zdpwla_itmi_beltum", 5);
	SetCraftScience("zdpwla_itmi_beltum", "Зачарователь", 3);
	SetenergyPenalty("zdpwla_itmi_beltum", 100);
	
	AddItemCategory ("Зачарователь", "ooltyb_itmi_mage3"); ----- заготовка руны 3 круг
	SetCraftAmount("ooltyb_itmi_mage3", 1);
	 AddIngre("ooltyb_itmi_mage3", "aixopt_itmi_ironnugget", 100);
	 AddIngre("ooltyb_itmi_mage3", "ooltyb_itmi_mage2", 1);
    AddTool("ooltyb_itmi_mage3", "aixopt_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_mage3", 15);
	SetCraftScience("ooltyb_itmi_mage3", "Зачарователь", 1);
	SetenergyPenalty("ooltyb_itmi_mage3", 50);
	SetCraftEXP("ooltyb_itmi_mage3", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_mage3", "Зачарователь")
	
	AddItemCategory ("Зачарователь", "ooltyb_itmi_mage4"); ----- заготовка руны 4 круг
	SetCraftAmount("ooltyb_itmi_mage4", 1);
	 AddIngre("ooltyb_itmi_mage4", "aixopt_itmi_ironnugget", 100);
	 AddIngre("ooltyb_itmi_mage4", "ooltyb_itmi_mage3", 1);
    AddTool("ooltyb_itmi_mage4", "aixopt_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_mage4", 15);
	SetCraftScience("ooltyb_itmi_mage4", "Зачарователь", 2);
	SetenergyPenalty("ooltyb_itmi_mage4", 50);
	SetCraftEXP("ooltyb_itmi_mage4", 100)
	SetCraftEXP_SKILL("ooltyb_itmi_mage4", "Зачарователь")
	
	AddItemCategory ("Зачарователь", "ooltyb_itmi_enchantset"); ----- набор для зачарования
	SetCraftAmount("ooltyb_itmi_enchantset", 1);
	 AddIngre("ooltyb_itmi_enchantset", "aixopt_itmi_sulfur", 10);
	 AddIngre("ooltyb_itmi_enchantset", "ooltyb_itmi_addon_whitepearl", 2);
	 AddIngre("ooltyb_itmi_enchantset", "aixopt_itmi_rockcrystal", 2);
	 AddIngre("ooltyb_itmi_enchantset", "aixopt_itmi_paper", 6);
	 AddIngre("ooltyb_itmi_enchantset", "ooltyb_itmi_magicore", 12);
	 AddIngre("ooltyb_itmi_enchantset", "aixopt_itmi_dye", 1);
	SetCraftPenalty("ooltyb_itmi_enchantset", 15);
	SetCraftScience("ooltyb_itmi_enchantset", "Зачарователь", 1);
	SetenergyPenalty("ooltyb_itmi_enchantset", 50);
	SetCraftEXP("ooltyb_itmi_enchantset", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_enchantset", "Зачарователь")
	
	AddItemCategory ("Зачарователь", "rmymew_itam_prot_mage_01"); ----- защитный кулон
	SetCraftAmount("rmymew_itam_prot_mage_01", 1);
	 AddIngre("rmymew_itam_prot_mage_01", "ooltyb_itmi_enchantset", 1);
	 AddIngre("rmymew_itam_prot_mage_01", "aixopt_itmi_ironnugget", 250);
	 AddIngre("rmymew_itam_prot_mage_01", "aixopt_itmi_quartz", 2);
	 AddIngre("rmymew_itam_prot_mage_01", "aixopt_itmi_jewelery", 1);
	SetCraftPenalty("rmymew_itam_prot_mage_01", 15);
	SetCraftScience("rmymew_itam_prot_mage_01", "Зачарователь", 1);
	SetenergyPenalty("rmymew_itam_prot_mage_01", 100);
	SetCraftEXP("rmymew_itam_prot_mage_01", 200)
	SetCraftEXP_SKILL("rmymew_itam_prot_mage_01", "Зачарователь")
	
	AddItemCategory ("Зачарователь", "rmymew_itam_prot_mage_02"); ----- защитный оберег
	SetCraftAmount("rmymew_itam_prot_mage_02", 1);
	 AddIngre("rmymew_itam_prot_mage_02", "ooltyb_itmi_enchantset", 2);
	 AddIngre("rmymew_itam_prot_mage_02", "aixopt_itmi_ironnugget", 500);
	 AddIngre("rmymew_itam_prot_mage_02", "aixopt_itmi_quartz", 4);
	 AddIngre("rmymew_itam_prot_mage_02", "aixopt_itmi_jewelery", 2);
	SetCraftPenalty("rmymew_itam_prot_mage_02", 15);
	SetCraftScience("rmymew_itam_prot_mage_02", "Зачарователь", 2);
	SetenergyPenalty("rmymew_itam_prot_mage_02", 100);
	SetCraftEXP("rmymew_itam_prot_mage_02", 300)
	SetCraftEXP_SKILL("rmymew_itam_prot_mage_02", "Зачарователь")
	
	AddItemCategory ("Зачарователь", "rmymew_itam_prot_mage_03"); ----- защитный амулет
	SetCraftAmount("rmymew_itam_prot_mage_03", 1);
	 AddIngre("rmymew_itam_prot_mage_03", "ooltyb_itmi_enchantset", 3);
	 AddIngre("rmymew_itam_prot_mage_03", "aixopt_itmi_ironnugget", 1000);
	 AddIngre("rmymew_itam_prot_mage_03", "aixopt_itmi_quartz", 8);
	 AddIngre("rmymew_itam_prot_mage_03", "aixopt_itmi_jewelery", 3);
	SetCraftPenalty("rmymew_itam_prot_mage_03", 15);
	SetCraftScience("rmymew_itam_prot_mage_03", "Зачарователь", 3);
	SetenergyPenalty("rmymew_itam_prot_mage_03", 100);
	
	AddItemCategory ("Зачарователь", "rmymew_itri_dex_01"); ----- малое кольцо ловкости
	SetCraftAmount("rmymew_itri_dex_01", 1);
	 AddIngre("rmymew_itri_dex_01", "ooltyb_itmi_enchantset", 1);
	 AddIngre("rmymew_itri_dex_01", "aixopt_itmi_ironnugget", 250);
	 AddIngre("rmymew_itri_dex_01", "aixopt_itmi_aquamarine", 2);
	 AddIngre("rmymew_itri_dex_01", "aixopt_itmi_jewelery", 1);
	SetCraftPenalty("rmymew_itri_dex_01", 15);
	SetCraftScience("rmymew_itri_dex_01", "Зачарователь", 1);
	SetenergyPenalty("rmymew_itri_dex_01", 100);
	SetCraftEXP("rmymew_itri_dex_01", 200)
	SetCraftEXP_SKILL("rmymew_itri_dex_01", "Зачарователь")
	
	AddItemCategory ("Зачарователь", "rmymew_itri_dex_02"); ----- среднее кольцо ловкости
	SetCraftAmount("rmymew_itri_dex_02", 1);
	 AddIngre("rmymew_itri_dex_02", "ooltyb_itmi_enchantset", 2);
	 AddIngre("rmymew_itri_dex_02", "aixopt_itmi_ironnugget", 500);
	 AddIngre("rmymew_itri_dex_02", "aixopt_itmi_aquamarine", 4);
	 AddIngre("rmymew_itri_dex_02", "aixopt_itmi_jewelery", 2);
	SetCraftPenalty("rmymew_itri_dex_02", 15);
	SetCraftScience("rmymew_itri_dex_02", "Зачарователь", 2);
	SetenergyPenalty("rmymew_itri_dex_02", 100);
	SetCraftEXP("rmymew_itri_dex_02", 300)
	SetCraftEXP_SKILL("rmymew_itri_dex_02", "Зачарователь")
	
	AddItemCategory ("Зачарователь", "rmymew_itri_dex_03"); ----- большое кольцо ловкости
	SetCraftAmount("rmymew_itri_dex_03", 1);
	 AddIngre("rmymew_itri_dex_03", "ooltyb_itmi_enchantset", 3);
	 AddIngre("rmymew_itri_dex_03", "aixopt_itmi_ironnugget", 1000);
	 AddIngre("rmymew_itri_dex_03", "aixopt_itmi_aquamarine", 8);
	 AddIngre("rmymew_itri_dex_03", "aixopt_itmi_jewelery", 3);
	SetCraftPenalty("rmymew_itri_dex_03", 15);
	SetCraftScience("rmymew_itri_dex_03", "Зачарователь", 3);
	SetenergyPenalty("rmymew_itri_dex_03", 100);
	
	AddItemCategory ("Зачарователь", "rmymew_itri_hp_01"); ----- малое кольцо жизни
	SetCraftAmount("rmymew_itri_hp_01", 1);
	 AddIngre("rmymew_itri_hp_01", "ooltyb_itmi_enchantset", 1);
	 AddIngre("rmymew_itri_hp_01", "aixopt_itmi_ironnugget", 250);
	 AddIngre("rmymew_itri_hp_01", "aixopt_itmi_rubin", 2);
	 AddIngre("rmymew_itri_hp_01", "aixopt_itmi_jewelery", 1);
	SetCraftPenalty("rmymew_itri_hp_01", 15);
	SetCraftScience("rmymew_itri_hp_01", "Зачарователь", 1);
	SetenergyPenalty("rmymew_itri_hp_01", 100);
	SetCraftEXP("rmymew_itri_hp_01", 200)
	SetCraftEXP_SKILL("rmymew_itri_hp_01", "Зачарователь")
	
	AddItemCategory ("Зачарователь", "rmymew_itri_hp_02"); ----- среднее кольцо жизни
	SetCraftAmount("rmymew_itri_hp_02", 1);
	 AddIngre("rmymew_itri_hp_02", "ooltyb_itmi_enchantset", 2);
	 AddIngre("rmymew_itri_hp_02", "aixopt_itmi_ironnugget", 500);
	 AddIngre("rmymew_itri_hp_02", "aixopt_itmi_rubin", 4);
	 AddIngre("rmymew_itri_hp_02", "aixopt_itmi_jewelery", 2);
	SetCraftPenalty("rmymew_itri_hp_02", 15);
	SetCraftScience("rmymew_itri_hp_02", "Зачарователь", 2);
	SetenergyPenalty("rmymew_itri_hp_02", 100);
	SetCraftEXP("rmymew_itri_hp_02", 300)
	SetCraftEXP_SKILL("rmymew_itri_hp_02", "Зачарователь")
	
	AddItemCategory ("Зачарователь", "rmymew_itri_hp_03"); ----- большое кольцо жизни
	SetCraftAmount("rmymew_itri_hp_03", 1);
	 AddIngre("rmymew_itri_hp_03", "ooltyb_itmi_enchantset", 3);
	 AddIngre("rmymew_itri_hp_03", "aixopt_itmi_ironnugget", 1000);
	 AddIngre("rmymew_itri_hp_03", "aixopt_itmi_rubin", 8);
	 AddIngre("rmymew_itri_hp_03", "aixopt_itmi_jewelery", 3);
	SetCraftPenalty("rmymew_itri_hp_03", 15);
	SetCraftScience("rmymew_itri_hp_03", "Зачарователь", 3);
	SetenergyPenalty("rmymew_itri_hp_03", 100);
	
	AddItemCategory ("Зачарователь", "rmymew_itri_str_01"); ----- малое кольцо силы
	SetCraftAmount("rmymew_itri_str_01", 1);
	 AddIngre("rmymew_itri_str_01", "ooltyb_itmi_enchantset", 1);
	 AddIngre("rmymew_itri_str_01", "aixopt_itmi_ironnugget", 250);
	 AddIngre("rmymew_itri_str_01", "aixopt_itmi_rubin", 2);
	 AddIngre("rmymew_itri_str_01", "aixopt_itmi_jewelery", 1);
	SetCraftPenalty("rmymew_itri_str_01", 15);
	SetCraftScience("rmymew_itri_str_01", "Зачарователь", 1);
	SetenergyPenalty("rmymew_itri_str_01", 100);
	SetCraftEXP("rmymew_itri_str_01", 200)
	SetCraftEXP_SKILL("rmymew_itri_str_01", "Зачарователь")
	
	AddItemCategory ("Зачарователь", "rmymew_itri_str_02"); ----- среднее кольцо силы
	SetCraftAmount("rmymew_itri_str_02", 1);
	 AddIngre("rmymew_itri_str_02", "ooltyb_itmi_enchantset", 2);
	 AddIngre("rmymew_itri_str_02", "aixopt_itmi_ironnugget", 500);
	 AddIngre("rmymew_itri_str_02", "aixopt_itmi_rubin", 4);
	 AddIngre("rmymew_itri_str_02", "aixopt_itmi_jewelery", 2);
	SetCraftPenalty("rmymew_itri_str_02", 15);
	SetCraftScience("rmymew_itri_str_02", "Зачарователь", 2);
	SetenergyPenalty("rmymew_itri_str_02", 100);
	SetCraftEXP("rmymew_itri_str_02", 300)
	SetCraftEXP_SKILL("rmymew_itri_str_02", "Зачарователь")
	
	AddItemCategory ("Зачарователь", "rmymew_itri_str_03"); ----- большое кольцо силы
	SetCraftAmount("rmymew_itri_str_03", 1);
	 AddIngre("rmymew_itri_str_03", "ooltyb_itmi_enchantset", 3);
	 AddIngre("rmymew_itri_str_03", "aixopt_itmi_ironnugget", 1000);
	 AddIngre("rmymew_itri_str_03", "aixopt_itmi_rubin", 8);
	 AddIngre("rmymew_itri_str_03", "aixopt_itmi_jewelery", 3);
	SetCraftPenalty("rmymew_itri_str_03", 15);
	SetCraftScience("rmymew_itri_str_03", "Зачарователь", 3);
	SetenergyPenalty("rmymew_itri_str_03", 100);
	
	AddItemCategory ("Зачарователь", "rmymew_itri_mana_01"); ----- кольцо паломника
	SetCraftAmount("rmymew_itri_mana_01", 1);
	 AddIngre("rmymew_itri_mana_01", "ooltyb_itmi_enchantset", 1);
	 AddIngre("rmymew_itri_mana_01", "aixopt_itmi_ironnugget", 250);
	 AddIngre("rmymew_itri_mana_01", "aixopt_itmi_aquamarine", 2);
	 AddIngre("rmymew_itri_mana_01", "aixopt_itmi_jewelery", 1);
	SetCraftPenalty("rmymew_itri_mana_01", 15);
	SetCraftScience("rmymew_itri_mana_01", "Зачарователь", 1);
	SetenergyPenalty("rmymew_itri_mana_01", 100);
	SetCraftEXP("rmymew_itri_mana_01", 200)
	SetCraftEXP_SKILL("rmymew_itri_mana_01", "Зачарователь")
	
		AddItemCategory ("Зачарователь", "rmymew_itri_mana_02"); ----- кольцо мага
	SetCraftAmount("rmymew_itri_mana_02", 1);
	 AddIngre("rmymew_itri_mana_02", "ooltyb_itmi_enchantset", 2);
	 AddIngre("rmymew_itri_mana_02", "aixopt_itmi_ironnugget", 500);
	 AddIngre("rmymew_itri_mana_02", "aixopt_itmi_aquamarine", 4);
	 AddIngre("rmymew_itri_mana_02", "aixopt_itmi_jewelery", 2);
	SetCraftPenalty("rmymew_itri_mana_02", 15);
	SetCraftScience("rmymew_itri_mana_02", "Зачарователь", 2);
	SetenergyPenalty("rmymew_itri_mana_02", 100);
	SetCraftEXP("rmymew_itri_mana_02", 300)
	SetCraftEXP_SKILL("rmymew_itri_mana_02", "Зачарователь")
	
	AddItemCategory ("Зачарователь", "rmymew_itri_mana_03"); ----- кольцо мастера
	SetCraftAmount("rmymew_itri_mana_03", 1);
	 AddIngre("rmymew_itri_mana_03", "ooltyb_itmi_enchantset", 3);
	 AddIngre("rmymew_itri_mana_03", "aixopt_itmi_ironnugget", 1000);
	 AddIngre("rmymew_itri_mana_03", "aixopt_itmi_aquamarine", 8);
	 AddIngre("rmymew_itri_mana_03", "aixopt_itmi_jewelery", 3);
	SetCraftPenalty("rmymew_itri_mana_03", 15);
	SetCraftScience("rmymew_itri_mana_03", "Зачарователь", 3);
	SetenergyPenalty("rmymew_itri_mana_03", 100);
	
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
			for i, v in pairs(CraftItem[instance].exp_skill) do
				local skill = v;
				if skill ~= nil then
					_craftGiveEXP(pid, skill, CraftItem[instance].exp);
				end
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
		
		file:close();
		
	else
		_craftSaveEXP(id);
	end

end

CRAFT_POVAR_LEVELS = {1000, 2500};
CRAFT_PLOTNIK_LEVELS = {1250, 2500};
CRAFT_BRONNIK_LEVELS = {1250, 2500};
CRAFT_ORYJEYNIK_LEVELS = {1250, 2500};
CRAFT_PORTNOY_LEVELS = {1250, 2500};
CRAFT_ALHIMIC_LEVELS = {1000, 2500};
CRAFT_KOZHEVNIK_LEVELS = {1250, 2500};
CRAFT_KYZNEC_LEVELS = {1000, 2000};

function _getCraftExpCMD(id)

	local nexp = 0;
	for i, v in ipairs(CRAFT_KYZNEC_LEVELS) do
		if Player[id].scraft_kyznec[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_kyznec[2].."/"..nexp..". Уровень профессии кузнеца: "..GetScienceLevel(id, "Кузнец"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_KOZHEVNIK_LEVELS) do
		if Player[id].scraft_kozhevnik[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_kozhevnik[2].."/"..nexp..". Уровень профессии кожевника: "..GetScienceLevel(id, "Кожевник"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_ALHIMIC_LEVELS) do
		if Player[id].scraft_alhimic[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_alhimic[2].."/"..nexp..". Уровень профессии алхимика: "..GetScienceLevel(id, "Алхимия"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_PORTNOY_LEVELS) do
		if Player[id].scraft_portnoy[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_portnoy[2].."/"..nexp..". Уровень профессии портного: "..GetScienceLevel(id, "Портной"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_ORYJEYNIK_LEVELS) do
		if Player[id].scraft_oryjeynik[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_oryjeynik[2].."/"..nexp..". Уровень профессии оружейника: "..GetScienceLevel(id, "Оружейник"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_POVAR_LEVELS) do
		if Player[id].scraft_povar[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_povar[2].."/"..nexp..". Уровень профессии повара: "..GetScienceLevel(id, "Повар"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_PLOTNIK_LEVELS) do
		if Player[id].scraft_plotnik[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_plotnik[2].."/"..nexp..". Уровень профессии плотника: "..GetScienceLevel(id, "Плотник"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_BRONNIK_LEVELS) do
		if Player[id].scraft_bronnik[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_bronnik[2].."/"..nexp..". Уровень профессии бронника: "..GetScienceLevel(id, "Бронник"));
		end
	end

end
addCommandHandler({"/копыт"}, _getCraftExpCMD);

function _craftGiveEXP(id, skill, exp)

	--#######################################################################################################
	if skill == "Повар" then

			if GetScienceLevel(id, "Повар") > 0 then
				local oldValue = Player[id].scraft_povar[2]; Player[id].scraft_povar[2] = Player[id].scraft_povar[2] + exp; local newValue = Player[id].scraft_povar[2];
				_craftSaveEXP(id);

				local nexp = 0;
				for i, v in ipairs(CRAFT_POVAR_LEVELS) do
					if Player[id].scraft_povar[1] == i then
						nexp = v;
						SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
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
			end
		--#######################################################################################################
	elseif skill == "Плотник" then

		if GetScienceLevel(id, "Плотник") > 0 then
			local oldValue = Player[id].scraft_plotnik[2]; Player[id].scraft_plotnik[2] = Player[id].scraft_plotnik[2] + exp; local newValue = Player[id].scraft_plotnik[2];
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_PLOTNIK_LEVELS) do
				if Player[id].scraft_plotnik[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
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
		end
		--#######################################################################################################
	elseif skill == "Портной" then

		if GetScienceLevel(id, "Портной") > 0 then
				local oldValue = Player[id].scraft_portnoy[2]; Player[id].scraft_portnoy[2] = Player[id].scraft_portnoy[2] + exp; local newValue = Player[id].scraft_portnoy[2]
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_PORTNOY_LEVELS) do
				if Player[id].scraft_portnoy[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
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
		end
		--#######################################################################################################
	elseif skill == "Оружейник" then
		if GetScienceLevel(id, "Оружейник") > 0 then
			local oldValue = Player[id].scraft_oryjeynik[2]; Player[id].scraft_oryjeynik[2] = Player[id].scraft_oryjeynik[2] + exp; local newValue = Player[id].scraft_oryjeynik[2]
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_ORYJEYNIK_LEVELS) do
				if Player[id].scraft_oryjeynik[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
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
		end
		--#######################################################################################################
	elseif skill == "Бронник" then
		if GetScienceLevel(id, "Бронник") > 0 then
			local oldValue = Player[id].scraft_bronnik[2]; Player[id].scraft_bronnik[2] = Player[id].scraft_bronnik[2] + exp; local newValue = Player[id].scraft_bronnik[2]
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_BRONNIK_LEVELS) do
				if Player[id].scraft_bronnik[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
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
		end
		--#######################################################################################################
	elseif skill == "Кожевник" then
		if GetScienceLevel(id, "Кожевник") > 0 then

			local oldValue = Player[id].scraft_kozhevnik[2]; Player[id].scraft_kozhevnik[2] = Player[id].scraft_kozhevnik[2] + exp; local newValue = Player[id].scraft_kozhevnik[2]
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_KOZHEVNIK_LEVELS) do
				if Player[id].scraft_kozhevnik[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
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
		end
		--#######################################################################################################
	elseif skill == "Кузнец" then
		if GetScienceLevel(id, "Кузнец") > 0 then

			local oldValue = Player[id].scraft_kyznec[2]; Player[id].scraft_kyznec[2] = Player[id].scraft_kyznec[2] + exp; local newValue = Player[id].scraft_kyznec[2]; 
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_KYZNEC_LEVELS) do
				if Player[id].scraft_kyznec[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
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
		end
		--#######################################################################################################
	elseif skill == "Алхимия" then
		if GetScienceLevel(id, "Алхимия") > 0 then

			local oldValue = Player[id].scraft_alhimic[2]; Player[id].scraft_alhimic[2] = Player[id].scraft_alhimic[2] + exp; local newValue = Player[id].scraft_alhimic[2]; 
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_ALHIMIC_LEVELS) do
				if Player[id].scraft_alhimic[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_alhimic[2] >= nexp then
				if Player[id].scraft_alhimic[1] == 1 or Player[id].scraft_alhimic[1] == 2 then
					Player[id].scraft_alhimic[1] = Player[id].scraft_alhimic[1] + 1; Player[id].scraft_alhimic[2] = 0;
					AddScience(id, "Алхимия", Player[id].scraft_alhimic[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень алхимика повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				end
			end
		end
		--#######################################################################################################
	elseif skill == "-------------" then
	end


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
			for i, v in pairs(CraftItem[instance].exp_skill) do
				local skill = v;
				if skill ~= nil then
					_craftGiveEXP(pid, skill, CraftItem[instance].exp);
				end
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

	local count = 0;
	for _ in pairs(CraftItem[instance].ing) do
			count = count + 1
	end

	local matches = 0;
	local items = getPlayerItems(pid);
	local max_matches = count;
	
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