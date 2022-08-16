
--  # Chest system by royclapton #
--  #       version: 1.0         #

local chest_window_left = CreateTexture(200, 1673, 3276, 7255, 'chest_gui_v5_chest')
local chest_window_right = CreateTexture(4776, 1673, 7846, 7255, 'chest_gui_v5_player')
local select_amount_block = CreateTexture(3475, 3960, 4635, 4485, 'menu_ingame')

-- админское открывание сундука
-- эксперимент с триггером (типо чтобы каждый сундук не прописывать туда)

CHEST = {};
DIR = "Database/Chests/";
DIRITEMS = "Database/Chests/Items/";
DIRINFO = "Database/Chests/Info/";

function _initChest()

	WORLD = "RPCORNER_KHORINIS.ZEN";
	_chestArr = {};

	-- #############################################################################
	-- ДОМА
	-- #############################################################################
	
	-- сундук в доме 1 (Боспер)
										
	_chestArr[1] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_1", WORLD, 8294.4921875, 273.60739135742, -2595.1494140625, "chest_1");
	Mob.SetRotation(_chestArr[1], 0, 153, 0)

	-- сундук в доме 2 (Торбен)
										
	_chestArr[2] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_2", WORLD, 7588.19140625, 273.18115234375, -2679.8410644531, "chest_2");
	Mob.SetRotation(_chestArr[2], 0, 330, 0)

	-- сундук в доме 3 (Маттео)
										
	_chestArr[3] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_3", WORLD, 6397.1337890625, 273.8720703125, -5325.6459960938, "chest_3");
	Mob.SetRotation(_chestArr[3], 0, 349, 0)

	-- сундук в доме 4 (Гарад)
										
	_chestArr[4] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_4", WORLD, 6088.51953125, 273.83486938477, -179.17907714844, "chest_4");
	Mob.SetRotation(_chestArr[4], 0, 237, 0)

	-- сундук в доме 5 (Константино)
										
	_chestArr[5] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_5", WORLD, 6651.546875, 126.93116760254, 58.411846160889, "chest_5");
	Mob.SetRotation(_chestArr[5], 0, 142, 0)

	-- сундук в доме 6 (Дом на 2 этаже)
										
	_chestArr[6] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_6", WORLD, 6835.8671875, 534.24896240234, -386.14410400391, "chest_6");
	Mob.SetRotation(_chestArr[6], 0, 325, 0)

	-- сундук в доме 7 (Верхний квартал)
										
	_chestArr[7] = Mob.Create("ChestBig_NW_Rich_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_7", WORLD, 12377.421875, 1303.2808837891, -4551.0419921875, "chest_7");
	Mob.SetRotation(_chestArr[7], 0, 274, 0)

	-- сундук в доме 8 (Верхний квартал)
										
	_chestArr[8] = Mob.Create("ChestBig_NW_Rich_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_8", WORLD, 12839.139648438, 1303.2816162109, -4858.9399414062, "chest_8");
	Mob.SetRotation(_chestArr[8], 0, 358, 0)

	-- сундук в доме 9 (Верхний квартал)
										
	_chestArr[9] = Mob.Create("ChestBig_NW_Rich_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_9", WORLD, 15270.767578125, 903.78149414062, -4158.189453125, "chest_9");
	Mob.SetRotation(_chestArr[9], 0, 297, 0)

	-- сундук в доме 10 (Верхний квартал)
										
	_chestArr[10] = Mob.Create("ChestBig_NW_Rich_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_10", WORLD, 10099.26953125, 1303.3887939453, -3000.3168945312, "chest_10");
	Mob.SetRotation(_chestArr[10], 0, 42, 0)

	-- сундук в доме 11 (Верхний квартал)
										
	_chestArr[11] = Mob.Create("ChestBig_NW_Rich_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_11", WORLD, 16859.7578125, 1303.3405761719, -3122.2102050781, "chest_11");
	Mob.SetRotation(_chestArr[11], 0, 4, 0)

	-- сундук в доме 12 (Верхний квартал)
										
	_chestArr[12] = Mob.Create("ChestBig_NW_Rich_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_12", WORLD, 10402.536132812, 1303.4384765625, 1347.9136962891, "chest_12");
	Mob.SetRotation(_chestArr[12], 0, 76, 0)

	-- сундук в доме 13 (Верхний квартал)
										
	_chestArr[13] = Mob.Create("ChestBig_NW_Rich_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_13", WORLD, 11071.19921875, 903.43316650391, 3615.701171875, "chest_13");
	Mob.SetRotation(_chestArr[13], 0, 147, 0)

	-- сундук в доме 14 (Торговый квартал)
										
	_chestArr[14] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_14", WORLD, 6069.255859375, 613.13720703125, 1745.9892578125, "chest_14");
	Mob.SetRotation(_chestArr[14], 0, 216, 0)

	-- сундук в доме 15 (Торговый квартал)
										
	_chestArr[15] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_15", WORLD, 4431.9775390625, 593.05865478516, 3039.0932617188, "chest_15");
	Mob.SetRotation(_chestArr[15], 0, 157, 0)

	-- сундук в доме 16 (Торговый квартал)
										
	_chestArr[16] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_16", WORLD, 9089.375, 660.32177734375, 6121.7211914062, "chest_16");
	Mob.SetRotation(_chestArr[16], 0, 66, 0)

	-- сундук в доме 17 (Торговый квартал)
										
	_chestArr[17] = Mob.Create("ChestBig_NW_Normal_Locked.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_17", WORLD, 8220.9765625, 273.16497802734, 3607.4880371094, "chest_17");
	Mob.SetRotation(_chestArr[17], 0, 65, 0)

	-- сундук в доме 18 (Портовый квартал)
										
	_chestArr[18] = Mob.Create("ChestBig_OCChestMediumLocked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_18", WORLD, 5209.6953125, -178.77725219727, 426.02478027344, "chest_18");
	Mob.SetRotation(_chestArr[18], 0, 324, 0)

	-- сундук в доме 19 (Портовый квартал)
										
	_chestArr[19] = Mob.Create("ChestBig_OCChestMediumLocked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_19", WORLD, 4260.5732421875, -100.39962768555, -2145.1137695312, "chest_19");
	Mob.SetRotation(_chestArr[19], 0, 268, 0)

	-- сундук в доме 20 (Портовый квартал)
										
	_chestArr[20] = Mob.Create("ChestBig_OCChestMediumLocked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_20", WORLD, 3223.2248535156, -5.8509087562561, -1167.2888183594, "chest_20");
	Mob.SetRotation(_chestArr[20], 0, 359, 0)

	-- сундук в доме 21 (Портовый квартал)
										
	_chestArr[21] = Mob.Create("ChestBig_OCChestMediumLocked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_21", WORLD, 3073.2004394531, 287.02883911133, -642.05255126953, "chest_21");
	Mob.SetRotation(_chestArr[21], 0, 180, 0)

	-- сундук в доме 22 (Портовый квартал)
										
	_chestArr[22] = Mob.Create("ChestBig_OCChestMediumLocked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_22", WORLD, 2191.771484375, -112.00724029541, -2110.8317871094, "chest_22");
	Mob.SetRotation(_chestArr[22], 0, 271, 0)

	-- сундук в доме 23 (Портовый квартал)
										
	_chestArr[23] = Mob.Create("Chestsmall_NW_Poor_Locked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_23", WORLD, 1337.9248046875, -180.82173156738, -769.01000976562, "chest_23");
	Mob.SetRotation(_chestArr[23], 0, 91, 0)		

	-- сундук в доме 24 (Портовый квартал)
										
	_chestArr[24] = Mob.Create("Chestsmall_NW_Poor_Locked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_24", WORLD, 2106.115234375, -182.44723510742, 1585.6767578125, "chest_24");
	Mob.SetRotation(_chestArr[24], 0, 173, 0)	

	-- сундук в доме 25 (Портовый квартал)
										
	_chestArr[25] = Mob.Create("Chestsmall_NW_Poor_Locked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_25", WORLD, 2820.6965332031, -182.38972473145, 311.42663574219, "chest_25");
	Mob.SetRotation(_chestArr[25], 0, 6, 0)	

	-- сундук в доме 26 (Портовый квартал)
										
	_chestArr[26] = Mob.Create("Chestsmall_NW_Poor_Locked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_26", WORLD, 2180.5068359375, -181.99996948242, 2056.0080566406, "chest_26");
	Mob.SetRotation(_chestArr[26], 0, 250, 0)

	-- сундук в доме 27 (Портовый квартал)
										
	_chestArr[27] = Mob.Create("ChestBig_OCChestMediumLocked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_27", WORLD, -192.93263244629, 90.518371582031, 2048.9543457031, "chest_27");
	Mob.SetRotation(_chestArr[27], 0, 174, 0)

	-- сундук в доме 28 (Портовый квартал)
										
	_chestArr[28] = Mob.Create("ChestBig_OCChestMediumLocked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_28", WORLD, -1020.2009277344, -179.66160583496, 2659.9792480469, "chest_28");
	Mob.SetRotation(_chestArr[28], 0, 268, 0)

	-- сундук в доме 29 (Портовый квартал)
										
	_chestArr[29] = Mob.Create("ChestBig_OCChestMediumLocked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_29", WORLD, -1126.294921875, -170.14253234863, 4600.1083984375, "chest_29");
	Mob.SetRotation(_chestArr[29], 0, 142, 0)	

	-- сундук в доме 30 (Портовый квартал)
										
	_chestArr[30] = Mob.Create("Chestsmall_NW_Poor_Locked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_30", WORLD, -599.94482421875, -182.24543762207, -6000.1982421875, "chest_30");
	Mob.SetRotation(_chestArr[30], 0, 320, 0)		

	-- сундук в доме 31 (Портовый квартал)
										
	_chestArr[31] = Mob.Create("Chestsmall_NW_Poor_Locked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_31", WORLD, 179.69470214844, -182.24543762207, -5232.4731445312, "chest_31");
	Mob.SetRotation(_chestArr[31], 0, 313, 0)

	-- сундук в доме 32 (Портовый квартал)
										
	_chestArr[32] = Mob.Create("Chestsmall_NW_Poor_Locked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_32", WORLD, 1201.8297119141, -182.74584960938, -4819.6860351562, "chest_32");
	Mob.SetRotation(_chestArr[32], 0, 206, 0)

	-- сундук в доме 33 (Портовый квартал)
										
	_chestArr[33] = Mob.Create("Chestsmall_NW_Poor_Locked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_33", WORLD, 3293.2700195312, -112.94424438477, -3376.9907226562, "chest_33");
	Mob.SetRotation(_chestArr[33], 0, 203, 0)

	-- сундук в доме 34 (Портовый квартал)
										
	_chestArr[34] = Mob.Create("Chestsmall_NW_Poor_Locked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_34", WORLD, 2620.0334472656, -112.94434356689, -3132.2028808594, "chest_34");
	Mob.SetRotation(_chestArr[34], 0, 196, 0)

	-- сундук в доме 35 (Портовый квартал)
										
	_chestArr[35] = Mob.Create("Chestsmall_NW_Poor_Locked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_35", WORLD, 3244.2717285156, -112.91236114502, -5470.0747070312, "chest_35");
	Mob.SetRotation(_chestArr[35], 0, 126, 0)

	-- сундук в доме 36 (Портовый квартал)
										
	_chestArr[36] = Mob.Create("Chestsmall_NW_Poor_Locked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_36", WORLD, 4633.0888671875, -103.80371856689, -4481.7368164062, "chest_36");
	Mob.SetRotation(_chestArr[36], 0, 212, 0)

	-- сундук в доме 37 (Портовый квартал)
										
	_chestArr[37] = Mob.Create("Chestsmall_NW_Poor_Locked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_keychest_37", WORLD, 4073.7106933594, -111.64363861084, -6803.1879882812, "chest_37");
	Mob.SetRotation(_chestArr[37], 0, 228, 0)

	-- #############################################################################
	-- ПРЕДПРИЯТИЯ
	-- #############################################################################

	-- сундук 1 на складе 1 (Портовый квартал)
										
	_chestArr[38] = Mob.Create("ChestBig_OCChestLargeLocked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_key_warehouse_01", WORLD, 1869.7169189453, -185.70420837402, 2936.8334960938, "chest_38");
	Mob.SetRotation(_chestArr[38], 0, 322, 0)

	-- сундук 2 на складе 1 (Портовый квартал)
										
	_chestArr[39] = Mob.Create("ChestBig_OCChestLargeLocked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_key_warehouse_01", WORLD, 1473.8054199219, 113.15247344971, 2662.1794433594, "chest_39");
	Mob.SetRotation(_chestArr[39], 0, 340, 0)

	-- сундук 3 на складе 1 (Портовый квартал)
										
	_chestArr[40] = Mob.Create("ChestBig_OCChestLargeLocked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_key_warehouse_01", WORLD, 1757.5423583984, 113.21334838867, 2907.0024414062, "chest_40");
	Mob.SetRotation(_chestArr[40], 0, 7, 0)

	-- сундук 1 на складе 2 (Портовый квартал)
										
	_chestArr[41] = Mob.Create("ChestBig_OCChestLargeLocked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_key_warehouse_02", WORLD, -631.9189453125, -179.52923583984, 1659.8067626953, "chest_41");
	Mob.SetRotation(_chestArr[41], 0, 93, 0)

	-- сундук 2 на складе 2 (Портовый квартал)
										
	_chestArr[42] = Mob.Create("ChestBig_OCChestLargeLocked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_key_warehouse_02", WORLD, -413.6643371582, -179.59645080566, 1498.873046875, "chest_42");
	Mob.SetRotation(_chestArr[42], 0, 330, 0)

	-- сундук 3 на складе 2 (Портовый квартал)
										
	_chestArr[43] = Mob.Create("ChestBig_OCChestLargeLocked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_key_warehouse_02", WORLD, -210.60273742676, -179.60775756836, 1781.0339355469, "chest_43");
	Mob.SetRotation(_chestArr[43], 0, 224, 0)

	-- сундук в таверне (Портовый квартал)
										
	_chestArr[44] = Mob.Create("ChestBig_NW_Normal_Locked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_key_tavern_02", WORLD, -972.49151611328, -171.55653381348, -992.80139160156, "chest_44");
	Mob.SetRotation(_chestArr[44], 0, 184, 0)

	-- сундук в таверне (Храмовый квартал)
										
	_chestArr[45] = Mob.Create("ChestBig_NW_Normal_Locked.mds", "MOBNAME_CHEST", 1, "CHESTBIG", "qbduuo_itke_key_tavern_01", WORLD, 7715.0859375, 131.8490447998, 1379.6407470703, "chest_45");
	Mob.SetRotation(_chestArr[45], 0, 121, 0)


	print(" ");
	print(table.getn(_chestArr).." chests load")

end

function _useChest(id, sc, chest_id, used)
	
	if sc == "CHESTBIG" then
		if used == 1 then


			if chest_id == "CHEST_1" then
				Player[id].chest_id = 1;
				_chestDraw(id, 1);

			elseif chest_id == "CHEST_2" then
				Player[id].chest_id = 2;
				_chestDraw(id, 2);

			elseif chest_id == "CHEST_3" then
				Player[id].chest_id = 3;
				_chestDraw(id, 3);

			elseif chest_id == "CHEST_4" then
				Player[id].chest_id = 4;
				_chestDraw(id, 4);

			elseif chest_id == "CHEST_5" then
				Player[id].chest_id = 5;
				_chestDraw(id, 5);

			elseif chest_id == "CHEST_6" then
				Player[id].chest_id = 6;
				_chestDraw(id, 6);

			elseif chest_id == "CHEST_7" then
				Player[id].chest_id = 7;
				_chestDraw(id, 7);

			elseif chest_id == "CHEST_8" then
				Player[id].chest_id = 8;
				_chestDraw(id, 8);

			elseif chest_id == "CHEST_9" then
				Player[id].chest_id = 9;
				_chestDraw(id, 9);

			elseif chest_id == "CHEST_10" then
				Player[id].chest_id = 10;
				_chestDraw(id, 10);
				
			elseif chest_id == "CHEST_11" then
				Player[id].chest_id = 11;
				_chestDraw(id, 11);		
				
			elseif chest_id == "CHEST_12" then
				Player[id].chest_id = 12;
				_chestDraw(id, 12);	
				
			elseif chest_id == "CHEST_13" then
				Player[id].chest_id = 13;
				_chestDraw(id, 13);	
				
			elseif chest_id == "CHEST_14" then
				Player[id].chest_id = 14;
				_chestDraw(id, 14);	
				
			elseif chest_id == "CHEST_15" then
				Player[id].chest_id = 15;
				_chestDraw(id, 15);

			elseif chest_id == "CHEST_16" then
				Player[id].chest_id = 16;
				_chestDraw(id, 16);

			elseif chest_id == "CHEST_17" then
				Player[id].chest_id = 17;
				_chestDraw(id, 17);

			elseif chest_id == "CHEST_18" then
				Player[id].chest_id = 18;
				_chestDraw(id, 18);

			elseif chest_id == "CHEST_19" then
				Player[id].chest_id = 19;
				_chestDraw(id, 19);
			
			elseif chest_id == "CHEST_20" then
				Player[id].chest_id = 20;
				_chestDraw(id, 20);

			elseif chest_id == "CHEST_21" then
				Player[id].chest_id = 21;
				_chestDraw(id, 21);
			
			elseif chest_id == "CHEST_22" then
				Player[id].chest_id = 22;
				_chestDraw(id, 22);

			elseif chest_id == "CHEST_23" then
				Player[id].chest_id = 23;
				_chestDraw(id, 23);
			
			elseif chest_id == "CHEST_24" then
				Player[id].chest_id = 24;
				_chestDraw(id, 24);

			elseif chest_id == "CHEST_25" then
				Player[id].chest_id = 25;
				_chestDraw(id, 25);

			elseif chest_id == "CHEST_26" then
				Player[id].chest_id = 26;
				_chestDraw(id, 26);
		
			elseif chest_id == "CHEST_27" then
				Player[id].chest_id = 27;
				_chestDraw(id, 27);

			elseif chest_id == "CHEST_28" then
				Player[id].chest_id = 28;
				_chestDraw(id, 28);

			elseif chest_id == "CHEST_29" then
				Player[id].chest_id = 29;
				_chestDraw(id, 29);

			elseif chest_id == "CHEST_30" then
				Player[id].chest_id = 30;
				_chestDraw(id, 30);

			elseif chest_id == "CHEST_31" then
				Player[id].chest_id = 31;
				_chestDraw(id, 31);

			elseif chest_id == "CHEST_32" then
				Player[id].chest_id = 32;
				_chestDraw(id, 32);

			elseif chest_id == "CHEST_33" then
				Player[id].chest_id = 33;
				_chestDraw(id, 33);

			elseif chest_id == "CHEST_34" then
				Player[id].chest_id = 34;
				_chestDraw(id, 34);

			elseif chest_id == "CHEST_35" then
				Player[id].chest_id = 35;
				_chestDraw(id, 35);

			elseif chest_id == "CHEST_36" then
				Player[id].chest_id = 36;
				_chestDraw(id, 36);

			elseif chest_id == "CHEST_37" then
				Player[id].chest_id = 37;
				_chestDraw(id, 37);

			elseif chest_id == "CHEST_38" then
				Player[id].chest_id = 38;
				_chestDraw(id, 38);

			elseif chest_id == "CHEST_39" then
				Player[id].chest_id = 39;
				_chestDraw(id, 39);

			elseif chest_id == "CHEST_40" then
				Player[id].chest_id = 40;
				_chestDraw(id, 40);

			elseif chest_id == "CHEST_41" then
				Player[id].chest_id = 41;
				_chestDraw(id, 41);

			elseif chest_id == "CHEST_42" then
				Player[id].chest_id = 42;
				_chestDraw(id, 42);

			elseif chest_id == "CHEST_43" then
				Player[id].chest_id = 43;
				_chestDraw(id, 43);

			elseif chest_id == "CHEST_44" then
				Player[id].chest_id = 44;
				_chestDraw(id, 44);

			elseif chest_id == "CHEST_45" then
				Player[id].chest_id = 45;
				_chestDraw(id, 45);

			end
		else

			if Player[id].chest_id ~= 0 then
				_destroyChestDraw(id);
				ShowChat(id, 1);
			end

		end
	end


end

function _chestConnect(id)

	Player[id].chest_id = 0;
	Player[id].chest_select = 0;
	Player[id].chest_return = {0, 0};
	Player[id].chest_amount = {false, 0};
	Player[id].chest_amount_final = "";
	Player[id].chest_amount_pos = {0, 0};
	Player[id].chest_check = false;

	Player[id].chestdraw = {};
	Player[id].chest_pos = {0, 0};
	Player[id].chest_pos_draw = nil;
	Player[id].chest_items = {};
	Player[id].chest_items_ids = 0;

	Player[id].chest_p_draw = {};
	Player[id].chest_p_pos_list = 0;
	Player[id].chest_p_pos = {0, 0}
	Player[id].chest_p_pos_draw = nil;
	Player[id].chest_p_items = {};
	Player[id].chest_p_page = 0;
	Player[id].chest_p_page_current = 0;
	Player[id].chest_p_count = 0;

end

function _chestDraw(id, cid)

	for i = 1, 2 do
		Player[id].chest_items[i] = {};
	end

	local filename = tostring(Player[id].chest_id)..".txt";
	local file = io.open(DIRITEMS..filename, "r");
	if file then

		local count = 0;
		for line in file:lines() do
			local result, item, amount = sscanf(line,"sd");
			if result == 1 then
				count = count + 1;
				Player[id].chest_items[1][#Player[id].chest_items[1] + 1] = item;
				Player[id].chest_items[2][#Player[id].chest_items[2] + 1] = amount;
			end
		end


		Player[id].chest_select = 1;
		Freeze(id);

		_firstOpenChest(id);
		ShowChat(id, 0);

		if count > 0 then
			Player[id].chest_pos = {1, count};
			Player[id].chest_pos_draw = CreatePlayerDraw(id, 330, 2800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			ShowPlayerDraw(id, Player[id].chest_pos_draw);
		else
			Player[id].chest_pos = {0, 0};
		end

		ShowTexture(id, chest_window_left);
		ShowTexture(id, chest_window_right);

		for i = 1, 2 do
			Player[id].chestdraw[i] = {};
		end

		for i = 1, count do
			Player[id].chestdraw[1][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			Player[id].chestdraw[2][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			ShowPlayerDraw(id, Player[id].chestdraw[1][i]);
			ShowPlayerDraw(id, Player[id].chestdraw[2][i]);
		end

		local pos = 2800;
		for i, v in pairs(Player[id].chest_items[1]) do
			local str = string.format("%s", GetItemName(v));
			UpdatePlayerDraw(id, Player[id].chestdraw[1][i], 420, pos, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			pos = pos + 250;
		end

		local pos = 2800;
		for i, v in pairs(Player[id].chest_items[2]) do
			UpdatePlayerDraw(id, Player[id].chestdraw[2][i], 2685, pos, v, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			pos = pos + 250;
		end


	end
end

function _firstOpenChest(id)

	for i = 1, 2 do
		Player[id].chest_p_items[i] = {};
	end

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
	if file then

		Player[id].chest_p_count = 0;
		local items = getPlayerItems(id);
		if items then
			for i in pairs(items) do
				Player[id].chest_p_count = Player[id].chest_p_count + 1;
				table.insert(Player[id].chest_p_items[1], items[i].instance)
				table.insert(Player[id].chest_p_items[2], items[i].amount)
			end
		end

		if Player[id].chest_p_count <= 16 then
			Player[id].chest_p_pos = {1, Player[id].chest_p_count};
			Player[id].chest_p_page = 1;
			Player[id].chest_p_page_current = 1;
			Player[id].chest_items_ids = 1;
		else
			Player[id].chest_p_pos = {1, 16};
			Player[id].chest_p_page_current = 1;
			Player[id].chest_items_ids = 1;

			if Player[id].chest_p_count > 16 and Player[id].chest_p_count <= 32 then
				Player[id].chest_p_page = 2;

			elseif Player[id].chest_p_count > 32 and Player[id].chest_p_count <= 48 then
				Player[id].chest_p_page = 3;

			elseif Player[id].chest_p_count > 48 and Player[id].chest_p_count <= 64 then
				Player[id].chest_p_page = 4;

			elseif Player[id].chest_p_count > 64 and Player[id].chest_p_count <= 80 then
				Player[id].chest_p_page = 5;

			elseif Player[id].chest_p_count > 80 and Player[id].chest_p_count <= 96 then
				Player[id].chest_p_page = 6;

			elseif Player[id].chest_p_count > 96 and Player[id].chest_p_count <= 112 then
				Player[id].chest_p_page = 7;

			elseif Player[id].chest_p_count > 112 and Player[id].chest_p_count <= 128 then
				Player[id].chest_p_page = 8;

			elseif Player[id].chest_p_count > 128 and Player[id].chest_p_count <= 144 then
				Player[id].chest_p_page = 9;
			end
		end

		
		Player[id].chest_p_pos_draw = CreatePlayerDraw(id, 4950, 2800, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		ShowPlayerDraw(id, Player[id].chest_p_pos_draw);

		for i = 1, 2 do
			Player[id].chest_p_draw[i] = {};
		end


		for i = 1, 16 do
			Player[id].chest_p_draw[1][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			Player[id].chest_p_draw[2][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			ShowPlayerDraw(id, Player[id].chest_p_draw[1][i]);
			ShowPlayerDraw(id, Player[id].chest_p_draw[2][i]);
		end

		_updateItemsChest_player(id);

		file:close();
	end
end
----------------------------------------------------------------

function _destroyChestDraw(id)

	local filename = tostring(Player[id].chest_id)..".txt";
	local file = io.open(DIRITEMS..filename, "r");

	local count = 0;
	for line in file:lines() do
		count = count + 1;
	end

	for i = 1, count do
		HidePlayerDraw(id, Player[id].chestdraw[1][i]);
		HidePlayerDraw(id, Player[id].chestdraw[2][i]);
		DestroyPlayerDraw(id, Player[id].chestdraw[1][i]);
		DestroyPlayerDraw(id, Player[id].chestdraw[2][i]);
	end

	----------------------------------

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
	local count = 0;
	for line in file:lines() do
		count = count + 1;
	end

	for i = 1, 16 do
		HidePlayerDraw(id, Player[id].chest_p_draw[1][i]);
		HidePlayerDraw(id, Player[id].chest_p_draw[2][i]);
		DestroyPlayerDraw(id, Player[id].chest_p_draw[1][i]);
		DestroyPlayerDraw(id, Player[id].chest_p_draw[2][i]);
	end

	----------------------------------

	HideTexture(id, chest_window_left);
	HideTexture(id, chest_window_right);

	local cid = Player[id].chest_id;
	Player[id].chest_id = 0;
	Player[id].chest_select = 0;

	Player[id].chest_p_page = 0;
	Player[id].chest_p_page_current = 0;
	Player[id].chest_items = {}
	Player[id].chest_p_items = {};
	Player[id].chest_items_ids = 0;

	if Player[id].chest_pos_draw ~= nil then
		HidePlayerDraw(id, Player[id].chest_pos_draw);
		DestroyPlayerDraw(id, Player[id].chest_pos_draw);
		Player[id].chest_pos_draw = nil;
	end

	if Player[id].chest_p_pos_draw ~= nil then
		HidePlayerDraw(id, Player[id].chest_p_pos_draw);
		DestroyPlayerDraw(id, Player[id].chest_p_pos_draw);
		Player[id].chest_p_pos_draw = nil;
	end



	Player[id].chest_pos = {0, 0};
	Player[id].chest_p_pos = {0, 0};


	if Player[id].chest_amount[1] == true then
		HideTexture(id, select_amount_block);
		HidePlayerDraw(id, chest_amount);
		UpdatePlayerDraw(id, chest_num, 4005, 4040, "", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
		HidePlayerDraw(id, chest_num);
		Player[id].chest_amount_final = "";
		Player[id].chest_amount[1] = false;
		Player[id].chest_amount[2] = 0;
		Player[id].chest_check = false;
	end

	UnFreeze(id);


end

function _destroyAfterDeal(id)

	local count = 0;
	for i, v in pairs(Player[id].chestdraw[1]) do
		count = count + 1;
	end

	for i = 1, count do
		HidePlayerDraw(id, Player[id].chestdraw[1][i]);
		HidePlayerDraw(id, Player[id].chestdraw[2][i]);
		DestroyPlayerDraw(id, Player[id].chestdraw[1][i]);
		DestroyPlayerDraw(id, Player[id].chestdraw[2][i]);
	end

	local count = 0;
	for i, v in pairs(Player[id].chest_p_draw[1]) do
		count = count + 1;
	end

	for i = 1, 16 do
		HidePlayerDraw(id, Player[id].chest_p_draw[1][i]);
		HidePlayerDraw(id, Player[id].chest_p_draw[2][i]);
		DestroyPlayerDraw(id, Player[id].chest_p_draw[1][i]);
		DestroyPlayerDraw(id, Player[id].chest_p_draw[2][i]);
	end

	HideTexture(id, chest_window_left);
	HideTexture(id, chest_window_right);

	local cid = Player[id].chest_id;

	Player[id].chest_items = {}
	Player[id].chest_p_items = {};
	Player[id].chest_items_ids = 0;

	if Player[id].chest_pos_draw ~= nil then
		HidePlayerDraw(id, Player[id].chest_pos_draw);
		DestroyPlayerDraw(id, Player[id].chest_pos_draw);
		Player[id].chest_pos_draw = nil;
	end

	if Player[id].chest_p_pos_draw ~= nil then
		HidePlayerDraw(id, Player[id].chest_p_pos_draw);
		DestroyPlayerDraw(id, Player[id].chest_p_pos_draw);
		Player[id].chest_p_pos_draw = nil;
	end

	Player[id].chest_pos = {0, 0};
	Player[id].chest_p_pos = {0, 0};
	Player[id].chest_return = {0, 0};
	Player[id].chest_p_page = 0;
	Player[id].chest_p_page_current = 0;


	HideTexture(id, select_amount_block);
	HidePlayerDraw(id, chest_amount);
	UpdatePlayerDraw(id, chest_num, 4005, 4040, "", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	HidePlayerDraw(id, chest_num);
	Player[id].chest_amount_final = "";
	Player[id].chest_amount[1] = false;
	Player[id].chest_amount[2] = 0;
	Player[id].chest_check = false;

	_chestDraw(id);

end

function _selectAmount(id)

	if Player[id].chest_amount[1] == false then
		Player[id].chest_amount[2] = 0;
		Player[id].chest_amount_final = "";
		ShowTexture(id, select_amount_block);
		ShowPlayerDraw(id, chest_amount);
		ShowPlayerDraw(id, chest_num);
		Player[id].chest_amount[1] = true;
		Freeze(id);
	end

end

function _cheskLens(id)

	if string.len(Player[id].chest_amount_final) == 1 then
		Player[id].chest_amount_pos = {4005, 4040};

	elseif string.len(Player[id].chest_amount_final) == 2 then
		Player[id].chest_amount_pos = {3990, 4040};

	elseif string.len(Player[id].chest_amount_final) == 3 then
		Player[id].chest_amount_pos = {3960, 4040};

	elseif string.len(Player[id].chest_amount_final) == 4 then
		Player[id].chest_amount_pos = {3920, 4040};

	elseif string.len(Player[id].chest_amount_final) == 5 then
		Player[id].chest_amount_pos = {3880, 4040};

	elseif string.len(Player[id].chest_amount_final) == 6 then
		Player[id].chest_amount_pos = {3840, 4040};

	elseif string.len(Player[id].chest_amount_final) == 7 then
		Player[id].chest_amount_pos = {3800, 4040};
	end


end

function _selectKey(id, down, up)

	if Player[id].chest_amount[1] == true then

		if down == KEY_1 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."1";
				_cheskLens(id);
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_2 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."2";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_3 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."3";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_4 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."4";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_5 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."5";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_6 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."6";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_7 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."7";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_8 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."8";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_9 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."9";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_0 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."0";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_SPACE then
			if Player[id].chest_amount[1] == true then
				local txt = string.sub(Player[id].chest_amount_final, 1, #Player[id].chest_amount_final-1)
				Player[id].chest_amount_final = txt;
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_RETURN then
			if Player[id].chest_select == 2 then
				if string.len(Player[id].chest_amount_final) > 0 then
					Player[id].chest_check = true;
					if Player[id].chest_amount[1] == true and Player[id].chest_check == true then
						local number = tonumber(Player[id].chest_amount_final);
						if number > 0 then
							Player[id].chest_amount[2] = number;

							local key = Player[id].chest_p_pos[1];
							local item = _checkCurrentItem(id, key) -- Player[id].chest_p_items[1][key];
							if item ~= nil then
								local tItem = 0;
								local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
								for line in file:lines() do
									local result, i, a = sscanf(line, "sd");
									if result == 1 then
										if i == item then
											tItem = a;
										end
									end
								end

								if tItem >= Player[id].chest_amount[2] then
									_putInChest(id, item, Player[id].chest_amount[2]);
								else
									GameTextForPlayer(id, 2710, 1055, "У вас нет такого количества.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2000);
									--SendPlayerMessage(id, 255, 255, 255, "У вас нет столько.")
								end
							end
						end
					end
				end

			elseif Player[id].chest_select == 1 then
				if string.len(Player[id].chest_amount_final) > 0 then
					Player[id].chest_check = true;
					if Player[id].chest_amount[1] == true and Player[id].chest_check == true then
						local number = tonumber(Player[id].chest_amount_final);
						if number > 0 then
							Player[id].chest_amount[2] = number;

							local key = Player[id].chest_pos[1];
							local item = Player[id].chest_items[1][key];

							local tItem = 0;
							local file = io.open("Database/Chests/Items/"..Player[id].chest_id..".txt", "r");
							for line in file:lines() do
								local result, i, a = sscanf(line, "sd");
								if result == 1 then
									if i == item then
										tItem = a;
									end
								end
							end

							if tItem >= Player[id].chest_amount[2] then
								_putInPlayer(id, item, Player[id].chest_amount[2]);
							else
								GameTextForPlayer(id, 2710, 1055, "В сундуке нет такого количества.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2000);
								--SendPlayerMessage(id, 255, 255, 255, "В сундуке столько нет.")
							end
						end
					end
				end
			else
			end
		end

	end

end

function _updateItemsChest_player(id)

	if Player[id].chest_p_page_current == 1 then

		local pos = 2800;
		for i = 1, 16 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][i], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][i], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250;
			end
		end

	elseif Player[id].chest_p_page_current == 2 then

		local pos = 2800;
		local c = 1;
		for i = 17, 32 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end


	elseif Player[id].chest_p_page_current == 3 then

		local pos = 2800;
		local c = 1;
		for i = 33, 48 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 4 then

		local pos = 2800;
		local c = 1;
		for i = 49, 64 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 5 then

		local pos = 2800;
		local c = 1;
		for i = 65, 80 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end


	elseif Player[id].chest_p_page_current == 6 then

		local pos = 2800;
		local c = 1;
		for i = 81, 96 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 7 then

		local pos = 2800;
		local c = 1;
		for i = 97, 112 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 8 then

		local pos = 2800;
		local c = 1;
		for i = 113, 128 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 9 then

		local pos = 2800;
		local c = 1;
		for i = 129, 144 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	end

end
----------------------------------------

function _chestKey(id, down, up)

	if Player[id].chest_id ~= 0 and Player[id].loggedIn == true then

		if Player[id].chest_amount[1] == false then
			---------------------------------------------------
			if down == KEY_DOWN then

				if Player[id].chest_select == 1 then

					Player[id].chest_pos[1] = Player[id].chest_pos[1] + 1;
					if Player[id].chest_pos[1] > Player[id].chest_pos[2] then
						Player[id].chest_pos[1] = 1;
					end
					_updateChestPos(id);

				elseif Player[id].chest_select == 2 then

					Player[id].chest_p_pos[1] = Player[id].chest_p_pos[1] + 1;
					if Player[id].chest_p_pos[1] > Player[id].chest_p_pos[2] then
						if Player[id].chest_p_page > 1 then
							Player[id].chest_p_page_current = Player[id].chest_p_page_current + 1;
							_resetalldrawsChest(id);
							_updateItemsChest_player(id);
							if Player[id].chest_p_page_current <= Player[id].chest_p_page then
								Player[id].chest_p_pos[1] = 1;
							else
								Player[id].chest_p_page_current = 1;
								Player[id].chest_p_pos[1] = 1;
								_resetalldrawsChest(id);
								_updateItemsChest_player(id);
							end
						else
							Player[id].chest_p_pos[1] = 1;
						end
					end
					_updateItemsPos(id);
				end

			end
			---------------------------------------------------
			if down == KEY_UP then

				if Player[id].chest_select == 1 then

					Player[id].chest_pos[1] = Player[id].chest_pos[1] - 1;
					if Player[id].chest_pos[1] <= 0 then
						Player[id].chest_pos[1] = Player[id].chest_pos[2];
					end

					_updateChestPos(id);

				elseif Player[id].chest_select == 2 then

					Player[id].chest_p_pos[1] = Player[id].chest_p_pos[1] - 1;
					if Player[id].chest_p_pos[1] < Player[id].chest_p_pos[2] then
						if Player[id].chest_p_page > 1 then
							Player[id].chest_p_page_current = Player[id].chest_p_page_current - 1;
							_resetalldrawsChest(id);
							_updateItemsChest_player(id);
							if Player[id].chest_p_page_current == Player[id].chest_p_page then
								Player[id].chest_p_pos[1] = 16;
							else
								Player[id].chest_p_page_current = 1;
								Player[id].chest_p_pos[1] = 1;
								_resetalldrawsChest(id);
								_updateItemsChest_player(id);
							end
						else
							Player[id].chest_p_pos[1] = 1;
						end
					end
					_updateItemsPos(id);
					_updateItemsChest_player(id);
				end

			end
			---------------------------------------------------
			if down == KEY_RIGHT then

				if Player[id].chest_select == 1 then

					_resetcolorall(id);

					Player[id].chest_select = 2;
					Player[id].chest_pos[1] = 0;
					_updateChestPos(id);

					Player[id].chest_p_pos[1] = 1;
					_updateItemsPos(id);
				end

			end
			---------------------------------------------------
			if down == KEY_LEFT then

				if Player[id].chest_select == 2 then

					_resetcolorall(id);

					Player[id].chest_select = 1;
					Player[id].chest_p_pos[1] = 0;
					_updateItemsPos(id);

					Player[id].chest_pos[1] = 1;
					_updateChestPos(id);
				end
			end
		end

		if down == KEY_ESCAPE then
			ShowChat(id, 1);
			_destroyChestDraw(id);
		end

		---------------------------------------------------

		if down == KEY_RETURN then
			_preaccept(id);
		end
	end

end

function _resetalldrawsChest(id)

	for i = 1, 16 do
		if Player[id].chest_p_draw[1][i] ~= nil then
			SetPlayerDrawText(id, Player[id].chest_p_draw[1][i], "");
			SetPlayerDrawText(id, Player[id].chest_p_draw[2][i], "");
		end
	end

end

function _resetcolorall(id)

	local count = 0;
	for i, _ in pairs(Player[id].chest_items[1]) do
		count = count + 1;
	end

	for i = 1, count do
		SetPlayerDrawColor(id, Player[id].chestdraw[1][i], 255, 255, 255);
		SetPlayerDrawColor(id, Player[id].chestdraw[2][i], 255, 255, 255);
	end

	local count = 0;
	for i, _ in pairs(Player[id].chest_p_items[1]) do
		count = count + 1;
	end

	for i = 1, 16 do
		if Player[id].chest_p_draw[1][i] ~= nil then
			SetPlayerDrawColor(id, Player[id].chest_p_draw[1][i], 255, 255, 255);
			SetPlayerDrawColor(id, Player[id].chest_p_draw[2][i], 255, 255, 255);
		end
	end


end

function _checkCurrentItem(id, cid)

	if Player[id].chest_p_page_current == 1 then

		local c = 1;
		for i = 1, 16 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 2 then

		local c = 1;
		for i = 17, 32 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 3 then

		local c = 1;
		for i = 33, 48 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 4 then

		local c = 1;
		for i = 49, 64 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 5 then

		local c = 1;
		for i = 65, 80 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 6 then

		local c = 1;
		for i = 81, 96 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 7 then

		local c = 1;
		for i = 97, 112 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 8 then

		local c = 1;
		for i = 113, 128 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 9 then

		local c = 1;
		for i = 129, 144 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	end
end

function _checkEmpty(id, cid)

	for i, v in pairs(Player[id].chest_items[1]) do
		if i == cid then
			return false;
		end
	end
	return true;

end

function _checkChestSlots(cid)

	local value = 0;
	local ldir = cid..".txt";
	local file = io.open(DIRITEMS..ldir,"r");

	for line in file:lines() do
		local result, item, amount = sscanf(line, "sd");
		if result == 1 then
			value = value + 1;
		end
	end

	if value < 16 then
		return true;
	else
		return false;
	end

end

function _playerHasItem(id, it)

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
	for line in file:lines() do
		local result, i, a = sscanf(line, "sd");
		if result == 1 then
			if i == it then
				return true;
			end
		end
	end
	return false;

end

function _chestHasItem(cid, it)

	local ldir = cid..".txt";
	local file = io.open(DIRITEMS..ldir,"r");
	for line in file:lines() do
		local result, item, amount = sscanf(line, "sd");
		if result == 1 then
			if item == it then
				return true;
			end
		end
	end
	return false;

end

-- положить в сундук
function _putInChest(id, item, amount)

	
	if _checkChestSlots(Player[id].chest_id) == true or _chestHasItem(Player[id].chest_id, item) == true then

		local key = {};
		for i, v in pairs(Player[id].chest_p_items[1]) do
			if v == item then
				key[1] = i;
				key[2] = v;
				break
			end
		end

		local slot_id = key[1];
		local slot_item = key[2];

		if Player[id].chest_p_items[2][slot_id] > 1 then

			local time = os.date('*t');
		    local ryear = time.year;
			local rmonth = time.month;
			local rday = time.day;
			local rhour = string.format("%02d", time.hour);
			local rminute = string.format("%02d", time.min);
			LogString("Logs/PlayersAll/chest", Player[id].nickname.." забрал из сундука x"..amount.." "..GetItemName(item).." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);

			--SendPlayerMessage(id, 255, 255, 255, "Вы положили в сундук "..GetItemName(item).." x"..amount);
			local str = "Вы положили в сундук "..GetItemName(item).." x"..amount;
			GameTextForPlayer(id, 2710, 1055, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2500);

			RemoveItem(id, item, amount);
			SaveItems(id);

			if _chestHasItem(Player[id].chest_id, item) == false then

				local ldir = Player[id].chest_id..".txt";
				local file = io.open(DIRITEMS..ldir,"a");
				file:write(item.." "..amount.."\n");
				file:close();

			else

				local slot_id_chest = 0;

				for i, v in pairs(Player[id].chest_items[1]) do
					if v == item then
						slot_id_chest = i;
					end
				end

				local ldir = Player[id].chest_id..".txt";

				local oldValue = Player[id].chest_items[2][slot_id_chest];
				local newValue = oldValue + amount;

				local file = io.open(DIRITEMS..ldir,"r+");
				local tempString = file:read("*a");
				file:close();
				local tempString = string.gsub(tempString, string.upper(item).." "..oldValue,string.upper(item).." "..newValue);
				local file = io.open(DIRITEMS..ldir,"w+");
				file:write(tempString);
				file:close();

			end


		elseif Player[id].chest_p_items[2][slot_id] == 1 then

			--SendPlayerMessage(id, 255, 255, 255, "Вы положили в сундук "..GetItemName(item).." x1");

			local time = os.date('*t');
		    local ryear = time.year;
			local rmonth = time.month;
			local rday = time.day;
			local rhour = string.format("%02d", time.hour);
			local rminute = string.format("%02d", time.min);
			LogString("Logs/PlayersAll/chest", Player[id].nickname.." забрал из сундука x1".." "..GetItemName(item).." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);


			local str ="Вы положили в сундук "..GetItemName(item).." x1"
			GameTextForPlayer(id, 2710, 1055, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2500);

			RemoveItem(id, item, 1);
			SaveItems(id);

			table.remove(Player[id].chest_p_items[1], slot_id);
			table.remove(Player[id].chest_p_items[2], slot_id);

			if _chestHasItem(Player[id].chest_id, item) == false then

				local ldir = Player[id].chest_id..".txt";
				local file = io.open(DIRITEMS..ldir,"a");
				file:write(item.." "..amount.."\n");
				file:close();

			else

				local slot_id_chest = 0;

				for i, v in pairs(Player[id].chest_items[1]) do
					if v == item then
						slot_id_chest = i;
					end
				end

				local ldir = Player[id].chest_id..".txt";

				local oldValue = Player[id].chest_items[2][slot_id_chest];
				local newValue = oldValue + 1;

				local file = io.open(DIRITEMS..ldir,"r+");
				local tempString = file:read("*a");
				file:close();
				local tempString = string.gsub(tempString, string.upper(item).." "..oldValue,string.upper(item).." "..newValue);
				local file = io.open(DIRITEMS..ldir,"w+");
				file:write(tempString);
				file:close();

			end

		end

		_destroyAfterDeal(id);
	else
		GameTextForPlayer(id, 2710, 1055, "Сундук переполнен.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2000);
		--SendPlayerMessage(id, 255, 255, 255, "В сундуке нет места.")
	end


end

-- забрать из сундука
function _putInPlayer(id, item, amount)

	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	LogString("Logs/PlayersAll/chest", Player[id].nickname.." забрал из сундука x"..amount.." "..GetItemName(item).." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);

	--SendPlayerMessage(id, 255, 255, 255, "Вы забрали из сундука "..GetItemName(item).." x"..amount);

	local str = "Вы забрали из сундука "..GetItemName(item).." x"..amount;
	GameTextForPlayer(id, 2710, 1055, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2000);
	GiveItem(id, item, amount);
	SaveItems(id);

	local key = {};
	for i, v in pairs(Player[id].chest_items[1]) do
		if v == item then
			key[1] = i;
			key[2] = v;
			break
		end
	end

	local slot_id = key[1];
	local slot_item = key[2];

	if Player[id].chest_items[2][slot_id] > 1 then
		
		local ldir = Player[id].chest_id..".txt";

		local oldValue = Player[id].chest_items[2][slot_id];
		local newValue = oldValue - amount;

		if newValue > 0 then

			local file = io.open(DIRITEMS..ldir,"r+");
			local tempString = file:read("*a");
			file:close();
			local tempString = string.gsub(tempString, string.upper(key[2]).." "..oldValue,string.upper(key[2]).." "..newValue);
			local file = io.open(DIRITEMS..ldir,"w+");
			file:write(tempString);
			file:close();

		else

			table.remove(Player[id].chest_items[1], slot_id);
			table.remove(Player[id].chest_items[2], slot_id);

			local count = 0;
			for i, _ in pairs(Player[id].chest_items[1]) do
				count = count + 1;
			end

			local ldir = Player[id].chest_id..".txt";
			local file = io.open(DIRITEMS..ldir,"w+");

			for i = 1, count do
				file:write(Player[id].chest_items[1][i].." "..Player[id].chest_items[2][i].."\n");
			end

			file:close();
		end

	elseif Player[id].chest_items[2][slot_id] == 1 then
		
		table.remove(Player[id].chest_items[1], slot_id);
		table.remove(Player[id].chest_items[2], slot_id);

		local count = 0;
		for i, _ in pairs(Player[id].chest_items[1]) do
			count = count + 1;
		end

		local ldir = Player[id].chest_id..".txt";
		local file = io.open(DIRITEMS..ldir,"w+");

		for i = 1, count do
			file:write(Player[id].chest_items[1][i].." "..Player[id].chest_items[2][i].."\n");
		end

		file:close();

	end

	_destroyAfterDeal(id);

end

function _preaccept(id)
	
	if Player[id].chest_select == 1 then

		if Player[id].chest_return[2] == 0 then

			local key = Player[id].chest_pos[1];

			if _checkEmpty(id, key) == false then
				SetPlayerDrawColor(id, Player[id].chestdraw[1][key], 149, 247, 69);
				SetPlayerDrawColor(id, Player[id].chestdraw[2][key], 149, 247, 69);
				Player[id].chest_return[2] = key;
				Player[id].chest_return[1] = 1;
			end

		elseif Player[id].chest_return[2] ~= Player[id].chest_pos[1] then

			local key = Player[id].chest_return[2];
			SetPlayerDrawColor(id, Player[id].chestdraw[1][key], 255, 255, 255);
			SetPlayerDrawColor(id, Player[id].chestdraw[2][key], 255, 255, 255);

			local key = Player[id].chest_pos[1];
			SetPlayerDrawColor(id, Player[id].chestdraw[1][key], 149, 247, 69);
			SetPlayerDrawColor(id, Player[id].chestdraw[2][key], 149, 247, 69);
			Player[id].chest_return[2] = key;
			Player[id].chest_return[1] = 1;

		elseif Player[id].chest_return[2] == Player[id].chest_pos[1] then
			_selectAmount(id)
		end

	elseif Player[id].chest_select == 2 then

		if Player[id].chest_return[2] == 0 then

			local key = Player[id].chest_p_pos[1];
			SetPlayerDrawColor(id, Player[id].chest_p_draw[1][key], 149, 247, 69);
			SetPlayerDrawColor(id, Player[id].chest_p_draw[2][key], 149, 247, 69);
			Player[id].chest_return[2] = key;
			Player[id].chest_return[1] = 1;

		elseif Player[id].chest_return[2] ~= Player[id].chest_p_pos[1] then

			local key = Player[id].chest_return[2];
			SetPlayerDrawColor(id, Player[id].chest_p_draw[1][key], 255, 255, 255);
			SetPlayerDrawColor(id, Player[id].chest_p_draw[2][key], 255, 255, 255);

			local key = Player[id].chest_p_pos[1];
			SetPlayerDrawColor(id, Player[id].chest_p_draw[1][key], 149, 247, 69);
			SetPlayerDrawColor(id, Player[id].chest_p_draw[2][key], 149, 247, 69);
			Player[id].chest_return[2] = key;
			Player[id].chest_return[1] = 1;

			

		elseif Player[id].chest_return[2] == Player[id].chest_p_pos[1] then
			_selectAmount(id)
		end

	end

end


function _updateChestPos(id)

	if Player[id].chest_pos[1] ~= 0 and Player[id].chest_pos[2] ~= 0 then

		if Player[id].chest_pos[1] == 1 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 2800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 2 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 3050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 3 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 3300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 4 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 3550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 5 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 3800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 6 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 4050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 7 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 4300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 8 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 4550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 9 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 4800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 10 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 5050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 11 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 5300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 12 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 5550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 13 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 5800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 14 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 6050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 15 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 6300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 16 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 6550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 0 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 0, 0, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end
	end

end

function _updateItemsPos(id)

	-- 4910, 2800 + 250 Y UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 2800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
 
	if Player[id].chest_p_pos[1] ~= 0 and Player[id].chest_p_pos[2] ~= 0 then

		if Player[id].chest_p_pos[1] == 1 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 2800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 2 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 3050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 3 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 3300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 4 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 3550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 5 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 3800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 6 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 4050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 7 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 4300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 8 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 4550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 9 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 4800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 10 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 5050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 11 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 5300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 12 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 5550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 13 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 5800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 14 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 6050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 15 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 6300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 16 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 6550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 0 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 0, 0, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end
	end

end
