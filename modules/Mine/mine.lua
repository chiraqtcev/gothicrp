
function _mGetOnline()
	local on = 0;
	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true and IsPlayerConnected(i) == 1 then
			on = on + 1;
		end
	end
	ONLINE = on;
end

function MINE_OnPlayerKey(playerid, keyDown, keyUp)

	if Player[playerid].loggedIn == true then
		if keyDown == KEY_P then
			Mine_ID5(playerid)
		end
	end

end

function freezeCameraTimer(id)
	FreezeCamera(id, 1);
end

function MINE_OnPlayerHasItem(playerid, itemInstance, amount, equipped, checkid)

	_mGetOnline();
	if ONLINE > 4 then

		if checkid == 1 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 5;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать траву. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);

						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 100, 1, playerid);

						SavePlayer(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end

		if checkid == 2 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 3;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать болотник. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);

						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 100, 1, playerid);

						SavePlayer(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end

		if checkid == 3 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 7;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать зерно. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);

						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 100, 1, playerid);

						SavePlayer(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end
		
		if checkid == 4 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 9;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать траву. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);
						
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);

						SavePlayer(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end
		
		if checkid == 5 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 5;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать траву. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);
						
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);

						SavePlayer(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end

		if checkid == 6 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 8;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать траву. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);
						
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);

						SavePlayer(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end

		if checkid == 7 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 10;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать траву. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);
						
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);

						SavePlayer(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end

		if checkid == 8 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 11;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать траву. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);
						
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);

						SavePlayer(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end
		UpdateEnergyBar(playerid);
	else
		SendPlayerMessage(playerid, 255, 255, 255, "Нельзя добывать при онлайне ниже 5.")
	end

end




function Mine_ID5(playerid)

	local x, y, z = GetPlayerPos(playerid);
	local pos1 = GetDistance3D(x, y, z, -14099.49609375, 1305.3173828125, -23938.755859375); -- trava
	local pos2 = GetDistance3D(x, y, z, -14856.24609375, 835.44305419922, -26938.673828125); -- med
	local pos3 = GetDistance3D(x, y, z, -13239.137695313, 1822.9360351563, -22232.513671875);  
	local pos4 = GetDistance3D(x, y, z, -46191.38671875, 1729.1195068359, 10840.122070313); -- ris
	local pos5 = GetDistance3D(x, y, z, -11862.547851563, 2324.3435058594, -22734.017578125); -- palki
    local pos6 = GetDistance3D(x, y, z, 16918.2734375, 294.71697998047, -12098.693359375);
	local pos7 = GetDistance3D(x, y, z, 7080.158203125, 6927.6362304688, 23345.705078125);
	local pos8 = GetDistance3D(x, y, z, 14550.779296875, 714.94372558594, -5142.43359375);
	local pos9 = GetDistance3D(x, y, z, 31135.796875, 327.05578613281, 993.57720947266);
	local pos10 = GetDistance3D(x, y, z, -14222.734375, -451.359375, 11521.8046875);
	local pos11 = GetDistance3D(x, y, z, -35906.76953125, -47.584125518799, -6108.67578125); -- болотник
	local pos12 = GetDistance3D(x, y, z, -18994.265625, 301.232421875, -1391.6633300781);
	local pos13 = GetDistance3D(x, y, z, 21202.974609375, -877.76257324219, 8857.2177734375);
	local pos14 = GetDistance3D(x, y, z, -14310.193359375, 1907.4954833984, 25870.154296875);
	local pos15 = GetDistance3D(x, y, z, -47537.08984375, 1717.5460205078, 10396.314453125);
	local pos16 = GetDistance3D(x, y, z, -47537.08984375, 1717.5460205078, 10396.314453125); 
	local pos17 = GetDistance3D(x, y, z, -46588.22265625, 1631.3251953125, 9508.2041015625);
	local pos18 = GetDistance3D(x, y, z, -45377.28125, 1633.4914550781, 10588.712890625);
	local pos19 = GetDistance3D(x, y, z, -44237.0625, 1467.8063964844, 10655.323242188);
	local pos20 = GetDistance3D(x, y, z, -45269.9140625, 1467.5943603516, 9392.6376953125);
	local pos21 = GetDistance3D(x, y, z, 3390.9956054688, -1363.0954589844, 17482.6796875);
	local pos22 = GetDistance3D(x, y, z, -30117.33984375, 928.03393554688, 10435.450195313);
	local pos23 = GetDistance3D(x, y, z, -32481.861328125, 1036.7192382813, 3053.3342285156); 
	local pos24 = GetDistance3D(x, y, z, -29345.4296875, 1225.1883544922, -1547.9229736328);
	local pos25 = GetDistance3D(x, y, z, 17048.138671875, 1064.6928710938, -18076.7734375); 
	local pos26 = GetDistance3D(x, y, z, 19378.064453125, 1985.9777832031, -12660.584960938); 
	local pos27 = GetDistance3D(x, y, z, 22478.06640625, -72.448776245117, -610.4365234375);
	local pos28 = GetDistance3D(x, y, z, 24437.55078125, 59.528366088867, 4865.9458007813);
	local pos29 = GetDistance3D(x, y, z, 27722.6015625, -79.770683288574, 6492.4819335938);
	local pos30 = GetDistance3D(x, y, z, -21140.857421875, -119.53739929199, 15366.821289063); 
	local pos31 = GetDistance3D(x, y, z, -20255.662109375, 220.72050476074, 23030.974609375); 
	local pos32 = GetDistance3D(x, y, z, -14182.826171875, -1042.8559570313, -6190.236328125);
	local pos33 = GetDistance3D(x, y, z, -21104.322265625, -605.65789794922, 5649.9799804688);
	local pos34 = GetDistance3D(x, y, z, -29684.298828125, 721.90460205078, 3342.2973632813); 
	local pos35 = GetDistance3D(x, y, z, -30117.33984375, 928.03393554688, 10435.450195313); 
	local pos36 = GetDistance3D(x, y, z, -26182.62109375, -723.66333007813, 12711.6171875)

	_mGetOnline();
	if ONLINE > 4 then

		if pos1 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 1);

		elseif pos2 < 550 then
			_mGetOnline();
			if ONLINE > 9 then
				if Player[playerid].mine == 0 then
					if Player[playerid].energy >= 5 then
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать мед. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						Player[playerid].mine = 6;
						Player[playerid].energy = Player[playerid].energy - 5;
						
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);
						SavePlayer(playerid);
						FreezePlayer(playerid, 1);
					else
						GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
					end
				end
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Нельзя добывать при онлайне ниже 5.")
			end

		elseif pos21 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 2);

		elseif pos3 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 2);

		elseif pos4 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 3);
			
		elseif pos6 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 4);
		
		elseif pos7 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 5);
		
		elseif pos8 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 6);

		elseif pos9 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 7);

		elseif pos10 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 8);

		elseif pos11 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 2);

		elseif pos12 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 8);

		elseif pos13 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 1);	

		elseif pos14 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 1);	
		
		elseif pos15 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 3);
		
		elseif pos16 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 3);
		
		elseif pos17 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 3);
			
		elseif pos18 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 3);
			
		elseif pos19 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 3);
			
		elseif pos20 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 3);

		elseif pos22 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 6);

		elseif pos23 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 7);

		elseif pos24 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 8);

		elseif pos25 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 2);

		elseif pos26 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 8);
		
		elseif pos27 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 7);

		elseif pos28 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 5);

		elseif pos29 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 6);	

		elseif pos30 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 8);	

		elseif pos31 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 4);

		elseif pos32 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 4);	

		elseif pos33 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 4);		

		elseif pos34 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 5);

		elseif pos35 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 6);

		elseif pos36 < 550 then
			HasItem(playerid, "GKWQDZ_ITMW_SICKLE", 2); 

		
		elseif pos5 < 550 then
			_mGetOnline();
			if ONLINE > 4 then
				if Player[playerid].mine == 0 then
					if Player[playerid].energy >= 5 then
						GameTextForPlayer(playerid, 50, 6000, "Вы начали искать палку. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						Player[playerid].mine = 4;
						Player[playerid].energy = Player[playerid].energy - 5;
						
						ShowTexture(playerid, Player[playerid].prog_background_f);  
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);
						SavePlayer(playerid);

						FreezePlayer(playerid, 1);
					else
						GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
					end
				end
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Нельзя добывать при онлайне ниже 5.")
			end

		end
		UpdateEnergyBar(playerid);
	end

end

function freezePlayerTimer(id);
	Freeze(id);
end

function MINE_OnPlayerUseItem(playerid, itemInstance, amount, hand)

	_mGetOnline();
	if ONLINE > 0 then

		if itemInstance == "AIXOPT_ITMI_SAW" then -- pila 
			_mGetOnline();
			if ONLINE > 0 then
				if Player[playerid].mine == 0 then
					if Player[playerid].energy >= 5 then
						GameTextForPlayer(playerid, 50, 6000, "Вы начали распиливать полено. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						Player[playerid].mine = 1;
						Player[playerid].energy = Player[playerid].energy - 5;
						
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						SetTimerEx("freezePlayerTimer", 800, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);
						SavePlayer(playerid);
						
					else
						GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
					end
				end
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Нельзя добывать при онлайне ниже 5.")
			end
		end

		if itemInstance == "GKWQDZ_ITMW_PICKAXE" then -- kirka
			_mGetOnline();
			if ONLINE > 0 then
				if Player[playerid].mine == 0 then
					if Player[playerid].energy >= 5 then
						GameTextForPlayer(playerid, 50, 6000, "Вы начали добывать железную руду. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						Player[playerid].mine = 2;
						Player[playerid].energy = Player[playerid].energy - 5;
					
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);
						SavePlayer(playerid);

						FreezePlayer(playerid, 1);
					else
						GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Вы еще не закончили прошлую работу","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
					SaveItems(playerid);
				end
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Нельзя добывать при онлайне ниже 5.")
			end
		end
		
		UpdateEnergyBar(playerid);
	end

end

function _wd(playerid)


	if Player[playerid].current_size_f > Player[playerid].zero_size_f then
		Player[playerid].current_size_f = Player[playerid].current_size_f - 20;
		UpdateTexture(Player[playerid].prog_f, 3007, 7283, Player[playerid].current_size_f, 7469, 'PROGRESS_BLUE_BAR');
	else
		KillTimer(Player[playerid].prog_timer);
		UpdateTexture(Player[playerid].prog_f, 3007, 7283, Player[playerid].start_size_f, 7469, 'PROGRESS_BLUE_BAR');
		Player[playerid].current_size_f = Player[playerid].start_size_f;
		Player[playerid].prog_timer = nil;
		HideTexture(playerid, Player[playerid].prog_f)
		HideTexture(playerid, Player[playerid].prog_background_f);
		FreezeCamera(playerid, 0);
		SetDefaultCamera(playerid);
		UnFreeze(playerid);

		if Player[playerid].mine == 1 then

		    Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);

			local rnd = math.random (1, 100);
			if rnd <= 45 then
		    GameTextForPlayer(playerid, 50, 6000, "Вы распилили бревно на три части","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "AIXOPT_ITMI_RAWWOOD", 3);
			elseif rnd > 45 and rnd <= 65 then
	        GameTextForPlayer(playerid, 50, 6000, "Вы распилили бревно на четыре части","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "AIXOPT_ITMI_RAWWOOD", 4);
		   	elseif rnd > 65 and rnd <= 75 then
	        GameTextForPlayer(playerid, 50, 6000, "Вы нашли тяжелый сук","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "GKWQDZ_ITMW_1H_BAU_MACE", 1);
		   	elseif rnd > 75 and rnd <= 85 then
	        GameTextForPlayer(playerid, 50, 6000, "Вы нашли желудь","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "HFDPUN_ITFO_PLANTS_TOWERWOOD_01", 1);
		   	elseif rnd > 85 and rnd <= 95 then
	        GameTextForPlayer(playerid, 50, 6000, "Вы нашли соту","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "AIXOPT_ITMI_HONEYCOMB", 1);
		   	elseif rnd > 95 and rnd <= 100 then
	        GameTextForPlayer(playerid, 50, 6000, "Вы нашли смолу","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "AIXOPT_ITMI_PITCH", 1);
		   	end
		   	SaveItems(playerid);

		elseif Player[playerid].mine == 2 then

			Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);

			local rnd = math.random (1, 100);
			if rnd <= 48 then
		    GameTextForPlayer(playerid, 50, 6000, "Вы откололи два куска железной руды","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "AIXOPT_ITMI_IRONNUGGET", 2);
			elseif rnd > 48 and rnd <= 50 then
	         GameTextForPlayer(playerid, 50, 6000, "Вы откололи горный хрусталь","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "AIXOPT_ITMI_ROCKCRYSTAL", 1);
		   	elseif rnd > 50 and rnd <= 80 then
	         GameTextForPlayer(playerid, 50, 6000, "Вы откололи три куска руды","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "AIXOPT_ITMI_IRONNUGGET", 3);
		   	elseif rnd > 80 and rnd <= 88 then
		   	 GameTextForPlayer(playerid, 50, 6000, "Вы откололи рудную крошку","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "AIXOPT_ITMI_ORESHARDS", 1);
		   	elseif rnd > 88 and rnd <= 89 then
		   	 GameTextForPlayer(playerid, 50, 6000, "Вы нашли кварц!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "AIXOPT_ITMI_QUARTZ", 1);
		   	elseif rnd > 89 and rnd <= 90 then
		   	 GameTextForPlayer(playerid, 50, 6000, "Вы нашли рубин!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "AIXOPT_ITMI_RUBIN", 1);
		   	elseif rnd > 90 and rnd <= 97 then
		   	 GameTextForPlayer(playerid, 50, 6000, "Вы откололи серу","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "AIXOPT_ITMI_SULFUR", 1);
		   	elseif rnd > 97 and rnd <= 98 then
		   	 GameTextForPlayer(playerid, 50, 6000, "Вы нашли аквамарин!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "AIXOPT_ITMI_AQUAMARINE", 1);
		   	elseif rnd > 98 and rnd <= 99 then
		   	 GameTextForPlayer(playerid, 50, 6000, "Вы нашли золотой самородок!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "AIXOPT_ITMI_GOLDNUGGET", 1);
		   	elseif rnd > 99 and rnd <= 100 then
		   	 GameTextForPlayer(playerid, 50, 6000, "Вы нашли серебряный самородок!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "AIXOPT_ITMI_SILVERNUGGET", 1);
		   	end

		   	SaveItems(playerid);
		    -- stamina OOLTYB_ITMI_MAGICORE

		elseif Player[playerid].mine == 5 then
			Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			
		    local rnd = math.random(1, 100);
			if rnd <= 40 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали стебель лесной ягоды.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_FORESTBERRY", 1);
		    elseif rnd > 40 and rnd <= 60 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали два стебля лесной ягоды.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_FORESTBERRY", 2);
		    elseif rnd > 60 and rnd <= 70 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли гроздь дикого винограда","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "UHAXLK_ITFO_WINEBERRY", 5);
		    elseif rnd > 70 and rnd <= 80 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали стебель Солнечника.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITFO_PLANTS_NIGHTSHADOW_01", 1);
		    elseif rnd > 80 and rnd <= 90 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали стебель Лунника.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITFO_PLANTS_NIGHTSHADOW_02", 1);
			 elseif rnd > 90 and rnd <= 95 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли ягоду гоблина!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_DEX_HERB_01", 1);
			 elseif rnd > 95 and rnd <= 100 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли вишню тролля!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITFO_PLANTS_TROLLBERRYS_01", 1);
		    end
			SaveItems(playerid);

		elseif Player[playerid].mine == 3 then

		   Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			
		    local rnd1 = math.random(1, 100);
			if rnd1 <= 40 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли один стебель болотника.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_SWAMPHERB", 1);
		    elseif rnd1 > 40 and rnd1 <= 60 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли два стебля болотника.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_SWAMPHERB", 2);
		    elseif rnd1 > 60 and rnd1 <= 75 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли Речной мирт.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_RIVERMIRT", 1);
		    elseif rnd1 > 75 and rnd1 <= 90 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли Иловый мирт.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_SILTMIRT", 1);
		    elseif rnd1 > 90 and rnd1 <= 98 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли моллюска","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "UHAXLK_ITAT_CLAMFLESH", 1);
			elseif rnd1 > 98 and rnd1 <= 100 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли жемчужину","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "AIXOPT_ITMI_WHITEPEARL", 1);
		    end
			SaveItems(playerid)
			
		elseif Player[playerid].mine == 8 then

		   Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			
		    local rnd = math.random(1, 100);
			if rnd <= 40 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли один стебель полевого растения.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_TEMP_HERB", 1);
		    elseif rnd > 40 and rnd <= 60 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли два стебля полевого растения.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_TEMP_HERB", 2);
		    elseif rnd > 60 and rnd <= 80 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли серафис.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_BLUEPLANT", 1);
		    elseif rnd > 80 and rnd <= 90 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли желудь.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITFO_PLANTS_TOWERWOOD_01", 1);
		    elseif rnd > 90 and rnd <= 98 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли драконий корень","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_STRENGTH_HERB_01", 1);
			elseif rnd > 98 and rnd <= 100 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли коронное растение!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_PERM_HERB", 1);
		    end
			SaveItems(playerid)
		
		elseif Player[playerid].mine == 9 then

		   	Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			
		    local rnd = math.random(1, 100);
			if rnd <= 40 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли черный гриб.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_MUSHROOM_01", 1);
		    elseif rnd > 40 and rnd <= 60 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли два черных гриба.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_MUSHROOM_01", 2);
		    elseif rnd > 60 and rnd <= 80 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли мясной гриб.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_MUSHROOM_02", 1);
		    elseif rnd > 80 and rnd <= 90 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли горный мох.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITFO_PLANTS_MOUNTAINMOSS_01", 1);
		    elseif rnd > 90 and rnd <= 95 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли каменный корень","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITFO_PLANTS_STONEROOT_01", 1);
			elseif rnd > 98 and rnd <= 100 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли гриб провидения!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_MUHOMOR", 1);
		    end
			SaveItems(playerid)

		elseif Player[playerid].mine == 10 then

			Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			
		    local rnd = math.random(1, 100);
			if rnd <= 40 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли один стебель полевого растения.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_TEMP_HERB", 1);
		    elseif rnd > 40 and rnd <= 55 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли два стебля полевого растения.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_TEMP_HERB", 2);
		    elseif rnd > 55 and rnd <= 65 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли два стебля серафиса","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_BLUEPLANT", 2);
		    elseif rnd > 65 and rnd <= 85 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали стебель огненной крапивы.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_MANA_HERB_01", 1);
		    elseif rnd > 85 and rnd <= 95 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали стебель огненной травы.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_MANA_HERB_02", 1);
			 elseif rnd > 95 and rnd <= 100 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали огненный корень","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_MANA_HERB_03", 1);
		    end
			SaveItems(playerid);

		elseif Player[playerid].mine == 11 then
			Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			
		    local rnd = math.random(1, 100);
			if rnd <= 40 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли один стебель полевого растения.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_TEMP_HERB", 1);
		    elseif rnd > 40 and rnd <= 55 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли два стебля полевого растения.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_TEMP_HERB", 2);
		    elseif rnd > 55 and rnd <= 65 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли два стебля серафиса","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_BLUEPLANT", 2);
		    elseif rnd > 65 and rnd <= 85 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали стебель лечебного растения.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_HEALTH_HERB_01", 1);
		    elseif rnd > 85 and rnd <= 95 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали стебель лечебной травы.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_HEALTH_HERB_02", 1);
			 elseif rnd > 95 and rnd <= 100 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали лечебный корень","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_HEALTH_HERB_03", 1);
		    end
			SaveItems(playerid);



		elseif Player[playerid].mine == 7 then

		    Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			local rnd = math.random(1, 100);
			if rnd <= 50 then
			GameTextForPlayer(playerid, 50, 6000, "Вы набрали две охапки зерна.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
			GiveItem(playerid, "AIXOPT_ITMI_WHEAT", 2);
			elseif rnd > 50 and rnd <= 75 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы набрали три охапки зерна.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "AIXOPT_ITMI_WHEAT", 3);
		    elseif rnd > 75 and rnd <= 90 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы набрали четыре охапки зерна.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "AIXOPT_ITMI_WHEAT", 4);
		    elseif rnd > 90 and rnd <= 100 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы наткнулись на сорняк","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "HFDPUN_ITPL_WEED", 1);	
		    end
		    SaveItems(playerid);

		    

		elseif Player[playerid].mine == 4 then

		    Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			GiveItem(playerid, "GKWQDZ_ITMW_1H_BAU_MACE", 1);
			SaveItems(playerid);
		    GameTextForPlayer(playerid, 50, 6000, "Вы нашли палку.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);

		elseif Player[playerid].mine == 6 then

		    Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			GiveItem(playerid, "UHAXLK_ITFO_HONEY", 1);
			SaveItems(playerid);
		    GameTextForPlayer(playerid, 50, 6000, "Вы набрали мед","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);

		end
	end
end