
createGUIMenu("DIALOG_HELM", {
	{ "Посмотреть ассортимент" },
	{ "Закрыть" },
    }, 150, 150, 150, 255, 255, 255, 5728, 3266, "Font_Old_10_White_Hi.TGA", nil, 2);

createGUIMenu("DIALOG_HELM_2", {
	{ " " },
	{ "Купить!" },
	{ "Вернуться назад" },
    }, 150, 150, 150, 255, 255, 255, 5728, 3066, "Font_Old_10_White_Hi.TGA", nil, 3);


--------------------------------------------------------------------------------------------
local but_back = CreateTexture(7096, 1800, 7887, 2296, 'botsvoice')
local menu_bc = CreateTexture(5665, 2931, 7335, 4151, 'menu_ingame')
local helmbc = CreateTexture(5691, 4197, 7303, 6329, 'dlg_conversation')
--------------------------------------------------------------------------------------------

camera_helm_start = Vob.Create("none", "PAOWORLD.ZEN", 9418.703125, 368.27850341797, 4679.3725585938);
camera_helm_start:SetRotation(0, -60, 0);

camera_helm_helm1 = Vob.Create("none", "PAOWORLD.ZEN", 9188.8447265625, 362.34643554688, 4786.3564453125); camera_helm_helm1:SetRotation(0, -130, 0);
camera_helm_helm2 = Vob.Create("none", "PAOWORLD.ZEN", 9265.9619140625, 362.34643554688, 4753.8173828125); camera_helm_helm2:SetRotation(0, -122, 0);
camera_helm_helm3 = Vob.Create("none", "PAOWORLD.ZEN", 9279.896484375, 362.34643554688, 4714.3779296875); camera_helm_helm3:SetRotation(0, -106, 0);
camera_helm_helm4 = Vob.Create("none", "PAOWORLD.ZEN", 9287.8984375, 362.34643554688, 4631.5004882813); camera_helm_helm4:SetRotation(0, -106, 0);

camera_helm_helm5 = Vob.Create("none", "PAOWORLD.ZEN", 9392.626953125, 268.26766967773, 4649.7568359375); camera_helm_helm5:SetRotation(0, -80, 0);
camera_helm_helm6 = Vob.Create("none", "PAOWORLD.ZEN", 9391.306640625, 278.26766967773, 4727.337890625); camera_helm_helm6:SetRotation(0, -95, 0);
camera_helm_helm7 = Vob.Create("none", "PAOWORLD.ZEN", 9319.5703125, 278.26766967773, 4816.5063476563); camera_helm_helm7:SetRotation(0, -131, 0);
camera_helm_helm8 = Vob.Create("none", "PAOWORLD.ZEN", 9286.7998046875, 278.26766967773, 4875.8408203125); camera_helm_helm8:SetRotation(0, -160, 0);


function BotsShop_Focus(playerid, focusid)
	
	if GetFocus(playerid) == SELLER_HELM
	or GetFocus(playerid) == SELLER_FOOD
	or GetFocus(playerid) == SELLER_ARMOR
	or GetFocus(playerid) == SELLER_BONDSTREET

	then
		ShowTexture(playerid, but_back);
		--ShowPlayerDraw(playerid, bdialog_draw);
		
	else
		HideTexture(playerid, but_back);
		--HidePlayerDraw(playerid, bdialog_draw);

	end

end

function butfrz(playerid)
	SetPlayerEnable_OnPlayerKey(playerid, 1)
end

function BuyHelm(playerid)

	if Player[playerid].campos == 1 then
		if Player[playerid].gold >= 200 then
			Player[playerid].gold = Player[playerid].gold - 200;
			GiveItem(playerid, "HELM_5", 1);
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: хороший выбор, заходи еще.");
			SendPlayerMessage(playerid, 152, 237, 160, "Куплено: Легкий кож. шлем.");
			SavePlayer(playerid);
			SaveItems(playerid);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: у тебя маловато золота.");
		end 

	elseif Player[playerid].campos == 2 then
		if Player[playerid].gold >= 250 then
			Player[playerid].gold = Player[playerid].gold - 250;
			GiveItem(playerid, "HELM_7", 1);
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: хороший выбор, заходи еще.");
			SendPlayerMessage(playerid, 152, 237, 160, "Куплено: Шлем и/к снеппера.");
			SavePlayer(playerid);
			SaveItems(playerid);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: у тебя маловато золота.");
		end

	elseif Player[playerid].campos == 3 then
		if Player[playerid].gold >= 400 then
			Player[playerid].gold = Player[playerid].gold - 400;
			GiveItem(playerid, "HELM_20", 1);
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: хороший выбор, заходи еще.");
			SendPlayerMessage(playerid, 152, 237, 160, "Куплено: Шлем кож. с шипами.");
			SavePlayer(playerid);
			SaveItems(playerid);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: у тебя маловато золота.");
		end

	elseif Player[playerid].campos == 4 then
		if Player[playerid].gold >= 600 then
			Player[playerid].gold = Player[playerid].gold - 600;
			GiveItem(playerid, "HELM_15", 1);
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: хороший выбор, заходи еще.");
			SendPlayerMessage(playerid, 152, 237, 160, "Куплено: Шлем стальной.");
			SavePlayer(playerid);
			SaveItems(playerid);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: у тебя маловато золота.");
		end 

	elseif Player[playerid].campos == 5 then
		if Player[playerid].gold >= 1200 then
			Player[playerid].gold = Player[playerid].gold - 1200;
			GiveItem(playerid, "HELM_3", 1);
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: хороший выбор, заходи еще.");
			SendPlayerMessage(playerid, 152, 237, 160, "Куплено: Шлем воина закр.");
			SavePlayer(playerid);
			SaveItems(playerid);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: у тебя маловато золота.");
		end 

	elseif Player[playerid].campos == 6 then
		if Player[playerid].gold >= 900 then
			Player[playerid].gold = Player[playerid].gold - 900;
			GiveItem(playerid, "HELM_1", 1);
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: хороший выбор, заходи еще.");
			SendPlayerMessage(playerid, 152, 237, 160, "Куплено: Шлем север. народов.");
			SavePlayer(playerid);
			SaveItems(playerid);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: у тебя маловато золота.");
		end 

	elseif Player[playerid].campos == 7 then
		if Player[playerid].gold >= 800 then
			Player[playerid].gold = Player[playerid].gold - 800;
			GiveItem(playerid, "HELM_9", 1);
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: хороший выбор, заходи еще.");
			SendPlayerMessage(playerid, 152, 237, 160, "Куплено: Шлем с рогами.");
			SavePlayer(playerid);
			SaveItems(playerid);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: у тебя маловато золота.");
		end 

	elseif Player[playerid].campos == 8 then
		if Player[playerid].gold >= 1000 then
			Player[playerid].gold = Player[playerid].gold - 1000;
			GiveItem(playerid, "HELM_21", 1);
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: хороший выбор, заходи еще.");
			SendPlayerMessage(playerid, 152, 237, 160, "Куплено: Плотный шлем.");
			SavePlayer(playerid);
			SaveItems(playerid);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "Торговец: у тебя маловато золота.");
		end 
	end


end

function ShopUpdateInfoHelm(playerid)

	if Player[playerid].campos == 1 then -- HELM_5
		UpdatePlayerDraw(playerid, helmname, 5770, 4358, "Легкий кож. шлем", "Font_Old_10_White_Hi.TGA", 247, 178, 178)
		UpdatePlayerDraw(playerid, helm_stata1, 5770, 4658, "Оружие: 5", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata2, 5770, 4858, "Стрелы: 5", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata3, 5770, 5058, "Огонь: 0", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata4, 5770, 5258, "Магия: 0", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_price, 5770, 5558, "Цена: 200", "Font_Old_10_White_Hi.TGA", 250, 228, 157) 

	elseif Player[playerid].campos == 2 then -- HELM_7
		UpdatePlayerDraw(playerid, helmname, 5770, 4358, "Шлем и/к снеппера", "Font_Old_10_White_Hi.TGA", 247, 178, 178)
		UpdatePlayerDraw(playerid, helm_stata1, 5770, 4658, "Оружие: 6", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata2, 5770, 4858, "Стрелы: 6", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata3, 5770, 5058, "Огонь: 0", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata4, 5770, 5258, "Магия: 0", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_price, 5770, 5558, "Цена: 250", "Font_Old_10_White_Hi.TGA", 250, 228, 157)

	elseif Player[playerid].campos == 3 then -- HELM_20
		UpdatePlayerDraw(playerid, helmname, 5770, 4358, "Шлем кож. с шипами", "Font_Old_10_White_Hi.TGA", 247, 178, 178)
		UpdatePlayerDraw(playerid, helm_stata1, 5770, 4658, "Оружие: 13", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata2, 5770, 4858, "Стрелы: 13", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata3, 5770, 5058, "Огонь: 4", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata4, 5770, 5258, "Магия: 0", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_price, 5770, 5558, "Цена: 400", "Font_Old_10_White_Hi.TGA", 250, 228, 157)

	elseif Player[playerid].campos == 4 then -- HELM_15
		UpdatePlayerDraw(playerid, helmname, 5770, 4358, "Шлем стальной", "Font_Old_10_White_Hi.TGA", 247, 178, 178)
		UpdatePlayerDraw(playerid, helm_stata1, 5770, 4658, "Оружие: 15", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata2, 5770, 4858, "Стрелы: 10", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata3, 5770, 5058, "Огонь: 3", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata4, 5770, 5258, "Магия: 3", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_price, 5770, 5558, "Цена: 600", "Font_Old_10_White_Hi.TGA", 250, 228, 157)

	elseif Player[playerid].campos == 5 then -- HELM_3
		UpdatePlayerDraw(playerid, helmname, 5770, 4358, "Шлем воина закр.", "Font_Old_10_White_Hi.TGA", 247, 178, 178)
		UpdatePlayerDraw(playerid, helm_stata1, 5770, 4658, "Оружие: 30", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata2, 5770, 4858, "Стрелы: 30", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata3, 5770, 5058, "Огонь: 10", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata4, 5770, 5258, "Магия: 10", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_price, 5770, 5558, "Цена: 1200", "Font_Old_10_White_Hi.TGA", 250, 228, 157)

	elseif Player[playerid].campos == 6 then -- HELM_1
		UpdatePlayerDraw(playerid, helmname, 5770, 4358, "Шлем север. народов", "Font_Old_10_White_Hi.TGA", 247, 178, 178)
		UpdatePlayerDraw(playerid, helm_stata1, 5770, 4658, "Оружие: 25", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata2, 5770, 4858, "Стрелы: 20", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata3, 5770, 5058, "Огонь: 5", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata4, 5770, 5258, "Магия: 5", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_price, 5770, 5558, "Цена: 900", "Font_Old_10_White_Hi.TGA", 250, 228, 157)

	elseif Player[playerid].campos == 7 then -- HELM_9
		UpdatePlayerDraw(playerid, helmname, 5770, 4358, "Шлем с рогами", "Font_Old_10_White_Hi.TGA", 247, 178, 178)
		UpdatePlayerDraw(playerid, helm_stata1, 5770, 4658, "Оружие: 20", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata2, 5770, 4858, "Стрелы: 15", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata3, 5770, 5058, "Огонь: 3", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata4, 5770, 5258, "Магия: 3", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_price, 5770, 5558, "Цена: 800", "Font_Old_10_White_Hi.TGA", 250, 228, 157)

	elseif Player[playerid].campos == 8 then -- HELM_21
		UpdatePlayerDraw(playerid, helmname, 5770, 4358, "Плотный шлем", "Font_Old_10_White_Hi.TGA", 247, 178, 178)
		UpdatePlayerDraw(playerid, helm_stata1, 5770, 4658, "Оружие: 25", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata2, 5770, 4858, "Стрелы: 25", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata3, 5770, 5058, "Огонь: 10", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_stata4, 5770, 5258, "Магия: 5", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(playerid, helm_price, 5770, 5558, "Цена: 1000", "Font_Old_10_White_Hi.TGA", 250, 228, 157)
	end
end

function ShopKeys_OtherBots(playerid, keyDown, keyUp)

	if keyDown == KEY_LCONTROL then
		if Player[playerid].dlg == false then
			if GetFocus(playerid) == SELLER_HELM then
				SetPlayerPos(playerid, 9421.447265625, 368.27850341797, 4786.1396484375);
				SetPlayerAngle(playerid, 247)
				Player[playerid].dlg = true;
				SetCameraBehindVob(playerid, camera_helm_start);
				SetTimerEx("camfrz", 800, 0, playerid);
				Freeze(playerid);
				ShowTexture(playerid, menu_bc);
				showGUIMenu(playerid, "DIALOG_HELM");
			end

			
		end
	end

	if keyDown == KEY_UP then
		switchGUIMenuUp(playerid, "DIALOG_HELM");
		switchGUIMenuUp(playerid, "DIALOG_HELM_2");
	end

	if keyDown == KEY_DOWN then
		switchGUIMenuDown(playerid, "DIALOG_HELM");
		switchGUIMenuDown(playerid, "DIALOG_HELM_2");
	end

	if keyDown == KEY_RIGHT then
		if Player[playerid].campos == 1 then
			FreezeCamera(playerid, 0);
			SetCameraBehindVob(playerid, camera_helm_helm2);
			SetTimerEx("camfrz", 500, 0, playerid);
			Player[playerid].campos = 2;
			SetPlayerEnable_OnPlayerKey(playerid, 0);
			SetTimerEx("butfrz", 800, 0, playerid);
			ShopUpdateInfoHelm(playerid)

		elseif Player[playerid].campos == 2 then
			FreezeCamera(playerid, 0);
			SetCameraBehindVob(playerid, camera_helm_helm3);
			SetTimerEx("camfrz", 500, 0, playerid);
			Player[playerid].campos = 3;
			SetPlayerEnable_OnPlayerKey(playerid, 0);
			SetTimerEx("butfrz", 800, 0, playerid);
			ShopUpdateInfoHelm(playerid)

		elseif Player[playerid].campos == 3 then
			FreezeCamera(playerid, 0);
			SetCameraBehindVob(playerid, camera_helm_helm4);
			SetTimerEx("camfrz", 500, 0, playerid);
			Player[playerid].campos = 4;
			SetPlayerEnable_OnPlayerKey(playerid, 0);
			SetTimerEx("butfrz", 800, 0, playerid);
			ShopUpdateInfoHelm(playerid)

		elseif Player[playerid].campos == 4 then
			FreezeCamera(playerid, 0);
			SetCameraBehindVob(playerid, camera_helm_helm5);
			SetTimerEx("camfrz", 500, 0, playerid);
			Player[playerid].campos = 5;
			SetPlayerEnable_OnPlayerKey(playerid, 0);
			SetTimerEx("butfrz", 800, 0, playerid);
			ShopUpdateInfoHelm(playerid)

		elseif Player[playerid].campos == 5 then
			FreezeCamera(playerid, 0);
			SetCameraBehindVob(playerid, camera_helm_helm6);
			SetTimerEx("camfrz", 500, 0, playerid);
			Player[playerid].campos = 6;
			SetPlayerEnable_OnPlayerKey(playerid, 0);
			SetTimerEx("butfrz", 800, 0, playerid);
			ShopUpdateInfoHelm(playerid)

		elseif Player[playerid].campos == 6 then
			FreezeCamera(playerid, 0);
			SetCameraBehindVob(playerid, camera_helm_helm7);
			SetTimerEx("camfrz", 500, 0, playerid);
			Player[playerid].campos = 7;
			SetPlayerEnable_OnPlayerKey(playerid, 0);
			SetTimerEx("butfrz", 800, 0, playerid);
			ShopUpdateInfoHelm(playerid)

		elseif Player[playerid].campos == 7 then
			FreezeCamera(playerid, 0);
			SetCameraBehindVob(playerid, camera_helm_helm8);
			SetTimerEx("camfrz", 500, 0, playerid);
			Player[playerid].campos = 8;
			SetPlayerEnable_OnPlayerKey(playerid, 0);
			SetTimerEx("butfrz", 800, 0, playerid);
			ShopUpdateInfoHelm(playerid)

		elseif Player[playerid].campos == 8 then
			FreezeCamera(playerid, 0);
			SetCameraBehindVob(playerid, camera_helm_helm1);
			SetTimerEx("camfrz", 500, 0, playerid);
			Player[playerid].campos = 1;
			SetPlayerEnable_OnPlayerKey(playerid, 0);
			SetTimerEx("butfrz", 800, 0, playerid);
			ShopUpdateInfoHelm(playerid)
		end
	end


	if keyDown == KEY_RETURN then
		if Player[playerid].dlg == true then
			if getPlayerOptionID(playerid, "DIALOG_HELM") == 1 then
				if Player[playerid].campos == 0 then
					FreezeCamera(playerid, 0);
					SetCameraBehindVob(playerid, camera_helm_helm1);
					SetTimerEx("camfrz", 800, 0, playerid);
					Player[playerid].campos = 1;
					ShowPlayerDraw(playerid, helmname);
					ShowPlayerDraw(playerid, helm_stata1);
					ShowPlayerDraw(playerid, helm_stata2);
					ShowPlayerDraw(playerid, helm_stata3);
					ShowPlayerDraw(playerid, helm_stata4);
					ShowPlayerDraw(playerid, helm_price);
					ShowTexture(playerid, helmbc);
					ShopUpdateInfoHelm(playerid);
					hideGUIMenu(playerid, "DIALOG_HELM");
					showGUIMenu(playerid, "DIALOG_HELM_2");
					ShowPlayerDraw(playerid, helm_upr1);
					ShowPlayerDraw(playerid, helm_upr2);
				end
			end

			if getPlayerOptionID(playerid, "DIALOG_HELM") == 2 then
				if Player[playerid].campos > 0 then
					FreezeCamera(playerid, 0);
					SetCameraBehindVob(playerid, camera_helm_start);
					SetTimerEx("camfrz", 800, 0, playerid);
					Freeze(playerid);
					hideGUIMenu(playerid, "DIALOG_HELM_2");
					showGUIMenu(playerid, "DIALOG_HELM");
					HidePlayerDraw(playerid, helmname);
					HidePlayerDraw(playerid, helm_stata1);
					HidePlayerDraw(playerid, helm_stata2);
					HidePlayerDraw(playerid, helm_stata3);
					HidePlayerDraw(playerid, helm_stata4);
					HidePlayerDraw(playerid, helm_price);
					HideTexture(playerid, helmbc);
					Player[playerid].campos = 0;
					HidePlayerDraw(playerid, helm_upr1);
					HidePlayerDraw(playerid, helm_upr2);
					Player[playerid].dlg = false;
				else
					FreezeCamera(playerid, 0);
					SetDefaultCamera(playerid);
					UnFreeze(playerid);
					Player[playerid].dlg = false;
					hideGUIMenu(playerid, "DIALOG_HELM");
					HideTexture(playerid, menu_bc);

				end
			end

			if getPlayerOptionID(playerid, "DIALOG_HELM_2") == 2 then
				BuyHelm(playerid)
			end

			if getPlayerOptionID(playerid, "DIALOG_HELM_2") == 3 then
				FreezeCamera(playerid, 0);
				SetCameraBehindVob(playerid, camera_helm_start);
				SetTimerEx("camfrz", 800, 0, playerid);
				hideGUIMenu(playerid, "DIALOG_HELM_2");
				showGUIMenu(playerid, "DIALOG_HELM");
				HidePlayerDraw(playerid, helmname);
				HidePlayerDraw(playerid, helm_stata1);
				HidePlayerDraw(playerid, helm_stata2);
				HidePlayerDraw(playerid, helm_stata3);
				HidePlayerDraw(playerid, helm_stata4);
				HidePlayerDraw(playerid, helm_price);
				HideTexture(playerid, helmbc);
				Player[playerid].campos = 0;
				HidePlayerDraw(playerid, helm_upr1);
				HidePlayerDraw(playerid, helm_upr2);
			end
		end
	end
end

function unfrzcam(playerid)
	FreezeCamera(playerid, 0);
end


--[[

	Player[playerid].dlg = false;
	FreezeCamera(playerid, 0);
	SetDefaultCamera(playerid);
	UnFreeze(playerid);
	HideTexture(playerid, menu_bc);
	hideGUIMenu(playerid, "DIALOG_HELM");

]]
