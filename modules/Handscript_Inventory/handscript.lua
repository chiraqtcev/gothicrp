function tLen(arg)
	return table.getn(arg);
end

Handscript = {};
local LINES_LIMIT = 20;
local PlayerWriting = {};
local PlayerReading = {};

function InitHandscripts()
	LoadHandscripts();
	repeat
		GUI_Letter_next_bg = CreateTexture(6750, 7000, 7500, 7250, "MENU_INGAME.TGA");
	until GUI_Letter_next_bg ~= 0;
	
	repeat
		GUI_Letter_prev_bg = CreateTexture(6200, 7000, 6750, 7250, "MENU_INGAME.TGA");
	until GUI_Letter_prev_bg ~= 0;
	
	repeat
		GUI_Letter_hint_auth_t = CreateTexture(6550, 6500, 7500, 6750, "MENU_INGAME.TGA");
	until GUI_Letter_hint_auth_t ~= 0;
	
	repeat
		GUI_Letter_hint_wax_t = CreateTexture(6550, 6250, 7500, 6500, "MENU_INGAME.TGA");
	until GUI_Letter_hint_wax_t ~= 0;
	
	repeat
		GUI_Letter_waxed = CreateTexture(4500, 6500, 5500, 7500, "WAX.TGA");
	until GUI_Letter_waxed ~= 0;
	
	repeat
		GUI_Book_next_bg = CreateTexture(6750, 7250, 7500, 7500, "MENU_INGAME.TGA");
	until GUI_Book_next_bg ~= 0;
	
	repeat
		GUI_Book_prev_bg = CreateTexture(6000, 7250, 6750, 7500, "MENU_INGAME.TGA");
	until GUI_Book_prev_bg ~= 0;
	
	repeat
		GUI_Book_bgl = CreateTexture(0, 2000, 4000, 7250, "BOOK_BROWN_L.TGA");
	until GUI_Book_bgl ~= 0;
	
	repeat
		GUI_Book_bgr = CreateTexture(4000, 2000, 8000, 7250, "BOOK_BROWN_R.TGA");
	until GUI_Book_bgr ~= 0;
	
	repeat
		GUI_Letter_bg = CreateTexture(2000, 1500, 5550, 7500, "LETTER1.TGA");
	until GUI_Letter_bg ~= 0;
	
	repeat
		GUI_Letter_sealed= CreateTexture(2000, 1500, 5550, 7500, "SEALED_SCROLL.TGA");
	until GUI_Letter_sealed ~= 0;
end

function GenLetter(pid)
	local uid; 
	repeat
		uid = math.random(10000);
	until Handscript[uid] == nil;
		Handscript[uid] = {};
		Handscript[uid].title = nil;
		Handscript[uid].text = {};
		Handscript[uid].type = "LETTER";
		Handscript[uid].author = GetPlayerName(pid);
		Handscript[uid].author_viewable = " ";
		Handscript[uid].waxed = 0;
		Handscript[uid].wax_removed = 0;
	return uid;
end

function GenBook(pid)
	local uid; 
	repeat
		uid = math.random(10000);
	until Handscript[uid] == nil;
		Handscript[uid] = {};
		Handscript[uid].title = nil;
		Handscript[uid].text = {};
		Handscript[uid].type = "BOOK";
		Handscript[uid].author = GetPlayerName(pid);
	return uid;
end

function AddHandscriptPage(uid)
	if Handscript[uid].pages == nil then
		Handscript[uid].pages = {};
	end
	
	local size = tLen(Handscript[uid].pages) + 1;
	Handscript[uid].pages[size] = {};
	Handscript[uid].pages[size].lines = {};
end

function AddHandscriptText(uid, text)
	text = string.gsub(text, "/", ",");
	text = string.gsub(text, "|", ":");
	text = string.format("   %s", text);
	if Handscript[uid].text == nil then
		Handscript[uid].text = {};
	end
	
	table.insert(Handscript[uid].text, text);
	
	local temptext = text;
	
	repeat
		if string.len(text) > 30 then
			AddHandscriptLine(uid, string.sub(temptext, 1, 30));
			temptext = string.sub(temptext, 31, string.len(temptext));
		end
	until string.len(temptext) <= 30;
	AddHandscriptLine(uid, temptext);
end

function AddHandscriptLine(uid, text)
	local p_size = tLen(Handscript[uid].pages);
	local l_size = tLen(Handscript[uid].pages[p_size].lines) + 1;
	
	if l_size >= LINES_LIMIT then
		AddHandscriptPage(uid);
		p_size = p_size + 1;
		l_size = 1;
	end
	
	table.insert(Handscript[uid].pages[p_size].lines, text);
end

function WriteHandscript(pid, text)
	
	text = string.gsub(text, "/", ",");
	if PlayerWriting[pid] ~= nil then
		SendPlayerMessage(pid, 255, 255, 255, GetPlayerName(pid).." сделал запись");
		if Handscript[PlayerWriting[pid]].title == nil then
			if string.len(text) > 23 then
				text = string.sub(text, 1, 23);
			end
			Handscript[PlayerWriting[pid]].title = text;
			SendPlayerMessage(pid, 255, 255, 0, "(ИНФО): Заголовок задан. Продолжайте запись содержимого (отправить в чат)");
			SendPlayerMessage(pid, 255, 255, 0, "(ИНФО): Для завершения нажмите Enter или Escape");
		else
			AddHandscriptText(PlayerWriting[pid], text);
		end
		
		if Handscript[PlayerWriting[pid]].type == "BOOK" then
			UpdateBookGUI(pid);
		else
			UpdateLetterGUI(pid);
		end
		
		return 1;
	end
	
	return 0;
end

GUI_Letter = {};

function DestroyLetterGUI(pid)
	for k in pairs(GUI_Letter[pid].line) do
		DestroyPlayerDraw(pid, GUI_Letter[pid].line[k]);
	end
	DestroyPlayerDraw(pid, GUI_Letter[pid].next_draw);
	DestroyPlayerDraw(pid, GUI_Letter[pid].prev_draw);
	DestroyPlayerDraw(pid, GUI_Letter[pid].title);
	DestroyPlayerDraw(pid, GUI_Letter[pid].author);
	DestroyPlayerDraw(pid, GUI_Letter[pid].hint_auth_d);
	DestroyPlayerDraw(pid, GUI_Letter[pid].hint_wax_d);
end

--[[

	bgl[0] = CreateTexture(4000, 1700, 7400, 6600, "LETTERS.TGA");
	bgl[1] = CreateTexture(4000, 1700, 7400, 6600, "LETTER1.TGA");
	bgl[2] = CreateTexture(4000, 1700, 7400, 6600, "LETTER2.TGA");
	waxed = CreateTexture(4300,5000,5300,6000,"WAX.TGA");
	logontx = CreateTexture(2700,2000,6800,7500, "LETTERS.TGA");]]
	
function GUILetterInit(pid)
	if GUI_Letter[pid] ~= nil then
		DestroyLetterGUI(pid);
		GUI_Letter[pid] = nil;
	end
	
	GUI_Letter[pid] = {};
	GUI_Letter[pid].current_page = 1;

	
	
	GUI_Letter[pid].title = CreatePlayerDraw(pid, 3000, 1850, " ", "Font_Old_20_White_Hi.TGA", 0, 0, 0);

	GUI_Letter[pid].next_draw = CreatePlayerDraw(pid, 6950, 7050, "След. >", "Font_Old_10_White_Hi.TGA", 240, 230, 140);
	GUI_Letter[pid].prev_draw = CreatePlayerDraw(pid, 6200, 7050, "< Пред.", "Font_Old_10_White_Hi.TGA", 240, 230, 140);
	GUI_Letter[pid].hint_auth_d = CreatePlayerDraw(pid, 6550, 6550, "Подпись (LCtrl)", "Font_Old_10_White_Hi.TGA", 240, 230, 140);
	GUI_Letter[pid].hint_wax_d = CreatePlayerDraw(pid, 6550, 6300, "Печать (LShift)", "Font_Old_10_White_Hi.TGA", 240, 230, 140);
	
	GUI_Letter[pid].author = CreatePlayerDraw(pid, 4650, 6200, " ", "Font_Old_10_White_Hi.TGA", 0, 0, 0);
	
	GUI_Letter[pid].line = {};
	
	for i = 0, LINES_LIMIT - 1 do
		table.insert(GUI_Letter[pid].line, CreatePlayerDraw(pid, 2550, 1850 + 225*i, " ", "Font_Old_10_White_Hi.TGA", 0, 0, 0));
	end
	
end

function UpdateLetterGUI(pid)

	local uid;
	if PlayerReading[pid] ~= nil then
		uid = PlayerReading[pid];
	elseif PlayerWriting[pid] ~= nil then
		uid = PlayerWriting[pid];
	end

	Player[pid].onGUI = true;
	
	if (PlayerReading[pid] ~= nil and ((Handscript[uid].waxed == 1 and Handscript[uid].wax_removed == 1) or Handscript[uid].waxed == 0)) or (PlayerReading[pid] == nil and PlayerWriting[pid] ~= nil) then
		ShowTexture(pid, GUI_Letter_bg);
		if Handscript[uid].title ~= nil and GUI_Letter[pid].current_page == 1 then
			UpdatePlayerDraw(pid, GUI_Letter[pid].title, 3000, 1850, Handscript[uid].title, "Font_Old_20_White_Hi.TGA", 0, 0, 0);
		else
			UpdatePlayerDraw(pid, GUI_Letter[pid].title, 3000, 1850, " ", "Font_Old_20_White_Hi.TGA", 0, 0, 0);
		end
		ShowPlayerDraw(pid, GUI_Letter[pid].title);
		
		for k in pairs(GUI_Letter[pid].line) do
			if Handscript[uid].pages[GUI_Letter[pid].current_page] ~= nil then
				if Handscript[uid].pages[GUI_Letter[pid].current_page].lines[k] ~= nil then
					UpdatePlayerDraw(pid, GUI_Letter[pid].line[k], 2550, 1850 + 225*k, Handscript[uid].pages[GUI_Letter[pid].current_page].lines[k], "Font_Old_10_White_Hi.TGA", 0, 0, 0);
				else
					UpdatePlayerDraw(pid, GUI_Letter[pid].line[k], 2550, 1850 + 225*k, " ", "Font_Old_10_White_Hi.TGA", 0, 0, 0);
				end
			else
				UpdatePlayerDraw(pid, GUI_Letter[pid].line[k], 2550, 1850 + 225*k, " ", "Font_Old_10_White_Hi.TGA", 0, 0, 0);
			end
			
			ShowPlayerDraw(pid, GUI_Letter[pid].line[k]);
		end
		if GUI_Letter[pid].current_page == tLen(Handscript[uid].pages) then
			UpdatePlayerDraw(pid, GUI_Letter[pid].author, 4650, 6200, Handscript[uid].author_viewable, "Font_Old_10_White_Hi.TGA", 0, 0, 0);
			ShowPlayerDraw(pid, GUI_Letter[pid].author);
			if Handscript[uid].waxed == 1 then
				ShowTexture(pid, GUI_Letter_waxed);
			else
				HideTexture(pid, GUI_Letter_waxed);		
			end
		else
			HidePlayerDraw(pid, GUI_Letter[pid].author);
			HideTexture(pid, GUI_Letter_waxed);
		end
		if GUI_Letter[pid].current_page < tLen(Handscript[uid].pages) then
			ShowPlayerDraw(pid, GUI_Letter[pid].next_draw);
			ShowTexture(pid, GUI_Letter_next_bg);
		else
			HidePlayerDraw(pid, GUI_Letter[pid].next_draw);
			HideTexture(pid, GUI_Letter_next_bg);
		end
		
		if GUI_Letter[pid].current_page > 1 then
			ShowPlayerDraw(pid, GUI_Letter[pid].prev_draw);
			ShowTexture(pid, GUI_Letter_prev_bg);
		else
			HidePlayerDraw(pid, GUI_Letter[pid].prev_draw);
			HideTexture(pid, GUI_Letter_prev_bg);
		end
		if PlayerWriting[pid] ~= nil and PlayerReading[pid] == nil then
			ShowPlayerDraw(pid, GUI_Letter[pid].hint_auth_d);
			ShowTexture(pid, GUI_Letter_hint_auth_t);
			ShowPlayerDraw(pid, GUI_Letter[pid].hint_wax_d);
			ShowTexture(pid, GUI_Letter_hint_wax_t);
		end
	elseif Handscript[uid].waxed == 1 and Handscript[uid].wax_removed == 0 then
		ShowTexture(pid, GUI_Letter_sealed);
	end
end

function UnsealLetter(pid, uid)
	if Handscript[uid].waxed == 1 and Handscript[uid].wax_removed == 0 then
		SendPlayerMessage(pid, 255, 255, 255, GetPlayerName(pid).." распечатал письмо");
		Handscript[uid].wax_removed = 1;
	end
end

function HideLetterGUI(pid)
	for k in pairs(GUI_Letter[pid].line) do
		HidePlayerDraw(pid, GUI_Letter[pid].line[k]);
	end
	
	HidePlayerDraw(pid, GUI_Letter[pid].next_draw);
	HideTexture(pid, GUI_Letter_next_bg);
	HidePlayerDraw(pid, GUI_Letter[pid].prev_draw);
	HideTexture(pid, GUI_Letter_prev_bg);
	HidePlayerDraw(pid, GUI_Letter[pid].title);
	HidePlayerDraw(pid, GUI_Letter[pid].author);
	HideTexture(pid, GUI_Letter_waxed);
	HideTexture(pid, GUI_Letter_bg);	
	HideTexture(pid, GUI_Letter_sealed);	
	HidePlayerDraw(pid, GUI_Letter[pid].hint_auth_d);
	HideTexture(pid, GUI_Letter_hint_auth_t);
	HidePlayerDraw(pid, GUI_Letter[pid].hint_wax_d);
	HideTexture(pid, GUI_Letter_hint_wax_t);
	Player[pid].onGUI = false;
end

GUI_Book = {};

function DestroyBookGUI(pid)
	for k in pairs(GUI_Book[pid].line_l) do
		DestroyPlayerDraw(pid, GUI_Book[pid].line_l[k]);
		DestroyPlayerDraw(pid, GUI_Book[pid].line_r[k]);
	end
	
	DestroyPlayerDraw(pid, GUI_Book[pid].next_draw);
	DestroyPlayerDraw(pid, GUI_Book[pid].prev_draw);
	DestroyPlayerDraw(pid, GUI_Book[pid].title);
	DestroyPlayerDraw(pid, GUI_Book[pid].title_underline);
end

function GUIBookInit(pid)
	if GUI_Book[pid] ~= nil then
		DestroyBookGUI(pid);
		GUI_Book[pid] = nil;
	end
	
	GUI_Book[pid] = {};
	GUI_Book[pid].current_page = 1;
	
	
	
	GUI_Book[pid].title = CreatePlayerDraw(pid, 2000, 2200, " ", "Font_Old_10_White_Hi.TGA", 0, 0, 0);
	GUI_Book[pid].title_underline = CreatePlayerDraw(pid, 2000, 2200, " ", "Font_Old_10_White_Hi.TGA", 0, 0, 0);
	
	GUI_Book[pid].next_draw = CreatePlayerDraw(pid, 6950, 7300, "След. >", "Font_Old_10_White_Hi.TGA", 240, 230, 140);
	GUI_Book[pid].prev_draw = CreatePlayerDraw(pid, 6200, 7300, "< Пред.", "Font_Old_10_White_Hi.TGA", 240, 230, 140);
	
	GUI_Book[pid].line_l = {};
	GUI_Book[pid].line_r = {};
	
	for i = 0, LINES_LIMIT - 1 do
		table.insert(GUI_Book[pid].line_l, CreatePlayerDraw(pid, 2000, 2200 + 225*i, " ", "Font_Old_10_White_Hi.TGA", 0, 0, 0));
		table.insert(GUI_Book[pid].line_r, CreatePlayerDraw(pid, 4050, 2150 + 225*i, " ", "Font_Old_10_White_Hi.TGA", 0, 0, 0));
	end
	
end

function UpdateBookGUI(pid)
	local uid;
	if PlayerReading[pid] ~= nil then
		uid = PlayerReading[pid];
	elseif PlayerWriting[pid] ~= nil then
		uid = PlayerWriting[pid];
	end
	Player[pid].onGUI = true;
	
	ShowTexture(pid, GUI_Book_bgl);
	ShowTexture(pid, GUI_Book_bgr);
	
	if Handscript[uid].title ~= nil and GUI_Book[pid].current_page == 1 then
		UpdatePlayerDraw(pid, GUI_Book[pid].title, 2000, 2200, Handscript[uid].title, "Font_Old_10_White_Hi.TGA", 0, 0, 0);
		local underline = "_";
		for i = 0, string.len(Handscript[uid].title) do
			underline = string.format("%s%s", underline, "_");
		end
		UpdatePlayerDraw(pid, GUI_Book[pid].title_underline, 2000, 2200, underline, "Font_Old_10_White_Hi.TGA", 0, 0, 0);
	else
		UpdatePlayerDraw(pid, GUI_Book[pid].title, 2000, 2200, " ", "Font_Old_20_White_Hi.TGA", 0, 0, 0);
		UpdatePlayerDraw(pid, GUI_Book[pid].title_underline, 2000, 2200, " ", "Font_Old_20_White_Hi.TGA", 0, 0, 0);
	end
	
	ShowPlayerDraw(pid, GUI_Book[pid].title);
	ShowPlayerDraw(pid, GUI_Book[pid].title_underline);
	
	
	for k in pairs(GUI_Book[pid].line_l) do
		if Handscript[uid].pages[GUI_Book[pid].current_page] ~= nil then
			if Handscript[uid].pages[GUI_Book[pid].current_page].lines[k] ~= nil then
				UpdatePlayerDraw(pid, GUI_Book[pid].line_l[k], 2000, 2250 + 225*k, Handscript[uid].pages[GUI_Book[pid].current_page].lines[k], "Font_Old_10_White_Hi.TGA", 0, 0, 0);
			else
				UpdatePlayerDraw(pid, GUI_Book[pid].line_l[k], 2000, 2250 + 225*k, " ", "Font_Old_10_White_Hi.TGA", 0, 0, 0);
			end
		else
			UpdatePlayerDraw(pid, GUI_Book[pid].line_l[k], 2000, 2250 + 225*k, " ", "Font_Old_10_White_Hi.TGA", 0, 0, 0);		
		end
		
		ShowPlayerDraw(pid, GUI_Book[pid].line_l[k]);
	end
	
	for k in pairs(GUI_Book[pid].line_r) do
		if Handscript[uid].pages[GUI_Book[pid].current_page + 1] ~= nil then
			if Handscript[uid].pages[GUI_Book[pid].current_page + 1].lines[k] ~= nil then
				UpdatePlayerDraw(pid, GUI_Book[pid].line_r[k], 4050, 2050 + 225*k, Handscript[uid].pages[GUI_Book[pid].current_page + 1].lines[k], "Font_Old_10_White_Hi.TGA", 0, 0, 0);
			else
				UpdatePlayerDraw(pid, GUI_Book[pid].line_r[k], 4050, 2050 + 225*k, " ", "Font_Old_10_White_Hi.TGA", 0, 0, 0);
			end
		else
			UpdatePlayerDraw(pid, GUI_Book[pid].line_r[k], 4050, 2050 + 225*k, " ", "Font_Old_10_White_Hi.TGA", 0, 0, 0);		
		end
		ShowPlayerDraw(pid, GUI_Book[pid].line_r[k]);
	end
	
	if GUI_Book[pid].current_page < tLen(Handscript[uid].pages) - 1 then
		ShowPlayerDraw(pid, GUI_Book[pid].next_draw);
		ShowTexture(pid, GUI_Book_next_bg);
	else
		HidePlayerDraw(pid, GUI_Book[pid].next_draw);
		HideTexture(pid, GUI_Book_next_bg);
	end
	
	
	if GUI_Book[pid].current_page > 1 then
		ShowPlayerDraw(pid, GUI_Book[pid].prev_draw);
		ShowTexture(pid, GUI_Book_prev_bg);
	else
		HidePlayerDraw(pid, GUI_Book[pid].prev_draw);
		HideTexture(pid, GUI_Book_prev_bg);
	end
end

function HideBookGUI(pid)
	for k in pairs(GUI_Book[pid].line_l) do
		HidePlayerDraw(pid, GUI_Book[pid].line_l[k]);
		HidePlayerDraw(pid, GUI_Book[pid].line_r[k]);
	end
	
	HidePlayerDraw(pid, GUI_Book[pid].next_draw);
	HideTexture(pid, GUI_Book_next_bg);
	HidePlayerDraw(pid, GUI_Book[pid].prev_draw);
	HideTexture(pid, GUI_Book_prev_bg);
	HidePlayerDraw(pid, GUI_Book[pid].title);
	HidePlayerDraw(pid, GUI_Book[pid].title_underline);
	HideTexture(pid, GUI_Book_bgl);	
	HideTexture(pid, GUI_Book_bgr);
	Player[pid].onGUI = false;
end

function NextPageLetter(pid, uid)
	if Handscript[uid].pages[GUI_Letter[pid].current_page + 1] ~= nil then
		GUI_Letter[pid].current_page = GUI_Letter[pid].current_page + 1;
	end
end

function PrevPageLetter(pid, uid)
	if Handscript[uid].pages[GUI_Letter[pid].current_page - 1] ~= nil then
		GUI_Letter[pid].current_page = GUI_Letter[pid].current_page - 1;
	end
end

function NextPageBook(pid, uid)
	if Handscript[uid].pages[GUI_Book[pid].current_page + 2] ~= nil then
		GUI_Book[pid].current_page = GUI_Book[pid].current_page + 2;
	end
end

function PrevPageBook(pid, uid)
	if Handscript[uid].pages[GUI_Book[pid].current_page - 2] ~= nil then
		GUI_Book[pid].current_page = GUI_Book[pid].current_page - 2;
	end
end

function SaveLetter(uid)

	local file = io.open("dlbase/handscripts/handscripts.me", "a+");
	file:write(uid.." ".."LETTER".."\n");
	file:close();
	
	handscriptFile = io.open("dlbase/handscripts/"..uid..".txt","w");
	handscriptFile:write(Handscript[uid].waxed, " ");
	handscriptFile:write(Handscript[uid].wax_removed, " ");
	handscriptFile:write(Handscript[uid].author, " ");
	handscriptFile:write(Handscript[uid].author_viewable, "\n");

	if Handscript[uid].title ~= nil then
		handscriptFile:write(Handscript[uid].title, "\n");
	end
	for k in pairs(Handscript[uid].text) do
		handscriptFile:write(Handscript[uid].text[k], "\n");
	end
	
	handscriptFile:close();
end

function SaveBook(uid)
	local handscriptFile = io.open("dlbase/handscripts/handscripts.me","a+");
	handscriptFile:write(uid, " ");
	handscriptFile:write("BOOK", "\n");
	handscriptFile:close();
	
	handscriptFile=io.open("dlbase/handscripts/"..uid..".txt","w");
	handscriptFile:write(Handscript[uid].author, "\n");
	handscriptFile:write(Handscript[uid].title, "\n");
	for k in pairs(Handscript[uid].text) do
		handscriptFile:write(Handscript[uid].text[k], "\n");
	end
	
	handscriptFile:close();
end

function LoadHandscripts()
	local hsFile = io.open("dlbase/handscripts/handscripts.me", "r");
	if hsFile then
		for line in hsFile:lines() do
			local result, uid, ttype = sscanf(line,"ds");
			if result == 1 then
				local sFile = io.open("dlbase/handscripts/"..uid..".txt", "r");
				local i = 0;
				Handscript[uid] = {};
				for line in sFile:lines() do
					if i == 0 then
						if ttype == "LETTER" then
							local res, waxed, wax_removed, author, author_viewable = sscanf(line, "ddss");
							if res == 1 then
								Handscript[uid].waxed = waxed;
								Handscript[uid].wax_removed = wax_removed;
								Handscript[uid].author = author;
								Handscript[uid].author_viewable = author_viewable;
							end
						elseif ttype == "BOOK" then
							Handscript[uid].author = line;
						end
					elseif i == 1 then
						Handscript[uid].title = line;
						AddHandscriptPage(uid);
					else
						AddHandscriptText(uid, line);
					end
					i = i + 1;
				end
				Handscript[uid].type = ttype;
				sFile:close();
			end
		end
	hsFile:close();
	end
end

function DeleteItem(playerid, item_instance, amountremove)
	local oldValue;
	local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","r+");
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
	local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","w+");
	file:write(tempString);
	file:close();
	RemoveItem(playerid, item_instance, amountremove);
end

function CheckPaper(pid, item_instance, amount, equipped, checkid)
	if checkid == 9843221 then
		if item_instance ~= "NULL" then
			DeleteItem(pid, "aixopt_itmi_paper", 1);
			PlayerWriting[pid] = GenBook(pid);
			AddHandscriptPage(PlayerWriting[pid]);
			GUIBookInit(pid);
			UpdateBookGUI(pid);
			SendPlayerMessage(pid, 255, 255, 255, GetPlayerName(pid).."приступил к написанию книги");
			SendPlayerMessage(pid, 255, 255, 0, "(ИНФО): Придумайте заголовок для книги (отправить в чат)");
		else
			SendPlayerMessage(pid, 255, 255, 0, "(ИНФО): У вас нет бумаги");		
		end
	elseif checkid == 9843222 then
		if item_instance ~= "NULL" then
			DeleteItem(pid, "aixopt_itmi_paper", 1);
			PlayerWriting[pid] = GenLetter(pid);
			AddHandscriptPage(PlayerWriting[pid]);
			GUILetterInit(pid);
			UpdateLetterGUI(pid);
			SendPlayerMessage(pid, 255, 255, 255, GetPlayerName(pid).."приступил к написанию письма");
			SendPlayerMessage(pid, 255, 255, 0, "(ИНФО): Придумайте заголовок для письма (отправить в чат)");
		else
			SendPlayerMessage(pid, 255, 255, 0, "(ИНФО): У вас нет бумаги");	
		end
	end
end

function StartWritingBook(pid)
	if Player[pid].onGUI == false and PlayerWriting[pid] == nil then
		HasItem(pid, "aixopt_itmi_paper", 9843221);		
	end
end
addCommandHandler({"/книга"}, StartWritingBook)

function StartWritingLetter(pid)
	if Player[pid].onGUI == false and PlayerWriting[pid] == nil then
		HasItem(pid, "aixopt_itmi_paper", 9843222);				
	end
end
addCommandHandler({"/письмо"}, StartWritingLetter)

function ReadBook(pid, uid)
	if PlayerReading[pid] == nil then
		PlayerReading[pid] = uid;
		GUIBookInit(pid);
		UpdateBookGUI(pid);
		SendPlayerMessage(pid, 255, 255, 255, GetPlayerName(pid).." приступил к чтению книги");
		if Handscript[uid].author == GetPlayerName(pid) then
			PlayerWriting[pid] = uid;
			SendPlayerMessage(pid, 255, 255, 0, "(ИНФО): Вы можете дополнить эту книгу");
		end
	end
end

function ReadHandscript(pid, uid)
	if Handscript[uid].type == "BOOK" then
		ReadBook(pid, uid);
	else
		ReadLetter(pid, uid);
	end
end

function ReadLetter(pid, uid)
	if PlayerReading[pid] == nil then
		PlayerReading[pid] = uid;
		GUILetterInit(pid);
		UpdateLetterGUI(pid);
		SendPlayerMessage(pid, 255, 255, 255, GetPlayerName(pid).." приступил к чтению письма");
		if Handscript[uid].author == GetPlayerName(pid) and (Handscript[uid].waxed == 0 or (Handscript[uid].waxed == 1 and Handscript[uid].wax_removed == 1)) then
			PlayerWriting[pid] = uid;
			SendPlayerMessage(pid, 255, 255, 0, "(ИНФО): Вы можете дополнить это письмо");
		end
	end
end


function HandscriptKey(pid, keydown, keyup)
	if PlayerReading[pid] ~= nil or PlayerWriting[pid] ~= nil then
		FreezePlayer(pid, 1);
		local uid;
		if PlayerReading[pid] ~= nil then
			uid = PlayerReading[pid];
		else
			uid = PlayerWriting[pid];
		end
		
		if Handscript[uid].type == "BOOK" then
			if keydown == KEY_LEFT then
				PrevPageBook(pid, uid);
				UpdateBookGUI(pid);
			elseif keydown == KEY_RIGHT then
				NextPageBook(pid, uid);
				UpdateBookGUI(pid);
			elseif keydown == KEY_ESCAPE then
				if PlayerWriting[pid] ~= nil then
					SaveBook(uid);
					if PlayerReading[pid] == nil then
						AddBookItem(pid, uid, 1);
					end
				end
				HideBookGUI(pid);
				PlayerReading[pid] = nil;
				PlayerWriting[pid] = nil;
				FreezePlayer(pid, 0);
			end
		elseif Handscript[uid].type == "LETTER" then
			if keydown == KEY_LEFT then
				PrevPageLetter(pid, uid);
				UpdateLetterGUI(pid);
			elseif keydown == KEY_RIGHT then
				NextPageLetter(pid, uid);
				UpdateLetterGUI(pid);
			elseif keydown == KEY_ESCAPE then
				if PlayerWriting[pid] ~= nil then
					SaveLetter(uid);
					if PlayerReading[pid] == nil then
						AddLetterItem(pid, uid, 1);
					end
				end
				HideLetterGUI(pid);
				PlayerReading[pid] = nil;
				PlayerWriting[pid] = nil;
				FreezePlayer(pid, 0);

			elseif keydown == KEY_RETURN then
				if PlayerReading[pid] ~= nil then
					UnsealLetter(pid, uid);
					SaveLetter(uid);
				end
				UpdateLetterGUI(pid);
			elseif keydown == KEY_LSHIFT and PlayerWriting[pid] ~= nil and PlayerReading[pid] == nil then
				if Handscript[uid].waxed == 0 then
					Handscript[uid].waxed = 1;
					Handscript[uid].wax_removed = 0;
				else
					Handscript[uid].waxed = 0;				
				end
				UpdateLetterGUI(pid);
			elseif keydown == KEY_LCONTROL and PlayerWriting[pid] ~= nil then
				if Handscript[uid].author_viewable == " " then
					Handscript[uid].author_viewable = GetPlayerName(pid);
				else
					Handscript[uid].author_viewable = " ";	
				end
				UpdateLetterGUI(pid);
			end
		end
	end
end