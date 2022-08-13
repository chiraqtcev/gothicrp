
--  #  Skin system by royclapton  #
--  #         version: 0.1        #


local skintex = CreateTexture(6294, 2280, 8174, 6212, 'skin1')

function RandomSkin1(playerid)

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

function _frzcm(id)
	FreezeCamera(id, 1);
end

function SkinKey1(playerid, keyDown, keyUp) -- a OnPlayerKey
	if Player[playerid].loggedIn == true then
		if keyDown == KEY_F9 then
			OpenSkinSet(playerid)
		end
	end
end

function OpenSkinSet(playerid)
	
	if Player[playerid].skinset == false then
		ShowTexture(playerid, skintex);
		Player[playerid].skinset = true;
		SetCursorVisible(playerid, 1);
		setCameraBeforePlayer(playerid, 10);
		SetTimerEx(_frzcm, 950, 0, playerid);
		Freeze(playerid);
	else
		HideTexture(playerid, skintex);
		Player[playerid].skinset = false;
		SetCursorVisible(playerid, 0);
		FreezeCamera(playerid, 0);
		SetDefaultCamera(playerid);
		Player[playerid].skin[1], Player[playerid].skin[2], Player[playerid].skin[3], Player[playerid].skin[4] = GetPlayerAdditionalVisual(playerid);
		SavePlayer(playerid);
		UnFreeze(playerid);
	end

end

-- SKIN
BUTTON_LEFT_TYPE = {6448, 6884, 5306, 5740}; BUTTON_RIGHT_TYPE = {7644, 8060, 5299, 5726};
BUTTON_LEFT_BODY = {6448, 6884, 4518, 4931}; BUTTON_RIGHT_BODY = {7644, 8060, 4510, 4951};
BUTTON_LEFT_HEAD = {6448, 6884, 2928, 3364}; BUTTON_RIGHT_HEAD = {7644, 8060, 2926, 3367};
BUTTON_LEFT_FACE = {6448, 6884, 3709, 4150}; BUTTON_RIGHT_FACE = {7644, 8060, 3719, 4160};
BUTTON_SKIN_RANDOM = {6820, 7208, 5938, 6281}; BUTTON_SKIN_FINISH = {7312, 7704, 5968, 6318};

function SkinMouse1(playerid, button, pressed, posX, posY)
	
	if button == MB_LEFT then
		if pressed == 0 then
		if Player[playerid].skinset == true then
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
				OpenSkinSet(playerid);
			end
			-------------------------------------------------------------------------
			if posX > BUTTON_SKIN_RANDOM[1] and posX < BUTTON_SKIN_RANDOM[2] and posY > BUTTON_SKIN_RANDOM[3] and posY < BUTTON_SKIN_RANDOM[4] then
				RandomSkin1(playerid);
			end
			-------------------------------------------------------------------------
		end
		end
	end

end