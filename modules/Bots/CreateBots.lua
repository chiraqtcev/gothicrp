

function CreatorNPC(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, name, save = sscanf(params, "sd");
		if result == 1 then

			if save == 1 then

				local bodyModel, bodyTexture, headModel, headTexture = GetPlayerAdditionalVisual(playerid);
				local posX, posY, posZ = GetPlayerPos(playerid);
				local angle = GetPlayerAngle(playerid);
				--createNPC(name, bodyModel, bodyTexture, headModel, headTexture, "NULL", GetPlayerInstance(playerid), posX, posY, posZ, angle, GetPlayerWorld(playerid), GetEquippedMeleeWeapon(playerid), GetEquippedRangedWeapon(playerid), GetEquippedArmor(playerid), GetPlayerVirtualWorld(playerid));

				local bot = CreateNPC(name);
				SpawnPlayer(bot);
				SetPlayerWorld(bot, GetPlayerWorld(playerid));
				SetPlayerVirtualWorld(bot, GetPlayerVirtualWorld(playerid));
				SetPlayerPos(bot, posX, posY, posZ);
				SetPlayerAngle(bot, angle);
				SetPlayerInstance(bot, GetPlayerInstance(playerid));

				if GetPlayerInstance(bot) == "PC_HERO" then
					SetPlayerAdditionalVisual(bot, bodyModel, bodyTexture, headModel, headTexture);
				end
				if GetEquippedMeleeWeapon(playerid) ~= "NULL" then
					EquipMeleeWeapon(bot, GetEquippedMeleeWeapon(playerid));
				end

				if GetEquippedRangedWeapon(playerid) ~= "NULL" then
					EquipRangedWeapon(bot, GetEquippedRangedWeapon(playerid))
				end

				if GetEquippedArmor(playerid) ~= "NULL" then
					EquipArmor(bot, GetEquippedArmor(playerid));
				end

				local npcFile = io.open("npc.list", "a");		
				npcFile:write(name, " ");
				npcFile:write(bodyModel, " ");
				npcFile:write(bodyTexture, " ");
				npcFile:write(headModel, " ");
				npcFile:write(headTexture, " ");
				npcFile:write("NULL", " ");
				npcFile:write(GetPlayerInstance(playerid), " ");
				npcFile:write(posX, " ");
				npcFile:write(posY, " ");
				npcFile:write(posZ, " ");
				npcFile:write(angle, " ");
				npcFile:write(GetPlayerWorld(playerid), " ");
				npcFile:write(GetEquippedMeleeWeapon(playerid)," ");
				npcFile:write(GetEquippedRangedWeapon(playerid)," ");
				npcFile:write(GetEquippedArmor(playerid)," ");
				npcFile:write(GetPlayerVirtualWorld(playerid),"\n");	
				npcFile:close();


			elseif save == 0 then

				local bodyModel, bodyTexture, headModel, headTexture = GetPlayerAdditionalVisual(playerid);
				local posX, posY, posZ = GetPlayerPos(playerid);
				local angle = GetPlayerAngle(playerid);
				--createNPC(name, bodyModel, bodyTexture, headModel, headTexture, "NULL", GetPlayerInstance(playerid), posX, posY, posZ, angle, GetPlayerWorld(playerid), GetEquippedMeleeWeapon(playerid), GetEquippedRangedWeapon(playerid), GetEquippedArmor(playerid), GetPlayerVirtualWorld(playerid));
				
				local bot = CreateNPC(name);
				SpawnPlayer(bot);
				SetPlayerWorld(bot, GetPlayerWorld(playerid));
				SetPlayerVirtualWorld(bot, GetPlayerVirtualWorld(playerid));
				SetPlayerPos(bot, posX, posY, posZ);
				SetPlayerAngle(bot, angle);
				SetPlayerInstance(bot, GetPlayerInstance(playerid));

				if GetPlayerInstance(bot) == "PC_HERO" then
					SetPlayerAdditionalVisual(bot, bodyModel, bodyTexture, headModel, headTexture);
				end
				if GetEquippedMeleeWeapon(playerid) ~= "NULL" then
					EquipMeleeWeapon(bot, GetEquippedMeleeWeapon(playerid));
				end

				if GetEquippedRangedWeapon(playerid) ~= "NULL" then
					EquipRangedWeapon(bot, GetEquippedRangedWeapon(playerid))
				end

				if GetEquippedArmor(playerid) ~= "NULL" then
					EquipArmor(bot, GetEquippedArmor(playerid));
				end

			end

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/νορ (θμÿ) (ρξυπΰνενθε).");
		end
	end

end
addCommandHandler({"/νορ"}, CreatorNPC);

function NCInit()

	local npcFile = io.open("npc.list", "r+");
	local filestream = npcFile:read();
	for line in io.lines("npc.list") do
		local result, name, bodyModel, bodyTexture, headModel, headTexture, anim, nInstance, posX, posY, posZ, angle, world, melee, ranged, armor, vw = sscanf(filestream,"ssdsdssddddssssd");
		if result==1 then
			createNPC(name, bodyModel, bodyTexture, headModel, headTexture, anim, nInstance, posX, posY, posZ, angle, world, melee, ranged, armor, vw);
		end
		filestream = npcFile:read("*l");
	end
	npcFile:close();

	print("NPC load");
end