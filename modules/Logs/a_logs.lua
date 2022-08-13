
--  #   LogsInGame by royclapton  #
--  #         version: 0.3        #




function _checkLogs(id, params)
	
	local result, lname = sscanf(params, "s");
	if result == 1 then
		if lname == "хиты" or lname == "hits" then
			local file = io.open("Logs/Hits/Hits.txt", "r");
			if file then
				local tempArr = {};
				
				for line in file:lines() do 
					local result, str = sscanf(line,"s");
					if result == 1 then
						tempArr[#tempArr+1] = str;
					end
				end
				file:close();
		
				local count = 0
			  	for _ in pairs(tempArr) do 
			  		count = count + 1;
			  	end

			  	if count <= 20 then
			  		for i = 1, count do
			  			SendPlayerMessage(id, 255, 255, 255, tempArr[i]);
			  		end
			  	else
			  		local c = 0;
			  		for i = count, 1, -1 do
			  			if c == 20 then
			  				break
			  			else
			  				c = c + 1;
			  				SendPlayerMessage(id, 255, 255, 255, tempArr[i]);
			  			end
			  		end
			  	end

			else
				SendPlayerMessage(id, 255, 255, 255, "‘айл с логом не создан (или не найден).")
			end

		elseif lname == "drop" or lname == "дроп" then
			local file = io.open("Logs/Drop/Drop.txt", "r");
			if file then

				local tempArr = {};
				
				for line in file:lines() do 
					local result, str = sscanf(line,"s");
					if result == 1 then
						tempArr[#tempArr+1] = str;
					end
				end

				file:close();

				local count = 0
			  	for _ in pairs(tempArr) do 
			  		count = count + 1;
			  	end

			  	if count <= 20 then
			  		for i = 1, count do
			  			SendPlayerMessage(id, 255, 255, 255, tempArr[i]);
			  		end
			  	else
			  		local c = 0;
			  		for i = count, 1, -1 do
			  			if c == 20 then
			  				break
			  			else
			  				c = c + 1;
			  				SendPlayerMessage(id, 255, 255, 255, tempArr[i]);
			  			end
			  		end
			  	end

			else
				SendPlayerMessage(id, 255, 255, 255, "‘айл с логом не создан (или не найден).")
			end

		end
	else
		SendPlayerMessage(id, 255, 255, 255, "/с_лог (название)")
	end
end
addCommandHandler({"/с_лог", "/s_log"}, _checkLogs);
function _checkLogs(id, params)
	
	local result, lname = sscanf(params, "s");
	if result == 1 then
		if lname == "хиты" or lname == "hits" then
			local file = io.open("Logs/Hits/Hits.txt", "r");
			if file then
				local tempArr = {};
				
				for line in file:lines() do 
					local result, str = sscanf(line,"s");
					if result == 1 then
						tempArr[#tempArr+1] = str;
					end
				end
				file:close();
		
				local count = 0
			  	for _ in pairs(tempArr) do 
			  		count = count + 1;
			  	end

			  	if count <= 20 then
			  		for i = 1, count do
			  			SendPlayerMessage(id, 255, 255, 255, tempArr[i]);
			  		end
			  	else
			  		local c = 0;
			  		for i = count, 1, -1 do
			  			if c == 20 then
			  				break
			  			else
			  				c = c + 1;
			  				SendPlayerMessage(id, 255, 255, 255, tempArr[i]);
			  			end
			  		end
			  	end

			else
				SendPlayerMessage(id, 255, 255, 255, "‘айл с логом не создан (или не найден).")
			end

		elseif lname == "drop" or lname == "дроп" then
			local file = io.open("Logs/Drop/Drop.txt", "r");
			if file then

				local tempArr = {};
				
				for line in file:lines() do 
					local result, str = sscanf(line,"s");
					if result == 1 then
						tempArr[#tempArr+1] = str;
					end
				end

				file:close();

				local count = 0
			  	for _ in pairs(tempArr) do 
			  		count = count + 1;
			  	end

			  	if count <= 20 then
			  		for i = 1, count do
			  			SendPlayerMessage(id, 255, 255, 255, tempArr[i]);
			  		end
			  	else
			  		local c = 0;
			  		for i = count, 1, -1 do
			  			if c == 20 then
			  				break
			  			else
			  				c = c + 1;
			  				SendPlayerMessage(id, 255, 255, 255, tempArr[i]);
			  			end
			  		end
			  	end

			else
				SendPlayerMessage(id, 255, 255, 255, "‘айл с логом не создан (или не найден).")
			end

		end
	else
		SendPlayerMessage(id, 255, 255, 255, "/с_лог (название)")
	end
end
addCommandHandler({"/с_лог", "/s_log"}, _checkLogs);
