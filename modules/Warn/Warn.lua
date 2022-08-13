
--  #  Warn system by royclapton  #
--  #         version: 1.0        #


function _getWarns(id)
	return Player[id].warns;
end

function _newWarn(id, sets)
	
	if Player[id].astatus > 0 then
		local result, pid, reason = sscanf(sets, "ds");
		if result == 1 then
			if Player[pid].loggedIn == true and IsPlayerConnected(pid) == 1 then

				Player[pid].warns = Player[pid].warns + 1;
				if Player[pid].warns < 3 then
					SendPlayerMessage(pid, 255, 255, 255, "Администратор "..Player[id].nickname.." выдал вам предупреждение по причине "..reason);
					SendPlayerMessage(pid, 255, 255, 255, "При достижении 3х предупреждений вы будете забанены. Текущее кол-во: "..Player[pid].warns);
					_saveWarn(pid);

					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 0 then
							SendPlayerMessage(i, 255, 255, 255, "Администратор "..Player[id].nickname.." выдал предупреждение "..Player[pid].nickname.." по причине "..reason);
						end
					end

				elseif Player[pid].warns > 2 then
					SendPlayerMessage(pid, 255, 255, 255, "Администратор "..Player[id].nickname.." выдал вам предупреждение по причине "..reason);
					SendPlayerMessage(pid, 255, 255, 255, "Вы забанены на сервере. Текущее кол-во предупреждений: "..Player[pid].warns);
					Player[pid].warns = 0;
					_saveWarn(pid);

					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 0 then
							SendPlayerMessage(i, 255, 255, 255, "Администратор "..Player[id].nickname.." выдал предупреждение "..Player[pid].nickname.." по причине "..reason);
						end
					end

					Ban(pid);
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизован или не найден.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/варн (ид) (причина)")
		end
	end

end
addCommandHandler({"/варн", "/warn"}, _newWarn);

function _saveWarn(id)

	local file = io.open("Database/Players/Warns/"..Player[id].nickname..".txt", "w");
	file:write(Player[id].warns);
	file:close();

end

function _readWarn(id);

	local file = io.open("Database/Players/Warns/"..Player[id].nickname..".txt", "r");
	if file then

		line = file:read("*l");
		local result, n = sscanf(line, "d");
		if result == 1 then
			Player[id].warns = n;
		end

		file:close();

	else
		_saveWarn(id);
	end

end