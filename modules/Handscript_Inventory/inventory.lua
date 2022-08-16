local TInventory = {}
local TTransfer = {};

function InitInvent(pid)
	if TInventory[pid] ~= nil then
		TInventory[pid] = nil;
	end
	
	TInventory[pid] = {};
	TInventory[pid].item = {};
	LoadTItems(pid);
end

function AddTItem(pid, item, amount)
	if TInventory[pid].item[item] == nil then
		TInventory[pid].item[item] = {};
		TInventory[pid].item[item].amount = amount;
		TInventory[pid].item[item].type = "MISC";
	else
		TInventory[pid].item[item].amount = TInventory[pid].item[item].amount + amount;
	end
	SaveTItems(pid);
end

function RemoveTItem(pid, item, amount)
	if TInventory[pid].item[item] ~= nil then
		TInventory[pid].item[item].amount = TInventory[pid].item[item].amount - amount;
		if TInventory[pid].item[item].amount <= 0 then
			TInventory[pid].item[item] = nil;
		end
	end
	SaveTItems(pid);
end

function GiveTItem(pid, tid)
	if IsPlayerConnected(tid) == 1 and IsNPC(tid) == 0 and TTransfer[pid] ~= nil then
		if TInventory[pid].item[TTransfer[pid]].type == "MISC" then
			SendPlayerMessage(pid, 194, 162, 218, GetPlayerName(pid).." передал предмет \""..TTransfer[pid].."\" "..GetPlayerName(tid).."у(е)");
			SendPlayerMessage(tid, 194, 162, 218, GetPlayerName(pid).." передал предмет \""..TTransfer[pid].."\" "..GetPlayerName(tid).."у(е)");
			RemoveTItem(pid, TTransfer[pid], 1);
			AddTItem(tid, TTransfer[pid], 1);
		elseif TInventory[pid].item[TTransfer[pid]].type == "BOOK" then
			SendPlayerMessage(pid, 194, 162, 218, GetPlayerName(pid).." передал книгу "..GetPlayerName(tid).."у(е)");
			SendPlayerMessage(tid, 194, 162, 218, GetPlayerName(pid).." передал книгу "..GetPlayerName(tid).."у(е)");
			RemoveTItem(pid, TTransfer[pid], 1);
			AddBookItem(tid, TTransfer[pid], 1);
		elseif TInventory[pid].item[TTransfer[pid]].type == "LETTER" then
			SendPlayerMessage(pid, 194, 162, 218, GetPlayerName(pid).." передал письмо "..GetPlayerName(tid).."у(е)");
			SendPlayerMessage(tid, 194, 162, 218, GetPlayerName(pid).." передал письмо "..GetPlayerName(tid).."у(е)");
			RemoveTItem(pid, TTransfer[pid], 1);
			AddLetterItem(tid, TTransfer[pid], 1);		
		end
	end
end

function DemoTItem(pid, item)
	if TInventory[pid].item[item] ~= nil then
		if TInventory[pid].item[item].type == "MISC" then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(pid,i) <= 1000 then
					SendPlayerMessage(i, 194, 162, 218, GetPlayerName(pid).." показал предмет \""..item.."\"");
				end
			end
		elseif TInventory[pid].item[item].type == "BOOK" then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(pid,i) <= 1000 then
					SendPlayerMessage(i, 194, 162, 218, GetPlayerName(pid).." показал книгу \""..Handscript[item].title.."\"");
				end
			end
		elseif TInventory[pid].item[item].type == "LETTER" then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(pid,i) <= 1000 then
					SendPlayerMessage(i, 194, 162, 218, GetPlayerName(pid).." показал письмо \""..Handscript[item].title.."\"");
				end
			end
		end
	end
end

function AddLetterItem(pid, uid, amount)
	uid = tonumber(uid);
	if TInventory[pid].item[uid] == nil then
		TInventory[pid].item[uid] = {};
		TInventory[pid].item[uid].amount = amount;
		TInventory[pid].item[uid].type = "LETTER";
	else
		TInventory[pid].item[uid].amount = TInventory[pid].item[uid].amount + amount;
	end
	SaveTItems(pid);
end

function AddBookItem(pid, uid, amount)
	uid = tonumber(uid);
	if TInventory[pid].item[uid] == nil then
		TInventory[pid].item[uid] = {};
		TInventory[pid].item[uid].amount = amount;
		TInventory[pid].item[uid].type = "BOOK";
	else
		TInventory[pid].item[uid].amount = TInventory[pid].item[uid].amount + amount;
	end
	SaveTItems(pid);
end

function LoadLetterItem(pid, uid, amount)
	uid = tonumber(uid);
	if TInventory[pid].item[uid] == nil then
		TInventory[pid].item[uid] = {};
		TInventory[pid].item[uid].amount = amount;
		TInventory[pid].item[uid].type = "LETTER";
	else
		TInventory[pid].item[uid].amount = TInventory[pid].item[uid].amount + amount;
	end
end

function LoadBookItem(pid, uid, amount)
	uid = tonumber(uid);
	if TInventory[pid].item[uid] == nil then
		TInventory[pid].item[uid] = {};
		TInventory[pid].item[uid].amount = amount;
		TInventory[pid].item[uid].type = "BOOK";
	else
		TInventory[pid].item[uid].amount = TInventory[pid].item[uid].amount + amount;
	end
end

function LoadTItem(pid, item, amount)
	if TInventory[pid].item[item] == nil then
		TInventory[pid].item[item] = {};
		TInventory[pid].item[item].amount = amount;
		TInventory[pid].item[item].type = "MISC";
	else
		TInventory[pid].item[item].amount = TInventory[pid].item[item].amount + amount;
	end
end

function InitInventTexture()
	repeat
		GUI_Inventory_bg = CreateTexture(5475, 200, 8000, 6225, "MENU_INGAME.TGA");
	until GUI_Inventory_bg ~= 0;
	repeat
		GUI_Inventory_show_bg = CreateTexture(5475, 6225, 8000, 6475, "MENU_INGAME.TGA");
	until GUI_Inventory_show_bg ~= 0;
	repeat
		GUI_Inventory_give_bg = CreateTexture(5475, 6475, 8000, 6725, "MENU_INGAME.TGA");
	until GUI_Inventory_give_bg ~= 0;
	repeat
		GUI_Inventory_read_bg = CreateTexture(5475, 6725, 8000, 7000, "MENU_INGAME.TGA");
	until GUI_Inventory_read_bg ~= 0;
end

GUI_Inventory_bg = 0;
GUI_Inventory_show_bg = 0;
GUI_Inventory_give_bg = 0;
GUI_Inventory_read_bg = 0;

GUI_Inventory  = {};

function DestroyInventoryGUI(pid)
	if GUI_Inventory[pid] ~= nil then
		for k, v in pairs(GUI_Inventory[pid].items) do
			if GUI_Inventory[pid].items[k].draw ~= nil then
				DestroyPlayerDraw(pid, GUI_Inventory[pid].items[k].draw);
			end
		end
		
		DestroyPlayerDraw(pid, GUI_Inventory[pid].title);
		DestroyPlayerDraw(pid, GUI_Inventory[pid].show_draw);
		DestroyPlayerDraw(pid, GUI_Inventory[pid].give_draw);
		DestroyPlayerDraw(pid, GUI_Inventory[pid].read_draw);
		if GUI_Inventory[pid].empty_draw ~= nil then
			DestroyPlayerDraw(pid, GUI_Inventory[pid].empty_draw);
		end
		
		GUI_Inventory[pid] = nil;
	end
end

function GUIInventoryInit(pid)
	if GUI_Inventory[pid] ~= nil then
		DestroyInventoryGUI(pid);
		GUI_Inventory[pid] = nil;
	end
	
	GUI_Inventory[pid] = {};
	GUI_Inventory[pid].current_item = -1;

	
	GUI_Inventory[pid].title = CreatePlayerDraw(pid, 6250, 25, "Инвентарь (РП)", "Font_Old_20_White_Hi.TGA", 240, 230, 140);
	
	GUI_Inventory[pid].show_draw = CreatePlayerDraw(pid, 5550, 6250, "Показать (LShift)", "Font_Old_10_White_Hi.TGA", 240, 230, 140);
	GUI_Inventory[pid].give_draw = CreatePlayerDraw(pid, 5550, 6500, "Передать (LCtrl)", "Font_Old_10_White_Hi.TGA", 240, 230, 140);
	GUI_Inventory[pid].read_draw = CreatePlayerDraw(pid, 5550, 6750, "Читать (Enter)", "Font_Old_10_White_Hi.TGA", 240, 230, 140);
	
	GUI_Inventory[pid].items = {};
	
	local i = 0;
	for k, v in pairs(TInventory[pid].item) do
		GUI_Inventory[pid].items[i] = {};
		if TInventory[pid].item[k].type == "MISC" then
			GUI_Inventory[pid].items[i].draw = CreatePlayerDraw(pid, 5550, 250 + 300*i, string.format("- %s x%d", k, TInventory[pid].item[k].amount), "Font_Old_10_White_Hi.TGA", 218, 165, 32);
			GUI_Inventory[pid].items[i].name = k;
			GUI_Inventory[pid].items[i].uid = k;
		elseif TInventory[pid].item[k].type == "LETTER" then
			if Handscript[k].title ~= nil then
				GUI_Inventory[pid].items[i].draw = CreatePlayerDraw(pid, 5550, 250 + 300*i, string.format("- %s (письмо) x%d", Handscript[k].title, TInventory[pid].item[k].amount), "Font_Old_10_White_Hi.TGA", 218, 165, 32);
			else
				GUI_Inventory[pid].items[i].draw = CreatePlayerDraw(pid, 5550, 250 + 300*i, string.format("- %s (письмо) x%d", "Без названия", TInventory[pid].item[k].amount), "Font_Old_10_White_Hi.TGA", 218, 165, 32);
			end
			
			if Handscript[k].title ~= nil then
				GUI_Inventory[pid].items[i].name = Handscript[k].title.." (письмо)";
			else
				GUI_Inventory[pid].items[i].name = "Без названия (письмо)";
			end
			
			GUI_Inventory[pid].items[i].uid = k;
		elseif TInventory[pid].item[k].type == "BOOK" then
			if Handscript[k].title ~= nil then
				GUI_Inventory[pid].items[i].draw = CreatePlayerDraw(pid, 5550, 250 + 300*i, string.format("- %s (книга) x%d", Handscript[k].title, TInventory[pid].item[k].amount), "Font_Old_10_White_Hi.TGA", 218, 165, 32);
			else
				GUI_Inventory[pid].items[i].draw = CreatePlayerDraw(pid, 5550, 250 + 300*i, string.format("- %s (книга) x%d", "Без названия", TInventory[pid].item[k].amount), "Font_Old_10_White_Hi.TGA", 218, 165, 32);
			end
			
			
			if Handscript[k].title ~= nil then
				GUI_Inventory[pid].items[i].name = Handscript[k].title.." (книга)";
			else
				GUI_Inventory[pid].items[i].name = "Без названия (книга)";
			end
			
			GUI_Inventory[pid].items[i].uid = k;
		end
		i = i + 1;
	end
	
	GUI_Inventory[pid].empty_draw = CreatePlayerDraw(pid, 5550, 250, "- Пусто", "Font_Old_10_White_Hi.TGA", 218, 165, 32);
end


function ShowInventoryGUI(pid)
	Player[pid].onGUI = true;
	FreezePlayer(pid, 1);
	GUI_Inventory[pid].current_item = 0;
	
	if tLen(GUI_Inventory[pid].items) <= 16 then
		for k, v in pairs(GUI_Inventory[pid].items) do
			ShowPlayerDraw(pid, GUI_Inventory[pid].items[k].draw);
		end
		
		if tLen(GUI_Inventory[pid].items) == 0 then
			ShowPlayerDraw(pid, GUI_Inventory[pid].empty_draw);
		end
	else
		for i = 0, 19 do
			ShowPlayerDraw(pid, GUI_Inventory[pid].items[i].draw);
		end
	end
	
	ShowPlayerDraw(pid, GUI_Inventory[pid].title);
	ShowPlayerDraw(pid, GUI_Inventory[pid].show_draw);
	ShowPlayerDraw(pid, GUI_Inventory[pid].give_draw);
	ShowTexture(pid, GUI_Inventory_bg);
	ShowTexture(pid, GUI_Inventory_show_bg);
	ShowTexture(pid, GUI_Inventory_give_bg);
end

function CheckTType(pid)
	if GUI_Inventory[pid] ~= nil then
		if GUI_Inventory[pid].items[GUI_Inventory[pid].current_item] ~= nil then
			if Handscript[GUI_Inventory[pid].items[GUI_Inventory[pid].current_item].uid] ~= nil then
				ShowPlayerDraw(pid, GUI_Inventory[pid].read_draw);
				ShowTexture(pid, GUI_Inventory_read_bg);
			else
				HideReadOption(pid);
			end
		end
	end	
end

function HideReadOption (pid)
	HidePlayerDraw(pid, GUI_Inventory[pid].read_draw);
	HideTexture(pid, GUI_Inventory_read_bg);
end

function HideInventoryGUI (pid)
	for k, v in pairs(GUI_Inventory[pid].items) do
		HidePlayerDraw(pid, GUI_Inventory[pid].items[k].draw);
	end
	
	HidePlayerDraw(pid, GUI_Inventory[pid].title);
	HidePlayerDraw(pid, GUI_Inventory[pid].show_draw);
	HidePlayerDraw(pid, GUI_Inventory[pid].give_draw);
	HidePlayerDraw(pid, GUI_Inventory[pid].read_draw);
	HidePlayerDraw(pid, GUI_Inventory[pid].empty_draw);	
	HideTexture(pid, GUI_Inventory_bg);
	HideTexture(pid, GUI_Inventory_show_bg);
	HideTexture(pid, GUI_Inventory_give_bg);
	HideTexture(pid, GUI_Inventory_read_bg);
	
	GUI_Inventory[pid].current_item = -1;
	FreezePlayer(pid, 0);
	Player[pid].onGUI = false;
end

function InventoryGUIMoveUp(pid)
		if(GUI_Inventory[pid].current_item > 0) then
			GUI_Inventory[pid].current_item = GUI_Inventory[pid].current_item - 1;
			--CheckTType(pid);
		end
end

function InventoryGUIMoveDown(pid)
		if(GUI_Inventory[pid].current_item < tLen(GUI_Inventory[pid].items)) then
			GUI_Inventory[pid].current_item = GUI_Inventory[pid].current_item + 1;
			--CheckTType(pid);
		end
end

function InventoryScrollUpdate(pid)
	CheckTType(pid);
	for k, v in pairs(GUI_Inventory[pid].items) do
		if Handscript[GUI_Inventory[pid].items[k].uid] == nil then
			if k == GUI_Inventory[pid].current_item then
				UpdatePlayerDraw(pid, GUI_Inventory[pid].items[k].draw, 5550, 900, string.format("- %s x%d", GUI_Inventory[pid].items[k].name, TInventory[pid].item[GUI_Inventory[pid].items[k].name].amount), "Font_Old_20_White_Hi.TGA", 255, 255, 0);
			else
				UpdatePlayerDraw(pid, GUI_Inventory[pid].items[k].draw, 5550, 1000 + 300*(k - GUI_Inventory[pid].current_item), string.format("- %s x%d", GUI_Inventory[pid].items[k].name, TInventory[pid].item[GUI_Inventory[pid].items[k].name].amount), "Font_Old_10_White_Hi.TGA", 218, 165, 32);
			end
		else
			if k == GUI_Inventory[pid].current_item then
				UpdatePlayerDraw(pid, GUI_Inventory[pid].items[k].draw, 5550, 900, string.format("- %s x%d", GUI_Inventory[pid].items[k].name, TInventory[pid].item[GUI_Inventory[pid].items[k].uid].amount), "Font_Old_20_White_Hi.TGA", 255, 255, 0);
			else
				UpdatePlayerDraw(pid, GUI_Inventory[pid].items[k].draw, 5550, 1000 + 300*(k - GUI_Inventory[pid].current_item), string.format("- %s x%d", GUI_Inventory[pid].items[k].name, TInventory[pid].item[GUI_Inventory[pid].items[k].uid].amount), "Font_Old_10_White_Hi.TGA", 218, 165, 32);
			end		
		end
		
		if (k - GUI_Inventory[pid].current_item) < -2 or (k - GUI_Inventory[pid].current_item) > 16 then
			HidePlayerDraw(pid, GUI_Inventory[pid].items[k].draw);
		else
			ShowPlayerDraw(pid, GUI_Inventory[pid].items[k].draw);
		end
	end
end

function SaveTItems(pid)
	local file = io.open("Database/Players/_inventory/"..Player[pid].nickname.."_rp.db","w");
	for k, v in pairs(TInventory[pid].item) do
		file:write(TInventory[pid].item[k].type.." "..TInventory[pid].item[k].amount.." "..k..'\n');
	end
	file:close();
end

function LoadTItems(pid)
	local fileitems = io.open("Database/Players/_inventory/"..Player[pid].nickname.."_rp.db","r+");
	if fileitems then
		for line in fileitems:lines() do
			local result, ttype, amount, item = sscanf(line,"sds");
			if result == 1 then
				if ttype == "MISC" then
					LoadTItem(pid, item, amount);
				elseif ttype == "LETTER" then
					LoadLetterItem(pid, item, amount);
				elseif ttype == "BOOK" then
					LoadBookItem(pid, item, amount);
				end
			end
		end
	fileitems:close();
	end
	GUIInventoryInit(pid);
end

function CheckInventoryGUI (pid, keydown, keyup)

	if Player[pid].loggedIn == true then

		if keydown == KEY_I then
			if GUI_Inventory[pid] ~= nil and GUI_Inventory[pid].current_item == -1 and Player[pid].onGUI == false then
				GUIInventoryInit(pid);
				ShowInventoryGUI(pid);
				InventoryScrollUpdate(pid);
			else
				HideInventoryGUI(pid);
			end
		elseif keydown == KEY_DOWN and GUI_Inventory[pid] ~= nil and GUI_Inventory[pid].current_item >= 0  then
			InventoryGUIMoveDown(pid);
			InventoryScrollUpdate(pid);
		elseif keydown == KEY_UP and GUI_Inventory[pid] ~= nil and GUI_Inventory[pid].current_item >= 0  then
			InventoryGUIMoveUp(pid);
			InventoryScrollUpdate(pid);
		elseif keydown == KEY_UP and GUI_Inventory[pid] ~= nil and GUI_Inventory[pid].current_item >= 0  then
			InventoryGUIMoveUp(pid);
			InventoryScrollUpdate(pid);
		elseif keydown == KEY_LSHIFT and GUI_Inventory[pid] ~= nil and GUI_Inventory[pid].current_item >= 0 and GUI_Inventory[pid].items[GUI_Inventory[pid].current_item] ~= nil then
			DemoTItem(pid, GUI_Inventory[pid].items[GUI_Inventory[pid].current_item].uid);
		elseif keydown == KEY_LCONTROL and GUI_Inventory[pid] ~= nil and GUI_Inventory[pid].items[GUI_Inventory[pid].current_item] ~= nil and GUI_Inventory[pid].current_item >= 0  then
			TTransfer[pid] = GUI_Inventory[pid].items[GUI_Inventory[pid].current_item].uid;
			HideInventoryGUI(pid);
			GameTextForPlayer(pid, 500, 6500, "Нажмите повторно LCtrl по игроку, для передачи предмета","Font_Old_10_White_Hi.TGA", 255, 154, 0, 5000);
		elseif keydown == KEY_LCONTROL and TTransfer[pid] ~= nil  then
			if GetFocus(pid) >= 0 then
				GiveTItem(pid, GetFocus(pid));
				TTransfer[pid] = nil;
			end
		elseif keydown == KEY_RETURN and GUI_Inventory[pid] ~= nil and GUI_Inventory[pid].current_item >= 0 and GUI_Inventory[pid].items[GUI_Inventory[pid].current_item] ~= nil and GUI_Inventory[pid].items[GUI_Inventory[pid].current_item].uid ~= nil then
			ReadHandscript(pid, GUI_Inventory[pid].items[GUI_Inventory[pid].current_item].uid);
			HideInventoryGUI(pid);
		end
	end
end


function CMD_GenItem(playerid, params)
	if Player[playerid].astatus > 2 then
		local result,id, amount,item = sscanf(params,"dds");
		if result == 1 then
			if IsPlayerConnected(id) == 1 then
				SendPlayerMessage(id, 255, 255,0, string.format("%s х%d \"%s\" %s %s","(ИНФО): Вы получили РП предмет", amount, item, "от", GetPlayerName(playerid)));
				SendPlayerMessage(playerid, 255, 255, 0, string.format("%s х%d \"%s\" %s %s","(ИНФО): Вы выдали РП предмет", amount, item,"для", GetPlayerName(id)));
				LogString("logADMIN",string.format("%s %s %s %s х%s",GetPlayerName(playerid),"сгенерировал РП предмет для", GetPlayerName(id), item, amount));
				AddTItem(id, item, amount);
			else
				SendPlayerMessage(playerid,255,255,0,string.format("%s%d%s","(СЕРВЕР): Игрок с id(",id,") не на сервере."));
			end
		else
			SendPlayerMessage(playerid,255,255,0,"(ИНФО): Используй: /ген (ID игрока) (количество) (наименование вещи)");
		end
	else
		SendPlayerMessage(playerid,255,154,100,"(СЕРВЕР): Вы не админ!");
	end
end
addCommandHandler({"/генрп"}, CMD_GenItem)
