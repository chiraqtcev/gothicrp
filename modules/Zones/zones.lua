


--  #  Zone system by royclapton  #
--  #         version: 0.5        #


-- как-то здесь насрано

local itqqqqq = CreateTexture(5620, 3957, 8184, 4457, 'dlg_conversation')

local zone_craft = {6046.1489257813, -556.20690917969, 875.36224365234}; -- координаты для зоны 1
local zone_craft1 = {-5696.9428710938, -890.16192626953, 1594.3939208984}; -- координаты для зоны 2
local zone_craft2 = {3963.7609863281, -1374.2171630859, 3355.9221191406}; -- задел для новой зоны
local zone_craft3 = {3390.9956054688, -1363.0954589844, 17482.6796875}; -- задел для новой зоны
local zone_craft4 = {14550.779296875, 714.94372558594, -5142.43359375}; -- задел для новой зоны
local zone_craft5 = {16918.2734375, 294.71697998047, -12098.693359375};
local zone_craft6 = {7080.158203125, 6927.6362304688, 23345.705078125};
local zone_craft7 = {-14294.690429688, -442.41973876953, 11298.95703125};
local zone_craft8 = {31135.796875, 327.05578613281, 993.57720947266};
local zone_craft9 = {-35906.76953125, -47.584125518799, -6108.67578125};
local zone_craft10 = {-18994.265625, 301.232421875, -1391.6633300781};
local zone_craft11 = {21202.974609375, -877.76257324219, 8857.2177734375};
local zone_craft12 = {-14310.193359375, 1907.4954833984, 25870.154296875};
local zone_craft13 = {-1250.7536621094, -778.23889160156, -6898.2431640625};
local zone_craft14 = {-32481.861328125, 1036.7192382813, 3053.3342285156};
local zone_craft15 = {-29345.4296875, 1225.1883544922, -1547.9229736328};
local zone_craft16 = {17048.138671875, 1064.6928710938, -18076.7734375};
local zone_craft17 = {19378.064453125, 1985.9777832031, -12660.584960938};
local zone_craft18 = {22478.06640625, -72.448776245117, -610.4365234375};
local zone_craft19 = {24437.55078125, 59.528366088867, 4865.9458007813};
local zone_craft20 = {27722.6015625, -79.770683288574, 6492.4819335938};
local zone_craft21 = {-21140.857421875, -119.53739929199, 15366.821289063};
local zone_craft22 = {-20255.662109375, 220.72050476074, 23030.974609375};
local zone_craft23 = {-14182.826171875, -1042.8559570313, -6190.236328125};
local zone_craft24 = {-21104.322265625, -605.65789794922, 5649.9799804688};
local zone_craft25 = {-29684.298828125, 721.90460205078, 3342.2973632813};
local zone_craft26 = {-30117.33984375, 928.03393554688, 10435.450195313};
local zone_craft27 = {-26182.62109375, -723.66333007813, 12711.6171875};
local zone_arena_nl = {-58407.38671875, 2637.2021484375, 17664.794921875}; -- арена НЛ
local zone_arena_melori = {-58407.38671875, 2637.2021484375, 17664.794921875}; -- арена тиморис

function CheckZones()

	for i = 0, GetMaxSlots() do
        if IsPlayerConnected(i) == 1 then
            local x, y, z = GetPlayerPos(i);

            local pos1 = GetDistance3D(x, y, z, zone_craft[1], zone_craft[2], zone_craft[3]);
			local pos2 = GetDistance3D(x, y, z, zone_craft1[1], zone_craft1[2], zone_craft1[3]);
			local pos3 = GetDistance3D(x, y, z, zone_craft2[1], zone_craft2[2], zone_craft2[3]);
			local pos4 = GetDistance3D(x, y, z, zone_craft3[1], zone_craft3[2], zone_craft3[3]);
			local pos5 = GetDistance3D(x, y, z, zone_craft4[1], zone_craft4[2], zone_craft4[3]);
			local pos6 = GetDistance3D(x, y, z, zone_craft5[1], zone_craft5[2], zone_craft5[3]);
			local pos7 = GetDistance3D(x, y, z, zone_craft6[1], zone_craft6[2], zone_craft6[3]);
			local pos8 = GetDistance3D(x, y, z, zone_craft7[1], zone_craft7[2], zone_craft7[3]);
			local pos9 = GetDistance3D(x, y, z, zone_craft8[1], zone_craft8[2], zone_craft8[3]);
			local pos10 = GetDistance3D(x, y, z, zone_craft9[1], zone_craft9[2], zone_craft9[3]);
			local pos11 = GetDistance3D(x, y, z, zone_craft10[1], zone_craft10[2], zone_craft10[3]);
			local pos12 = GetDistance3D(x, y, z, zone_craft11[1], zone_craft11[2], zone_craft11[3]);
			local pos13 = GetDistance3D(x, y, z, zone_craft12[1], zone_craft12[2], zone_craft12[3]);
			local pos14 = GetDistance3D(x, y, z, zone_craft13[1], zone_craft13[2], zone_craft13[3]);
			local pos15 = GetDistance3D(x, y, z, zone_arena_nl[1], zone_arena_nl[2], zone_arena_nl[3]);
			local pos16 = GetDistance3D(x, y, z, zone_craft14[1], zone_craft14[2], zone_craft14[3]);
			local pos17 = GetDistance3D(x, y, z, zone_craft15[1], zone_craft15[2], zone_craft15[3]);
			local pos18 = GetDistance3D(x, y, z, zone_craft16[1], zone_craft16[2], zone_craft16[3]);
			local pos19 = GetDistance3D(x, y, z, zone_craft17[1], zone_craft17[2], zone_craft17[3]);
			local pos20 = GetDistance3D(x, y, z, zone_craft18[1], zone_craft18[2], zone_craft18[3]);
			local pos21 = GetDistance3D(x, y, z, zone_craft19[1], zone_craft19[2], zone_craft19[3]);
			local pos22 = GetDistance3D(x, y, z, zone_craft20[1], zone_craft20[2], zone_craft20[3]);
			local pos23 = GetDistance3D(x, y, z, zone_craft21[1], zone_craft21[2], zone_craft21[3]);
			local pos24 = GetDistance3D(x, y, z, zone_craft22[1], zone_craft22[2], zone_craft22[3]);
			local pos25 = GetDistance3D(x, y, z, zone_craft23[1], zone_craft23[2], zone_craft23[3]);
			local pos26 = GetDistance3D(x, y, z, zone_craft24[1], zone_craft24[2], zone_craft24[3]);
			local pos27 = GetDistance3D(x, y, z, zone_craft25[1], zone_craft25[2], zone_craft25[3]);
			local pos28 = GetDistance3D(x, y, z, zone_craft26[1], zone_craft26[2], zone_craft26[3]);
			local pos29 = GetDistance3D(x, y, z, zone_craft27[1], zone_craft27[2], zone_craft27[3]);
			local pos30 = GetDistance3D(x, y, z, zone_arena_melori[1], zone_arena_melori[2], zone_arena_melori[3]);
			---------------------------------------------------------
            if pos1 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 1);
							Player[i].zone[2] = true;
						end
					end
				end
				
			---------------------------------------------------------
			
			elseif pos2 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 2);
							Player[i].zone[2] = true;
						end
					end
				end
			
			---------------------------------------------------------
			
			elseif pos3 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 3);
							Player[i].zone[2] = true;
						end
					end
				end
			
			---------------------------------------------------------
			elseif pos4 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 4);
							Player[i].zone[2] = true;
						end
					end
				end
			---------------------------------------------------------
			elseif pos5 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 5);
							Player[i].zone[2] = true;
						end
					end
				end
			---------------------------------------------------------
			elseif pos6 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 6);
							Player[i].zone[2] = true;
						end
					end
				end
			---------------------------------------------------------
			elseif pos7 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 7);
							Player[i].zone[2] = true;
						end
					end
				end
			---------------------------------------------------------
			elseif pos8 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 8);
							Player[i].zone[2] = true;
						end
					end
				end
			---------------------------------------------------------
				elseif pos9 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 9);
							Player[i].zone[2] = true;
						end
					end
				end
			---------------------------------------------------------
		elseif pos10 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 10);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos11 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 11);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos12 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 12);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos13 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 13);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos14 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 14);
							Player[i].zone[2] = true;
						end
					end
				end
			elseif pos15 < 700 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 15);
							Player[i].zone[2] = true;
						end
					end
				end

				elseif pos16 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 16);
							Player[i].zone[2] = true;
						end
					end
				end

				elseif pos17 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 17);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos18 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 18);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos19 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 19);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos20 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
						if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 20);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos21 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 21);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos22 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 22);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos23 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 23);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos24 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 24);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos25 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 25);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos26 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 26);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos27 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 27);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos28 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 28);
							Player[i].zone[2] = true;
						end
					end
				end

			elseif pos29 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 29);
							Player[i].zone[2] = true;
						end
					end
				end
				
			elseif pos30 < 600 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZonesCraft(i, 30);
							Player[i].zone[2] = true;
						end
					end
				end
			-- ЭТО НЕ ТРОГАТЬ.
            else
				if Player[i].loggedIn == true then
					Player[i].zone[1] = false; 
					if Player[i].zone[1] == false then
						if Player[i].zone[2] == true then
							HidePlayerDraw(i, zoneinfo);
							HideTexture(i, itqqqqq);
							Player[i].zone[2] = false;
						end
					end
				end
            end
			---------------------------------------------------------
			
        end
    end

end
SetTimer("CheckZones", 1000, 1);


function ShowZonesCraft(id, dId)

    if dId == 1 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка кузнеца (Нажмите K)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == 2 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Вы в точке для крафта (другая)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	elseif dId == 3 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка прокачки (Нажмите P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	elseif dId == 4 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи болотника (Нажмите P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	elseif dId == 5 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи лесных трав (P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	elseif dId == 6 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи грибов (Нажмите P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	elseif dId == 7 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи полевых трав (P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	elseif dId == 8 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи леч. трав (P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == 9 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи огненных трав (P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == 10 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи болотника (Нажмите P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == 11 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи леч. трав (Нажмите P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == 12 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи лесных трав (Нажмите P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == 13 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи лесных трав (Нажмите P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == 14 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка Кожевника (Нажмите K)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == 15 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка прокачки (Нажмите P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == 16 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи огненных трав (P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == 17 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи леч. трав (P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
   	elseif dId == 18 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи болотника (Нажмите P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
   	elseif dId == 19 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи леч. трав (P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == 20 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи огненных трав (P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
   elseif dId == 21 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи лесных ягод (P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
   elseif dId == 22 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи лесных ягод (P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
   elseif dId == 23 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи леч. трав (P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
   elseif dId == 24 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи грибов (Нажмите P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
   elseif dId == 25 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи грибов (Нажмите P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
   elseif dId == 26 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи грибов (Нажмите P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
   elseif dId == 27 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи лесных ягод (P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
   elseif dId == 28 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи лесных трав (P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
   elseif dId == 29 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка добычи болотника (Нажмите P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	 elseif dId == 30 then
        UpdatePlayerDraw(id, zoneinfo, 5790, 4107, "Точка прокачки (Нажмите P)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    end

end