
--  #  Save PI by royclapton  #


function _getIP(id)
	return GetPlayerIP(id);
end

function _getMAC(id)
	return GetMacAddress(id);
end

function _saveInfoPO(id)

	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	local date = rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear;

	local file = io.open("Database/Players/Info/"..GetPlayerName(id)..".txt", "a+");
	if file then
		file:write(GetPlayerName(id).." / IP: ".._getIP(id).." / MAC: ".._getMAC(id).." / Date: "..date.."\n");
		file:close();
	end

end