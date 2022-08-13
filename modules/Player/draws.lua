function DrawInit(playerid)

	local nickname = GetPlayerName(playerid);

	indrawnick = string.format("%s", nickname);
	autonick = CreatePlayerDraw(playerid, 6554, 4712, indrawnick, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	autopass = CreatePlayerDraw(playerid, 6554, 5357, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	automac = CreatePlayerDraw(playerid, 6580, 6497, "Войти по MAC", "Font_Old_20_White_Hi.TGA", 255, 255, 255);

	rtdraw = CreatePlayerDraw(playerid, 7740, 7430, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	gtdraw = CreatePlayerDraw(playerid, 7740, 7630, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	datedraw = CreatePlayerDraw(playerid, 7740, 7830, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	helmname = CreatePlayerDraw(playerid, 5770, 4358, "", "Font_Old_10_White_Hi.TGA", 247, 178, 178);
	helm_stata1 = CreatePlayerDraw(playerid, 5770, 4658, "", "Font_Old_10_White_Hi.TGA", 247, 178, 178);
	helm_stata2 = CreatePlayerDraw(playerid, 5770, 4858, "", "Font_Old_10_White_Hi.TGA", 247, 178, 178);
	helm_stata3 = CreatePlayerDraw(playerid, 5770, 5058, "", "Font_Old_10_White_Hi.TGA", 247, 178, 178);
	helm_stata4 = CreatePlayerDraw(playerid, 5770, 5258, "", "Font_Old_10_White_Hi.TGA", 247, 178, 178);
	helm_price = CreatePlayerDraw(playerid, 5770, 5558, "", "Font_Old_10_White_Hi.TGA", 247, 178, 178);

	helm_upr1 = CreatePlayerDraw(playerid, 6022, 5807, "Переключение:", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	helm_upr2 = CreatePlayerDraw(playerid, 6022, 6007, "      < >", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	chest_amount = CreatePlayerDraw(playerid, 3621, 3730, "Укажите кол-во", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	chest_num = CreatePlayerDraw(playerid, 4005, 4040, "0", "Font_Old_20_White_Hi.TGA", 255, 255, 255);


	reglogPODSKAZOCHKA = CreatePlayerDraw(playerid, 100, 100, "Для успешной регистрации/авторизации - откройте чат, и введите пароль.", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	-- ok 177, 255, 173
	-- medium 250, 255, 173
	-- bad 255, 173, 173
	fooddraw = CreatePlayerDraw(playerid, 7798, 7520, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	stats_name = CreatePlayerDraw(playerid, 2460, 1680, "Арена", "Font_Old_20_White_Hi.TGA", 255, 198, 84);
	stats_str1 = CreatePlayerDraw(playerid, 2685, 2420, "Ближний бой", "Font_Old_10_White_Hi.TGA", 255, 198, 84);
	stats_str2 = CreatePlayerDraw(playerid, 4025, 2420, "Персонаж", "Font_Old_10_White_Hi.TGA", 255, 198, 84);
	stats_str3 = CreatePlayerDraw(playerid, 5150, 2420, "Дальний бой", "Font_Old_10_White_Hi.TGA", 255, 198, 84);
	stats_left_1 = CreatePlayerDraw(playerid, 2715, 2915, "Одноручное", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	stats_left_2 = CreatePlayerDraw(playerid, 2720, 3630, " Двуручное", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	stats_middle_1 = CreatePlayerDraw(playerid, 4155, 2915, "Сила", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	stats_middle_2 = CreatePlayerDraw(playerid, 4055, 3630, "Ловкость", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	stats_middle_3 = CreatePlayerDraw(playerid, 4215, 4315, "ХП", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	stats_middle_4 = CreatePlayerDraw(playerid, 3915, 5000, "Маг. энергия", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	stats_right_1 = CreatePlayerDraw(playerid, 5410, 2915, "Лук", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	stats_right_2 = CreatePlayerDraw(playerid, 5290, 3630, "Арбалет", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	craft_info1 = CreatePlayerDraw(playerid, 310, 1845, "Каталоги", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	craft_info2 = CreatePlayerDraw(playerid, 2980, 1845, "Список", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	craft_info3 = CreatePlayerDraw(playerid, 5590, 1845, "Требования", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	craft_craft = CreatePlayerDraw(playerid, 6610, 6335, "КРАФТ", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	craft_leveldr = CreatePlayerDraw(playerid, 915, 7075, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	craft_dop1 = CreatePlayerDraw(playerid, 5690, 3040, "Ингредиенты: ", "Font_Old_10_White_Hi.TGA", 245, 144, 144);
	craft_dop1_1 = CreatePlayerDraw(playerid, 5690, 3240, "Железо: --", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	craft_dop1_2 = CreatePlayerDraw(playerid, 5690, 3440, "Дерево: --", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	craft_dop2 = CreatePlayerDraw(playerid, 5690, 3640, "Уровень навыка:", "Font_Old_10_White_Hi.TGA", 245, 144, 144);
	craft_dop2_1 = CreatePlayerDraw(playerid, 5690, 3840, "--", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	craft_dop3 = CreatePlayerDraw(playerid, 5690, 4040, "Энергия:", "Font_Old_10_White_Hi.TGA", 245, 144, 144);
	craft_dop3_1 = CreatePlayerDraw(playerid, 5690, 4240, "--", "Font_Old_10_White_Hi.TGA", 255, 255, 255);


	rpinv_name = CreatePlayerDraw(playerid, 6000, 2180, "Статусы", "Font_Old_20_White_Hi.TGA", 255, 198, 84);
	rpinv_ch = CreatePlayerDraw(playerid, 5990, 2600, ">", "Font_Old_10_White_Hi.TGA", 255, 198, 84);
	rpinv_str1 = CreatePlayerDraw(playerid, 5990, 6245, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	rpinv_str2 = CreatePlayerDraw(playerid, 7390, 6245, "Показать", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	rpinv_slot1 = CreatePlayerDraw(playerid, 6040, 2600, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	rpinv_slot2 = CreatePlayerDraw(playerid, 6040, 2800, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	rpinv_slot3 = CreatePlayerDraw(playerid, 6040, 3000, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	rpinv_slot4 = CreatePlayerDraw(playerid, 6040, 3200, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	rpinv_slot5 = CreatePlayerDraw(playerid, 6040, 3400, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	rpinv_slot6 = CreatePlayerDraw(playerid, 6040, 3600, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	rpinv_slot7 = CreatePlayerDraw(playerid, 6040, 3800, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	rpinv_slot8 = CreatePlayerDraw(playerid, 6040, 4000, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	rpinv_slot9 = CreatePlayerDraw(playerid, 6040, 4200, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	rpinv_slot10 = CreatePlayerDraw(playerid, 6040, 4400, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	
	zoneinfo = CreatePlayerDraw(playerid, 300, 300, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	
end