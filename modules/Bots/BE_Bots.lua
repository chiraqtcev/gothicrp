function InitMobs() -- ������� ����� �� ������� ����.

	addMonster("SCAVENGER", {
	ai = "ANIMAL", -- ���� ������ ��������, �� ai ��������� �����. ���� ������� (�������), �� ������ 1H ��� 2H.
	name = "���������", -- ���, ������� ����� � ����.
	instance = "SCAVENGER", -- ���������.
	str = 7, -- ����
	dex = 7, -- ��������
	hp = 100, -- ��
	min_dist = 400, -- ���������, ����� ��� ������� ���� �����
	max_dist = 600, -- ���������, ����� ��� ������ ���, � ����� �������
	respawn = 10000, -- ������� (��� �����, ��� ������ ��� �����������. �������� �����, ������� ��� �������, ����� ���������� �� 2)
	blow_time = 2, }); -- ��� �����. ���������� ���.

	addMonster("WOLF", {
	ai = "ANIMAL",
	name = "����",
	instance = "WOLF",
	str = 10,
	dex = 10,
	hp = 120,
	min_dist = 400,
	max_dist = 600,
	respawn = 10000,
	blow_time = 2, });
	
	addMonster("MMMWISP", 
	{
		ai = "ANIMAL",
		name = "������",
		instance = "WISP",
		str = 5,
		dex = 5,
		skill_1h = 0,
		skill_2h = 0,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 3,
		hp = 50,
		mp = 0,
		exp = 0,
		min_dist = 0,
		max_dist = 0,
		respawn = 1204,
		blow_time = 2,
	});

addMonster("MMMBLOODFLY",
{
	ai = "ANIMAL",
	name = "��������-����",
	instance = "BLOODFLY",
	str = 8,
	dex = 8,
	hp = 80,
	min_dist = 400,
	max_dist = 600,
	respawn = 10000,
	blow_time = 2,
});

addMonster("MMMKABAN", 
{
	ai = "ANIMAL",
	name = "�����",
	instance = "KEILER",
	str = 15,
	dex = 15,
	hp = 120,
	min_dist = 250,
	max_dist = 700,
	respawn = 10000,
	blow_time = 2,
});

addMonster("MMMBUG", 
{
	ai = "ANIMAL",
	name = "�������-���",
	instance = "GIANT_BUG",
	str = 10,
	dex = 10,
	hp = 150,
	min_dist = 250,
	max_dist = 700,
	respawn = 10000,
	blow_time = 2,
});


addMonster("MMMSCAVENGERL", 
{
	ai = "ANIMAL",
	name = "�������-���������",
	instance = "SCAVENGER",
	str = 5,
	dex = 5,
	hp = 40,
	min_dist = 200,
	max_dist = 700,
	respawn = 10000,
	blow_time = 2,
});

addMonster("MMMWOLFL", 
{
	ai = "ANIMAL",
	name = "�������-����",
	instance = "WOLF",
	str = 5,
	dex = 5,
	hp = 70,
	min_dist = 250,
	max_dist = 700,
	respawn = 10000,
	blow_time = 2,
});

addMonster("MMMMINECRAWLERWARRIOR", 
{
	ai = "ANIMAL",
	name = "������-����",
	instance = "MINECRAWLERWARRIOR",
	str = 40,
	dex = 40,
	hp = 350,
	mp = 0,
	exp = 0,
	min_dist = 250,
	max_dist = 700,
	respawn = 10000,
	blow_time = 2,
});

addMonster("MMMBLATTCRAWLER", 
{
	ai = "ANIMAL",
	name = "�������",
	instance = "BLATTCRAWLER",
	str = 40,
	dex = 40,
	hp = 350,
	mp = 0,
	exp = 0,
	min_dist = 250,
	max_dist = 700,
	respawn = 10000,
	blow_time = 2,
});

addMonster("MMMMINECRAWLER", 
{
	ai = "ANIMAL",
	name = "������",
	instance = "MINECRAWLER",
	str = 25,
	dex = 25,
	hp = 180,
	mp = 0,
	exp = 0,
	min_dist = 250,
	max_dist = 700,
	respawn = 10000,
	blow_time = 2,
});

addMonster("MMMMOLERAT", 
{
	ai = "ANIMAL",
	name = "���������",
	instance = "MOLERAT",
	str = 8,
	dex = 8,
	hp = 90,
	mp = 0,
	exp = 0,
	min_dist = 250,
	max_dist = 700,
	respawn = 10000,
	blow_time = 2,
});

addMonster("MMMMKRISA", 
{
	ai = "ANIMAL",
	name = "�����",
	instance = "GIANT_RAT",
	str = 5,
	dex = 5,
	hp = 50,
	mp = 0,
	exp = 0,
	min_dist = 250,
	max_dist = 700,
	respawn = 10000,
	blow_time = 2,
});

addMonster("MMMLURKER", 
{
	ai = "ANIMAL",
	name = "������",
	instance = "LURKER",
	str = 15,
	dex = 15,
	lvl = 3,
	hp = 130,
	mp = 0,
	exp = 0,
	min_dist = 250,
	max_dist = 700,
	respawn = 10000,
	blow_time = 2,
});

addMonster("MMMZOMBIE", 
{
	ai = "ANIMAL",
	name = "�����",
	instance = "ZOMBIE01",
	str = 25,
	dex = 25,
	hp = 250,
	mp = 0,
	exp = 0,
	min_dist = 250,
	max_dist = 700,
	respawn = 10000,
	blow_time = 2,
});

addMonster("MMM1HBANDIT",
    {
        ai = "1H",
        name = "������",
        instance = "PC_HERO",
        str = 20,
        dex = 20,
        hp = 200,
        min_dist = 250,
        max_dist = 900,
        respawn = 10000,
        blow_time = 1,
		skill_1h = 30,
		armor = "huzvui_itar_bdt_m",
		weapon = "gkwqdz_itmw_nagelkeule",
    });

addMonster("MMM2HBANDIT",
    {
        ai = "2H",
        name = "���������",
        instance = "PC_HERO",
        str = 30,
        dex = 30,
        hp = 350,
        min_dist = 250,
        max_dist = 900,
        respawn = 10000,
        blow_time = 1,
		skill_1h = 30,
		skill_2h = 30,
		armor = "huzvui_itar_bdt_h",
		weapon = "gkwqdz_itmw_2h_sld_sword",
    });

	addMonster("MMMWARG", 
	{
		ai = "ANIMAL",
		name = "����",
		instance = "WARG",
		str = 45,
		dex = 45,
		hp = 300,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMWARAN", 
	{
		ai = "ANIMAL",
		name = "�����",
		instance = "WARAN",
		str = 16,
		dex = 16,
		hp = 130,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMTROLL", 
	{
		ai = "ANIMAL",
		name = "������",
		instance = "TROLL",
		str = 50,
		dex = 50,
		hp = 800,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMTROLL_BLACK", 
	{
		ai = "ANIMAL",
		name = "������-������",
		instance = "TROLL_BLACK",
		str = 100,
		dex = 100,
		hp = 1600,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMSHEEP", 
	{
		ai = "ANIMAL",
		name = "����",
		instance = "SHEEP",
		str = 0,
		dex = 0,
		skill_1h = 0,
		skill_2h = 0,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 0,
		hp = 99999,
		mp = 0,
		exp = 0,
		min_dist = 0,
		max_dist = 0,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMDRAGONSNAPPER", 
	{
		ai = "ANIMAL",
		name = "���������-�������",
		instance = "DRAGONSNAPPER",
		str = 30,
		dex = 30,
		hp = 270,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMSNAPPER", 
	{
		ai = "ANIMAL",
		name = "�����",
		instance = "SNAPPER",
		str = 20,
		dex = 20,
		hp = 170,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMHARPIE", 
	{
		ai = "ANIMAL",
		name = "������",
		instance = "HARPIE",
		str = 25,
		dex = 25,
		skill_1h = 0,
		skill_2h = 0,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 5,
		hp = 200,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

		addMonster("MMMBAT", 
	{
		ai = "ANIMAL",
		name = "������� ����",
		instance = "BAT",
		str = 25,
		dex = 25,
		skill_1h = 0,
		skill_2h = 0,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 5,
		hp = 200,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMswampdrone", 
	{
		ai = "ANIMAL",
		name = "�������� ����",
		instance = "Swampdrone",
		str = 25,
		dex = 25,
		skill_1h = 0,
		skill_2h = 0,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 5,
		hp = 200,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMDEMON", 
	{
		ai = "ANIMAL",
		name = "�����",
		instance = "DEMON",
		str = 35,
		dex = 35,
		lvl = 8,
		hp = 300,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMBEAR", 
	{
		ai = "ANIMAL",
		name = "�������",
		instance = "BEAR",
		str = 45,
		dex = 45,
		hp = 600,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMSHADOWBEAST", 
	{
		ai = "ANIMAL",
		name = "��������",
		instance = "SHADOWBEAST",
		str = 50,
		dex = 50,
		hp = 500,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});
	
	addMonster("MMMSHADOWBEASTSKELETON", 
	{
		ai = "ANIMAL",
		name = "������-���������",  
		instance = "shadowbeast_skeleton",
		str = 50,
		dex = 50,
		hp = 500,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMSTONEGOLEM",
	{
		ai = "ANIMAL",
		name = "��������-�����", 
		instance = "STONEGOLEM",
		str = 60,
		dex = 60,
		hp = 600,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});
	
	addMonster("MMMSWAMPGOLEM",
	{
		ai = "ANIMAL",
		name = "��������-�����", 
		instance = "SWAMPGOLEM",
		str = 60,
		dex = 60,
		hp = 600,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});
	
	addMonster("MMMSTONEGUARDIAN", 
	{
		ai = "ANIMAL",
		name = "�������",
		instance = "STONEGUARDIAN",
		str = 50,
		dex = 60,
		hp = 400,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMICEGOLEM", 
	{
		ai = "ANIMAL",
		name = "�������-�����",
		instance = "ICEGOLEM",
		str = 70,
		dex = 70,
		skill_1h = 0,
		skill_2h = 0,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 8,
		hp = 600,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});


	addMonster("MMMFIREGOLEM", 
	{
		ai = "ANIMAL",
		name = "��������-�����",
		instance = "FIREGOLEM",
		str = 70,
		dex = 70,
		skill_1h = 0,
		skill_2h = 0,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 8,
		hp = 600,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMMEATBUG", 
	{
		ai = "ANIMAL",
		name = "������-���",
		instance = "MEATBUG",
		str = 0,
		dex = 0,
		skill_1h = 0,
		skill_2h = 0,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 0,
		hp = 1,
		mp = 0,
		exp = 0,
		min_dist = 0,
		max_dist = 0,
		respawn = 10000,
		blow_time = 0,
	});

	addMonster("MMMSWAMPSHARK", 
	{
		ai = "ANIMAL",
		name = "���������",
		instance = "SWAMPSHARK",
		str = 22,
		dex = 22,
		skill_1h = 0,
		skill_2h = 0,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 6,
		hp = 170,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});

	addMonster("MMMGOBBO_GREEN", 
	{
		ai = "1H",
		name = "������",
		instance = "GOBBO_GREEN",
		str = 8,
		dex = 8,
		skill_1h = 20,
		skill_2h = 0,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 3,
		hp = 80,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
		weapon = "gkwqdz_ITMW_1H_MISC_SWORD",
	});

	addMonster("MMMGOBBO_BLACK", 
	{
		ai = "1H",
		name = "������-������",
		instance = "GOBBO_BLACK",
		str = 14,
		dex = 14,
		skill_1h = 30,
		skill_2h = 0,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 5,
		hp = 110,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
		weapon = "gkwqdz_ITMW_1H_MISC_SWORD",
	});

	addMonster("MMMGOBBO_WAR", 
	{
		ai = "1H",
		name = "������-����",
		instance = "GOBBO_WARRIOR",
		str = 20,
		dex = 20,
		skill_1h = 40,
		skill_2h = 0,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 5,
		hp = 150,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
		weapon = "gkwqdz_ITMW_1H_MISC_SWORD",
	});

	addMonster("MMMGOBBO_SKELETON", 
	{
		ai = "1H",
		name = "������-������",
		instance = "GOBBO_SKELETON",
		str = 25,
		dex = 25,
		skill_1h = 30,
		skill_2h = 0,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 6,
		hp = 160,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
		weapon = "gkwqdz_ITMW_1H_MISC_SWORD",
	});
		
	addMonster("MMMORC_ROAM",
	{
		ai = "2H",
		name = "���",
		instance = "ORC_ROAM",
		str = 25,
		dex = 25,
		skill_1h = 0,
		skill_2h = 30,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 7,
		hp = 250,
		exp = 0,
		min_dist = 300,
		max_dist = 900,
		respawn = 10000,
		blow_time = false,
		weapon = "gkwqdz_ITMW_2H_ORCAXE_04",
	});
		
	addMonster("MMMOSkeleton",
	{
		ai = "2H",
		name = "������",
		instance = "Skeleton",
		str = 25,
		dex = 25,
		skill_1h = 0,
		skill_2h = 30,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 7,
		hp = 250,
		exp = 0,
		min_dist = 300,
		max_dist = 900,
		respawn = 10000,
		blow_time = false,
		weapon = "gkwqdz_ItMw_2h_Sld_Sword",
	});	

		addMonster("MMMSkeletonDigger",
	{
		ai = "2H",
		name = "������ ��������",
		instance = "Skeleton_Digger",
		str = 20,
		dex = 20,
		skill_1h = 0,
		skill_2h = 30,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 7,
		hp = 210,
		exp = 0,
		min_dist = 300,
		max_dist = 900,
		respawn = 10000,
		blow_time = false,
		weapon = "gkwqdz_itmw_pickaxe",
	});	
		
	addMonster("MMMORCWARRIOR_ROAM",
		{
			ai = "2H",
			name = "���-����",
			instance = "ORCWARRIOR_ROAM",
			str = 30,
			dex = 30,
			skill_1h = 0,
			skill_2h = 40,
			skill_bow = 0,
			skill_cbow = 0,
			lvl = 7,
			hp = 300,
			exp = 0,
			min_dist = 300,
			max_dist = 900,
			respawn = 10000,
			blow_time = false,
			weapon = "gkwqdz_itmw_2h_orcaxe_04",
		});
		
	addMonster("MMMORCELITE_ROAM",
		{
			ai = "2H",
			name = "�������-���",
			instance = "ORCELITE_ROAM",
			str = 40,
			dex = 40,
			skill_1h = 0,
			skill_2h = 50,
			skill_bow = 0,
			skill_cbow = 0,
			lvl = 8,
			hp = 350,
			exp = 0,
			min_dist = 250,
			max_dist = 900,
			respawn = 10000,
			blow_time = false,
			weapon = "gkwqdz_itmw_2h_orcsword_02",
		});
		
	addMonster("MMMORCSHAMAN_SIT",
		{
			ai = "2H",
			name = "���-�����",
			instance = "ORCSHAMAN_SIT",
			str = 20,
			dex = 20,
			skill_1h = 0,
			skill_2h = 30,
			skill_bow = 0,
			skill_cbow = 0,
			lvl = 50,
			hp = 200,
			exp = 0,
			min_dist = 250,
			max_dist = 900,
			respawn = 10000,
			blow_time = false,
			weapon = "gkwqdz_itmw_2h_orcaxe_03",
		});

	addMonster("MMMUNDEADORCWARRIOR",
    {
        ai = "2H",
        name = "���-������",
        instance = "UNDEADORCWARRIOR",
        str = 40,
        dex = 40,
		skill_1h = 0,
		skill_2h = 40,
		skill_bow = 0,
		skill_cbow = 0,
        lvl = 10,
        hp = 300,
        exp = 0,
        min_dist = 250,
        max_dist = 900,
        respawn = 10000,
        blow_time = false,
		weapon = "gkwqdz_itmw_2h_orcaxe_02",
    });
	
	addMonster("MMMSKELETON",
    {
        ai = "2H",
        name = "������",
        instance = "SKELETON",
        str = 30,
        dex = 30,
		skill_1h = 0,
		skill_2h = 30,
		skill_bow = 0,
		skill_cbow = 0,
        lvl = 7,
        hp = 300,
        exp = 0,
        min_dist = 250,
        max_dist = 900,
        respawn = 10000,
        blow_time = false,
		weapon = "gkwqdz_itmw_2h_sword_m_01",
    });

	addMonster("MMMFIREWARAN", 
	{
		ai = "ANIMAL",
		name = "�������� ����",
		instance = "FIREWARAN",
		str = 22,
		dex = 22,
		skill_1h = 0,
		skill_2h = 0,
		skill_bow = 0,
		skill_cbow = 0,
		lvl = 6,
		hp = 170,
		mp = 0,
		exp = 0,
		min_dist = 250,
		max_dist = 700,
		respawn = 10000,
		blow_time = 2,
	});
	
	addMonster("MMMDRACONIAN",
    {
        ai = "2H",
        name = "�������-����",
        instance = "DRACONIAN",
        str = 50,
        dex = 50,
		skill_1h = 0,
		skill_2h = 30,
		skill_bow = 0,
		skill_cbow = 0,
        lvl = 8,
        hp = 400,
        exp = 0,
        min_dist = 250,
        max_dist = 900,
        respawn = 10000,
        blow_time = false,
		weapon = "gkwqdz_itmw_2h_orcsword_01",
    });


end

function SpawnMobs() -- ������� �����.

	print("--------------")
	spawnMonster("SCAVENGER", -14488.6796875, 873.25775146484, -25877.61328125, 1, "OLDWORLD\\OLDWORLD.ZEN", 200, true) -- ��� ����, ����������, ����������, ���, ��������� ����� ������ (���� ������ 1), �������������.
	spawnMonster("WOLF", -13239.137695313, 1852.9360351563, -22232.513671875, 1, "OLDWORLD\\OLDWORLD.ZEN", 200, true)
	ai_Init(true); -- �������� �� ������ ������.
	print("--------------")


end


function _createNewBot(playerid, params)
		
	if Player[playerid].astatus > 0 then	
		local result, bType, status, amount = sscanf(params, "sdd");
		if result == 1 then

			local toFileType;

			local x, y, z = GetPlayerPos(playerid);
			local world = GetPlayerWorld(playerid);

			if bType == "����" or bType == "wolf" then
				spawnMonster("WOLF", x, y+20, z, amount, world, 200, true)
				toFileType = "WOLF";
			end

			if bType == "���������" or bType == "scav" then
				spawnMonster("SCAVENGER", x, y+20, z, amount, world, 200, true)
				toFileType = "SCAVENGER";
			end
	        
			if bType == "����" or bType == "blood" then
				spawnMonster("MMMBLOODFLY", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMBLOODFLY";
			end
			if bType == "�����" or bType == "borov" then
				spawnMonster("MMMKABAN", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMKABAN";
			end
			if bType == "����������" or bType == "bug" then
				spawnMonster("MMMBUG", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMBUG";
			end
			if bType == "����������������" then
				spawnMonster("MMMSCAVENGERL", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSCAVENGERL";
			end	
			if bType == "�����������" then
				spawnMonster("MMMMINECRAWLERWARRIOR", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMMINECRAWLERWARRIOR";
			end
			if bType == "�������" then
				spawnMonster("MMMMINECRAWLER", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMMINECRAWLER";
			end
			if bType == "���������" then
				spawnMonster("MMMMOLERAT", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMMOLERAT";
			end
			if bType == "�����" then
				spawnMonster("MMMMKRISA", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMMKRISA";
			end
			if bType == "������" then
				spawnMonster("MMMLURKER", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMLURKER";
			end
			if bType == "�����" then
				spawnMonster("MMMZOMBIE", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMZOMBIE";
			end
			if bType == "������" then
				spawnMonster("MMM1HBANDIT", x, y+20, z, amount, world, 200, true)
				toFileType = "MMM1HBANDIT";
			end
			if bType == "������������" then
				spawnMonster("MMMDRAGON_UNDEAD", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDRAGON_UNDEAD";
			end
			if bType == "���������" then
				spawnMonster("MMMDRAGON_ICE", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDRAGON_ICE";
			end
			if bType == "������������" then
				spawnMonster("MMMDRAGON_SWAMP", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDRAGON_SWAMP";
			end
			if bType == "�����������" then
				spawnMonster("MMMDRAGON_FIRE", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDRAGON_FIRE";
			end
			if bType == "������������" then
				spawnMonster("MMMDRAGON_ROCK", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDRAGON_ROCK";
			end
			if bType == "����" then
				spawnMonster("MMMWARG", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMWARG";
			end
			if bType == "�����" then
				spawnMonster("MMMWARAN", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMWARAN";
			end
			if bType == "������" then
				spawnMonster("MMMTROLL", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMTROLL";
			end
			if bType == "������������" then
				spawnMonster("MMMTROLL_BLACK", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMTROLL_BLACK";
			end
			if bType == "����" then
				spawnMonster("MMMSHEEP", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSHEEP";
			end
			if bType == "���������������" then
				spawnMonster("MMMDRAGONSNAPPER", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDRAGONSNAPPER";
			end
			if bType == "�����" then
				spawnMonster("MMMSNAPPER", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSNAPPER";
			end
			if bType == "������" then
				spawnMonster("MMMHARPIE", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMHARPIE";
			end
			if bType == "����" then
				spawnMonster("MMMBAT", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMBAT";
			end
			if bType == "�����" then
				spawnMonster("MMMDEMON", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDEMON";
			end
			if bType == "�������" then
				spawnMonster("MMMBEAR", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMBEAR";
			end
			if bType == "��������" then
				spawnMonster("MMMSHADOWBEAST", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSHADOWBEAST";
			end
			if bType == "��������" then
				spawnMonster("MMMSTONEGOLEM", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSTONEGOLEM";
			end
			if bType == "��������" then
				spawnMonster("MMMICEGOLEM", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMICEGOLEM";
			end
			if bType == "��������" then
				spawnMonster("MMMCoalGolem", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMCoalGolem";
			end
			if bType == "��������" then
				spawnMonster("MMMFIREGOLEM", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMFIREGOLEM";
			end
			if bType == "���" then
				spawnMonster("MMMMEATBUG", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMMEATBUG";
			end
			if bType == "���������" then
				spawnMonster("MMMSWAMPSHARK", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSWAMPSHARK";
			end
			if bType == "�������" then
				spawnMonster("MMMSTONEGUARDIAN", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSTONEGUARDIAN";
			end
			if bType == "������" then
				spawnMonster("MMMGOBBO_GREEN", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMGOBBO_GREEN";
			end
			if bType == "�������" then
				spawnMonster("MMMGOBBO_BLACK", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMGOBBO_BLACK";
			end
			if bType == "�������" then
				spawnMonster("MMMGOBBO_WAR", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMGOBBO_WAR";
			end
			if bType == "�������" then
				spawnMonster("MMMGOBBO_SKELETON", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMGOBBO_SKELETON";
			end
			if bType == "������" then
				spawnMonster("MMMWISP", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMWISP";
			end
			if bType == "���" then
				spawnMonster("MMMORC_ROAM", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMORC_ROAM";
			end
			if bType == "����" then
				spawnMonster("MMMORCWARRIOR_ROAM", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMORCWARRIOR_ROAM";
			end
			if bType == "����" then
				spawnMonster("MMMORCELITE_ROAM", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMORCELITE_ROAM";
			end
			if bType == "����" then
				spawnMonster("MMMORCSHAMAN_SIT", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMORCSHAMAN_SIT";
			end
			if bType == "����" then
				spawnMonster("MMMUNDEADORCWARRIOR", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMUNDEADORCWARRIOR";
			end
			if bType == "������" then
				spawnMonster("MMMSKELETON", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSKELETON";
			end
			if bType == "����" then
				spawnMonster("MMMDRACONIAN", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDRACONIAN";
			end 
			
			if bType == "�����" then
				spawnMonster("MMMFIREWARAN", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMFIREWARAN";
			end 
			
			if bType == "�������" then
				spawnMonster("MMMBLATTCRAWLER", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMBLATTCRAWLER";
			end 
			
			if bType == "�������������" then
				spawnMonster("MMMSWAMPGOLEM", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSWAMPGOLEM";
			end
			
			if bType == "��������������" then
				spawnMonster("MMMSHADOWBEASTSKELETON", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSHADOWBEASTSKELETON";
			end

			if bType == "����" then
				spawnMonster("MMMswampdrone", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMswampdrone";
			end

			if bType == "������" then
				spawnMonster("MMMSKELETON", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSKELETON";
			end

			if bType == "�������������" then
				spawnMonster("MMMSkeletonDigger", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSkeletonDigger";
			end


			if bType == "���������" then
				spawnMonster("MMM2HBANDIT", x, y+20, z, amount, world, 200, true)
				toFileType = "MMM2HBANDIT";
			end
			
			if status == 1 then
				if Player[playerid].astatus > 1 then
					local file = io.open("nBots.txt", "a+");
					if file then
						file:write(toFileType.." "..x.." "..y.." "..z.." "..amount.." "..world.."\n");
						file:close();
					else
						print("File 'nBots' ne sozdan ili ne nayden!")
					end
				else
					SendPlayerMessage(playerid, 255, 255, 255, "�� �� ������ �������� ����� � �����������. ������ �� �����������.")
				end
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/�� (���) (����������) (����������)")
		end
	end

end
addCommandHandler({"/��", "/sp"}, _createNewBot);


function _readNewBots()

	local file = io.open("nBots.txt", "r");
	local tempvar = file:read();
	for line in io.lines("nBots.txt") do
		local result, type, x, y, z, amount, world = sscanf(tempvar, "sdddds");
		if result == 1 then
			spawnMonster(tostring(type), x, y, z, amount, world, 200, true);
		end
		tempvar = file:read("*l");
	end
	file:close();

	print("_BE_Bots load")



end

function _setInviseForBots(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			if Player[id].inviseforbots == false then
				Player[id].inviseforbots = true;
				SendPlayerMessage(id, 255, 255, 255, "������ ��� ����� �� ��������.")
			else
				Player[id].inviseforbots = false;
				SendPlayerMessage(id, 255, 255, 255, "������ �� ������ ��� �����.")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/��� (��)")
		end
	end

end
addCommandHandler({"/���", "/agr"}, _setInviseForBots);

function IsInvise(playerid) -- ��� �� ��� ��� �����

	if Player[playerid].loggedIn == true then
		if Player[playerid].inviseforbots == true then
			return true;
		else
			return false;
		end
	else
		return false;
	end

end