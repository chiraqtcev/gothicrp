function InitMobs() -- создаем мобов по шаблону ниже.

	addMonster("SCAVENGER", {
	ai = "ANIMAL", -- если делаем животное, то ai оставляем таким. если бандита (условно), то ставим 1H или 2H.
	name = "Падальщик", -- имя, которое будет в игре.
	instance = "SCAVENGER", -- инстанция.
	str = 7, -- сила
	dex = 7, -- ловкость
	hp = 100, -- хп
	min_dist = 400, -- дистанция, когда моб побежит бить ебало
	max_dist = 600, -- дистанция, когда моб начнет агр, а потом побежит
	respawn = 10000, -- респавн (хуй знает, это минуты или милисекунды. итоговое число, которое тут указано, потом умножается на 2)
	blow_time = 2, }); -- хуй знает. оставляйте так.

	addMonster("WOLF", {
	ai = "ANIMAL",
	name = "Волк",
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
		name = "Огонек",
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
	name = "Кровавая-муха",
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
	name = "Кабан",
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
	name = "Полевой-жук",
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
	name = "Молодой-падальщик",
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
	name = "Молодой-волк",
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
	name = "Ползун-воин",
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
	name = "Богомол",
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
	name = "Ползун",
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
	name = "Кротокрыс",
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
	name = "Крыса",
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
	name = "Луркер",
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
	name = "Зомби",
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
        name = "Бандит",
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
        name = "Разбойник",
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
		name = "Варг",
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
		name = "Варан",
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
		name = "Тролль",
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
		name = "Черный-тролль",
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
		name = "Овца",
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
		name = "Драконний-снеппер",
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
		name = "Глорх",
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
		name = "Гарпия",
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
		name = "Летучая мышь",
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
		name = "Болотный дрон",
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
		name = "Демон",
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
		name = "Медведь",
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
		name = "Мракорис",
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
		name = "Скелет-мракориса",  
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
		name = "Каменный-голем", 
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
		name = "Болотный-голем", 
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
		name = "Часовой",
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
		name = "Ледяной-голем",
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
		name = "Огненный-голем",
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
		name = "Мясной-жук",
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
		name = "Болотожор",
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
		name = "Гоблин",
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
		name = "Черный-гоблин",
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
		name = "Гоблин-воин",
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
		name = "Гоблин-скелет",
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
		name = "Орк",
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
		name = "Скелет",
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
		name = "Скелет рудокопа",
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
			name = "Орк-воин",
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
			name = "Элитный-орк",
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
			name = "Орк-шаман",
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
        name = "Орк-нежить",
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
        name = "Скелет",
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
		name = "Огненный ящер",
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
        name = "Человек-ящер",
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

function SpawnMobs() -- спавним мобов.

	print("--------------")
	spawnMonster("SCAVENGER", -14488.6796875, 873.25775146484, -25877.61328125, 1, "OLDWORLD\\OLDWORLD.ZEN", 200, true) -- тип моба, координаты, количество, мир, дистанция между мобами (если больше 1), агрессивность.
	spawnMonster("WOLF", -13239.137695313, 1852.9360351563, -22232.513671875, 1, "OLDWORLD\\OLDWORLD.ZEN", 200, true)
	ai_Init(true); -- оставьте на всякий случай.
	print("--------------")


end


function _createNewBot(playerid, params)
		
	if Player[playerid].astatus > 0 then	
		local result, bType, status, amount = sscanf(params, "sdd");
		if result == 1 then

			local toFileType;

			local x, y, z = GetPlayerPos(playerid);
			local world = GetPlayerWorld(playerid);

			if bType == "волк" or bType == "wolf" then
				spawnMonster("WOLF", x, y+20, z, amount, world, 200, true)
				toFileType = "WOLF";
			end

			if bType == "падальщик" or bType == "scav" then
				spawnMonster("SCAVENGER", x, y+20, z, amount, world, 200, true)
				toFileType = "SCAVENGER";
			end
	        
			if bType == "муха" or bType == "blood" then
				spawnMonster("MMMBLOODFLY", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMBLOODFLY";
			end
			if bType == "кабан" or bType == "borov" then
				spawnMonster("MMMKABAN", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMKABAN";
			end
			if bType == "полевойжук" or bType == "bug" then
				spawnMonster("MMMBUG", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMBUG";
			end
			if bType == "молодойпадальщик" then
				spawnMonster("MMMSCAVENGERL", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSCAVENGERL";
			end	
			if bType == "воинкраулер" then
				spawnMonster("MMMMINECRAWLERWARRIOR", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMMINECRAWLERWARRIOR";
			end
			if bType == "краулер" then
				spawnMonster("MMMMINECRAWLER", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMMINECRAWLER";
			end
			if bType == "кротокрыс" then
				spawnMonster("MMMMOLERAT", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMMOLERAT";
			end
			if bType == "крыса" then
				spawnMonster("MMMMKRISA", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMMKRISA";
			end
			if bType == "луркер" then
				spawnMonster("MMMLURKER", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMLURKER";
			end
			if bType == "зомби" then
				spawnMonster("MMMZOMBIE", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMZOMBIE";
			end
			if bType == "бандит" then
				spawnMonster("MMM1HBANDIT", x, y+20, z, amount, world, 200, true)
				toFileType = "MMM1HBANDIT";
			end
			if bType == "драконнежить" then
				spawnMonster("MMMDRAGON_UNDEAD", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDRAGON_UNDEAD";
			end
			if bType == "драконлед" then
				spawnMonster("MMMDRAGON_ICE", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDRAGON_ICE";
			end
			if bType == "драконболото" then
				spawnMonster("MMMDRAGON_SWAMP", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDRAGON_SWAMP";
			end
			if bType == "драконогонь" then
				spawnMonster("MMMDRAGON_FIRE", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDRAGON_FIRE";
			end
			if bType == "драконкамень" then
				spawnMonster("MMMDRAGON_ROCK", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDRAGON_ROCK";
			end
			if bType == "варг" then
				spawnMonster("MMMWARG", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMWARG";
			end
			if bType == "варан" then
				spawnMonster("MMMWARAN", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMWARAN";
			end
			if bType == "тролль" then
				spawnMonster("MMMTROLL", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMTROLL";
			end
			if bType == "черныйтролль" then
				spawnMonster("MMMTROLL_BLACK", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMTROLL_BLACK";
			end
			if bType == "овца" then
				spawnMonster("MMMSHEEP", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSHEEP";
			end
			if bType == "драконийснеппер" then
				spawnMonster("MMMDRAGONSNAPPER", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDRAGONSNAPPER";
			end
			if bType == "глорх" then
				spawnMonster("MMMSNAPPER", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSNAPPER";
			end
			if bType == "гарпия" then
				spawnMonster("MMMHARPIE", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMHARPIE";
			end
			if bType == "мышь" then
				spawnMonster("MMMBAT", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMBAT";
			end
			if bType == "демон" then
				spawnMonster("MMMDEMON", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDEMON";
			end
			if bType == "медведь" then
				spawnMonster("MMMBEAR", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMBEAR";
			end
			if bType == "мракорис" then
				spawnMonster("MMMSHADOWBEAST", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSHADOWBEAST";
			end
			if bType == "камголем" then
				spawnMonster("MMMSTONEGOLEM", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSTONEGOLEM";
			end
			if bType == "ледголем" then
				spawnMonster("MMMICEGOLEM", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMICEGOLEM";
			end
			if bType == "магголем" then
				spawnMonster("MMMCoalGolem", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMCoalGolem";
			end
			if bType == "огнголем" then
				spawnMonster("MMMFIREGOLEM", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMFIREGOLEM";
			end
			if bType == "жук" then
				spawnMonster("MMMMEATBUG", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMMEATBUG";
			end
			if bType == "болотожор" then
				spawnMonster("MMMSWAMPSHARK", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSWAMPSHARK";
			end
			if bType == "часовой" then
				spawnMonster("MMMSTONEGUARDIAN", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSTONEGUARDIAN";
			end
			if bType == "гоблин" then
				spawnMonster("MMMGOBBO_GREEN", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMGOBBO_GREEN";
			end
			if bType == "чгоблин" then
				spawnMonster("MMMGOBBO_BLACK", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMGOBBO_BLACK";
			end
			if bType == "вгоблин" then
				spawnMonster("MMMGOBBO_WAR", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMGOBBO_WAR";
			end
			if bType == "сгоблин" then
				spawnMonster("MMMGOBBO_SKELETON", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMGOBBO_SKELETON";
			end
			if bType == "огонек" then
				spawnMonster("MMMWISP", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMWISP";
			end
			if bType == "орк" then
				spawnMonster("MMMORC_ROAM", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMORC_ROAM";
			end
			if bType == "ворк" then
				spawnMonster("MMMORCWARRIOR_ROAM", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMORCWARRIOR_ROAM";
			end
			if bType == "эорк" then
				spawnMonster("MMMORCELITE_ROAM", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMORCELITE_ROAM";
			end
			if bType == "шорк" then
				spawnMonster("MMMORCSHAMAN_SIT", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMORCSHAMAN_SIT";
			end
			if bType == "норк" then
				spawnMonster("MMMUNDEADORCWARRIOR", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMUNDEADORCWARRIOR";
			end
			if bType == "скелет" then
				spawnMonster("MMMSKELETON", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSKELETON";
			end
			if bType == "ящер" then
				spawnMonster("MMMDRACONIAN", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMDRACONIAN";
			end 
			
			if bType == "оящер" then
				spawnMonster("MMMFIREWARAN", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMFIREWARAN";
			end 
			
			if bType == "богомол" then
				spawnMonster("MMMBLATTCRAWLER", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMBLATTCRAWLER";
			end 
			
			if bType == "болотныйголем" then
				spawnMonster("MMMSWAMPGOLEM", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSWAMPGOLEM";
			end
			
			if bType == "мракорисскелет" then
				spawnMonster("MMMSHADOWBEASTSKELETON", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSHADOWBEASTSKELETON";
			end

			if bType == "дрон" then
				spawnMonster("MMMswampdrone", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMswampdrone";
			end

			if bType == "скелет" then
				spawnMonster("MMMSKELETON", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSKELETON";
			end

			if bType == "скелетрудокоп" then
				spawnMonster("MMMSkeletonDigger", x, y+20, z, amount, world, 200, true)
				toFileType = "MMMSkeletonDigger";
			end


			if bType == "разбойник" then
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
					SendPlayerMessage(playerid, 255, 255, 255, "Вы не можете спавнить мобов с сохранением. Запись не произведена.")
				end
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/сп (моб) (сохранение) (количество)")
		end
	end

end
addCommandHandler({"/сп", "/sp"}, _createNewBot);


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
				SendPlayerMessage(id, 255, 255, 255, "Теперь для мобов вы невидимы.")
			else
				Player[id].inviseforbots = false;
				SendPlayerMessage(id, 255, 255, 255, "Теперь вы видимы для мобов.")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/агр (ид)")
		end
	end

end
addCommandHandler({"/агр", "/agr"}, _setInviseForBots);

function IsInvise(playerid) -- чек на агр для мобов

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