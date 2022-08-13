
--  #   Reg system by royclapton  #
--  #         version: 1.0        #

local regfon1 = CreateTexture(6375, 2255, 8125, 6350, 'reg1') 
local regfon2 = CreateTexture(6294, 2280, 8174, 6212, 'skin1') 
local classfon1 = CreateTexture(4385, 2280, 8002, 6860, 'setClass')


reg_camera_pos1 = Vob.Create("none", "KOLONIE.ZEN", 5085.091796875, 842.24005126953, 6503.3813476563);
reg_camera_pos1:SetRotation(0, -32, 0);

skin_camera_pos1 = Vob.Create("none", "KOLONIE.ZEN", 8960, 309, 5166);
skin_camera_pos1:SetRotation(0, 20, 0);

function VobTimer(playerid)
	SetCameraBehindVob(playerid, reg_camera_pos1);
	SetTimerEx("camfrz", 700, 0, playerid);
end

function VobTimerSkin(playerid)
	SetPlayerPos(playerid, -6263.4360351562, -431.19046020508, -1240.5786132812);
	SetPlayerAngle(playerid, 186);
	setCameraBeforePlayer(playerid, 20);
	SetTimerEx("camfrz", 800, 0, playerid);
end

function KillVobTimer(playerid)
	KillTimer(Player[playerid].vobtimer);
end

function camfrz(playerid)
	FreezeCamera(playerid, 1);
end

function ShowRegister(playerid)
	
	FreezePlayer(playerid, 1);
	Player[playerid].vobtimer = SetTimerEx("VobTimer", 1000, 0, playerid);
	ShowTexture(playerid, regfon1);
	ShowPlayerDraw(playerid, autonick);
	ShowPlayerDraw(playerid, autopass);
	SetCursorVisible(playerid, 1);

end


local treg;
function EnterPasswordReg(playerid, text)
	
	if string.len(text) > 3 and not(string.find(string.lower(text), string.lower(" "))) then
		Player[playerid].rdy = true;
		treg = tostring(text);
		Player[playerid].enterreg = false;
		Player[playerid].password = treg;
		UpdatePlayerDraw(playerid, autopass, 6554, 5357, treg, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	else
		GameTextForPlayer(playerid, 2485, 5580, "Подсказка: не менее 3 символов без пробелов.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 3000);
	end

end

function RegMouse(playerid, button, pressed, posX, posY)

	if button == MB_LEFT then
		if pressed == 0 then
			if Player[playerid].loggedIn == false then
				if posX > BUTTON_EXIT_REGLOG[1] and posX < BUTTON_EXIT_REGLOG[2] and posY > BUTTON_EXIT_REGLOG[3] and posY < BUTTON_EXIT_REGLOG[4] then
					ExitGame(playerid);
				end

				if posX > BUTTON_ENTER_REGLOG[1] and posX < BUTTON_ENTER_REGLOG[2] and posY > BUTTON_ENTER_REGLOG[3] and posY < BUTTON_ENTER_REGLOG[4] then
					if Player[playerid].enterreg == false and Player[playerid].rdy == true then
						HideTexture(playerid, regfon1);
						HidePlayerDraw(playerid, autonick);
						HidePlayerDraw(playerid, autopass);
						Player[playerid].loggedIn = true;
						Player[playerid].rdy = false;
						ClearInventory(playerid);
						print(" ");
						print(" ");
						print("==========================================");
						print("                REG_INFO					 ");
						print("   ",GetPlayerName(playerid),"register in server.");
						print("==========================================");
						print(" ");
						print(" ");
						FreezeCamera(playerid, 0);
						SetDefaultCamera(playerid);
						Player[playerid].steptwo = true;
						Player[playerid].defclick = Player[playerid].defclick + 1;
						SetCursorVisible(playerid, 0);
						SetTimerEx("ShowSkin", 600, 0, playerid);
					end
				end
			end
		end
	end
end

function RandomSkin(playerid)

	local pol;
	local head = math.random(1, 7); local Hhead;
	local b1rnd = math.random(1,3);

	if b1rnd == 1 then
		pol = "Hum_Body_Naked0";
	elseif b1rnd == 2 then
		pol = "Hum_Body_Naked0";
	elseif b1rnd == 3 then
		pol = "Hum_Body_Babe0";
	end

	if head == 1 then
		Hhead = "Hum_Head_FatBald"
	elseif head == 2 then
		Hhead = "Hum_Head_Fighter";
	elseif head == 3 then
		Hhead = "Hum_Head_Pony";
	elseif head == 4 then
		Hhead = "Hum_Head_Bald";
	elseif head == 5 then
		Hhead = "Hum_Head_Thief";
	elseif head == 6 then
		Hhead = "Hum_Head_Psionic";
	elseif head == 7 then
		Hhead = "Hum_Head_Babe";
	end
	
	SetPlayerAdditionalVisual(playerid, pol, math.random(1, 20), Hhead, math.random(60,200));

end

function ShowSkin(playerid)

	Player[playerid].steptwo = true;
	Player[playerid].vobtimer = SetTimerEx("VobTimerSkin", 200, 0, playerid);
	Freeze(playerid);
	LockShowChat(playerid, false);
	ShowTexture(playerid, regfon2);
	--RandomSkin(playerid);
	SetCursorVisible(playerid, 1);

end

function EndSkin(playerid)

	Player[playerid].steptwo = false;
	HideTexture(playerid, regfon2);
	Player[playerid].skin[1], Player[playerid].skin[2], Player[playerid].skin[3], Player[playerid].skin[4] = GetPlayerAdditionalVisual(playerid);
	EndClass (playerid);
	--ShowClass(playerid);

end


function EndClass(playerid)
	
	UnFreeze(playerid);
	FreezeCamera(playerid, 0);
	SetDefaultCamera(playerid);
	SetPlayerVirtualWorld(playerid, 0);
	SetCursorVisible(playerid, 0);
	Player[playerid].loggedIn = true;
	ShowChat(playerid, 1);

	SetTimerEx("AllSave", 1000, 0, playerid);
	
	Player[playerid].hOldHP = GetPlayerHealth(playerid);
	
	HidePlayerDraw(playerid, reglogPODSKAZOCHKA);
end


function AllSave(playerid)
	
	SavePlayer(playerid);

	Player[playerid].h1 = 10;
	Player[playerid].h2 = 10;
	Player[playerid].bow = 10;
	Player[playerid].cbow = 10;
	Player[playerid].hp = 300;
	Player[playerid].chp = 300;
	Player[playerid].mp = 0;
	Player[playerid].cmp = 0;
	Player[playerid].currenthp = 300;
	Player[playerid].str = 10;
	Player[playerid].dex = 10;
	Player[playerid].mag = 0;
	
	SaveStats(playerid);
	LoadStats(playerid);
	SaveItems(playerid);
	SaveSkill(playerid);

	Player[playerid].rpinventory = {"", "", "", "", "", "", "", "", "", ""};
	Player[playerid].rpinventory_amount = {" ", " ", " ", " ", " ", " ", " ", " ", " ", " "};
	SaveRPInv(playerid);
	SaveHunt(playerid);
	Player[playerid]._language_myrtana = 1; Player[playerid]._language_current = "MYRTANA";
	_saveLang(playerid);
	_saveMac(playerid);
	_saveFat(playerid);

	InitDLPlayerInfo(playerid);
	SaveDLPlayerInfo(playerid);
    InitInvent(playerid);
	_hudInit(playerid);
	ShowPlayerDraw(playerid, Player[playerid].afkdraw);
	_saveWarn(playerid);

	_saveInfoPO(playerid);
	_craftSaveEXP(playerid);
	SetTimerEx(_onAC, 10000, 0, playerid);
	_saveZen(playerid);
	_saveInst(playerid);
end



function SkinMouse(playerid, button, pressed, posX, posY)
	
	if button == MB_LEFT then
		if pressed == 0 then
		if Player[playerid].steptwo == true then
			-------------------------------------------------------------------------
			if posX > BUTTON_LEFT_TYPE[1] and posX < BUTTON_LEFT_TYPE[2] and posY > BUTTON_LEFT_TYPE[3] and posY < BUTTON_LEFT_TYPE[4] then

				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				if bodyM == "Hum_Body_Babe0" then
					bodyM = "Hum_Body_Naked0";
				elseif bodyM == "Hum_Body_Naked0" then
					bodyM = "Hum_Body_Babe0"
				end
				SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			end
			
			if posX > BUTTON_RIGHT_TYPE[1] and posX < BUTTON_RIGHT_TYPE[2] and posY > BUTTON_RIGHT_TYPE[3] and posY < BUTTON_RIGHT_TYPE[4] then

				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				if bodyM == "Hum_Body_Babe0" then
					bodyM = "Hum_Body_Naked0";
				elseif bodyM == "Hum_Body_Naked0" then
					bodyM = "Hum_Body_Babe0"
				end
				SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			end
			-------------------------------------------------------------------------
			if posX > BUTTON_LEFT_BODY[1] and posX < BUTTON_LEFT_BODY[2] and posY > BUTTON_LEFT_BODY[3] and posY < BUTTON_LEFT_BODY[4] then

				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				if bodyT >= 0 then
					bodyT = bodyT - 1;
				else
					bodyT = bodyT - 1;
					bodyT = bodyT + 1;
				end
				SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			end
			
			if posX > BUTTON_RIGHT_BODY[1] and posX < BUTTON_RIGHT_BODY[2] and posY > BUTTON_RIGHT_BODY[3] and posY < BUTTON_RIGHT_BODY[4] then
				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				if bodyT <= 56 then
					bodyT = bodyT + 1;
				else
					bodyT = bodyT + 1;
					bodyT = bodyT - 1;
				end
				SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			end
			-------------------------------------------------------------------------
			if posX > BUTTON_LEFT_HEAD[1] and posX < BUTTON_LEFT_HEAD[2] and posY > BUTTON_LEFT_HEAD[3] and posY < BUTTON_LEFT_HEAD[4] then
				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				if headM == "Hum_Head_Fighter" then
					headM = "Hum_Head_FatBald";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);

				elseif headM == "Hum_Head_Pony" then
					headM = "Hum_Head_Fighter";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "Hum_Head_Bald" then
					headM = "Hum_Head_Pony";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "Hum_Head_Thief" then
					headM = "Hum_Head_Bald";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			
				elseif headM == "Hum_Head_Psionic" then
					headM = "Hum_Head_Thief";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BABE7" then
					headM = "Hum_Head_Psionic";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT); 
				
				elseif headM == "HUM_HEAD_BABE12" then
					headM = "HUM_HEAD_BABE7";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BALD" then
					headM = "HUM_HEAD_BABE12";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BEARD1" then
					headM = "HUM_HEAD_BALD";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_BEARD2" then
					headM = "HUM_HEAD_BEARD1";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BEARD3" then
					headM = "HUM_HEAD_BEARD2";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_BEARD4" then
					headM = "HUM_HEAD_BEARD3";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BEARDMAN" then
					headM = "HUM_HEAD_BEARD4";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_LONG" then
					headM = "HUM_HEAD_BEARDMAN";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_SHEPHERD" then
					headM = "HUM_HEAD_LONG";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_LONGHAIR2" then
					headM = "HUM_HEAD_SHEPHERD";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "Hum_Head_FatBald" then
					headM = "HUM_HEAD_LONGHAIR2";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "Hum_Head_FatBald" then
					headM = "HUM_HEAD_MUSTACHE";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				end
			end
			
			if posX > BUTTON_RIGHT_HEAD[1] and posX < BUTTON_RIGHT_HEAD[2] and posY > BUTTON_RIGHT_HEAD[3] and posY < BUTTON_RIGHT_HEAD[4] then
				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				if headM == "Hum_Head_FatBald" then
					headM = "Hum_Head_Fighter";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);

				elseif headM == "Hum_Head_Fighter" then
					headM = "Hum_Head_Pony";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "Hum_Head_Pony" then
					headM = "Hum_Head_Bald";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "Hum_Head_Bald" then
					headM = "Hum_Head_Thief";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			
				elseif headM == "Hum_Head_Thief" then
					headM = "Hum_Head_Psionic";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "Hum_Head_Psionic" then
					headM = "HUM_HEAD_BABE7";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT); 
				
				elseif headM == "HUM_HEAD_BABE7" then
					headM = "HUM_HEAD_BABE12";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BABE12" then
					headM = "HUM_HEAD_BALD";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BALD" then
					headM = "HUM_HEAD_BEARD1";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_BEARD1" then
					headM = "HUM_HEAD_BEARD2";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BEARD2" then
					headM = "HUM_HEAD_BEARD3";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_BEARD3" then
					headM = "HUM_HEAD_BEARD4";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BEARD4" then
					headM = "HUM_HEAD_BEARDMAN";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BEARDMAN" then
					headM = "HUM_HEAD_LONG";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_LONG" then
					headM = "HUM_HEAD_SHEPHERD";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_SHEPHERD" then
					headM = "HUM_HEAD_LONGHAIR2";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_LONGHAIR2" then
					headM = "HUM_HEAD_MUSTACHE";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_MUSTACHE" then
					headM = "Hum_Head_FatBald";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				end
			end
			-------------------------------------------------------------------------
			if posX > BUTTON_LEFT_FACE[1] and posX < BUTTON_LEFT_FACE[2] and posY > BUTTON_LEFT_FACE[3] and posY < BUTTON_LEFT_FACE[4] then
				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				headT = headT - 1;
				SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			end
			
			if posX > BUTTON_RIGHT_FACE[1] and posX < BUTTON_RIGHT_FACE[2] and posY > BUTTON_RIGHT_FACE[3] and posY < BUTTON_RIGHT_FACE[4] then
				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				headT = headT + 1;
				SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			end
			-------------------------------------------------------------------------
			if posX > BUTTON_SKIN_FINISH[1] and posX < BUTTON_SKIN_FINISH[2] and posY > BUTTON_SKIN_FINISH[3] and posY < BUTTON_SKIN_FINISH[4] then
				Player[playerid].defclick = Player[playerid].defclick + 1;
				if Player[playerid].defclick >=3 then
					EndSkin(playerid);
				end
			end
			-------------------------------------------------------------------------
			if posX > BUTTON_SKIN_RANDOM[1] and posX < BUTTON_SKIN_RANDOM[2] and posY > BUTTON_SKIN_RANDOM[3] and posY < BUTTON_SKIN_RANDOM[4] then
				if Player[playerid].steptwo == true then
					RandomSkin(playerid);
				end
			end
			-------------------------------------------------------------------------
		end
		end
	end

end