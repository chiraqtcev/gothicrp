
--  #   Mac system by royclapton  #
--  #         version: 1.0        #


FORUM_MACS = {}

function _saveMac(id)
	
	local file = io.open("Database/Players/Macs/"..GetMacAddress(id),"w+");
	file:write(GetPlayerName(id));
	file:close();

end

function _checkMac(id)
	
	local file = io.open("Database/Players/Macs/"..GetMacAddress(id), "r");
	local trueNick;
	if file then
		line = file:read("*l");
		local result, nick = sscanf(line, "s");
		if result == 1 then
			trueNick = nick;
			if trueNick ~= GetPlayerName(id) then
				ClearChat(id)
				SendPlayerMessage(id, 255, 173, 173, "Уважаемый игрок. В целях безопасности игра на сервере ограничена правилом...")
				SendPlayerMessage(id, 255, 173, 173, "...один аккаунт = один компьютер.");
				SendPlayerMessage(id, 255, 173, 173, "Для продолжения игры укажите никнейм аккаунта, который регистрировался.");
				SendPlayerMessage(id, 248, 252, 179, "На MAC: "..GetMacAddress(id).." зарегистрирован аккаунт: "..trueNick);
				SendPlayerMessage(id, 248, 252, 179, "Текущий никнейм: "..GetPlayerName(id));
				Kick(id);
			end
		end
		file:close();
	end
	
end

function _checkForumMacs(id)

	for i, v in pairs(FORUM_MACS) do
		if GetPlayerName(id) == v then
			table.remove(FORUM_MACS, i);
			_saveMac(id);
			_updateMacForum();
			break
		end
	end

end

function _updateMacForum()

	local file = io.open("Database/Players/Macs/forum_list.txt", "w");
	if file then
		if table.getn(FORUM_MACS) > 0 then
			for i = 1, table.getn(FORUM_MACS) do
				file:write(FORUM_MACS[i].."\n");
			end
		else
			os.remove("Database/Players/Macs/forum_list.txt");
			print(" ");
			print(" ");
			print("All forums accs register");
			print(" ");
			print(" ");
		end
	end

end

function _macForumInit()

	local file = io.open("Database/Players/Macs/forum_list.txt", "r");
	if file then
		for line in file:lines() do
			local result, name = sscanf(line, "s");
			if result == 1 then
				table.insert(FORUM_MACS, name);
			end
		end
		file:close();
	end

end