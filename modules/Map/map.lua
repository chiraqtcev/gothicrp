
--  #  Hero system by Osmith  #

local MapTexture = CreateTexture(700, 100, 8100, 8300, 'MAP_NEWWORLD_CAVES');
local PktX = 4220;
local PktZ = 3800; -- 4392

function _InitMap()
	SetTimer("UpdateMap", 2000, 1);
end

function _playerMap(playerid) 
	Player[playerid].MapOn = false;
	Player[playerid].Pkt = CreateDraw(0, 0, " ", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[playerid].Name = CreateDraw(0, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	Player[playerid].tPkt = CreateDraw(0, 0, " ", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[playerid].tName = CreateDraw(0, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
end

function _openMap(id)

	if Player[id].astatus > 1 then

		if Player[id].MapOn == false then

			Player[id].MapOn = true;
			--ShowTexture(id, MapTexture);
			for i = 0, GetMaxPlayers() do
				if IsPlayerConnected(i) == 1 then
					ShowDraw(id, Player[i].Pkt);
					ShowDraw(id, Player[i].Name);
				end
			end

		else

			Player[id].MapOn = false;
			--HideTexture(id, MapTexture);
			for i = 0, GetMaxPlayers() do
				if IsPlayerConnected(i) == 1 then
					HideDraw(id, Player[i].Pkt);
					HideDraw(id, Player[i].Name);
				end
			end
		end

	end
end


function UpdateMap(playerid)
for i = 0, GetMaxPlayers() - 1 do
	if IsPlayerConnected(i) == 1 then
		local x, y, z = GetPlayerPos(i);
		UpdateDraw(Player[i].Pkt, (x/28) + PktX, PktZ - (z/28), "+", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
		UpdateDraw(Player[i].Name, (x/28) + PktX + 100, PktZ - (z/28), ""..GetPlayerName(i).."", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		tUpdateMap(i);
	end
end
end

function tUpdateMap(playerid)
local tx, ty, tz = GetPlayerPos(playerid);
UpdateDraw(Player[playerid].tPkt, (tx/28) + PktX, PktZ - (tz/28), "+", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
UpdateDraw(Player[playerid].tName, (tx/28) + PktX + 100, PktZ - (tz/28), ""..GetPlayerName(playerid).."", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
end