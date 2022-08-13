
--  # AC stats (attributes) (files) by royclapton #
--  #                version: 0.1                 #
--  #                    lite                     #

-- в логин и в рег

function _ac_att_connect(id)
	Player[id]._ac_stats = false;
end

function _onAC(id)
	Player[id]._ac_stats = true;
end

function _offAC(id)
	Player[id]._ac_stats = false;
end

function _ac_ChangeStrength(id, newValue, oldValue)

	--[[if newValue ~= oldValue then
	
		if IsNPC(id) == 0 then
			if Player[id].loggedIn == true then
				local time = os.date('*t');
			    local ryear = time.year;
				local rmonth = time.month;
				local rday = time.day;
				local rhour = string.format("%02d", time.hour);
				local rminute = string.format("%02d", time.min);

				if Player[id]._ac_stats == true then
					LogString("Logs/AC/ac_att", Player[id].nickname.." изменил силу до "..newValue..", имея в БД: "..Player[id].str.." ("..oldValue..") / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);
					SendPlayerMessage(id, 255, 255, 255, "Обнаружено несовпадение в параметре силы персонажа! Значение по БД: "..Player[id].str.." / В игре: "..newValue);
					SendPlayerMessage(id, 255, 255, 255, "Вы забанены до выяснения ситуации.")
					for i = 0, GetMaxPlayers() do
						SendPlayerMessage(i, 247, 77, 77, Player[id].nickname.." забанен за использование читов (изменение характеристик - сила).");
					end
					Ban(id);
				end
			end
		end

	end]]


end

function _ac_ChangeDexterity(id, newValue, oldValue)

	--[[if newValue ~= oldValue then
		
		if IsNPC(id) == 0 then
			if Player[id].loggedIn == true then
				local time = os.date('*t');
			    local ryear = time.year;
				local rmonth = time.month;
				local rday = time.day;
				local rhour = string.format("%02d", time.hour);
				local rminute = string.format("%02d", time.min);

				if Player[id]._ac_stats == true then
					LogString("Logs/AC/ac_att", Player[id].nickname.." изменил ловкость до "..newValue..", имея в БД: "..Player[id].dex.." ("..oldValue..") / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);
					SendPlayerMessage(id, 255, 255, 255, "Обнаружено несовпадение в параметре ловкости персонажа! Значение по БД: "..Player[id].dex.." / В игре: "..newValue);
					SendPlayerMessage(id, 255, 255, 255, "Вы забанены до выяснения ситуации.")
					for i = 0, GetMaxPlayers() do
						SendPlayerMessage(i, 247, 77, 77, Player[id].nickname.." забанен за использование читов (изменение характеристик - ловкость).");
					end
					Ban(id);
				end
			end
		end

	end]]

end

function _ac_ChangeAcrobatic(id, newValue, oldValue)

	--[[if newValue ~= oldValue then
	
		if IsNPC(id) == 0 then
			if Player[id].loggedIn == true then
				local time = os.date('*t');
			    local ryear = time.year;
				local rmonth = time.month;
				local rday = time.day;
				local rhour = string.format("%02d", time.hour);
				local rminute = string.format("%02d", time.min);

				if Player[id]._ac_stats == true then
					LogString("Logs/AC/ac_att", Player[id].nickname.." получил навык акробатики. / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);
					SendPlayerMessage(id, 255, 255, 255, "Обнаружен навык акробатики (на сервере запрещен).");
					SendPlayerMessage(id, 255, 255, 255, "Вы забанены до выяснения ситуации.")
					for i = 0, GetMaxPlayers() do
						SendPlayerMessage(i, 247, 77, 77, Player[id].nickname.." забанен за использование читов (получение акробатики).");
					end
					Ban(id);
				end
			end
		end
	
	end]]

end