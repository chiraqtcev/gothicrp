function SaveItems(playerid)

	if Player[playerid].hero_use[1] == false then
		local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","w+");
		local items = getPlayerItems(playerid);
		if items then
			for i in pairs(items) do
				file:write(items[i].instance.." "..items[i].amount.."\n");
			end
		end
		file:close();
	else
		local file = io.open("Database/Heroes/Items/"..GetPlayerName(playerid)..".txt","w+");
		local items = getPlayerItems(playerid);
		if items then
			for i in pairs(items) do
				file:write(items[i].instance.." "..items[i].amount.."\n");
			end
		end
		file:close();
	end

end


function ReadItems(playerid)

	if Player[playerid].hero_use[1] == false then
		local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","r+");
		if file then
			for line in file:lines() do 
				local result, item, bdvalue = sscanf(line,"sd");
				if result == 1 and bdvalue ~= 0 then
					GiveItem(playerid, item, bdvalue);
				end
			end
		file:close();
		end
	else
		local file = io.open("Database/Heroes/Items/"..GetPlayerName(playerid)..".txt","r+");
		if file then
			for line in file:lines() do 
				local result, item, bdvalue = sscanf(line,"sd");
				if result == 1 and bdvalue ~= 0 then
					GiveItem(playerid, item, bdvalue);
				end
			end
		file:close();
		end
	end

end