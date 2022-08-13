function OtherNPC()


	SELLER_HELM = CreateNPC("Торговец");
	SpawnPlayer(SELLER_HELM);
	SetPlayerWorld(SELLER_HELM, "PAOWORLD.ZEN");
	SetPlayerPos(SELLER_HELM, 9146.919921875, 368.23022460938, 4673.2543945313);
	SetPlayerAngle(SELLER_HELM, 66);
	EquipArmor(SELLER_HELM, "ITAR_VLK_H_BLACK");
	PlayAnimation(SELLER_HELM, "S_LGUARD");
	SetPlayerAdditionalVisual(SELLER_HELM, "Hum_Body_Naked0", 1, "Hum_Head_Bald", 25);

	SELLER_FOOD = CreateNPC("Торговец");
	SpawnPlayer(SELLER_FOOD);
	SetPlayerWorld(SELLER_FOOD, "PAOWORLD.ZEN");
	SetPlayerPos(SELLER_FOOD, 9340.2451171875, 368.24563598633, 4298.2973632813);
	SetPlayerAngle(SELLER_FOOD, 58);
	EquipArmor(SELLER_FOOD, "ITAR_VLK_H_BLACK");
	PlayAnimation(SELLER_FOOD, "S_HGUARD");
	SetPlayerAdditionalVisual(SELLER_FOOD, "Hum_Body_Naked0", 1, "Hum_Head_Bald", 23);

	SELLER_ARMOR = CreateNPC("Торговец");
	SpawnPlayer(SELLER_ARMOR);
	SetPlayerWorld(SELLER_ARMOR, "PAOWORLD.ZEN");
	SetPlayerPos(SELLER_ARMOR, 10341.943359375, 368.29733276367, 4152.1694335938);
	SetPlayerAngle(SELLER_ARMOR, 298);
	EquipArmor(SELLER_ARMOR, "ITAR_VLK_H_BLACK");
	PlayAnimation(SELLER_ARMOR, "S_LGUARD");
	SetPlayerAdditionalVisual(SELLER_ARMOR, "Hum_Body_Naked0", 1, "Hum_Head_Bald", 22);

	SELLER_BONDSTREET = CreateNPC("Торговец");
	SpawnPlayer(SELLER_BONDSTREET);
	SetPlayerWorld(SELLER_BONDSTREET, "PAOWORLD.ZEN");
	SetPlayerPos(SELLER_BONDSTREET, 10126.188476563, 373.14096069336, 2556.2570800781);
	SetPlayerAngle(SELLER_BONDSTREET, 3);
	EquipArmor(SELLER_BONDSTREET, "ITAR_VLK_H_BLACK");
	PlayAnimation(SELLER_BONDSTREET, "S_HGUARD");
	SetPlayerAdditionalVisual(SELLER_BONDSTREET, "Hum_Body_Naked0", 1, "Hum_Head_Bald", 21);

end

