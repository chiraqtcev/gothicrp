

function SaveSkill(playerid)

	local file = io.open("Database/Players/Skills/"..Player[playerid].nickname..".txt", "w+");
	file:write(Player[playerid].readscrolls.."\n");
	file:write("0".."\n");
	file:write("0".."\n");
	file:write("0".."\n");
	file:write("0".."\n");
	file:write("0".."\n");
	file:write("0".."\n");
	file:write("0".."\n");
	file:write("0".."\n");
	file:write("0".."\n");
	file:write("0".."\n");
	file:write("0".."\n");
	file:close();

end

function ReadSkill(playerid)

	local file = io.open("Database/Players/Skills/"..Player[playerid].nickname..".txt", "r+");
	if file then

		tempvar = file:read("*l");
		local result, pos = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].readscrolls = pos;
		end
	
	
		file:close()

	else
		SaveSkill(playerid);
	end

end


