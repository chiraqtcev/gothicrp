
function SaveStats(playerid)
	
	local file = io.open("Database/Players/Stats/"..GetPlayerName(playerid)..".db", "w+");

	file:write(Player[playerid].str.."\n");
	file:write(Player[playerid].dex.."\n");
	file:write(Player[playerid].hp.."\n");
	file:write(Player[playerid].mp.."\n");
	file:write(Player[playerid].h1.."\n");
	file:write(Player[playerid].h2.."\n");
	file:write(Player[playerid].cbow.."\n");
	file:write(Player[playerid].bow.."\n");
	file:write(Player[playerid].mag.."\n");

	file:write(GetPlayerHealth(playerid).."\n");
	file:write(GetPlayerMana(playerid).."\n");
	file:close();

end

function ReadStats(playerid)
	
	local file = io.open("Database/Players/Stats/"..GetPlayerName(playerid)..".db", "r+");
	
	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].str = par;
		end

	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].dex = par;
		end

	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].hp = par;
		end

	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].mp = par;
		end

	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].h1 = par;
		end


	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].h2 = par;
		end


	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].cbow = par;
		end


	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].bow = par;
		end


	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].mag = par;
		end


	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			if par > 0 then
				Player[playerid].chp = par;
			elseif par < 1 then
				Player[playerid].chp = 10;
			end
		end


	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].cmp = par;
		end

	file:close();

end

