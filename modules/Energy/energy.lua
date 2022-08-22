
--  #  Energy system by royclapton  #
--  #           version: 1.0        #

preENERGY_BLOCK = {};

function EnergyBar(id)

	if Player[id].eBar == false then
		Player[id].eBar = true;
		ShowTexture(id, Player[id].energybar[1])
		UpdateEnergyBar(id);
	else
		Player[id].eBar = false;
		HideTexture(id, Player[id].energybar[1])
	end

end

function UpdateEnergyBar(id)

	local a = 100 - Player[id].energy;
	local b = a * 11.2;

	--Player[id].energybar_x = 1100 - b;
	--UpdateTexture(Player[id].energybar[1], 74, 7592, Player[id].energybar_x, 7809, 'BAR1');
	_updateHud(id);

end

function _initEnergy()

	local file = io.open("Blocks/preENERGY.txt", "r");
		for line in file:lines() do
			local result, name = sscanf(line, "s");
			if result == 1 then
				table.insert(preENERGY_BLOCK, name);
			end
		end
	file:close();

end

function _addToPreEnergy(id)

	local status = false;
	for i, v in pairs(preENERGY_BLOCK) do
		if Player[id].nickname == v then
			status = true;
		end
	end

	if status == false then
		table.insert(preENERGY_BLOCK, Player[id].nickname);
		local file = io.open("Blocks/preENERGY.txt", "w+");
		for i = 1, table.getn(preENERGY_BLOCK) do
			file:write(preENERGY_BLOCK[i].."\n");
		end
		file:close();
	end

end

function _checkPreEnergy(id)

	local file = io.open("Blocks/preENERGY.txt", "r");
	if file then
		for line in file:lines() do
			local result, name = sscanf(line, "s");
			if result == 1 then
				if Player[id].nickname == name then
					file:close();
					return true;
				end
			end
		end
		file:close();
	end
	return false;

end

function UseEnergyItems(playerid, itemInstance, amount, hand)

	if Player[playerid].loggedIn == true then

		local checked = false;

		if _checkBlock(playerid, "energy", Player[playerid].nickname) == true then
  			checked = true;
  		end

  		if checked == false then

  			local time = os.date('*t');
		    local ryear = time.year;
			local rmonth = time.month;
			local rday = time.day;
			local rhour = string.format("%02d", time.hour);
			local rminute = string.format("%02d", time.min);
			local date = rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear;
			local oldEnergy = Player[playerid].energy;

			local item = string.upper(itemInstance);
  			local itfo = string.find(itemInstance, "ITFO");
  			local joint = string.find(itemInstance, "JOINT");
  			if itfo then
				SetPlayerVirtualWorld(playerid, math.random(5, 1000));
				SetTimerEx("BackToZero", 1500, 0, playerid);
			end

			if joint then
				SetPlayerVirtualWorld(playerid, math.random(5, 1000));
				SetTimerEx("BackToZero", 1500, 0, playerid);
			end
			
			local oldLimit = Player[playerid].energyblock; local oldEnergy = Player[playerid].energy; local newEnergy = 0; local item_en = 0; local newLimit = 0;
			
			if itemInstance == "UHAXLK_ITFO_FRIEDMEAT" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50;
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "UHAXLK_ITFO_FRIEDFISH" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50;
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_FISHFRIED" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50;
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "UHAXLK_ITFO_HONEY" then
				
					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25;
					item_en = 25;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_ADDON_SHELLFLESH" then
				
					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25;
					item_en = 25;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_POORSOUP" then
				
					Player[playerid].energy = Player[playerid].energy + 100;
					Player[playerid].energyblock = Player[playerid].energyblock + 100;
					item_en = 100;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
				

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MUSHROOMOFFAL" then
				
					Player[playerid].energy = Player[playerid].energy + 100;
					Player[playerid].energyblock = Player[playerid].energyblock + 100;
					item_en = 100;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
				

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_GRAPEJUICE" then
				
					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25;
					item_en = 25;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "UHAXLK_ITFO_SAUSAGE" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50;
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MARINMUSHROOM" then
				
					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25;
					item_en = 25;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "UHAXLK_ITFO_BREAD" then
				
					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25;	
					item_en = 25;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_ADDON_MEATSOUP" then
				
					Player[playerid].energy = Player[playerid].energy + 100;
					Player[playerid].energyblock = Player[playerid].energyblock + 100;
					item_en = 100;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
				

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_FISHBATTER" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50;
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "UHAXLK_ITFO_MEATBUGRAGOUT" then
				
					Player[playerid].energy = Player[playerid].energy + 100;
					Player[playerid].energyblock = Player[playerid].energyblock + 100;
					item_en = 100;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
				

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BERRYSALAD" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50;
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "UHAXLK_ITFO_CHEESE" then
				
					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25;
					item_en = 25;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_TEA" then
				
					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25;
					item_en = 25;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MORS" then
				
					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25;
					item_en = 25;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
				

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_RICEBOOZE" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50;
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);


			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "UHAXLK_ITFO_SOUP" then
				
					Player[playerid].energy = Player[playerid].energy + 100;
					Player[playerid].energyblock = Player[playerid].energyblock + 100;	
					item_en = 100;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
		
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MEDOVUHA" then
				
					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25;
					item_en = 25;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_ADDON_MEATSOUP" then
				
					Player[playerid].energy = Player[playerid].energy + 100; 
					Player[playerid].energyblock = Player[playerid].energyblock + 100;
					item_en = 100;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
				
				
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BARBECUE" then

					Player[playerid].energy = Player[playerid].energy + 50; 
					Player[playerid].energyblock = Player[playerid].energyblock + 50;
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
				
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MUSHROOMCUTLET" then

					Player[playerid].energy = Player[playerid].energy + 50; 
					Player[playerid].energyblock = Player[playerid].energyblock + 50; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
				
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_ACORNBREAD" then
				
					Player[playerid].energy = Player[playerid].energy + 25; 
					Player[playerid].energyblock = Player[playerid].energyblock + 25; 
					item_en = 25;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			
				
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "UHAXLK_ITFO_BOOZE" then

					Player[playerid].energy = Player[playerid].energy + 50; 
					Player[playerid].energyblock = Player[playerid].energyblock + 50; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
				
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BERRYLIQUEUR" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
				
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_SEASALAD" then
				
					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25;
					item_en = 25;				
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			
				
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MBLINCHIK" then
				
					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25; 
					item_en = 25;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			
				
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BOMBER" then
				
					Player[playerid].energy = Player[playerid].energy + 100;
					Player[playerid].energyblock = Player[playerid].energyblock + 100; 
					item_en = 100;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
				
				
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MEATBUGPATE" then

					Player[playerid].energy = Player[playerid].energy + 50; 
					Player[playerid].energyblock = Player[playerid].energyblock + 50;
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
				
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "UHAXLK_ITFO_WINE" then

					Player[playerid].energy = Player[playerid].energy + 50; 
					Player[playerid].energyblock = Player[playerid].energyblock + 50; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "UHAXLK_ITFO_STEW" then
				
					Player[playerid].energy = Player[playerid].energy + 100;
					Player[playerid].energyblock = Player[playerid].energyblock + 100;
					item_en = 100;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
				
				
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "UHAXLK_ITFO_FISHSOUP" then
				
					Player[playerid].energy = Player[playerid].energy + 100;
					Player[playerid].energyblock = Player[playerid].energyblock + 100;
					item_en = 100;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
				

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "AIXOPT_ITMI_JOINT" then
				
					Player[playerid].energy = Player[playerid].energy + 5;
					Player[playerid].energyblock = Player[playerid].energyblock + 5;
					item_en = 5;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			
			
			
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "OOLTYB_ITFO_MEATBUGFRIED" then
				
					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25;
					item_en = 25;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			
				
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "AIXOPT_ITMI_JOINT_1" then
				
					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25;
					item_en = 25;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_ACORNBOOZE" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_CASSEROLE" then

					Player[playerid].energy = Player[playerid].energy + 100;
					Player[playerid].energyblock = Player[playerid].energyblock + 100; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_WINESTEW" then

					Player[playerid].energy = Player[playerid].energy + 100;
					Player[playerid].energyblock = Player[playerid].energyblock + 100; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_FRIEDEGG" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BACON" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_SMOKEDFISH" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_HONEYBISCUIT" then

					Player[playerid].energy = Player[playerid].energy + 10;
					Player[playerid].energyblock = Player[playerid].energyblock + 10; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BERRYPIE" then

					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BEAFPIE" then

					Player[playerid].energy = Player[playerid].energy + 25;
					Player[playerid].energyblock = Player[playerid].energyblock + 25; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MAGICSOUP" then

					Player[playerid].energy = Player[playerid].energy + 100;
					Player[playerid].energyblock = Player[playerid].energyblock + 100; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_ADDON_FIRESTEW" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_SHAURMA" then

					Player[playerid].energy = Player[playerid].energy + 100;
					Player[playerid].energyblock = Player[playerid].energyblock + 100; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MANAGA" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BARON" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_FREEDOM" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_OYSTERSOUP" then

					Player[playerid].energy = Player[playerid].energy + 100;
					Player[playerid].energyblock = Player[playerid].energyblock + 100; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
					
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_HONEYMEAT" then

					Player[playerid].energy = Player[playerid].energy + 50;
					Player[playerid].energyblock = Player[playerid].energyblock + 50; 
					item_en = 50;
					_addToPreEnergy(playerid);
					SavePlayer(playerid);
			end

			newEnergy = Player[playerid].energy;
			newLimit = Player[playerid].energyblock;


			local correct_limit = 100 - oldLimit; -- число, которое мы можем восстановить
			local energy_get = newEnergy - oldEnergy; -- сколько восстановлено стамины сейчас.
			if energy_get > correct_limit then
				Player[playerid].energy = oldEnergy + correct_limit; -- устанавливает уровень стамины (старый+лимит).
			end


			--[[local correct_limit = 100 - oldLimit;
			if newEnergy > oldEnergy then
				if correct_limit ~= 100 then
					if oldEnergy == 0 then
						Player[playerid].energy = correct_limit;
					end
				end
			end]]




			if Player[playerid].energy > 100 then
				Player[playerid].energy = 100;
			end
			
			if itfo then
				LogString("Logs/PlayersAll/Food", Player[playerid].nickname.." съел "..GetItemName(itemInstance).." (старая стамина: "..oldEnergy.." / новая стамина: "..Player[playerid].energy.." / ост. лимит: "..100-Player[playerid].energyblock.." / Дата: "..date..")");
			end

			if joint then
				LogString("Logs/PlayersAll/Food", Player[playerid].nickname.." съел "..GetItemName(itemInstance).." (старая стамина: "..oldEnergy.." / новая стамина: "..Player[playerid].energy.." / ост. лимит: "..100-Player[playerid].energyblock.." / Дата: "..date..")");
			end
			if Player[playerid].energyblock >= 99 then
				Player[playerid].energyblock = 100;
				_addToBlock(playerid, "energy")
				SendPlayerMessage(playerid, 250, 67, 67, "Внимание, достигнут лимит восстановления стамины.")
			end

			_updateHud(playerid);
			SavePlayer(playerid);
		else
			local item = string.upper(itemInstance);
  			local itfo = string.find(itemInstance, "ITFO");
  			if itfo then
				GameTextForPlayer(playerid, 50, 6000, "Достигнут дневной лимит восстановления энергии.","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
			
			if item == "OOLTYB_ITMI_JOINT_1" or item == "OOLTYB_ITMI_JOINT" then
				GameTextForPlayer(playerid, 50, 6000, "Достигнут дневной лимит восстановления энергии.","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end
	end
end

function BackToZero(id)
	SetPlayerVirtualWorld(id, 0);
end
