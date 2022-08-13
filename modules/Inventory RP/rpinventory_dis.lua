
-- [[  ]]

local rpinv_background = CreateTexture(5910, 2280, 8050, 6650, 'menu_ingame')
local rpinv_background_1 = CreateTexture(5910, 6093, 8050, 6593, 'menu_ingame')
local rpinv_background_1_1 = CreateTexture(7247, 6170, 7270, 6553, 'dlg_conversation')

function DeleteEmptyRPSlot(playerid)

	local i = 1
	while Player[playerid].rpinventory[i] do
		if Player[playerid].rpinventory[i] == "" then
		    table.remove(Player[playerid].rpinventory, i)
		    i = i - 1;
  		end
  	i = i + 1;
	end

end

function RefreshRPSlots(playerid)

	local count = 0
  	for _ in pairs(Player[playerid].rpinventory) do 
  		count = count + 1;
  	end

  	if count < 10 then
  		while count < 10 do
  			Player[playerid].rpinventory[#Player[playerid].rpinventory+1] = "";
  			count = count + 1;
  		end
  	end

end

function CheckHasRPItem(playerid, itemname)

	for i, v in pairs(Player[playerid].rpinventory) do 
		if v == itemname then
			return true;
		end
	end
	return false;

end

function CheckRPInvAmounts(playerid)

	local count = 0
  	for _ in pairs(Player[playerid].rpinventory_amount) do 
  		count = count + 1;
  	end

  	if count < 10 then
  		while count < 10 do
  			Player[playerid].rpinventory_amount[#Player[playerid].rpinventory_amount+1] = "";
  			count = count + 1;
  		end
  	end

end



function CreateRPItem(playerid, params)

	if Player[playerid].astatus > 1 then
		local result, id, amount, itemname = sscanf(params, "dds");
		if result == 1 then
			if CheckRPInvLimit(id) == true then
			
				if CheckHasRPItem(id, itemname) == false then
					DeleteEmptyRPSlot(id);
					Player[id].rpinventory[#Player[id].rpinventory+1] = itemname;
					RefreshRPSlots(id);

					local n;
					for i, v in pairs(Player[id].rpinventory) do 
						if v == itemname then
							n = i;
						end
					end
					if amount <= 1 then
						Player[id].rpinventory_amount[n] = 1;
					else
						Player[id].rpinventory_amount[n] = amount;
					end

					SendPlayerMessage(playerid, 255,255,0, "Игроку "..GetPlayerName(id).." выдано: "..itemname.." x"..amount);
					SendPlayerMessage(id, 255,255,0, "Вам выдано: "..itemname.." x"..amount);
					SaveRPInv(id);
					
				else
				
					local n;
					for i, v in pairs(Player[id].rpinventory) do 
						if v == itemname then
							n = i;
						end
					end
					
					Player[id].rpinventory_amount[n] = Player[id].rpinventory_amount[n] + amount;
					SaveRPInv(id);
					
					SendPlayerMessage(playerid, 255,255,0, "Игроку "..GetPlayerName(id).." выдано: "..itemname.." x"..amount);
					SendPlayerMessage(id, 255,255,0, "Вам выдано: "..itemname.." x"..amount);
					
					
				end
			else
				SendPlayerMessage(playerid, 255, 0, 0, "У игрока нет места в рп-инвентаре.")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 0, "/ген (id) (name) (amount)");
		end
	end
	
end
addCommandHandler({"/rpitem", "/ген"}, CreateRPItem)

function RPInvMouse(playerid, button, pressed, posX, posY)

	if button == MB_LEFT then
		if pressed == 0 then
			if Player[playerid].loggedIn == true and Player[playerid].openinv == true then

				if posX > rpInv_show[1] and posX < rpInv_show[2] and posY > rpInv_show[3] and posY < rpInv_show[4] then

					if Player[playerid].rpinventory_slot ~= nil then
						local n = Player[playerid].rpinventory_slot;
						for i = 0, GetMaxPlayers() do
							if GetDistancePlayers(playerid, i) <= 1000 then
								SendPlayerMessage(i, 128, 0, 255, GetPlayerName(playerid).." имеет статус: "..Player[playerid].rpinventory[n]..".");       
							end
						end
					end

				end

			end
		end
	end
end

function GOODBYE_MY_MIND(playerid)

	Player[playerid].openinv = false;
	HideTexture(playerid, rpinv_background);
	HideTexture(playerid, rpinv_background_1);
	HideTexture(playerid, rpinv_background_1_1);
	HidePlayerDraw(playerid, rpinv_name);
	HidePlayerDraw(playerid, rpinv_str1);
	HidePlayerDraw(playerid, rpinv_str2);
	HidePlayerDraw(playerid, rpinv_slot1);
	HidePlayerDraw(playerid, rpinv_slot2);
	HidePlayerDraw(playerid, rpinv_slot3);
	HidePlayerDraw(playerid, rpinv_slot4);
	HidePlayerDraw(playerid, rpinv_slot5);
	HidePlayerDraw(playerid, rpinv_slot6);
	HidePlayerDraw(playerid, rpinv_slot7);
	HidePlayerDraw(playerid, rpinv_slot8);
	HidePlayerDraw(playerid, rpinv_slot9);
	HidePlayerDraw(playerid, rpinv_slot10);
	FreezePlayer(playerid, 0);
	HidePlayerDraw(playerid, rpinv_ch);
	Player[playerid].rpinventory_slot = nil;
	SetCursorVisible(playerid, 0);

end


function rpinvKey(playerid, keyDown, keyUp)
	
	if Player[playerid].loggedIn == true then
		if keyDown == KEY_Y then
			OpenRPInventory(playerid)
		end

		if keyDown == KEY_DOWN then
			if Player[playerid].openinv == true then
				if Player[playerid].rpinventory_slot ~= nil then
					local n = Player[playerid].rpinventory_slot;
					if Player[playerid].rpinventory[n+1] ~= "" then
						if Player[playerid].rpinventory_slot == 10 then
							Player[playerid].rpinventory_slot = 1;
							UpdateRPInvSlot(playerid);
						else
							Player[playerid].rpinventory_slot = Player[playerid].rpinventory_slot + 1;
							UpdateRPInvSlot(playerid);
						end
					end
				end
			end
		end

		if keyDown == KEY_UP then
			if Player[playerid].openinv == true then
				if Player[playerid].rpinventory_slot ~= nil then
					local n = Player[playerid].rpinventory_slot;
					if Player[playerid].rpinventory[n-1] ~= "" then
						if Player[playerid].rpinventory_slot == 1 then
							Player[playerid].rpinventory_slot = 1;
							UpdateRPInvSlot(playerid);
						else
							Player[playerid].rpinventory_slot = Player[playerid].rpinventory_slot - 1;
							UpdateRPInvSlot(playerid);
						end
					end
				end
			end
		end
	end

end


function UpdateRPInvSlot(playerid)


	if Player[playerid].rpinventory_slot == 1 then
		UpdatePlayerDraw(playerid, rpinv_ch, 5975, 2600, ">", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	elseif Player[playerid].rpinventory_slot == 2 then
		UpdatePlayerDraw(playerid, rpinv_ch, 5975, 2800, ">", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	elseif Player[playerid].rpinventory_slot == 3 then
		UpdatePlayerDraw(playerid, rpinv_ch, 5975, 3000, ">", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	elseif Player[playerid].rpinventory_slot == 4 then
		UpdatePlayerDraw(playerid, rpinv_ch, 5975, 3200, ">", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	elseif Player[playerid].rpinventory_slot == 5 then
		UpdatePlayerDraw(playerid, rpinv_ch, 5975, 3400, ">", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	elseif Player[playerid].rpinventory_slot == 6 then
		UpdatePlayerDraw(playerid, rpinv_ch, 5975, 3600, ">", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	elseif Player[playerid].rpinventory_slot == 7 then
		UpdatePlayerDraw(playerid, rpinv_ch, 5975, 3800, ">", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	elseif Player[playerid].rpinventory_slot == 8 then
		UpdatePlayerDraw(playerid, rpinv_ch, 5975, 4000, ">", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	elseif Player[playerid].rpinventory_slot == 9 then
		UpdatePlayerDraw(playerid, rpinv_ch, 5975, 4200, ">", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	elseif Player[playerid].rpinventory_slot == 10 then
		UpdatePlayerDraw(playerid, rpinv_ch, 5975, 4400, ">", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end

end

function OpenRPInventory(playerid)

	if Player[playerid].openinv == false then

		Player[playerid].openinv = true;
		ShowTexture(playerid, rpinv_background);
		ShowTexture(playerid, rpinv_background_1);
		ShowTexture(playerid, rpinv_background_1_1);
		ShowPlayerDraw(playerid, rpinv_name);
		ShowPlayerDraw(playerid, rpinv_str1);
		ShowPlayerDraw(playerid, rpinv_str2);
		ShowPlayerDraw(playerid, rpinv_slot1);
		ShowPlayerDraw(playerid, rpinv_slot2);
		ShowPlayerDraw(playerid, rpinv_slot3);
		ShowPlayerDraw(playerid, rpinv_slot4);
		ShowPlayerDraw(playerid, rpinv_slot5);
		ShowPlayerDraw(playerid, rpinv_slot6);
		ShowPlayerDraw(playerid, rpinv_slot7);
		ShowPlayerDraw(playerid, rpinv_slot8);
		ShowPlayerDraw(playerid, rpinv_slot9);
		ShowPlayerDraw(playerid, rpinv_slot10);
		UpdateDrawRPInv(playerid);
		FreezePlayer(playerid, 1);

		if Player[playerid].rpinventory[1] ~= "" then
			ShowPlayerDraw(playerid, rpinv_ch);
			Player[playerid].rpinventory_slot = 1;
			UpdateRPInvSlot(playerid);
			SetCursorVisible(playerid, 1);
		end

	else
	
		Player[playerid].openinv = false;
		HideTexture(playerid, rpinv_background);
		HideTexture(playerid, rpinv_background_1);
		HideTexture(playerid, rpinv_background_1_1);
		HidePlayerDraw(playerid, rpinv_name);
		HidePlayerDraw(playerid, rpinv_str1);
		HidePlayerDraw(playerid, rpinv_str2);
		HidePlayerDraw(playerid, rpinv_slot1);
		HidePlayerDraw(playerid, rpinv_slot2);
		HidePlayerDraw(playerid, rpinv_slot3);
		HidePlayerDraw(playerid, rpinv_slot4);
		HidePlayerDraw(playerid, rpinv_slot5);
		HidePlayerDraw(playerid, rpinv_slot6);
		HidePlayerDraw(playerid, rpinv_slot7);
		HidePlayerDraw(playerid, rpinv_slot8);
		HidePlayerDraw(playerid, rpinv_slot9);
		HidePlayerDraw(playerid, rpinv_slot10);
		FreezePlayer(playerid, 0);
		if Player[playerid].rpinventory[1] ~= "" then
			HidePlayerDraw(playerid, rpinv_ch);
			Player[playerid].rpinventory_slot = nil;
			SetCursorVisible(playerid, 0);
		end
		
	end

end
addCommandHandler({"/статус", "/status"}, OpenRPInventory);

function SaveRPInv(playerid)

	local file = io.open("Database/Players/RPInv/"..GetPlayerName(playerid)..".txt","w+");

	file:write(Player[playerid].rpinventory[1].."\n");
	file:write(Player[playerid].rpinventory[2].."\n");
	file:write(Player[playerid].rpinventory[3].."\n");
	file:write(Player[playerid].rpinventory[4].."\n");
	file:write(Player[playerid].rpinventory[5].."\n");
	file:write(Player[playerid].rpinventory[6].."\n");
	file:write(Player[playerid].rpinventory[7].."\n");
	file:write(Player[playerid].rpinventory[8].."\n");
	file:write(Player[playerid].rpinventory[9].."\n");
	file:write(Player[playerid].rpinventory[10]);
	file:close();

	local file = io.open("Database/Players/RPInv/"..GetPlayerName(playerid).."_amount"..".txt","w+");
	file:write(Player[playerid].rpinventory_amount[1].."\n");
	file:write(Player[playerid].rpinventory_amount[2].."\n");
	file:write(Player[playerid].rpinventory_amount[3].."\n");
	file:write(Player[playerid].rpinventory_amount[4].."\n");
	file:write(Player[playerid].rpinventory_amount[5].."\n");
	file:write(Player[playerid].rpinventory_amount[6].."\n");
	file:write(Player[playerid].rpinventory_amount[7].."\n");
	file:write(Player[playerid].rpinventory_amount[8].."\n");
	file:write(Player[playerid].rpinventory_amount[9].."\n");
	file:write(Player[playerid].rpinventory_amount[10]);
	file:close();

end

function ReadRPInv(playerid)

	Player[playerid].rpinventory = {};
	Player[playerid].rpinventory_amount = {};

	local file = io.open("Database/Players/RPInv/"..GetPlayerName(playerid)..".txt","r");
	if file then
		for line in file:lines() do 
			local result, item = sscanf(line,"s");
			if result == 1 then
				Player[playerid].rpinventory[#Player[playerid].rpinventory+1] = item;
			end
		end

		local count = 0
		for _ in pairs(Player[playerid].rpinventory) do 
			count = count + 1;
		end

		if count < 10 then
			while count < 10 do
				Player[playerid].rpinventory[#Player[playerid].rpinventory+1] = "";
				count = count + 1;
			end
		end
		

		file:close();

		local file = io.open("Database/Players/RPInv/"..GetPlayerName(playerid).."_amount"..".txt","r");

		for line in file:lines() do 
			local result, amount = sscanf(line,"d");
			if result == 1 then
				Player[playerid].rpinventory_amount[#Player[playerid].rpinventory_amount+1] = amount;
			end
		end

		local count = 0
		for _ in pairs(Player[playerid].rpinventory_amount) do 
			count = count + 1;
		end

		if count < 10 then
			while count < 10 do
				Player[playerid].rpinventory_amount[#Player[playerid].rpinventory_amount+1] = "";
				count = count + 1;
			end
		end

		file:close();
	else
	 SaveRPInv(playerid)
	end


end

function CheckRPInvLimit(playerid)

	local count = 0
	for i, v in pairs(Player[playerid].rpinventory) do 
		if v ~= "" and v ~= " " then
			count = count + 1 
		end
	end

	if count < 10 then
		return true
	else
		return false
	end

end

function FindEmptySlotsInDraw(playerid)

	if Player[playerid].rpinventory[1] == "" then
		SetPlayerDrawText(playerid, rpinv_slot1, "");
		
	elseif Player[playerid].rpinventory[2] == "" then
		SetPlayerDrawText(playerid, rpinv_slot2, "");
		
	elseif Player[playerid].rpinventory[3] == "" then
		SetPlayerDrawText(playerid, rpinv_slot3, "");
		
	elseif Player[playerid].rpinventory[4] == "" then
		SetPlayerDrawText(playerid, rpinv_slot4, "");
		
	elseif Player[playerid].rpinventory[5] == "" then
		SetPlayerDrawText(playerid, rpinv_slot5, "");
		
	elseif Player[playerid].rpinventory[6] == "" then
		SetPlayerDrawText(playerid, rpinv_slot6, "");
		
	elseif Player[playerid].rpinventory[7] == "" then
		SetPlayerDrawText(playerid, rpinv_slot7, "");
		
	elseif Player[playerid].rpinventory[8] == "" then
		SetPlayerDrawText(playerid, rpinv_slot8, "");
		
	elseif Player[playerid].rpinventory[9] == "" then
		SetPlayerDrawText(playerid, rpinv_slot9, "");
		
	elseif Player[playerid].rpinventory[10] == "" then
		SetPlayerDrawText(playerid, rpinv_slot10, "");
		
	end
		
		
end


function UpdateDrawRPInv(playerid)

	local stopstatus = false;

	if stopstatus == false then
		if Player[playerid].rpinventory[1] ~= "" then
			local str = string.format("%s%s%d", Player[playerid].rpinventory[1]," x", Player[playerid].rpinventory_amount[1])
			UpdatePlayerDraw(playerid, rpinv_slot1, 6040, 2600, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		else
			stopstatus = true;
		end
	end

	if stopstatus == false then
		if Player[playerid].rpinventory[2] ~= "" then
			local str = string.format("%s%s%d", Player[playerid].rpinventory[2]," x", Player[playerid].rpinventory_amount[2])
			UpdatePlayerDraw(playerid, rpinv_slot2, 6040, 2800, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		else
			stopstatus = true;
		end
	end

	if stopstatus == false then
		if Player[playerid].rpinventory[3] ~= "" then
			local str = string.format("%s%s%d", Player[playerid].rpinventory[3]," x", Player[playerid].rpinventory_amount[3])
			UpdatePlayerDraw(playerid, rpinv_slot3, 6040, 3000, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		else
			stopstatus = true;
		end
	end


	if stopstatus == false then
		if Player[playerid].rpinventory[4] ~= "" then
			local str = string.format("%s%s%d", Player[playerid].rpinventory[4]," x", Player[playerid].rpinventory_amount[4])
			UpdatePlayerDraw(playerid, rpinv_slot4, 6040, 3200, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		else
			stopstatus = true;
		end
	end


	if stopstatus == false then
		if Player[playerid].rpinventory[5] ~= "" then
			local str = string.format("%s%s%d", Player[playerid].rpinventory[5]," x", Player[playerid].rpinventory_amount[5])
			UpdatePlayerDraw(playerid, rpinv_slot5, 6040, 3400, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		else
			stopstatus = true;
		end
	end

	if stopstatus == false then
		if Player[playerid].rpinventory[6] ~= "" then
			local str = string.format("%s%s%d", Player[playerid].rpinventory[6]," x", Player[playerid].rpinventory_amount[6])
			UpdatePlayerDraw(playerid, rpinv_slot6, 6040, 3600, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		else
			stopstatus = true;
		end
	end

	if stopstatus == false then
		if Player[playerid].rpinventory[7] ~= "" then
			local str = string.format("%s%s%d", Player[playerid].rpinventory[7]," x", Player[playerid].rpinventory_amount[7])
			UpdatePlayerDraw(playerid, rpinv_slot7, 6040, 3800, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		else
			stopstatus = true;
		end
	end

	if stopstatus == false then
		if Player[playerid].rpinventory[8] ~= "" then
			local str = string.format("%s%s%d", Player[playerid].rpinventory[8]," x", Player[playerid].rpinventory_amount[8])
			UpdatePlayerDraw(playerid, rpinv_slot8, 6040, 4000, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		else
			stopstatus = true;
		end
	end

	if stopstatus == false then
		if Player[playerid].rpinventory[9] ~= "" then
			local str = string.format("%s%s%d", Player[playerid].rpinventory[9]," x", Player[playerid].rpinventory_amount[9])
			UpdatePlayerDraw(playerid, rpinv_slot9, 6040, 4200, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		else
			stopstatus = true;
		end
	end

	if stopstatus == false then
		if Player[playerid].rpinventory[10] ~= "" then
			local str = string.format("%s%s%d", Player[playerid].rpinventory[10]," x", Player[playerid].rpinventory_amount[10])
			UpdatePlayerDraw(playerid, rpinv_slot10, 6040, 4400, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		else
			stopstatus = true;
		end
	end



end


