--[[

CreateDraw(92, 7988)
UpdateTexture(..., -12, 7967, 8292, 500, inv_back.tga)

]]

local tex_slide = 2352
Pid_Stat1 = CreateTexture(70, 0, 1146, 0, "Bar_Back_v2.tex");
Pid_Stat2 = CreateTexture(70, 0, 1146, 0, "Bar_Back_v2.tex");
Pid_Stat3 = CreateTexture(70, 0, 1146, 0, "Bar_Back_v2.tex");
Pid_Stat4 = CreateTexture(70, 0, 1146, 0, "Bar_Back_v2.tex");
Pid_Stat5 = CreateTexture(70, 0, 1146, 0, "Bar_Back_v2.tex");
Pid_Stat6 = CreateTexture(70, 0, 1146, 0, "Bar_Back_v2.tex");
Pid_Stat7 = CreateTexture(70, 0, 1146, 0, "Bar_Back_v2.tex");
Pid_Stat4s = CreateTexture(70, 0, 1146, 0, "Bar_Back_v2.tex");
Pid_Stat5s = CreateTexture(70, 0, 1146, 0, "Bar_Back_v2.tex");
Pid_Stat6s = CreateTexture(70, 0, 1146, 0, "Bar_Back_v2.tex");
Pid_Stat7s = CreateTexture(70, 0, 1146, 0, "Bar_Back_v2.tex");
Pid_Stat8 = CreateTexture(70, 0, 1146, 0, "Bar_Back_v2.tex");
Slide = {};
for i = 1, 11 - 1 do
	Slide[i] = CreateTexture(70, 0, 1146, 0, "Bar_Back_v2.tex");
end
local Piden_Draw1 = CreateDraw(3480, 1863, "СТАТИСТИКА", "Font_Old_10_White_Hi.TGA", 255,250,200);
local Piden_Draw2 = CreateDraw(3420, 1863, "БОЕВЫЕ НАВЫКИ", "Font_Old_10_White_Hi.TGA", 255,250,200);
local Piden_Draw3 = CreateDraw(3600, 1863, "РЕМЕСЛА", "Font_Old_10_White_Hi.TGA", 255,250,200);
local Piden_Draw4 = CreateDraw(3420, 1863, "РП-ИНВЕНТАРЬ", "Font_Old_10_White_Hi.TGA", 255,250,200);
local Piden_Draw_desc1 = CreateDraw(3365, 6118, "Перейти/Прокачать", "Font_Old_10_White_Hi.TGA", 255,250,200);
local Piden_Draw_desc1La = CreateDraw(3765, 6378, " -> ", "Font_Old_10_White_Hi.TGA", 255,230,102);
local Piden_Draw_desc2 = CreateDraw(4693, 6118, "Назад", "Font_Old_10_White_Hi.TGA", 255,250,200);
local Piden_Draw_desc2La = CreateDraw(4753, 6378, " <- ", "Font_Old_10_White_Hi.TGA", 255,230,102);
--local Piden_Draw_desc3 = CreateDraw(5573, 6098, "Листать", "Font_Old_10_White_Hi.TGA", 255,250,200);
--local Piden_Draw_desc3La = CreateDraw(5573, 6298, "Стрелки", "Font_Old_10_White_Hi.TGA", 255,230,102);
local Piden_Draw_desc3 = CreateDraw(3365, 6118, "Показать(LShift)", "Font_Old_10_White_Hi.TGA", 255,250,200);
local Piden_Draw_desc3La = CreateDraw(3365, 6378, "Передать(Enter)", "Font_Old_10_White_Hi.TGA", 255,250,200);

local Pid_MenuLn = false

for i = 0, MAX_PLAYERS - 1 do
	Player[i].PidMenuOpen = false;
	Player[i].ErpeMenuOpen = false;
	Player[i].WikiOption = 1;
	Player[i].WikiCatName = nil;
	Player[i].Stam_cout = 0;
	Player[i].Stam_up = false
	Player[i].Mana_cout = 0;
	Player[i].Mana_up = false
end

function StamUpdate(pid)
	--UpdateTexture(HIL_STAMINA[pid][2], 115, 7057, (point-HILM), 160, "bar_iddqd.TEX") --//"BAR_WATER.TEX"
	Player[pid].HILM = anx(pid, 115+51) + 100
	local texm = Player[pid].HILM/100;
	local stam = (Player[pid].Stamina-texm*Player[pid].Stamina)
	local point = (Player[pid].HILM-stam)
	local PPI = GetPPI(pid)
	local bottomTop = 8192 - any(pid, 17+(barSizeY+barSizeY+barSizeY+barSizeY))
	UpdateTextureSize(HIL_STAMINA[pid][2], (anx(pid, 17)/MyPPI)*PPI, (bottomTop/MyPPI)*PPI, ((point-Player[pid].HILM)/MyPPI)*PPI, (any(pid, barSizeY-7)/MyPPI)*PPI, "BAR_IDDQD.TEX")									
	Player[pid].Stam_up = true
	--ShowTexture(pid, HIL_STAMINA[pid][6])
	--ShowTexture(pid, HIL_STAMINA[pid][2])
end

function Pid_Open(pid)
local tbl_main = {
	{"    Статистика"},
};
--cout = cout + 1
	createGUIMenu(pid.."PID_MENU", tbl_main, 255,250,200, 0,173,90, 1965, 2400, "Font_Old_10_White_Hi.TGA", nil, 4);
	showGUIMenu(pid, pid.."PID_MENU", 500);
	--if Pid_MenuLn == false then
		UpdateTextureSize(Pid_Stat1, 1620, 1555, 4785, 5270, "GUI_BACKGROUND.tex")
		UpdateTextureSize(Pid_Stat2, 1810, 1778, 1241, 300, "TEXTBOX.tex")
		UpdateTextureSize(Pid_Stat3, 3334, 1778, 1117, 300, "TEXTBOX.tex")
		UpdateTextureSize(Pid_Stat4, 1848, 3823, 1105, 338, "BUTTON.tex")
		UpdateTextureSize(Pid_Stat5, 1848, 2329, 1105, 338, "BUTTON.tex")
		UpdateTextureSize(Pid_Stat6, 1848, 2823, 1105, 338, "BUTTON.tex")
		UpdateTextureSize(Pid_Stat7, 1848, 3341, 1105, 338, "BUTTON.tex")
		UpdateTextureSize(Pid_Stat4s, 1848, 3823, 1105, 338, "BUTTON_HIGHLIGHTED.tex")
		UpdateTextureSize(Pid_Stat5s, 1848, 2329, 1105, 338, "BUTTON_HIGHLIGHTED.tex")
		UpdateTextureSize(Pid_Stat6s, 1848, 2823, 1105, 338, "BUTTON_HIGHLIGHTED.tex")
		UpdateTextureSize(Pid_Stat7s, 1848, 3341, 1105, 338, "BUTTON_HIGHLIGHTED.tex")
		UpdateTextureSize(Pid_Stat8, 4537, 1778, 782, 300, "TEXTBOX.tex")
		local checking = tex_slide
		for i = 1, 11 - 1 do
			UpdateTextureSize(Slide[i], 3240, checking, 157, 224, "SLIDER_RTRIANGLE.tex")
			checking = checking + 350
		end
		--[[UpdateTexture(Pid_Stat1, 1665, 1600, 1435, 5305, "Menu_Ingame.tga")
		UpdateTexture(Pid_Stat2, 1731, 1756, 1298, 338, "Menu_Choice_back.tga")
		UpdateTexture(Pid_Stat3, 1731, 2159, 1298, 4578, "Menu_Ingame.tga")
		UpdateTexture(Pid_Stat4, 3144, 1611, 3364, 5284, "Menu_Ingame.tga")
		UpdateTexture(Pid_Stat5, 3220, 1763, 1262, 408, "Menu_Choice_back.tga")
		UpdateTexture(Pid_Stat6, 3220, 2215, 3221, 3818, "Menu_Ingame.tga")
		UpdateTexture(Pid_Stat7, 3219, 6017, 3213, 722, "menu_ingame.tga")
		UpdateTexture(Pid_Stat8, 4535, 1761, 915, 406, "menu_choice_back.tga")]]
	--	Pid_MenuLn = true
	--end
	FreezePlayer(pid, 1)
	ShowChat(pid, 0)
--	ShowTexture(pid, Pid_Stat1)
	ShowTexture(pid, Pid_Stat1)
	ShowTexture(pid, Pid_Stat2)
	ShowTexture(pid, Pid_Stat3)
	ShowTexture(pid, Pid_Stat4)
	ShowTexture(pid, Pid_Stat5)
	ShowTexture(pid, Pid_Stat6)
	ShowTexture(pid, Pid_Stat7)
	ShowTexture(pid, Pid_Stat8)
	ShowPlayerDraw(pid, Pid_Ddqd)
	ShowPlayerDraw(pid, AP_draw)
	ShowDraw(pid, Piden_Draw1)
	ShowDraw(pid, Piden_Draw_desc1)
	ShowDraw(pid, Piden_Draw_desc1La)
	ShowDraw(pid, Piden_Draw_desc2)
	ShowDraw(pid, Piden_Draw_desc2La)
	Pid_Stat_Open(pid)
	StamUpdate(pid)
	--ShowDraw(pid, Menu_Draw)
	--ShowDraw(pid, show) --26:44 16:15
end

function Pid_Close(pid)
	hideGUIMenu(pid, pid.."PID_MENU");
	destroyGUIMenu(pid.."PID_MENU")
	HideTexture(pid, Pid_Stat1)
	HideTexture(pid, Pid_Stat2)
	HideTexture(pid, Pid_Stat3)
	HideTexture(pid, Pid_Stat4)
	HideTexture(pid, Pid_Stat5)
	HideTexture(pid, Pid_Stat6)
	HideTexture(pid, Pid_Stat7)
	HideTexture(pid, Pid_Stat8)
	HidePlayerDraw(pid, AP_draw)
	FreezePlayer(pid, 0)
	ShowChat(pid, 1)
	HideDraw(pid, Piden_Draw1)
	HideDraw(pid, Piden_Draw2)
	HideDraw(pid, Piden_Draw3)
	HideDraw(pid, Piden_Draw4)
	HideDraw(pid, Piden_Draw_desc1)
	HideDraw(pid, Piden_Draw_desc1La)
	HideDraw(pid, Piden_Draw_desc2)
	HideDraw(pid, Piden_Draw_desc2La)
	HideDraw(pid, Piden_Draw_desc3)
	HideDraw(pid, Piden_Draw_desc3La)
	--ShowPlayerDraw(pid, rp_title
	--HideDraw(pid, Menu_Draw)
	--HideRPBG(pid)
	HidePlayerDraw(pid, Pid_Ddqd)
	--HideDraw(pid, give)
	Player[pid].ErpeMenuOpen = false
	Player[pid].PidMenuOpen = false
	if isOpenMenu(pid, pid.."STATIS_MENU") == true then --Pid_Wep_Close(pid)
		Pid_Stat_Close(pid)
	elseif isOpenMenu(pid, pid.."WEP_MENU") == true then --Pid_Wep_Close(pid)
		Pid_Wep_Close(pid)
	end
end

function Pid_Stat_Open(pid)
--local result2 = "SELECT * FROM account WHERE `nick` = '"..Player[pid].nick.."'";
--local result = mysql_query ( handler, result2)
--local val = mysql_fetch_assoc(result)
local tbl_prosto = {
	{"Сила"},
	{"Ловкость"},
	{"Здоровье"},
	{"Мана"},
	{"Выносливость"},
	{"Круг магии"}
};
--cout = cout + 1
	createGUIMenu(pid.."STATIS_MENU", tbl_prosto, 255,250,200, 255,250,200, 3450, 2375, "Font_Old_10_White_Hi.TGA", nil, 6);
	showGUIMenu(pid, pid.."STATIS_MENU", 350);
	UpdatePlayerDraw(pid, Sila_draw, 4650, 2375, GetPlayerStrength(pid), "Font_Old_10_White_Hi.TGA", 255,230,102);
	UpdatePlayerDraw(pid, Lovkost_draw, 4650, 2725, GetPlayerDexterity(pid), "Font_Old_10_White_Hi.TGA", 255,230,102);
	UpdatePlayerDraw(pid, Hp_draw, 4650, 3075, GetPlayerHealth(pid).."/"..GetPlayerMaxHealth(pid), "Font_Old_10_White_Hi.TGA", 255,230,102);
	UpdatePlayerDraw(pid, Mp_draw, 4650, 3425, GetPlayerMana(pid).."/"..GetPlayerMaxMana(pid), "Font_Old_10_White_Hi.TGA", 255,230,102);
	UpdatePlayerDraw(pid, Stamina_draw, 4650, 3775, Player[pid].Stamina.."%", "Font_Old_10_White_Hi.TGA", 255,230,102);
	UpdatePlayerDraw(pid, Krug_draw, 4650, 4125, GetPlayerMagicLevel(pid), "Font_Old_10_White_Hi.TGA", 255,230,102); --strok_hund
	ShowPlayerDraw(pid, Sila_draw)
	ShowPlayerDraw(pid, Lovkost_draw)
	ShowPlayerDraw(pid, Hp_draw)
	ShowPlayerDraw(pid, Mp_draw)
	ShowPlayerDraw(pid, Krug_draw)
	ShowPlayerDraw(pid, Stamina_draw)
	--ShowTexture(pid, Slide[1])
	--mysql_free_result(result);
	--ShowRPBG(pid)
	--ShowTexture(pid, GUI_Inventory_bg)
	--ShowPlayerDraw(pid, rp_title)
	--ShowDraw(pid, give)
	--ShowDraw(pid, show)
end

function Pid_Stat_Close(pid)
	hideGUIMenu(pid, pid.."STATIS_MENU");
	destroyGUIMenu(pid.."STATIS_MENU")
	HidePlayerDraw(pid, Sila_draw)
	HidePlayerDraw(pid, Lovkost_draw)
	HidePlayerDraw(pid, Hp_draw)
	HidePlayerDraw(pid, Mp_draw)
	HidePlayerDraw(pid, Krug_draw)
	HidePlayerDraw(pid, Stamina_draw)
	HidePlayerDraw(pid, strok_hund)
	for i = 1, 11 - 1 do
		HideTexture(pid, Slide[i])
	end
	--Pid_Close(pid)
	--HideRPBG(pid)
	--HidePlayerDraw(pid, rp_title)
	--HideDraw(pid, show)
	--HideDraw(pid, give)
end

function Pid_Wep_Open(pid)
--local result2 = "SELECT * FROM account WHERE `nick` = '"..Player[pid].nick.."'";
--local result = mysql_query ( handler, result2)
--local val = mysql_fetch_assoc(result)
local tbl_prostos = {
	{"Одноручное"},
	{"Двуручное"},
	{"Луки"},
	{"Арбалеты"}
};
--cout = cout + 1
	createGUIMenu(pid.."WEP_MENU", tbl_prostos, 255,250,200, 255,250,200, 3450, 2375, "Font_Old_10_White_Hi.TGA", nil, 4);
	showGUIMenu(pid, pid.."WEP_MENU", 350);
	UpdatePlayerDraw(pid, OneH_draw, 4650, 2375, GetPlayerSkillWeapon(pid, SKILL_1H).."%", "Font_Old_10_White_Hi.TGA", 255,230,102);
	UpdatePlayerDraw(pid, TwoH_draw, 4650, 2725, GetPlayerSkillWeapon(pid, SKILL_2H).."%", "Font_Old_10_White_Hi.TGA", 255,230,102);
	UpdatePlayerDraw(pid, BowH_draw, 4650, 3075, GetPlayerSkillWeapon(pid, SKILL_BOW).."%", "Font_Old_10_White_Hi.TGA", 255,230,102);
	UpdatePlayerDraw(pid, CBowH_draw, 4650, 3425, GetPlayerSkillWeapon(pid, SKILL_CBOW).."%", "Font_Old_10_White_Hi.TGA", 255,230,102);
	ShowPlayerDraw(pid, OneH_draw)
	ShowPlayerDraw(pid, TwoH_draw)
	ShowPlayerDraw(pid, BowH_draw)
	ShowPlayerDraw(pid, CBowH_draw)
	--ShowTexture(pid, Slide[1])
	--mysql_free_result(result);
	--ShowRPBG(pid)
	--ShowTexture(pid, GUI_Inventory_bg)
	--ShowPlayerDraw(pid, rp_title)
	--ShowDraw(pid, give)
	--ShowDraw(pid, show)
end

function Pid_Wep_Close(pid)
	hideGUIMenu(pid, pid.."WEP_MENU");
	destroyGUIMenu(pid.."WEP_MENU")
	HidePlayerDraw(pid, OneH_draw)
	HidePlayerDraw(pid, TwoH_draw)
	HidePlayerDraw(pid, BowH_draw)
	HidePlayerDraw(pid, CBowH_draw)
	HidePlayerDraw(pid, strok_hund)
	for i = 1, 11 - 1 do
		HideTexture(pid, Slide[i])
	end
	--Pid_Close(pid)
	--HideRPBG(pid)
	--HidePlayerDraw(pid, rp_title)
	--HideDraw(pid, show)
	--HideDraw(pid, give)
end

function StatMenuKey(playerid, keydown, keyup)
	if Player[playerid].LoginMenuOpen ~= true then
		--HelpMenuKey(playerid, keydown, keyup)
		if keydown == KEY_F2 then
			if Player[playerid].PidMenuOpen == false then
				Pid_Open(playerid)
				Player[playerid].PidMenuOpen = true
			elseif Player[playerid].PidMenuOpen == true then
				Pid_Close(playerid)
				Player[playerid].PidMenuOpen = false
			end
		elseif keydown == KEY_F3 then
			if Player[playerid].PidMenuOpen == true then
				Pid_Close(playerid)
				Player[playerid].PidMenuOpen = false
			end
		elseif keydown == KEY_F1 then
			if Player[playerid].PidMenuOpen == true then
				Pid_Close(playerid)
				Player[playerid].PidMenuOpen = false
			end
		elseif keydown == KEY_ESCAPE then
			if Player[playerid].PidMenuOpen == true then
				Pid_Close(playerid)
				Player[playerid].PidMenuOpen = false
			end
		elseif keydown == KEY_DOWN then --// Лист вниз.
			if Player[playerid].PidMenuOpen == true then
				if Player[playerid].ErpeMenuOpen == false then
					switchGUIMenuDown(playerid, playerid.."PID_MENU", 500);
					if getPlayerOptionID(playerid, playerid.."PID_MENU") == 1 then
						Pid_Stat_Open(playerid)
						ShowTexture(playerid, Pid_Stat8)
						--SetPlayerDrawPos(pid, strok_hund, 3310, 2375)
						ShowPlayerDraw(playerid, AP_draw)
						ShowDraw(playerid, Piden_Draw1)
						HideDraw(playerid, Piden_Draw2)
						HideDraw(playerid, Piden_Draw3)
						HideDraw(playerid, Piden_Draw4)
						ShowDraw(playerid, Piden_Draw_desc1)
						ShowDraw(playerid, Piden_Draw_desc1La)
						ShowDraw(playerid, Piden_Draw_desc2)
						ShowDraw(playerid, Piden_Draw_desc2La)
						HideDraw(playerid, Piden_Draw_desc3)
						HideDraw(playerid, Piden_Draw_desc3La)
						RP_Pidclose(playerid)
					elseif getPlayerOptionID(playerid, playerid.."PID_MENU") == 2 then
						Pid_Stat_Close(playerid)
						Pid_Wep_Open(playerid)
						ShowTexture(playerid, Pid_Stat8)
						--SetPlayerDrawPos(pid, strok_hund, 3310, 2725)
						ShowPlayerDraw(playerid, AP_draw)
						HideDraw(playerid, Piden_Draw1)
						ShowDraw(playerid, Piden_Draw2)
						HideDraw(playerid, Piden_Draw3)
						HideDraw(playerid, Piden_Draw4)
						ShowDraw(playerid, Piden_Draw_desc1)
						ShowDraw(playerid, Piden_Draw_desc1La)
						ShowDraw(playerid, Piden_Draw_desc2)
						ShowDraw(playerid, Piden_Draw_desc2La)
						HideDraw(playerid, Piden_Draw_desc3)
						HideDraw(playerid, Piden_Draw_desc3La)
						RP_Pidclose(playerid)
					elseif getPlayerOptionID(playerid, playerid.."PID_MENU") == 3 then
						ShowTexture(playerid, Pid_Stat8)
						Pid_Wep_Close(playerid)
						ShowPlayerDraw(playerid, AP_draw)
						--SetPlayerDrawPos(pid, strok_hund, 3310, 3075)
						ShowDraw(playerid, Piden_Draw3)
						HideDraw(playerid, Piden_Draw2)
						HideDraw(playerid, Piden_Draw4)
						HideDraw(playerid, Piden_Draw1)
						ShowDraw(playerid, Piden_Draw_desc1)
						ShowDraw(playerid, Piden_Draw_desc1La)
						ShowDraw(playerid, Piden_Draw_desc2)
						ShowDraw(playerid, Piden_Draw_desc2La)
						HideDraw(playerid, Piden_Draw_desc3)
						HideDraw(playerid, Piden_Draw_desc3La)
						RP_Pidclose(playerid)
					elseif getPlayerOptionID(playerid, playerid.."PID_MENU") == 4 then
						RP_Pidopen(playerid)
						HideTexture(playerid, Pid_Stat8)
						HidePlayerDraw(playerid, AP_draw)
						--SetPlayerDrawPos(pid, strok_hund, 3310, 3425)
						HideDraw(playerid, Piden_Draw1)
						HideDraw(playerid, Piden_Draw2)
						HideDraw(playerid, Piden_Draw3)
						ShowDraw(playerid, Piden_Draw4)
						HideDraw(playerid, Piden_Draw_desc1)
						HideDraw(playerid, Piden_Draw_desc1La)
						HideDraw(playerid, Piden_Draw_desc2)
						HideDraw(playerid, Piden_Draw_desc2La)
						ShowDraw(playerid, Piden_Draw_desc3)
						ShowDraw(playerid, Piden_Draw_desc3La)
					end
				elseif Player[playerid].ErpeMenuOpen == true then
					if isOpenMenu(playerid, playerid.."STATIS_MENU") == true then
						switchGUIMenuDown(playerid, playerid.."STATIS_MENU", 350);
						if getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 1 then
							--SetStatisStat(playerid, 1)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[1])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 2375)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 2 then
							--SetStatisStat(playerid, 2)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[2])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 2725)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 3 then
							--SetStatisStat(playerid, 3)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[3])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3075)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 4 then
							--SetStatisStat(playerid, 4)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[4])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3425)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 5 then
							--SetStatisStat(playerid, 4)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[5])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3775)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 6 then
							--SetStatisStat(playerid, 4)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[6])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 4125)
						end
					elseif isOpenMenu(playerid, playerid.."WEP_MENU") == true then
						switchGUIMenuDown(playerid, playerid.."WEP_MENU", 350);
						if getPlayerOptionID(playerid, playerid.."WEP_MENU") == 1 then
							--SetStatisStat(playerid, 1)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[1])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 2375)
						elseif getPlayerOptionID(playerid, playerid.."WEP_MENU") == 2 then
							--SetStatisStat(playerid, 2)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[2])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 2725)
						elseif getPlayerOptionID(playerid, playerid.."WEP_MENU") == 3 then
							--SetStatisStat(playerid, 3)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[3])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3075)
						elseif getPlayerOptionID(playerid, playerid.."WEP_MENU") == 4 then
							--SetStatisStat(playerid, 4)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[4])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3425)
						end
					end
				end
			end
		elseif keydown == KEY_UP then --// Лист вниз.
			if Player[playerid].PidMenuOpen == true then
				if Player[playerid].ErpeMenuOpen == false then
					switchGUIMenuUp(playerid, playerid.."PID_MENU", 500); --HelpIDm_Open(pid) OpenSkinEditor(playerid)
					if getPlayerOptionID(playerid, playerid.."PID_MENU") == 1 then
						Pid_Stat_Open(playerid)
						Pid_Wep_Close(playerid)
					--	SetPlayerDrawPos(pid, strok_hund, 3310, 2375)
						ShowTexture(playerid, Pid_Stat8)
						ShowPlayerDraw(playerid, AP_draw)
						ShowDraw(playerid, Piden_Draw1)
						HideDraw(playerid, Piden_Draw2)
						HideDraw(playerid, Piden_Draw3)
						HideDraw(playerid, Piden_Draw4)
						ShowDraw(playerid, Piden_Draw_desc1)
						ShowDraw(playerid, Piden_Draw_desc1La)
						ShowDraw(playerid, Piden_Draw_desc2)
						ShowDraw(playerid, Piden_Draw_desc2La)
						HideDraw(playerid, Piden_Draw_desc3)
						HideDraw(playerid, Piden_Draw_desc3La)
						RP_Pidclose(playerid)
					elseif getPlayerOptionID(playerid, playerid.."PID_MENU") == 2 then
						ShowTexture(playerid, Pid_Stat8)
						Pid_Wep_Open(playerid)
						ShowPlayerDraw(playerid, AP_draw)
					--	SetPlayerDrawPos(pid, strok_hund, 3310, 2725)
						HideDraw(playerid, Piden_Draw1)
						ShowDraw(playerid, Piden_Draw2)
						HideDraw(playerid, Piden_Draw3)
						HideDraw(playerid, Piden_Draw4)
						ShowDraw(playerid, Piden_Draw_desc1)
						ShowDraw(playerid, Piden_Draw_desc1La)
						ShowDraw(playerid, Piden_Draw_desc2)
						ShowDraw(playerid, Piden_Draw_desc2La)
						HideDraw(playerid, Piden_Draw_desc3)
						HideDraw(playerid, Piden_Draw_desc3La)
						RP_Pidclose(playerid)
					elseif getPlayerOptionID(playerid, playerid.."PID_MENU") == 3 then
						ShowTexture(playerid, Pid_Stat8)
						ShowPlayerDraw(playerid, AP_draw)
					--	SetPlayerDrawPos(pid, strok_hund, 3310, 3075)
						ShowDraw(playerid, Piden_Draw3)
						HideDraw(playerid, Piden_Draw2)
						HideDraw(playerid, Piden_Draw4)
						HideDraw(playerid, Piden_Draw1)
						ShowDraw(playerid, Piden_Draw_desc1)
						ShowDraw(playerid, Piden_Draw_desc1La)
						ShowDraw(playerid, Piden_Draw_desc2)
						ShowDraw(playerid, Piden_Draw_desc2La)
						HideDraw(playerid, Piden_Draw_desc3)
						HideDraw(playerid, Piden_Draw_desc3La)
						RP_Pidclose(playerid)
					elseif getPlayerOptionID(playerid, playerid.."PID_MENU") == 4 then
						Pid_Stat_Close(playerid)
						RP_Pidopen(playerid)
						HideTexture(playerid, Pid_Stat8)
					--	SetPlayerDrawPos(pid, strok_hund, 3310, 3425)
						HidePlayerDraw(playerid, AP_draw)
						HideDraw(playerid, Piden_Draw1)
						HideDraw(playerid, Piden_Draw2)
						HideDraw(playerid, Piden_Draw3)
						ShowDraw(playerid, Piden_Draw4)
						HideDraw(playerid, Piden_Draw_desc1)
						HideDraw(playerid, Piden_Draw_desc1La)
						HideDraw(playerid, Piden_Draw_desc2)
						HideDraw(playerid, Piden_Draw_desc2La)
						ShowDraw(playerid, Piden_Draw_desc3)
						ShowDraw(playerid, Piden_Draw_desc3La)
					end
				elseif Player[playerid].ErpeMenuOpen == true then
					if isOpenMenu(playerid, playerid.."STATIS_MENU") == true then
						switchGUIMenuUp(playerid, playerid.."STATIS_MENU", 350);
						if getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 1 then
							--SetStatisStat(playerid, 1)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[1])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 2375)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 2 then
							--SetStatisStat(playerid, 2)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[2])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 2725)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 3 then
							--SetStatisStat(playerid, 3)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[3])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3075)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 4 then
							--SetStatisStat(playerid, 4)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[4])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3425)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 5 then
							--SetStatisStat(playerid, 4)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[5])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3775)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 6 then
							--SetStatisStat(playerid, 4)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[6])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 4125)
						end
					elseif isOpenMenu(playerid, playerid.."WEP_MENU") == true then
						switchGUIMenuDown(playerid, playerid.."WEP_MENU", 350);
						if getPlayerOptionID(playerid, playerid.."WEP_MENU") == 1 then
							--SetStatisStat(playerid, 1)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[1])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 2375)
						elseif getPlayerOptionID(playerid, playerid.."WEP_MENU") == 2 then
							--SetStatisStat(playerid, 2)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[2])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 2725)
						elseif getPlayerOptionID(playerid, playerid.."WEP_MENU") == 3 then
							--SetStatisStat(playerid, 3)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[3])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3075)
						elseif getPlayerOptionID(playerid, playerid.."WEP_MENU") == 4 then
							--SetStatisStat(playerid, 4)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[4])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3425)
						end
					end
				end
			end
		elseif keydown == KEY_RIGHT then --// Лист вни
			if isOpenMenu(playerid, playerid.."STATIS_MENU") == true then
				if Player[playerid].ErpeMenuOpen == true then
					if getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 1 then
						SetStatisStat(playerid, 1)
					elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 2 then
						SetStatisStat(playerid, 2)
					elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 3 then
						SetStatisStat(playerid, 3)
					elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 4 then
						SetStatisStat(playerid, 4)
					end
				end
			elseif isOpenMenu(playerid, playerid.."WEP_MENU") == true then
				if Player[playerid].ErpeMenuOpen == true then
					if getPlayerOptionID(playerid, playerid.."WEP_MENU") == 1 then
						SetStatisStat(playerid, 65)
					elseif getPlayerOptionID(playerid, playerid.."WEP_MENU") == 2 then
						SetStatisStat(playerid, 66)
					elseif getPlayerOptionID(playerid, playerid.."WEP_MENU") == 3 then
						SetStatisStat(playerid, 67)
					elseif getPlayerOptionID(playerid, playerid.."WEP_MENU") == 4 then
						SetStatisStat(playerid, 68)
					end
				end
			end
			if Player[playerid].PidMenuOpen == true then
				Player[playerid].ErpeMenuOpen = true
				if isOpenMenu(playerid, playerid.."STATIS_MENU") == true then
					if getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 1 then
							--SetStatisStat(playerid, 1)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[1])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 2375)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 2 then
							--SetStatisStat(playerid, 2)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[2])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 2725)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 3 then
							--SetStatisStat(playerid, 3)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[3])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3075)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 4 then
							--SetStatisStat(playerid, 4)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[4])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3425)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 5 then
							--SetStatisStat(playerid, 4)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[5])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3775)
						elseif getPlayerOptionID(playerid, playerid.."STATIS_MENU") == 6 then
							--SetStatisStat(playerid, 4)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[6])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 4125)
						end
					--ShowPlayerDraw(playerid, strok_hund)
				elseif isOpenMenu(playerid, playerid.."MENF5_INV") == true then
					RP_CloseF5(playerid)
					RP_OpenF5(playerid)
				elseif isOpenMenu(playerid, playerid.."WEP_MENU") == true then
					if getPlayerOptionID(playerid, playerid.."WEP_MENU") == 1 then
							--SetStatisStat(playerid, 1)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[1])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 2375)
						elseif getPlayerOptionID(playerid, playerid.."WEP_MENU") == 2 then
							--SetStatisStat(playerid, 2)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[2])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 2725)
						elseif getPlayerOptionID(playerid, playerid.."WEP_MENU") == 3 then
							--SetStatisStat(playerid, 3)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[3])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3075)
						elseif getPlayerOptionID(playerid, playerid.."WEP_MENU") == 4 then
							--SetStatisStat(playerid, 4)
							for i = 1, 11 - 1 do
								HideTexture(playerid, Slide[i])
							end
							ShowTexture(playerid, Slide[4])
							--SetPlayerDrawPos(playerid, strok_hund, 3310, 3425)
						end
					--ShowPlayerDraw(playerid, strok_hund)
				end
			end
		elseif keydown == KEY_LEFT then
			if isOpenMenu(playerid, playerid.."MENF5_INV") == true then
				RP_CloseF5(playerid)
				RP_OpenF5_STAT(playerid)
			end
			if Player[playerid].PidMenuOpen == true then
				Player[playerid].ErpeMenuOpen = false
				--HidePlayerDraw(playerid, strok_hund)
				for i = 1, 11 - 1 do
					HideTexture(playerid, Slide[i])
				end
			end
		end
	end
end

function SetStatisStat(playerid, arg)
	if arg == 1 then
		if Player[playerid].AP > 0 then
			local str = GetPlayerStrength(playerid)
			local str2 = (str+2);
			if str2 < 91 then
			SetPlayerStrength(playerid, str2)
			GameTextForPlayer(playerid, 3365, 5590, "Вы повысили 'силу' на "..str2.." пунктов!","Font_Old_10_White_Hi.TGA", 102, 255, 0, 2000);
			Player[playerid].AP = Player[playerid].AP - 1
			UpdatePlayerDraw(playerid, AP_draw, 4585, 1856, "AP:"..Player[playerid].AP.."  WP:"..Player[playerid].WP, "Font_Old_10_White_Hi.TGA", 255,250,200);
			UpdatePlayerDraw(playerid, Sila_draw, 4650, 2375, GetPlayerStrength(playerid), "Font_Old_10_White_Hi.TGA", 255,230,102);
			SaveAccount(playerid)
			else
			GameTextForPlayer(playerid, 3365, 5590, "Вы достигли максимума!","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
			end
		else
			GameTextForPlayer(playerid, 3365, 5590, "Недостаточно AP очков!","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
		end
	elseif arg == 2 then
		if Player[playerid].AP > 0 then
			local str = GetPlayerDexterity(playerid)
			local str2 = (str+2);
			if str2 < 91 then
			SetPlayerDexterity(playerid, str2)
			GameTextForPlayer(playerid, 3365, 5590, "Вы повысили 'ловкость' на "..str2.." пунктов!","Font_Old_10_White_Hi.TGA", 102, 255, 0, 2000);
			Player[playerid].AP = Player[playerid].AP - 1
			UpdatePlayerDraw(playerid, AP_draw, 4585, 1856, "AP:"..Player[playerid].AP.."  WP:"..Player[playerid].WP, "Font_Old_10_White_Hi.TGA", 255,250,200);
			UpdatePlayerDraw(playerid, Lovkost_draw, 4650, 2725, GetPlayerDexterity(playerid), "Font_Old_10_White_Hi.TGA", 255,230,102);
			SaveAccount(playerid)
			else
		    GameTextForPlayer(playerid, 3365, 5590, "Вы достигли максимума!","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
			end
		else
			GameTextForPlayer(playerid, 3365, 5590, "Недостаточно AP очков!","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
		end
	elseif arg == 3 then
		if Player[playerid].AP > 0 then
			local str = GetPlayerMaxHealth(playerid)
			local str2 = (str+15);
			SetPlayerMaxHealth(playerid, str2)
			GameTextForPlayer(playerid, 3365, 5590, "Вы повысили 'здоровье' на "..str2.." пунктов!","Font_Old_10_White_Hi.TGA", 102, 255, 0, 2000);
			Player[playerid].AP = Player[playerid].AP - 1
			UpdatePlayerDraw(playerid, AP_draw, 4585, 1856, "AP:"..Player[playerid].AP.."  WP:"..Player[playerid].WP, "Font_Old_10_White_Hi.TGA", 255,250,200);
			UpdatePlayerDraw(playerid, Hp_draw, 4650, 3075, GetPlayerHealth(playerid).."/"..GetPlayerMaxHealth(playerid), "Font_Old_10_White_Hi.TGA", 255,230,102);
			BE_OnPlayerChangeHealth(playerid)
			SaveAccount(playerid)
		else
			GameTextForPlayer(playerid, 3365, 5590, "Недостаточно AP очков!","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
		end
	elseif arg == 4 then
		if Player[playerid].AP > 0 then
			local str = GetPlayerMaxMana(playerid)
			local str2 = (str+25);
			SetPlayerMaxMana(playerid, str2)
			GameTextForPlayer(playerid, 3365, 5590, "Вы повысили 'ману' на "..str2.." пунктов!","Font_Old_10_White_Hi.TGA", 102, 255, 0, 2000);
			Player[playerid].AP = Player[playerid].AP - 1
			UpdatePlayerDraw(playerid, AP_draw, 4585, 1856, "AP:"..Player[playerid].AP.."  WP:"..Player[playerid].WP, "Font_Old_10_White_Hi.TGA", 255,250,200);
			UpdatePlayerDraw(playerid, Mp_draw, 4650, 3425, GetPlayerMana(playerid).."/"..GetPlayerMaxMana(playerid), "Font_Old_10_White_Hi.TGA", 255,230,102);
			SaveAccount(playerid)
		else
			GameTextForPlayer(playerid, 3365, 5590, "Недостаточно AP очков!","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
		end
	elseif arg == 65 then
		if Player[playerid].WP > 0 then
			local str = GetPlayerSkillWeapon(playerid, 0)
			local str2 = (str+10);
			if str2 < 61 then
				SetPlayerSkillWeapon(playerid, 0, str2)
				GameTextForPlayer(playerid, 3365, 5590, "Вы повысили 'владение одноручным' на "..str2.." пунктов!","Font_Old_10_White_Hi.TGA", 102, 255, 0, 2000);
				Player[playerid].WP = Player[playerid].WP - 1
				UpdatePlayerDraw(playerid, AP_draw, 4585, 1856, "AP:"..Player[playerid].AP.."  WP:"..Player[playerid].WP, "Font_Old_10_White_Hi.TGA", 255,250,200);
				UpdatePlayerDraw(playerid, OneH_draw, 4650, 2375, str2.."%", "Font_Old_10_White_Hi.TGA", 255,230,102);
				SaveAccount(playerid)
			else
				GameTextForPlayer(playerid, 3365, 5590, "Вы достигли максимума!","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
			end
		else
			GameTextForPlayer(playerid, 3365, 5590, "Недостаточно WP очков!","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
		end
	elseif arg == 66 then
		if Player[playerid].WP > 0 then
			local str = GetPlayerSkillWeapon(playerid, 1)
			local str2 = (str+10);
			if str2 < 61 then
				SetPlayerSkillWeapon(playerid, 1, str2)
				GameTextForPlayer(playerid, 3365, 5590, "Вы повысили 'владение двуручным' на "..str2.." пунктов!","Font_Old_10_White_Hi.TGA", 102, 255, 0, 2000);
				Player[playerid].WP = Player[playerid].WP - 1
				UpdatePlayerDraw(playerid, AP_draw, 4585, 1856, "AP:"..Player[playerid].AP.."  WP:"..Player[playerid].WP, "Font_Old_10_White_Hi.TGA", 255,250,200);
				UpdatePlayerDraw(playerid, TwoH_draw, 4650, 2725, str2.."%", "Font_Old_10_White_Hi.TGA", 255,230,102);
				SaveAccount(playerid)
			else
				GameTextForPlayer(playerid, 3365, 5590, "Вы достигли максимума!","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
			end
		else
			GameTextForPlayer(playerid, 3365, 5590, "Недостаточно WP очков!","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
		end
	elseif arg == 67 then
		if Player[playerid].WP > 0 then
			local str = GetPlayerSkillWeapon(playerid, 2)
			local str2 = (str+10);
			if str2 < 61 then
				SetPlayerSkillWeapon(playerid, 2, str2)
				GameTextForPlayer(playerid, 3365, 5590, "Вы повысили 'владение луками' на "..str2.." пунктов!","Font_Old_10_White_Hi.TGA", 102, 255, 0, 2000);
				Player[playerid].WP = Player[playerid].WP - 1
				UpdatePlayerDraw(playerid, AP_draw, 4585, 1856, "AP:"..Player[playerid].AP.."  WP:"..Player[playerid].WP, "Font_Old_10_White_Hi.TGA", 255,250,200);
				UpdatePlayerDraw(playerid, BowH_draw, 4650, 3075, str2.."%", "Font_Old_10_White_Hi.TGA", 255,230,102);
				SaveAccount(playerid)
			else
				GameTextForPlayer(playerid, 3365, 5590, "Вы достигли максимума!","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
			end
		else
			GameTextForPlayer(playerid, 3365, 5590, "Недостаточно WP очков!","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
		end
	elseif arg == 68 then
		if Player[playerid].WP > 0 then
			local str2 = GetPlayerSkillWeapon(playerid, 3)
			if str < 61 then
				local str2 = (str+10);
				SetPlayerSkillWeapon(playerid, 3, str2)
				GameTextForPlayer(playerid, 3365, 5590, "Вы повысили 'владение арбалетами' на "..str2.." пунктов!","Font_Old_10_White_Hi.TGA", 102, 255, 0, 2000);
				Player[playerid].WP = Player[playerid].WP - 1
				UpdatePlayerDraw(playerid, AP_draw, 4585, 1856, "AP:"..Player[playerid].AP.."  WP:"..Player[playerid].WP, "Font_Old_10_White_Hi.TGA", 255,250,200);
				UpdatePlayerDraw(playerid, CBowH_draw, 4650, 3425, str2.."%", "Font_Old_10_White_Hi.TGA", 255,230,102);
				SaveAccount(playerid)
			else
				GameTextForPlayer(playerid, 3365, 5590, "Вы достигли максимума!","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
			end
		else
			GameTextForPlayer(playerid, 3365, 5590, "Недостаточно WP очков!","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
		end
	end
end

function RP_Pidopen(playerid)
		if Player[playerid].RPinvIsOpen == false then
			FreezePlayer(playerid, 1)
			RP_OpenF5_STAT(playerid)
			Player[playerid].RPinvIsOpen = true
		end
end

function RP_Pidclose(playerid)
		if Player[playerid].RPinvIsOpen == true then
			FreezePlayer(playerid, 1)
			RP_CloseF5(playerid)
			Player[playerid].RPinvIsOpen = false
		end
end