function InstancePlayer(playerid, dest)
Player[playerid].IsInstance = true
Player[playerid].Resolution = false
	if dest == "������������" then
		SetPlayerInstance(playerid,"DRAGON_UNDEAD");
	elseif dest == "�����������" then
		SetPlayerInstance(playerid,"DRAGON_FIRE");
	elseif dest == "���������" then
		SetPlayerInstance(playerid,"DRAGON_ICE");
	elseif dest == "������������" then
		SetPlayerInstance(playerid,"DRAGON_ROCK");	
	elseif dest == "������������" then
		SetPlayerInstance(playerid,"DRAGON_SWAMP");
	elseif dest == "���������" then
		SetPlayerInstance(playerid,"BLOODFLY");
	elseif dest == "���������" then
		SetPlayerInstance(playerid,"MOLERAT");
	elseif dest == "����" then
		SetPlayerInstance(playerid,"SWAMPDRONE");
	elseif dest == "���������" then
		SetPlayerInstance(playerid,"RAZOR");
	elseif dest == "������" then
		SetPlayerInstance(playerid,"ORCBITER");
		SetPlayerMaxHealth(playerid, 600)
		SetPlayerHealth(playerid, 600)
	elseif dest == "������" then
		SetPlayerInstance(playerid,"BLOODHOUND");
	elseif dest == "����" then
		SetPlayerInstance(playerid,"WARG");
		SetPlayerMaxHealth(playerid, 700)
		SetPlayerHealth(playerid, 700)
	elseif dest == "����������" then
		SetPlayerInstance(playerid,"GIANT_BUG");
	elseif dest == "����" then
		SetPlayerInstance(playerid,"WOLF");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "��������" then
		SetPlayerInstance(playerid,"ICEWOLF");
	elseif dest == "�����" then
		SetPlayerInstance(playerid,"WARAN");
	elseif dest == "���������" then
		SetPlayerInstance(playerid,"FIREWARAN");
	elseif dest == "������" then
		SetPlayerInstance(playerid,"TROLL");
	elseif dest == "����" then
		SetPlayerInstance(playerid,"SHEEP");
	elseif dest == "������" then
		SetPlayerInstance(playerid,"HORSE");
	elseif dest == "�������" then
		SetPlayerInstance(playerid, "NONE_ADDON_111_QUARHODRON");
	elseif dest == "��������" then
		SetPlayerInstance(playerid,"DRAGONSNAPPER");
		SetPlayerMaxHealth(playerid, 800)
		SetPlayerHealth(playerid, 800)
	elseif dest == "�������" then
		SetPlayerInstance(playerid,"SNAPPER");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "���������" then
		SetPlayerInstance(playerid,"SCAVENGER");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "����������" then
		SetPlayerInstance(playerid,"SCAVENGER_DEMON");
	elseif dest == "���������" then
		SetPlayerInstance(playerid,"ALLIGATOR");
	elseif dest == "����" then
		SetPlayerInstance(playerid,"STONEPUMA");
	elseif dest == "�������" then
		SetPlayerInstance(playerid,"STONEGUARDIAN");
	elseif dest == "������" then
		SetPlayerInstance(playerid,"LURKER");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "�����" then
		SetPlayerInstance(playerid,"KEILER")
	elseif dest == "�����" then
		SetPlayerInstance(playerid,"GIANT_RAT")
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "������" then
		SetPlayerInstance(playerid,"GIANT_DESERTRAT")
	elseif dest == "������" then
		SetPlayerInstance(playerid,"SWAMPRAT")
	elseif dest == "������" then
		SetPlayerInstance(playerid,"HARPIE");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "���" then
		SetPlayerInstance(playerid,"UNDEAD_MUD");
	elseif dest == "�����" then
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
	elseif dest == "������" then
		SetPlayerInstance(playerid,"SLEEPER");
	elseif dest == "�����" then
		SetPlayerInstance(playerid,"DEMON");
	elseif dest == "���������" then
		SetPlayerInstance(playerid,"DEMONLORD");
	elseif dest == "��������-������" then
		SetPlayerInstance(playerid,"SHADOWBEAST_SKELETON");
	elseif dest == "��������" then
		SetPlayerInstance(playerid,"SHADOWBEAST");
	elseif dest == "������������" then
		SetPlayerInstance(playerid,"SHADOWBEAST_ADDON_FIRE");
	elseif dest == "�����" then
		SetPlayerInstance(playerid,"STONEGOLEM");
		SetPlayerHealth(playerid,1000);
		SetPlayerMaxHealth(playerid,1000);
	elseif dest == "������" then
		SetPlayerInstance(playerid,"ICEGOLEM");
		SetPlayerHealth(playerid,1000);
		SetPlayerMaxHealth(playerid,1000);
	elseif dest == "������" then
		SetPlayerInstance(playerid,"FIREGOLEM");
		SetPlayerHealth(playerid,1000);
		SetPlayerMaxHealth(playerid,1000);
	elseif dest == "������" then
		SetPlayerInstance(playerid,"SWAMPGOLEM");
		SetPlayerHealth(playerid,1000);
		SetPlayerMaxHealth(playerid,1000);
	elseif dest == "���" then
		SetPlayerInstance(playerid,"MEATBUG");
	elseif dest == "������" then
		SetPlayerInstance(playerid,"GOBBO_GREEN");
		EquipMeleeWeapon(playerid,"gkwqdz_ItMw_1h_Bau_MacE");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "�������" then
		SetPlayerInstance(playerid,"GOBBO_BLACK");
		EquipMeleeWeapon(playerid,"gkwqdz_ItMw_1h_Bau_MacE");
		SetPlayerMaxHealth(playerid, 500)
		SetPlayerHealth(playerid, 500)
	elseif dest == "�������" then
		SetPlayerInstance(playerid,"GOBBO_SKELETON");
		EquipMeleeWeapon(playerid,"gkwqdz_ItMw_1h_Bau_MacE");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "�������" then
		SetPlayerInstance(playerid,"GOBBO_WARRIOR");
		EquipMeleeWeapon(playerid,"gkwqdz_ItMw_1h_MISC_SworD");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "������" then
		SetPlayerInstance(playerid,"WISP");

	elseif dest == "�������" then
		SetPlayerInstance(playerid,"BLATTCRAWLER");
	elseif dest == "�������" then
		SetPlayerInstance(playerid,"MINECRAWLER");
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
	elseif dest == "��������" then
		SetPlayerInstance(playerid,"MINECRAWLERWARRIOR");
		SetPlayerMaxHealth(playerid, 600)
		SetPlayerHealth(playerid, 600)
	elseif dest == "���" then

		ClearInventory(playerid);
		SetPlayerInstance(playerid,"PC_Orc");
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_04");
		SetPlayerStrength(playerid, 45);
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
		
	elseif dest == "���-����" then
	
		ClearInventory(playerid);
		SetPlayerInstance(playerid,"ORCWARRIOR_ROAM");
		SetPlayerStrength(playerid, 60);
		SetPlayerMaxHealth(playerid, 300)
		SetPlayerHealth(playerid, 300)
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_04");
		
	elseif dest == "���-�������" then
		SetPlayerInstance(playerid,"ORCELITE_ROAM");
		SetPlayerStrength(playerid, 60);
		SetPlayerMaxHealth(playerid, 400)
		SetPlayerHealth(playerid, 400)
		ClearInventory(playerid);
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_04");

	elseif dest == "���-�����" then
		SetPlayerInstance(playerid,"ORCSHAMAN_SIT");
		SetPlayerMana(playerid,600);
		SetPlayerMaxMana(playerid,600);
		SetPlayerMaxHealth(playerid, 250)
		SetPlayerHealth(playerid, 250)
		SetPlayerStrength(playerid, 60);

		ClearInventory(playerid);
		GiveItem(playerid, "ITRU_CHARGEFIREBALL", 1);
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_03");

	elseif dest == "���-������" then
		SetPlayerInstance(playerid,"OrcSkeleton");
		SetPlayerStrength(playerid, 60);
		SetPlayerMaxHealth(playerid, 400)
		SetPlayerHealth(playerid, 400)
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_04");


	elseif dest == "����" then
		SetPlayerInstance(playerid,"DRACONIAN");
		SetPlayerMana(playerid,600);
		SetPlayerMaxMana(playerid,600);
		SetPlayerStrength(playerid, 60);
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_04");
		SetPlayerMagicLevel(playerid, 6);

	elseif dest == "���-������" then
		SetPlayerInstance(playerid,"UNDEADORCWARRIOR");
		SetPlayerStrength(playerid, 60);
		EquipMeleeWeapon(playerid, "gkwqdz_ITMW_2H_ORCAXE_02");
		
	elseif dest == "������-����" then
	
		ClearInventory(playerid);
		SetPlayerInstance(playerid,"SKELETON_LORD");
		SetPlayerStrength(playerid, 60);
		SetPlayerMaxHealth(playerid, 450)
		SetPlayerHealth(playerid, 450)
		EquipMeleeWeapon(playerid, "gkwqdz_ItMw_2H_Sword_M_01");
		EquipArmor(playerid, "huzvui_ITAR_PAL_SKEL");
		
	elseif dest == "������" then

		ClearInventory(playerid);
		SetPlayerInstance(playerid,"SKELETON");
		EquipMeleeWeapon(playerid, "gkwqdz_ItMw_2H_Sword_M_01");
		SetPlayerStrength(playerid, 45);
		SetPlayerMaxHealth(playerid, 350)
		SetPlayerHealth(playerid, 350)

	elseif dest == "������-���" then

		ClearInventory(playerid);
		SetPlayerInstance(playerid,"SKELETONMAGE");
		EquipMeleeWeapon(playerid, "gkwqdz_ItMw_2H_Sword_M_01");
		SetPlayerMaxHealth(playerid, 500)
		SetPlayerHealth(playerid, 500)
		SetPlayerMaxMana(playerid, 700)
		SetPlayerMana(playerid, 700)
		GiveItem(playerid, "ITRU_CHARGEFIREBALL", 1);
		GiveItem(playerid, "ITRU_ICECUBE", 1);

	elseif dest == "������-�����" then

		ClearInventory(playerid);
		SetPlayerInstance(playerid,"SKELETON_PIRATE");
		EquipMeleeWeapon(playerid, "GKWQDZ_ItMw_Addon_PIR1hSword");
		SetPlayerStrength(playerid, 50);
		SetPlayerMaxHealth(playerid, 380)
		SetPlayerHealth(playerid, 380)

	elseif dest == "������-�������" then

		ClearInventory(playerid);
		SetPlayerInstance(playerid,"SKELETON_CAPTAIN");
		EquipMeleeWeapon(playerid, "GKWQDZ_ItMw_Rapier");
		SetPlayerStrength(playerid, 50);
		SetPlayerMaxHealth(playerid, 380)
		SetPlayerHealth(playerid, 380)

	elseif dest == "�������" then
		SetPlayerInstance(playerid,"Dragon_Dark");
	elseif dest == "�������" then
		SetPlayerInstance(playerid,"TROLL_DEAD");
	elseif dest == "���������" then
		SetPlayerInstance(playerid,"SWAMPSHARK");
	elseif dest == "�������" then
		SetPlayerInstance(playerid,"TROLL_BLACK");
	elseif dest == "�������" then
		SetPlayerInstance(playerid,"BEAR");
	elseif dest == "����" then
		SetPlayerInstance(playerid,"BAT");
	elseif dest == "������1" then
		SetPlayerInstance(playerid,"CART");
	elseif dest == "������2" then
	SetPlayerInstance(playerid,"BIGCART");
	elseif dest == "��������" then
	SetPlayerInstance(playerid,"CRAWLERQUEEN");
	end
end

function CMD_INSTANC_NPC(playerid, params)

	local result, pid, dest = sscanf(params,"ds");
	if result == 1 then
		if Player[playerid].astatus > 0 then
			InstancePlayer(pid, dest);
			LogString("logGAMETECH", Player[pid].nickname.." ��������� � "..dest)
		end
	else
		SendPlayerMessage(playerid,255,255,0,string.format("%s","(INFO): ��������� /���� (id) (instance)"));
	end


end
addCommandHandler({"/����","/inst"}, CMD_INSTANC_NPC)