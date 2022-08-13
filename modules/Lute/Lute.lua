--local Dialog_future = CreateTexture(2245, 5986, 5871, 7854, "inv_back.tga")

for i = 0, MAX_PLAYERS - 1 do
	Player[i].IsLunya = false
	Player[i].IsLunyaMenu = false
end

function ASuka()
	for i = 0, MAX_PLAYERS - 1 do
		Player[i].DialogOpenLn = 1
	end
end

local tbl_lynya = {
{"(1) Сыграть на лютне!"},
{"(ВЫХОД)"}
};

local tbl_gry = {
{"Высокие ноты:"},
{"  1 2 3 4 5 6 7 8 9 0 ' |"},
{"Низкие ноты:"},
{"  Q W E R Y U I O P х ъ"},
{"  A S D F G H J K L ;"},
{"	Чтобы закончить, нажмите Z"},
};

local sound_id1 = CreateSound("LUTE_PLAY_1.WAV")
local sound_id2 = CreateSound("LUTE_PLAY_2.WAV")
local sound_id3 = CreateSound("LUTE_PLAY_3.WAV")
local sound_id4 = CreateSound("LUTE_PLAY_4.WAV")
local sound_id5 = CreateSound("LUTE_PLAY_5.WAV")
local sound_id6 = CreateSound("LUTE_PLAY_6.WAV")
local sound_id7 = CreateSound("LUTE_PLAY_7.WAV")
local sound_id8 = CreateSound("LUTE_PLAY_8.WAV")
local sound_id9 = CreateSound("LUTE_PLAY_9.WAV")
local sound_id0 = CreateSound("LUTE_PLAY_0.WAV")
local sound_id_l = CreateSound("LUTE_PLAY_[.WAV")
local sound_id_r = CreateSound("LUTE_PLAY_].WAV")
local sound_id_back = CreateSound("LUTE_PLAY_BACKSLASH.WAV")
local sound_id_ai = CreateSound("LUTE_PLAY_'.WAV")
local sound_id_ji = CreateSound("LUTE_PLAY_;.WAV")
local sound_idq = CreateSound("LUTE_PLAY_Q.WAV")
local sound_idw = CreateSound("LUTE_PLAY_W.WAV")
local sound_ide = CreateSound("LUTE_PLAY_E.WAV")
local sound_idr = CreateSound("LUTE_PLAY_R.WAV")
local sound_idy = CreateSound("LUTE_PLAY_Y.WAV")
local sound_idu = CreateSound("LUTE_PLAY_U.WAV")
local sound_idi = CreateSound("LUTE_PLAY_I.WAV")
local sound_ido = CreateSound("LUTE_PLAY_O.WAV")
local sound_idp = CreateSound("LUTE_PLAY_P.WAV")
local sound_ida = CreateSound("LUTE_PLAY_A.WAV")
local sound_ids = CreateSound("LUTE_PLAY_S.WAV")
local sound_idd = CreateSound("LUTE_PLAY_D.WAV")
local sound_idf = CreateSound("LUTE_PLAY_F.WAV")
local sound_idg = CreateSound("LUTE_PLAY_G.WAV")
local sound_idh = CreateSound("LUTE_PLAY_H.WAV")
local sound_idj = CreateSound("LUTE_PLAY_J.WAV")
local sound_idk = CreateSound("LUTE_PLAY_K.WAV")
local sound_idl = CreateSound("LUTE_PLAY_L.WAV")

createGUIMenu("LUTNYA_MENU", tbl_lynya, 255, 255, 255, 255, 255, 0, 2445, 6186, "Font_Old_10_White_Hi.TGA", CreateTexture(2245, 5986, 5871, 7854, "inv_back.tga"), 2);
createGUIMenu("LUTNYA_GRY", tbl_gry, 255, 255, 0, 255, 255, 0, 5955, 3630, "Font_Old_10_White_Hi.TGA", nil, 6);

function LunyaUsed(playerid, itemInstance, amount, hand)
	if itemInstance == "AIXOPT_ITMI_LUTE" then
		CloseInventory(playerid)
		showGUIMenu(playerid, "LUTNYA_MENU", 250);
		FreezePlayer(playerid, 1)
		Player[playerid].IsLunyaMenu = true
		--ShowTexture(playerid, Dialog_future)
	end
end

function Lutnya(playerid, keydown, keyup)
	if Player[playerid].IsLunyaMenu == true then
		if keydown == KEY_UP then
			switchGUIMenuUp(playerid, "LUTNYA_MENU", 250);
		elseif keydown == KEY_DOWN then
			switchGUIMenuDown(playerid, "LUTNYA_MENU", 250);
		elseif keydown == KEY_RETURN then
			if getPlayerOptionID(playerid, "LUTNYA_MENU") == 1 then
				hideGUIMenu(playerid, "LUTNYA_MENU");
				Player[playerid].IsLunya = true
				Player[playerid].IsLunyaMenu = false
				PlayAnimation(playerid, "T_LUTE_S0_2_S1")
				showGUIMenu(playerid, "LUTNYA_GRY", 250);
			elseif getPlayerOptionID(playerid, "LUTNYA_MENU") == 2 then
				hideGUIMenu(playerid, "LUTNYA_MENU");
				Player[playerid].IsLunyaMenu = false
				FreezePlayer(playerid, 0)
			end
		end
	elseif Player[playerid].IsLunya == true then
		local x, y, z = GetPlayerPos(playerid)
		if keydown == KEY_Z then
			Player[playerid].IsLunya = false
			PlayAnimation(playerid, "T_LUTE_S1_2_S0")
			hideGUIMenu(playerid, "LUTNYA_GRY");
			FreezePlayer(playerid, 0)
		elseif keydown == KEY_1 then
       PlayPlayerSound3D(playerid, sound_id1, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_2 then
        PlayPlayerSound3D(playerid, sound_id2, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_3 then

        PlayPlayerSound3D(playerid, sound_id3, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_4 then

        PlayPlayerSound3D(playerid, sound_id4, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_5 then

        PlayPlayerSound3D(playerid, sound_id5, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_6 then

        PlayPlayerSound3D(playerid, sound_id6, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_7 then

        PlayPlayerSound3D(playerid, sound_id7, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_8 then

         PlayPlayerSound3D(playerid, sound_id8, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_9 then

         PlayPlayerSound3D(playerid, sound_id9, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_0 then

        PlayPlayerSound3D(playerid, sound_id0, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_BACKSLASH then

        PlayPlayerSound3D(playerid, sound_id_back, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_APOSTROPHE then

        PlayPlayerSound3D(playerid, sound_id_ai, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_Q then

        PlayPlayerSound3D(playerid, sound_idq, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_W then

        PlayPlayerSound3D(playerid, sound_idw, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_E then

        PlayPlayerSound3D(playerid, sound_ide, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_R then

        PlayPlayerSound3D(playerid, sound_idr, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_Y then

        PlayPlayerSound3D(playerid, sound_idy, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_U then

        PlayPlayerSound3D(playerid, sound_idu, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_I then

         PlayPlayerSound3D(playerid, sound_idi, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_O then

        PlayPlayerSound3D(playerid, sound_ido, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_P then

        PlayPlayerSound3D(playerid, sound_idp, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_LBRACKET then

         PlayPlayerSound3D(playerid, sound_id_l, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_RBRACKET then

          PlayPlayerSound3D(playerid, sound_id_r, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_A then

         PlayPlayerSound3D(playerid, sound_ida, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_S then

       PlayPlayerSound3D(playerid, sound_ids, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_D then

         PlayPlayerSound3D(playerid, sound_idd, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_F then

        PlayPlayerSound3D(playerid, sound_idf, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_G then

        PlayPlayerSound3D(playerid, sound_idg, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_H then

         PlayPlayerSound3D(playerid, sound_idh, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_J then

         PlayPlayerSound3D(playerid, sound_idj, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_K then

        PlayPlayerSound3D(playerid, sound_idk, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_L then

         PlayPlayerSound3D(playerid, sound_idl, x, y, z, 2100)
		--DestroySound(sound_id)
		elseif keydown == KEY_SEMICOLON then

        PlayPlayerSound3D(playerid, sound_id_ji, x, y, z, 2100)
		--DestroySound(sound_id)
		end
	end
end