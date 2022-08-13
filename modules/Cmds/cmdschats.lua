
function CMD_ME(playerid, params)	
	
	local result, text = sscanf(params, "s");
	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local result, msg = sscanf(params,"s");
	if result == 1 then
	
		local txt = "";
		if Player[playerid].masked == false then
			txt = GetPlayerName(playerid).." "..msg;
		else
			txt = "Неизвестный "..msg;
		end
		
		for i = 0, GetMaxPlayers() - 1 do
			if GetDistancePlayers(playerid,i) <= 1500 then
				SendPlayerMessage(i, 194,162,218, txt);         
			end
		end
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/я (действие от первого лица)");
	end
end
addCommandHandler({"/я"}, CMD_ME)


function CMD_OOC(playerid, params)
	
	local result, text = sscanf(params, "s");
	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local result, msg = sscanf(params,"s");
    if result == 1 then
    	if OOC_STATUS == true then
		
			local txt = "";
			if Player[playerid].masked == false then
				txt = "(( "..GetPlayerName(playerid)..": "..msg.." ))";
			else
				txt = "(( Неизвестный: "..msg.." ))";
			end
		
			for i = 0, GetMaxPlayers() - 1 do
				if GetDistancePlayers(playerid, i) <= 1500 then
					SendPlayerMessage(i, 160, 160, 160, txt);         
				end
			end
			LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "ООС-чат отключен администрацией.")
		end
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/о (нрп информация)");
	end
	
end
addCommandHandler({"/о"}, CMD_OOC)



function CMD_DO(playerid, params)


	local result, text = sscanf(params, "s");
	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local result, msg = sscanf(params,"s");
	if result == 1 then
	
		local txt = "";
		if Player[playerid].masked == false then
			txt = msg.." ("..GetPlayerName(playerid)..")";
		else
			txt = msg.." (Неизвестный)";
		end
	
		for i = 0, GetMaxPlayers() - 1 do
			if GetDistancePlayers(playerid, i) <= 2000 then
				SendPlayerMessage(i, 194,162,218, txt);         
			end
		end
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/до (внешняя информация)");
	end

end
addCommandHandler({"/до"}, CMD_DO)

function CMD_M(playerid, params)

	local result, text = sscanf(params, "s");
	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local result, msg = sscanf(params,"s");
	    if result == 1 then
	    local txt = "(Мысли персонажа "..GetPlayerName(playerid)..") "..msg;

		for i = 0, GetMaxPlayers() do
			if GetDistancePlayers(playerid, i) <= 1400 and Player[i].astatus > 0 then
				SendPlayerMessage(i, 210, 217, 169, txt);      
			end
		end
		SendPlayerMessage(playerid, 210, 217, 169, txt);
		
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/м (мысли)");
	end
		
end
addCommandHandler({"/м"}, CMD_M)


function CMD_SH(playerid, params)

	local result, text = sscanf(params, "s");
	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local result, msg = sscanf(params,"s");
	if result == 1 then
	    
		local txt = "";
		if Player[playerid].masked == false then
			txt = GetPlayerName(playerid).." шепчет: "..msg;
		else
			txt = "Неизвестный шепчет: "..msg;
		end
		
		for i = 0, GetMaxPlayers() - 1 do
			if GetDistancePlayers(playerid, i) <= 300 then
				SendPlayerMessage(i, 255, 255, 0, txt);         
			end
		end
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/ш (шепот)");
	end

end
addCommandHandler({"/ш"}, CMD_SH)

function CMD_K(playerid, params)

	local result, text = sscanf(params, "s");
	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local result, msg = sscanf(params,"s");
	    if result == 1 then
	    
		local txt = "";
		if Player[playerid].masked == false then
			txt = GetPlayerName(playerid).." крикнул: "..msg;
		else
			txt = "Неизвестный крикнул: "..msg;
		end
		
		
		for i = 0, GetMaxPlayers() - 1 do
			if GetDistancePlayers(playerid, i) <= 4000 then
				SendPlayerMessage(i, 255, 255, 255, txt);         
			end
		end
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 255, 255,"/к (крик)");
	end
	
end
addCommandHandler({"/к"}, CMD_K)