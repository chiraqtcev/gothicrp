-- Макросы для удобства 
function SSM(playerid, args)
	SendPlayerMessage(playerid, 243, 234, 111, "> "..args);
end

function SEM(playerid, args)
	SendPlayerMessage(playerid, 255, 0, 0, "> "..args);
end

function SYNM(playerid, args)
	SendPlayerMessage(playerid, 158, 158, 158, "> "..args);
end

function SAM(args)
	for i = 0, GetMaxPlayers() do 
		if CheckConnected(i) == true and Player[i].astatus > 0 and Player[i].aduty then
			SendPlayerMessage(i, 222, 94, 94, "> "..args);
		end
	end
end

function CheckConnected(playerid)
	if Player[playerid].loggedIn == true and IsPlayerConnected(playerid) == 1 then
		return true;
	else
		return false;
	end
end

function CheckAdmin(playerid, lvl)
	if Player[playerid].aduty ~= true then
		SEM(playerid, "Активируйте админ права (/адути)");
		return false;
	end

	if Player[playerid].astatus >= lvl then
		return true;
	else
		SEM(playerid, "У вас нет доступа для использования данной команды.");
		SYNM(playerid, "Ваш уровень доступа: "..Player[playerid].astatus..", необходим: "..lvl);
		return false;
	end
end

function ac_SetPlayerHealth(playerid, value)
	if CheckConnected(playerid) == true then
		_offAC(playerid);
		SetPlayerHealth(playerid, value);
		_onAC(playerid);
	end
end
