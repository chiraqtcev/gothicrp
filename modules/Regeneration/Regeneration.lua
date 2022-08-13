
--  #  Regeneration system by royclapton  #
--  #             version: 1.0            #

function _onBedConnect(id)
	Player[id]._useBed = false;
end

function _onBed(id, scheme, on, used)

	if scheme == "BED_FRONT" or scheme == "BED_BACK" then

		if used == 1 then

			Player[id]._useBed = true;
			local hpLimit = GetPlayerMaxHealth(id) / 2;
			if GetPlayerHealth(id) < hpLimit then
				SendPlayerMessage(id, 255, 255, 255, "Вы легли в кровать. Началась регенерация ХП.")
			end

		else

			Player[id]._useBed = false;
			local hpLimit = GetPlayerMaxHealth(id) / 2;
			if GetPlayerHealth(id) < hpLimit then
				SendPlayerMessage(id, 255, 255, 255, "Вы встали с кровати. Регенерация завершена.")
			end

		end

	end


	if scheme == "BEDHIGH_FRONT" or scheme == "BEDHIGH_BACK" then

		if used == 1 then

			Player[id]._useBed = true;
			local hpLimit = GetPlayerMaxHealth(id) / 2;
			if GetPlayerHealth(id) < hpLimit then
				SendPlayerMessage(id, 255, 255, 255, "Вы легли в кровать. Началась регенерация ХП.")
			end

		else

			Player[id]._useBed = false;
			local hpLimit = GetPlayerMaxHealth(id) / 2;
			if GetPlayerHealth(id) < hpLimit then
				SendPlayerMessage(id, 255, 255, 255, "Вы встали с кровати. Регенерация завершена.")
			end

		end

	end


end

function _bedRegen()

	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true and GetPlayerHealth(i) > 0 then
			if Player[i]._useBed == true then
				local hpLimit = GetPlayerMaxHealth(i) / 2;
				if GetPlayerHealth(i) < hpLimit then
					SetPlayerHealth(i, GetPlayerHealth(i) + 1);
				end
			end
		end
	end

end
SetTimer(_bedRegen, 10000, 1);