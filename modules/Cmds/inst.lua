function InstancePlayer(playerid, dest)
Player[playerid].IsInstance = true
Player[playerid].Resolution = false
	if dest == "драконнежить" then
		SetPlayerInstance(playerid,"DRAGON_UNDEAD");
	elseif dest == "драконогонь" then
		SetPlayerInstance(playerid,"DRAGON_FIRE");
	elseif dest == "драконлед" then
		SetPlayerInstance(playerid,"DRAGON_ICE");
	elseif dest == "драконкамень" then
		SetPlayerInstance(playerid,"DRAGON_ROCK");	
	elseif dest == "драконболото" then
		SetPlayerInstance(playerid,"DRAGON_SWAMP");
	elseif dest == "кровомуха" then
		SetPlayerInstance(playerid,"BLOODFLY");
		elseif dest == "кротокрыс" then
		SetPlayerInstance(playerid,"MOLERAT");
	elseif dest == "дрон" then
		SetPlayerInstance(playerid,"SWAMPDRONE");
	elseif dest == "бритвозуб" then
		SetPlayerInstance(playerid,"RAZOR");
	elseif dest == "чомпер" then
		SetPlayerInstance(playerid,"ORCBITER");
		SetPlayerMaxHealth(playerid, 600)
		SetPlayerHealth(playerid, 600)
	elseif dest == "гончая" then
		SetPlayerInstance(playerid,"BLOODHOUND");
	elseif dest == "варг" then
		SetPlayerInstance(playerid,"WARG");
		SetPlayerMaxHealth(playerid, 700)
		SetPlayerHealth(playerid, 700)
	elseif dest == "полевойжук" then
		SetPlayerInstance(playerid,"GIANT_BUG");
	elseif dest == "волк" then
		SetPlayerInstance(playerid,"WOLF");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "ледоволк" then
		SetPlayerInstance(playerid,"ICEWOLF");
	elseif dest == "варан" then
		SetPlayerInstance(playerid,"WARAN");
	elseif dest == "огневаран" then
		SetPlayerInstance(playerid,"FIREWARAN");
	elseif dest == "тролль" then
		SetPlayerInstance(playerid,"TROLL");
	elseif dest == "овца" then
		SetPlayerInstance(playerid,"SHEEP");
	elseif dest == "лошадь" then
		SetPlayerInstance(playerid,"HORSE");
	elseif dest == "призрак" then
		SetPlayerInstance(playerid, "NONE_ADDON_111_QUARHODRON");
	elseif dest == "снепперд" then
		SetPlayerInstance(playerid,"DRAGONSNAPPER");
		SetPlayerMaxHealth(playerid, 800)
		SetPlayerHealth(playerid, 800)
	elseif dest == "снеппер" then
		SetPlayerInstance(playerid,"SNAPPER");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "падальщик" then
		SetPlayerInstance(playerid,"SCAVENGER");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "лпадальщик" then
		SetPlayerInstance(playerid,"SCAVENGER_DEMON");
	elseif dest == "аллигатор" then
		SetPlayerInstance(playerid,"ALLIGATOR");
	elseif dest == "пума" then
		SetPlayerInstance(playerid,"STONEPUMA");
	elseif dest == "часовой" then
		SetPlayerInstance(playerid,"STONEGUARDIAN");
	elseif dest == "луркер" then
		SetPlayerInstance(playerid,"LURKER");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "кабан" then
		SetPlayerInstance(playerid,"KEILER")
	elseif dest == "крыса" then
		SetPlayerInstance(playerid,"GIANT_RAT")
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "пкрыса" then
		SetPlayerInstance(playerid,"GIANT_DESERTRAT")
	elseif dest == "бкрыса" then
		SetPlayerInstance(playerid,"SWAMPRAT")
	elseif dest == "ожж" then
		SetPlayerInstance(playerid,"SWARM");
	elseif dest == "гарпия" then
		SetPlayerInstance(playerid,"HARPIE");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "мад" then
		SetPlayerInstance(playerid,"UNDEAD_MUD");
	elseif dest == "зомби" then
		local zombak = math.random(4)
		if zombak == 0 then
			SetPlayerInstance(playerid,"ZOMBIE01");
		elseif zombak == 1 then
			SetPlayerInstance(playerid,"ZOMBIE02");
		elseif zombak == 2 then
			SetPlayerInstance(playerid,"ZOMBIE03");
		elseif zombak == 3 then
			SetPlayerInstance(playerid,"ZOMBIE04");
		end
	elseif dest == "спящий" then
		SetPlayerInstance(playerid,"SLEEPER");
	elseif dest == "демон" then
		SetPlayerInstance(playerid,"DEMON");
	elseif dest == "демонлорд" then
		SetPlayerInstance(playerid,"DEMONLORD");
	elseif dest == "мракорис-скелет" then
		SetPlayerInstance(playerid,"SHADOWBEAST_SKELETON");
	elseif dest == "мракорис" then
		SetPlayerInstance(playerid,"SHADOWBEAST");
	elseif dest == "огнемракорис" then
		SetPlayerInstance(playerid,"SHADOWBEAST_ADDON_FIRE");
	elseif dest == "голем" then
		SetPlayerInstance(playerid,"STONEGOLEM");
		SetPlayerHealth(playerid,1000);
		SetPlayerMaxHealth(playerid,1000);
	elseif dest == "лголем" then
		SetPlayerInstance(playerid,"ICEGOLEM");
		SetPlayerHealth(playerid,1000);
		SetPlayerMaxHealth(playerid,1000);
	elseif dest == "мголем" then
		SetPlayerInstance(playerid,"CoalGolem");
		SetPlayerHealth(playerid,1000);
		SetPlayerMaxHealth(playerid,1000);
	elseif dest == "оголем" then
		SetPlayerInstance(playerid,"FIREGOLEM");
		SetPlayerHealth(playerid,1000);
		SetPlayerMaxHealth(playerid,1000);
	elseif dest == "бголем" then
		SetPlayerInstance(playerid,"SWAMPGOLEM");
		SetPlayerHealth(playerid,1000);
		SetPlayerMaxHealth(playerid,1000);
	elseif dest == "жук" then
		SetPlayerInstance(playerid,"MEATBUG");
	elseif dest == "гоблин" then
		SetPlayerInstance(playerid,"GOBBO_GREEN");
		EquipMeleeWeapon(playerid,"gkwqdz_ItMw_1h_Bau_MacE");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "чгоблин" then
		SetPlayerInstance(playerid,"GOBBO_BLACK");
		EquipMeleeWeapon(playerid,"gkwqdz_ItMw_1h_Bau_MacE");
		SetPlayerMaxHealth(playerid, 500)
		SetPlayerHealth(playerid, 500)
	elseif dest == "сгоблин" then
		SetPlayerInstance(playerid,"GOBBO_SKELETON");
		EquipMeleeWeapon(playerid,"gkwqdz_ItMw_1h_Bau_MacE");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "вгоблин" then
		SetPlayerInstance(playerid,"GOBBO_WARRIOR");
		EquipMeleeWeapon(playerid,"gkwqdz_ItMw_1h_MISC_SworD");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "в1гоблин" then
		SetPlayerInstance(playerid,"GOBBO_WARRIOR_VISIR");
		EquipMeleeWeapon(playerid,"gkwqdz_ItMw_1h_Misc_AxE");
		SetPlayerMaxHealth(playerid, 700)
		SetPlayerHealth(playerid, 700)
	elseif dest == "огонек" then
		SetPlayerInstance(playerid,"WISP");
		elseif dest == "Гоблиннаездник" then
		SetPlayerInstance(playerid,"MOLERAT_GOBBO");
		elseif dest == "Гоблиннаездниквоин" then
		SetPlayerInstance(playerid,"MOLERAT_GOBBO_WARRIOR");
	elseif dest == "богомол" then
		SetPlayerInstance(playerid,"BLATTCRAWLER");
	elseif dest == "краулер" then
		SetPlayerInstance(playerid,"MINECRAWLER");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "вкраулер" then
		SetPlayerInstance(playerid,"MINECRAWLERWARRIOR");
		SetPlayerMaxHealth(playerid, 600)
		SetPlayerHealth(playerid, 600)
	elseif dest == "орк" then

		ClearInventory(playerid);
		SetPlayerInstance(playerid,"ORC_ROAM");
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_04");
		SetPlayerStrength(playerid, 45);
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
		
	elseif dest == "орк-воин" then
	
		ClearInventory(playerid);
		SetPlayerInstance(playerid,"ORCWARRIOR_ROAM");
		SetPlayerStrength(playerid, 60);
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_04");
		
	elseif dest == "орк-элитник" then
		SetPlayerInstance(playerid,"ORCELITE_ROAM");
		SetPlayerStrength(playerid, 60);
		SetPlayerMaxHealth(playerid, 400)
		SetPlayerHealth(playerid, 400)
		ClearInventory(playerid);
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_04");

	elseif dest == "орк-шаман" then
		SetPlayerInstance(playerid,"ORCSHAMAN_SIT");
		SetPlayerMana(playerid,600);
		SetPlayerMaxMana(playerid,600);
		SetPlayerMaxHealth(playerid, 250)
		SetPlayerHealth(playerid, 250)
		SetPlayerStrength(playerid, 60);

		ClearInventory(playerid);
		GiveItem(playerid, "ITRU_CHARGEFIREBALL", 1);
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_03");

	elseif dest == "орк-скелет" then
		SetPlayerInstance(playerid,"SkeletonOrcWarrior");
		SetPlayerStrength(playerid, 60);
		SetPlayerMaxHealth(playerid, 400)
		SetPlayerHealth(playerid, 400)
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_04");

	elseif dest == "орк-храмовник" then
		SetPlayerInstance(playerid,"OrcTemplar_Roam");
		SetPlayerStrength(playerid, 60);
		SetPlayerMaxHealth(playerid, 400)
		SetPlayerHealth(playerid, 400)
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_04");

	elseif dest == "ящер" then
		SetPlayerInstance(playerid,"DRACONIAN");
		SetPlayerMana(playerid,600);
		SetPlayerMaxMana(playerid,600);
		SetPlayerStrength(playerid, 60);
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_04");
		SetPlayerMagicLevel(playerid, 6);

	elseif dest == "ящерсобиратель" then
		SetPlayerInstance(playerid,"LizardSobiratel");
		SetPlayerStrength(playerid, 60);
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_STL_WARAXE");

	elseif dest == "ящерохотник" then
		SetPlayerInstance(playerid,"LIZARDHUNTER");
		EquipMeleeWeapon(playerid,"gkwqdz_ITMW_STL_WARAXE");

	elseif dest == "орк-нежить" then
		SetPlayerInstance(playerid,"UNDEADORCWARRIOR");
		SetPlayerStrength(playerid, 60);
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_02");
		
	elseif dest == "алорд" then
	
		ClearInventory(playerid);
		SetPlayerInstance(playerid,"SKELETON_LORD");
		SetPlayerStrength(playerid, 60);
		SetPlayerMaxHealth(playerid, 450)
		SetPlayerHealth(playerid, 450)
		EquipMeleeWeapon(playerid, "gkwqdz_ItMw_2H_Sword_M_01");
		EquipArmor(playerid, "huzvui_ITAR_PAL_SKEL");
		
	elseif dest == "скелет" then

		ClearInventory(playerid);
		SetPlayerInstance(playerid,"SKELETON");
		EquipMeleeWeapon(playerid, "gkwqdz_ItMw_2H_Sword_M_01");
		SetPlayerStrength(playerid, 45);
		SetPlayerMaxHealth(playerid, 350)
		SetPlayerHealth(playerid, 350)

	elseif dest == "чдракон" then
		SetPlayerInstance(playerid,"Dragon_Dark");
	elseif dest == "нтролль" then
		SetPlayerInstance(playerid,"TROLL_DEAD");
	elseif dest == "болотожор" then
		SetPlayerInstance(playerid,"SWAMPSHARK");
	elseif dest == "чтролль" then
		SetPlayerInstance(playerid,"TROLL_BLACK");
	elseif dest == "медведь" then
		SetPlayerInstance(playerid,"BEAR");
	elseif dest == "мышь" then
		SetPlayerInstance(playerid,"BAT");
	end
end

function CMD_INSTANC_NPC(playerid, params)

	local result, pid, dest = sscanf(params,"ds");
	if result == 1 then
		if Player[playerid].astatus > 0 then
			InstancePlayer(pid, dest);
			LogString("logGAMETECH", Player[pid].nickname.." превращен в "..dest)
		end
	else
		SendPlayerMessage(playerid,255,255,0,string.format("%s","(INFO): Используй /инст (id) (instance)"));
	end


end
addCommandHandler({"/инст","/inst"}, CMD_INSTANC_NPC)