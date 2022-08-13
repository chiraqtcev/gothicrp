
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
			txt = "����������� "..msg;
		end
		
		for i = 0, GetMaxPlayers() - 1 do
			if GetDistancePlayers(playerid,i) <= 1500 then
				SendPlayerMessage(i, 194,162,218, txt);         
			end
		end
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/� (�������� �� ������� ����)");
	end
end
addCommandHandler({"/�"}, CMD_ME)


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
				txt = "(( �����������: "..msg.." ))";
			end
		
			for i = 0, GetMaxPlayers() - 1 do
				if GetDistancePlayers(playerid, i) <= 1500 then
					SendPlayerMessage(i, 160, 160, 160, txt);         
				end
			end
			LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "���-��� �������� ��������������.")
		end
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/� (��� ����������)");
	end
	
end
addCommandHandler({"/�"}, CMD_OOC)



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
			txt = msg.." (�����������)";
		end
	
		for i = 0, GetMaxPlayers() - 1 do
			if GetDistancePlayers(playerid, i) <= 2000 then
				SendPlayerMessage(i, 194,162,218, txt);         
			end
		end
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/�� (������� ����������)");
	end

end
addCommandHandler({"/��"}, CMD_DO)

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
	    local txt = "(����� ��������� "..GetPlayerName(playerid)..") "..msg;

		for i = 0, GetMaxPlayers() do
			if GetDistancePlayers(playerid, i) <= 1400 and Player[i].astatus > 0 then
				SendPlayerMessage(i, 210, 217, 169, txt);      
			end
		end
		SendPlayerMessage(playerid, 210, 217, 169, txt);
		
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/� (�����)");
	end
		
end
addCommandHandler({"/�"}, CMD_M)


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
			txt = GetPlayerName(playerid).." ������: "..msg;
		else
			txt = "����������� ������: "..msg;
		end
		
		for i = 0, GetMaxPlayers() - 1 do
			if GetDistancePlayers(playerid, i) <= 300 then
				SendPlayerMessage(i, 255, 255, 0, txt);         
			end
		end
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/� (�����)");
	end

end
addCommandHandler({"/�"}, CMD_SH)

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
			txt = GetPlayerName(playerid).." �������: "..msg;
		else
			txt = "����������� �������: "..msg;
		end
		
		
		for i = 0, GetMaxPlayers() - 1 do
			if GetDistancePlayers(playerid, i) <= 4000 then
				SendPlayerMessage(i, 255, 255, 255, txt);         
			end
		end
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 255, 255,"/� (����)");
	end
	
end
addCommandHandler({"/�"}, CMD_K)