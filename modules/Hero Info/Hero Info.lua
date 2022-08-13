
--  #   Hero info by royclapton   #
--  #        version: 1.0         #

function _heroInfoConnect(id)
	
	Player[id]._heroinfo_open = false;

	Player[id]._heroinfo_main_draws = {};
	Player[id]._heroinfo_main_draws[1] = CreatePlayerDraw(id, 6925, 390, "����", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[id]._heroinfo_main_draws[2] = CreatePlayerDraw(id, 6886, 2410, "���-��", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[id]._heroinfo_main_draws[3] = CreatePlayerDraw(id, 6856, 4810, "������", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[id]._heroinfo_main_draws[4] = CreatePlayerDraw(id, 5160, 390, "�����", "Font_Old_20_White_Hi.TGA", 255, 255, 255);

	Player[id]._heroinfo_title_1_draws = {}; -- ����
	for i = 1, 9 do
		Player[id]._heroinfo_title_1_draws[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	Player[id]._heroinfo_title_2_draws = {}; -- �����
	for i = 1, 9 do
		Player[id]._heroinfo_title_2_draws[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	Player[id]._heroinfo_title_3_draws = {}; -- ������
	for i = 1, 9 do
		Player[id]._heroinfo_title_3_draws[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	Player[id]._heroinfo_title_4_draws = {}; -- �����
	for i = 1, 10 do
		Player[id]._heroinfo_title_4_draws[i] = CreatePlayerDraw(id, 0, 0, "");
	end


	Player[id]._heroinfo_tex = {};
	Player[id]._heroinfo_tex[1] = CreateTexture(6353, 101, 8067, 7180, 'menu_ingame')
	Player[id]._heroinfo_tex[2] = CreateTexture(4595, 154, 6301, 3043, 'menu_ingame')

end

function _heroKey(id, down, up)

	if Player[id].loggedIn == true then

		if down == KEY_V then
			_heroMenu(id);
		end

	end

end

function _heroMenu(id)
	
	if Player[id]._heroinfo_open == false then


		for i = 1, table.getn(Player[id]._heroinfo_tex) do
			ShowTexture(id, Player[id]._heroinfo_tex[i])
		end

		for i = 1, table.getn(Player[id]._heroinfo_main_draws) do
			ShowPlayerDraw(id, Player[id]._heroinfo_main_draws[i]);
		end

		for i = 1, table.getn(Player[id]._heroinfo_title_1_draws) do
			ShowPlayerDraw(id, Player[id]._heroinfo_title_1_draws[i]);
		end

		for i = 1, table.getn(Player[id]._heroinfo_title_2_draws) do
			ShowPlayerDraw(id, Player[id]._heroinfo_title_2_draws[i]);
		end

		for i = 1, table.getn(Player[id]._heroinfo_title_3_draws) do
			ShowPlayerDraw(id, Player[id]._heroinfo_title_3_draws[i]);
		end

		for i = 1, table.getn(Player[id]._heroinfo_title_4_draws) do
			ShowPlayerDraw(id, Player[id]._heroinfo_title_4_draws[i]);
		end

		_updateHeroMenu(id);

		Player[id]._heroinfo_open = true;
	else

		for i = 1, table.getn(Player[id]._heroinfo_tex) do
			HideTexture(id, Player[id]._heroinfo_tex[i])
		end

		for i = 1, table.getn(Player[id]._heroinfo_main_draws) do
			HidePlayerDraw(id, Player[id]._heroinfo_main_draws[i]);
		end

		for i = 1, table.getn(Player[id]._heroinfo_title_1_draws) do
			HidePlayerDraw(id, Player[id]._heroinfo_title_1_draws[i]);
		end

		for i = 1, table.getn(Player[id]._heroinfo_title_2_draws) do
			HidePlayerDraw(id, Player[id]._heroinfo_title_2_draws[i]);
		end

		for i = 1, table.getn(Player[id]._heroinfo_title_3_draws) do
			HidePlayerDraw(id, Player[id]._heroinfo_title_3_draws[i]);
		end

		for i = 1, table.getn(Player[id]._heroinfo_title_4_draws) do
			HidePlayerDraw(id, Player[id]._heroinfo_title_4_draws[i]);
		end

		Player[id]._heroinfo_open = false;
	end

end

function _updateHeroMenu(id)

	-- title 1
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[1], 6460, 840,  string.format("%s%s", "�������: ",Player[id].nickname), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[2], 6460, 1040, string.format("%s%d", "���������� ����: ",Player[id].rude), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[3], 6460, 1240, string.format("%s%d", "���������� �����: ",Player[id].rude_coins), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[4], 6460, 1440, string.format("%s%d", "������� ��: ",GetPlayerHealth(id)), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[5], 6460, 1640, string.format("%s%d%s%d", "������� ��: ",GetPlayerMana(id)," / ����: ",GetPlayerMagicLevel(id)), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[6], 6460, 1840, string.format("%s%d%s", "������� �������: ",Player[id].energy," / 100"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[7], 6460, 2040, string.format("%s%d", "����� �������: ",100 - Player[id].energyblock), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[8], 6460, 2240, "------------------------------", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	-- title 2
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[1], 6460, 2860,  string.format("%s%d", "����: ",Player[id].str), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[2], 6460, 3060,  string.format("%s%d", "��������: ",Player[id].dex), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[3], 6460, 3260,  string.format("%s%d", "����. ��: ",Player[id].hp), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[4], 6460, 3460,  string.format("%s%d", "����. ��: ",Player[id].mp), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[5], 6460, 3860,  string.format("%s%d", "����������: ",Player[id].h1), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[6], 6460, 4060,  string.format("%s%d", "���������: ",Player[id].h2), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[7], 6460, 4260,  string.format("%s%d", "���: ",Player[id].bow), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[8], 6460, 4460,  string.format("%s%d", "�������: ",Player[id].cbow), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[9], 6460, 4660,  "------------------------------", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	-- title 3 
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[1],	6460, 5160,  string.format("%s%d%s", "�������: ",Player[id].huntlevel," / 3"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[2], 6460, 5360,  string.format("%s%s%s", "������ �������: ",Player[id].readscrolls," / 1"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[3], 6460, 5560,  string.format("%s%s%s", "�������: ",GetScienceLevel(id, "�������")," / 3"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[4], 6460, 5760,  string.format("%s%s%s", "�����: ",GetScienceLevel(id, "�����")," / 3"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[5], 6460, 5960,  string.format("%s%s%s", "�������: ",GetScienceLevel(id, "�������")," / 3"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[6], 6460, 6160,  string.format("%s%s%s", "�������: ",GetScienceLevel(id, "�������")," / 3"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[7], 6460, 6360,  string.format("%s%s%s", "�������: ",GetScienceLevel(id, "�������")," / 3"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[8], 6460, 6560,  string.format("%s%s%s", "���������: ",GetScienceLevel(id, "���������")," / 3"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[9], 6460, 6760,  string.format("%s%s%s", "��������: ",GetScienceLevel(id, "��������")," / 3"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	-- title 4
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[1],	4700, 840,  string.format("%s%d", "������: ",Player[id]._language_orcs), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[2],	4700, 1040,  string.format("%s%d", "������: ",Player[id]._language_yarkendar), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[3],	4700, 1240,  string.format("%s%d", "������� ��������: ",Player[id]._language_temoris), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[4],	4700, 1440,  string.format("%s%d", "���������: ",Player[id]._language_gatia), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[5],	4700, 1640,  string.format("%s%d", "����� ��������: ",Player[id]._language_afro), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[6],	4700, 1840,  string.format("%s%d", "������������: ",Player[id]._language_demon), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[7],	4700, 2040,  string.format("%s%d", "������: ",Player[id]._language_waran), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[8],	4700, 2240,  string.format("%s%d", "����������: ",Player[id]._language_warant), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[9],	4700, 2440,  string.format("%s%d", "�����������: ",Player[id]._language_nord), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[10], 4700, 2640,  string.format("%s%d", "����������: ",Player[id]._language_myrtana), "Font_Old_10_White_Hi.TGA", 255, 255, 255);



end