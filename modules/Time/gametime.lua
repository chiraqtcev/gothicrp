
timebc = CreateTexture(6855, 7225, 8215, 8193, 'dlg_conversation')

function TTable(playerid)

	ShowPlayerDraw(playerid, gtdraw);
	ShowPlayerDraw(playerid, rtdraw);
	ShowPlayerDraw(playerid, datedraw);
	ShowTexture(playerid, timebc);

end

function UpdateTTable(playerid)

	-- game
	local hour, minute = GetTime();
    local gh = string.format("%02d",hour);
    local gm = string.format("%02d",minute);
    local gt = "Game time: "..gh..":"..gm
	UpdatePlayerDraw(playerid, gtdraw, 6936, 7583, gt, "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	-- real time/date
	time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	local rt = "Real time: "..rhour..":"..rminute;
	local rd = "Date: "..rday.."."..rmonth.."."..ryear;
	UpdatePlayerDraw(playerid, rtdraw, 6936, 7383, rt, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(playerid, datedraw, 6936, 7783, rd, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	
end