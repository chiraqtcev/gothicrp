--[[
***************************************************
* GMP Movements Gates/Doors script by Risen       *
* Date: 03-07-2013                                *
*                                                 *
* Added unical keys for gates/doors by royclapton *
** Free open for admins                           *
* Date: 31-03-2022/01-04-2022                     *
***************************************************
]]--

local movementTimer;
MovementList     = {};
MovementType     = {TYPE_GATE = 0, TYPE_DOOR = 1};
MovementStatus   = {STATUS_OPENED = 0, STATUS_CLOSED = 1, STATUS_MOVING_TO_OPEN = 2, STATUS_MOVING_TO_CLOSE = 3};
MovementDistance = {DISTANCE_PLAYER_GATE = 1000, DISTANCE_PLAYER_DOOR = 300, DISTANCE_MOVE_GATE = 5};


--[[
prototype of movement:
	type,
	status,
	vobName,
	worldName,
	
	opened_posX,
	opened_posY,
	opened_posZ,
	opened_rotX,
	opened_rotY,
	opened_rotZ,
	
	closed_posX,
	closed_posY,
	closed_posZ,
	closed_rotX,
	closed_rotY,
	closed_rotZ,
	vobID
]]--

function OnFilterscriptInit()

	print("--------------------------------------------------");
	print("Movement Gates/Doors script 0.2 by Risen");
	print("* Add unical keys for gates/doors by royclapton")
	print("** Free open for admins")
	print("--------------------------------------------------");
	movementTimer = SetTimer("MovementProcess",50,1);


	-- #############################################################################
	-- ВОРОТА
	-- #############################################################################

	-- Город - ворота у Верхнего квартала
	movement = CreateMovement(MovementType.TYPE_GATE,MovementStatus.STATUS_OPENED,"OC_LOB_GATE_BIG.3DS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,8116.8843036761, -342.00326538086, -6209.3877701862,0,10,0);
	SetMovementCoordinationAsOpened(movement,8116.8843036761, -2622.00326538086, -6209.3877701862,0,10,0);
	SetMovementKey(movement, "qbduuo_itke_key_citygate");
	-------------------------------------------------------------

	-- Город - ворота у Рыночной площади
	movement = CreateMovement(MovementType.TYPE_GATE,MovementStatus.STATUS_OPENED,"OC_LOB_GATE_BIG.3DS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,10385.835506937,-351.71014404297,5809.4149127126,0,55,0);
	SetMovementCoordinationAsOpened(movement,10385.835506937,-2621.71014404297,5809.4149127126,0,55,0);
	SetMovementKey(movement, "qbduuo_itke_key_citygate");
	-------------------------------------------------------------

	-- Казарма - ворота 1
	movement = CreateMovement(MovementType.TYPE_GATE,MovementStatus.STATUS_OPENED,"OC_LOB_GATE_BIG.3DS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,5601.9464054438,98.216674804688,5498.8532150055,0,-30,0);
	SetMovementCoordinationAsOpened(movement,5601.9464054438,-241.78332519531,5498.8532150055,0,-30,0);
	SetMovementKey(movement, "qbduuo_itke_key_barracks");
	-------------------------------------------------------------

	-- Казарма - ворота 2
	movement = CreateMovement(MovementType.TYPE_GATE,MovementStatus.STATUS_OPENED,"OC_LOB_GATE_BIG.3DS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,6475.0722205036,118.18353271484,8206.4743350891,0,-120,0);
	SetMovementCoordinationAsOpened(movement,6475.0722205036,-241.81646728516,8206.4743350891,0,-120,0);
	SetMovementKey(movement, "qbduuo_itke_key_barracks");
	-------------------------------------------------------------



	-- #############################################################################
	-- ДВЕРИ
	-- #############################################################################

	-- Ратуша - входная дверь
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"DOOR_NW_RICH_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,14389.810348721, 1088.2690429688, -1048.8181225337, 0, 45, 0);
	SetMovementCoordinationAsOpened(movement,14391.866737505, 1088.2482910156, -1164.1251554767, 0, -50, 0);
	SetMovementKey(movement, "qbduuo_itke_key_cityhall");

	-- Суд - входная дверь
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"DOOR_NW_RICH_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,14676.657213564, 1318.1906738281, -3317.1857534494, 0, 25, 0);
	SetMovementCoordinationAsOpened(movement,14768.779365545, 1315.1518554688, -3264.228639481, 0, 120, 0);
	SetMovementKey(movement, "qbduuo_itke_key_court");

	-- Банк - входная дверь
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"DOOR_NW_RICH_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,12075.597543811, 888.18762207031, 2917.0172290202, 0, 200, 0);
	SetMovementCoordinationAsOpened(movement,11970.609729108, 888.20251464844, 2864.5008557417, 0, 290, 0);
	SetMovementKey(movement, "qbduuo_itke_key_bank");

	-- Банк - внутренняя дверь
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"DOOR_NW_RICH_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,12548.828125, 863, 3590.3720703125, 0, 110, 0);
	SetMovementCoordinationAsOpened(movement,12463.25390625, 863.47680664062, 3571.6059570312, 0, 20, 0);
	SetMovementKey(movement, "qbduuo_itke_key_bank");

	-- Тюрьма - камера 1
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"OC_LOB_GATE_SMALL2.3DS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,3782.5559126545,848.20037841797,5226.8241160176,30,0,-90);
	SetMovementCoordinationAsOpened(movement,3782.5559126545,588.20037841797,5226.8241160176,30,0,-90);
	SetMovementKey(movement, "qbduuo_itke_key_prison_door");


	-- Тюрьма - камера 2
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"OC_LOB_GATE_SMALL2.3DS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,4109.2030182522,848.19598388672,5411.9772718668,30,0,-90);
	SetMovementCoordinationAsOpened(movement,4109.2030182522,588.19598388672,5411.9772718668,30,0,-90);
	SetMovementKey(movement, "qbduuo_itke_key_prison_door");

	-- Тюрьма - камера 3
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"OC_LOB_GATE_SMALL2.3DS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,4355.6133956,848.18798828125,5702.2712936641,120,0,-90);
	SetMovementCoordinationAsOpened(movement,4355.6133956,588.18798828125,5702.2712936641,120,0,-90);
	SetMovementKey(movement, "qbduuo_itke_key_prison_door");

	-- Таверна Корагона - дверь 1
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,7903.5400390625, 122.23747253418, 918.83905029297, 0, -148, 0);
	SetMovementCoordinationAsOpened(movement,7797.8920898438, 122.10255432129, 900.94744873047, 0, -37, 0);
	SetMovementKey(movement, "qbduuo_itke_key_tavern_01");

	-- Таверна Корагона - дверь 2
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,9047.5986328125, 134.2416229248, 799.20745849609, 0, 121, 0);
	SetMovementCoordinationAsOpened(movement,9066.26171875, 134.20643615723, 705.21856689453, 0, -132, 0);
	SetMovementKey(movement, "qbduuo_itke_key_tavern_01");

	-- Таверна Корагона - подвал
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,8848.0341796875, -168.89056396484, 1587.4249267578, 0, 215, 0);
	SetMovementCoordinationAsOpened(movement,8828.9365234375, -169.89056396484, 1681.4343261719, 0, 113, 0);
	SetMovementKey(movement, "qbduuo_itke_key_tavern_01");

	-- Портовая таверна - вход
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,-1534.8272705078, -191.78816223145, -839.66748046875, -1.6000001430511, 193, 0);
	SetMovementCoordinationAsOpened(movement,-1630.7391357422, -193.64447021484, -890.15588378906, 0, -64, 0);
	SetMovementKey(movement, "qbduuo_itke_key_tavern_02");

	-- Портовая таверна - 2 этаж
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Poor_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsOpened(movement,-1540.73828125, 79.311401367188, -1171.4644775391, 0, -9, 0);
	SetMovementCoordinationAsClosed(movement,-1468.4035644531, 83.311401367188, -1087.8026123047, 0, 96, 0);
	SetMovementKey(movement, "qbduuo_itke_key_tavern_02");

	-- Бордель - вход
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,-822.13995361328, -187.88513183594, -2998.1608886719, 0, -90, 0);
	SetMovementCoordinationAsOpened(movement,-886.48785400391, -189.88513183594, -2923.9223632812, 0, 23, 0);
	SetMovementKey(movement, "qbduuo_itke_key_brothel");

	-- Бордель - комната персонала
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,1007.2094726562, -184.62590026855, -3266.4641113281, 0, 0, 0);
	SetMovementCoordinationAsOpened(movement,1061.7078857422, -185.62590026855, -3189.970703125, 0, 91, 0);
	SetMovementKey(movement, "qbduuo_itke_key_brothel");

	-- Бордель - комната для клиента 1
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,348.61001586914, 68.350616455078, -3163.8486328125, 0, 90, 0);
	SetMovementCoordinationAsOpened(movement,436.54449462891, 82.967346191406, -3235.8696289062, 0, 184, 0);
	SetMovementKey(movement, "qbduuo_itke_key_brothel");

	-- Бордель - комната для клиента 2
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,348.92816162109, 68.362884521484, -2691.3825683594, 0, 90, 0);
	SetMovementCoordinationAsOpened(movement,424.97216796875, 69.239822387695, -2772.7651367188, 0, 195, 0);
	SetMovementKey(movement, "qbduuo_itke_key_brothel");

	-- Бордель - комната для клиента 3
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,348.18655395508, 69.435241699219, -2204.0849609375, 0, 90, 0);
	SetMovementCoordinationAsOpened(movement,424.9626159668, 67.435241699219, -2278.2255859375, 0, 190, 0);
	SetMovementKey(movement, "qbduuo_itke_key_brothel");

	-- Портовый склад 1
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,112.5745010376, -196.7758026123, 2649.9270019531, 0, -292, 0);
	SetMovementCoordinationAsOpened(movement,201.82342529297, -196.47904968262, 2605.0832519531, 0, 174, 0);
	SetMovementKey(movement, "qbduuo_itke_key_warehouse_01");

	-- Портовый склад 2 (дверь 1)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,-372.18893432617, -227.98751831055, 2074.5346679688, 0, -181, 0);
	SetMovementCoordinationAsOpened(movement,-443.0041809082, -228.06484985352, 2013.8843994141, 0, -74, 0);
	SetMovementKey(movement, "qbduuo_itke_key_warehouse_02");

	-- Портовый склад 2 (дверь 2)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,187.27368164062, -226.72749328613, 1695.6219482422, 0, 90, 0);
	SetMovementCoordinationAsOpened(movement,133.58866882324, -227.72019958496, 1617.3298339844, 0, -18, 0);
	SetMovementKey(movement, "qbduuo_itke_key_warehouse_02");

	-- Канализация - море
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,-530.26886005403, -630.94915771484, 5260.3303565246, 0, -90, 0);
	SetMovementCoordinationAsOpened(movement,-470.39397032917, -642.94226074219, 5331.7191289494, 0, -175, 0);
	SetMovementKey(movement, "itke_thiefguildkey_mis");

	-- Канализация - гостиница
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"DOOR_NW_RICH_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,7855.6787208783, 273.4866027832, 2938.2582458051, 0, -115, 0);
	SetMovementCoordinationAsOpened(movement,7899.8692587502, 273.50598144531, 3037.6077174098, 0, -215, 0);
	SetMovementKey(movement, "itke_thiefguildkey_mis");

	-- Башня 1
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,8829.6833510113, 268.32241821289, -6093.4939446219, 0, 5, 0);
	SetMovementCoordinationAsOpened(movement,8900.9351607316, 268.07730102539, -6021.2260218113, 0, 95, 0);
	SetMovementKey(movement, "qbduuo_itke_key_tower_1");	

	-- Башня 2
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,7322.2927260113, 268.30960083008, -5881.3176750907, 0, 190, 0);
	SetMovementCoordinationAsOpened(movement,7256.9911121766, 268.29449462891, -5808.3636263606, 0, 95, 0);
	SetMovementKey(movement, "qbduuo_itke_key_tower_2");

	-- Башня 3
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,7783.3947148763, 268.30914306641, -1179.0183089137, 0, 195, 0);
	SetMovementCoordinationAsOpened(movement,7707.2778984983, 268.29385375977, -1214.0161271651, 0, 280, 0);
	SetMovementKey(movement, "qbduuo_itke_key_tower_3");

	-- Башня 4
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,5270.480005317, 188.9001159668, -2875.2194304654, 0, 330, 0);
	SetMovementCoordinationAsOpened(movement,5286.9302726305, 188.89392089844, -2776.6314785154, 0, 415, 0);
	SetMovementKey(movement, "qbduuo_itke_key_tower_4");

	-- Башня 5
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,9880.6861965221, 268.32635498047, 6302.4133077466, 0, 415, 0);
	SetMovementCoordinationAsOpened(movement,9873.0812921003, 268.32458496094, 6215.798810663, 0, 320, 0);
	SetMovementKey(movement, "qbduuo_itke_key_tower_5");

	-- Башня 6
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,10682.069767421, 268.32037353516, 5042.8633798987, 0, 415, 0);
	SetMovementCoordinationAsOpened(movement,10680.32242294, 266.85385131836, 4949.7683108396, 0, 325, 0);
	SetMovementKey(movement, "qbduuo_itke_key_tower_6");

	-- Маяк - входная дверь
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"DOOR_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,-818.621673798,2395.2214355469,15951.992982639,0,150,0 );
	SetMovementCoordinationAsOpened(movement,-847.88305260646,2393.2482910156,15842.287729541,0,240,0);

	-- Монастырь - входная дверь
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,47155.7265625, 4882.9536132812, 18705.61328125, 0, 60, 0);
	SetMovementCoordinationAsOpened(movement,47258.109375, 4882.9370117188, 18684.63671875, 0, -208, 0);
	SetMovementKey(movement, "qbduuo_itke_key_monastery");

	-- Монастырь - задняя дверь
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,49606.578125, 4993.6669921875, 17503.220703125, 0, -31, 0);
	SetMovementCoordinationAsOpened(movement,49695.94921875, 4990.9443359375, 17474.69140625, 0, -119, 0);
	SetMovementKey(movement, "qbduuo_itke_key_monastery");

	-- Монастырь - черный ход в подвале
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,49357.2109375, 3887.0314941406, 16894.283203125, 0, -30, 0);
	SetMovementCoordinationAsOpened(movement,49451.3515625, 3886.09375, 16867.630859375, 0, -122, 0);
	SetMovementKey(movement, "qbduuo_itke_key_monastery");

	-- Монастырь - библиотека 1
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,46574.421875, 4982.9379882812, 20196.59375, 0, -121, 0);
	SetMovementCoordinationAsOpened(movement,46599.90234375, 4978.9555664062, 20282.1328125, 0, -214, 0);
	SetMovementKey(movement, "itke_klosterbibliothek");

	-- Монастырь - библиотека 1
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,45832.953125, 4994.5537109375, 20976.986328125, 0, -31, 0);
	SetMovementCoordinationAsOpened(movement,45852.3125, 4982.3759765625, 21064.728515625, 0, 61, 0);
	SetMovementKey(movement, "itke_klosterbibliothek");

	-- Дома --

	-- Нижний квартал - Дом 1 (Боспер)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,7608.0005197181, 266.99667358398, -3472.4038627032, 0, 60, 0);
	SetMovementCoordinationAsOpened(movement,7566.5136956663, 268.24566650391, -3558.3415246572, 0, -30, 0);
	SetMovementKey(movement, "qbduuo_itke_key_1");

	-- Нижний квартал - Дом 2 (Торбен)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,7300.1468941189, 268.25146484375, -1928.5076784303, 0, -30, 0);
	SetMovementCoordinationAsOpened(movement,7316.3307967597, 268.26013183594, -1848.1297641001, 0, 60, 0);
	SetMovementKey(movement, "qbduuo_itke_key_2");

	-- Нижний квартал - Дом 2 (Торбен) - задний ход
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,8080.9506835938, 266.15252685547, -2239.3349609375, 0, -120, 0);
	SetMovementCoordinationAsOpened(movement,8108.2294921875, 267.33889770508, -2148.4924316406, 0, -230, 0);
	SetMovementKey(movement, "qbduuo_itke_key_2");

	-- Нижний квартал - Дом 3 (Маттео)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,6305.9071441303, 268.30728149414, -4298.5543104821, 0, 80, 0);
	SetMovementCoordinationAsOpened(movement,6369.2416306928, 278.31268310547, -4351.4995089921, 0, -195, 0);
	SetMovementKey(movement, "qbduuo_itke_key_3");

	-- Нижний квартал - Дом 4 (Гарад)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,6054.2383016267, 268.2473449707, -977.64398437021, 0, -35, 0);
	SetMovementCoordinationAsOpened(movement,6152.0723429675, 268.23837280273, -987.67161407904, 0, -125, 0);
	SetMovementKey(movement, "qbduuo_itke_key_4");

	-- Нижний квартал - Дом 5 (Константино)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,6954.1875070022, 120.01168823242, -588.87953584241, 0, -35, 0);
	SetMovementCoordinationAsOpened(movement,7064.5574054128, 119.42663574219, -605.67518416959, 0, -130, 0);
	SetMovementKey(movement, "qbduuo_itke_key_5");

	-- Нижний квартал - Дом 6 (Дом на втором этаже)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,7357.0825195312, 492.70416259766, -1052.2393798828, 0, -33, 0);
	SetMovementCoordinationAsOpened(movement,7361.0717773438, 491.90972900391, -956.59655761719, 0, 57, 0);
	SetMovementKey(movement, "qbduuo_itke_key_6");		

	-- Верхний квартал - Дом 7 
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,11327.356932179, 888.19622802734, -4568.3477219228, 0, -225, 0);
	SetMovementCoordinationAsOpened(movement,11217.377739747, 888.20141601563, -4571.9135352456, 0, -315, 0);
	SetMovementKey(movement, "qbduuo_itke_key_7");

	-- Верхний квартал - Дом 8 
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,12641.362678611, 888.19873046875, -3955.2529699281, 0, -5, 0);
	SetMovementCoordinationAsOpened(movement,12713.076301034, 888.71356201172, -3872.7161951147, 0, 90, 0);
	SetMovementKey(movement, "qbduuo_itke_key_8");

	-- Верхний квартал - Дом 9 
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,13473.735170589, 888.18566894531, -3516.2946074613, 0, 115, 0);
	SetMovementCoordinationAsOpened(movement,13381.425956536, 888.20147705078, -3544.4382081358, 0, 20, 0);
	SetMovementKey(movement, "qbduuo_itke_key_9");	

	-- Верхний квартал - Дом 10
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,11040.341281912, 888.20178222656, -2929.7419088858, 0, -230, 0);
	SetMovementCoordinationAsOpened(movement,11030.143128442, 888.22271728516, -3045.2563841173, 0, -135, 0);
	SetMovementKey(movement, "qbduuo_itke_key_10");

	-- Верхний квартал - Дом 11 (Судья)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,16259.132449074, 898.20971679688, -2411.1612547149, 0, 95, 0);
	SetMovementCoordinationAsOpened(movement,16169.953311447, 898.201171875, -2497.8532576416, 0, 5, 0);
	SetMovementKey(movement, "qbduuo_itke_key_11");

	-- Верхний квартал - Дом 12
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,11239.780215407, 886.05883789063, 1721.9895668716, 0, 75, 0);
	SetMovementCoordinationAsOpened(movement,11337.755186669, 882.99853515625, 1660.0874649542, 0, 170, 0);
	SetMovementKey(movement, "qbduuo_itke_key_12");

	-- Верхний квартал - Дом 12 (балкон)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,10296.655273438, 878.25329589844, 1482.9548339844, 0, -105, 0);
	SetMovementCoordinationAsOpened(movement,10353.450195312, 868.24603271484, 1553.7889404297, 0, -190, 0);
	SetMovementKey(movement, "qbduuo_itke_key_12");

	-- Верхний квартал - Дом 12 (проходная)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,10648.5234375, 865.84429931641, 2343.0710449219, 0, 165, 0);
	SetMovementCoordinationAsOpened(movement,10584.280273438, 864.75506591797, 2379.3693847656, 0, 70, 0);
	SetMovementKey(movement, "qbduuo_itke_key_12");

	-- Верхний квартал - Дом 13
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,11608.753919297, 886.49005126953, 2855.7156376169, 0, 150, 0);
	SetMovementCoordinationAsOpened(movement,11591.958847215, 885.24633789063, 2746.226774319, 0, 240, 0);
	SetMovementKey(movement, "qbduuo_itke_key_13");

	-- Верхний квартал - Дом 13 (проходная)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,10762.887695312, 866.36303710938, 2836.8327636719, 0, 238, 0);
	SetMovementCoordinationAsOpened(movement,10675.798828125, 865.33428955078, 2858.4086914062, 0, -30, 0);
	SetMovementKey(movement, "qbduuo_itke_key_13");

	-- Торговый квартал - Дом 14 (площадь правосудия, левый)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,5735.9897460938, 310.73846435547, 1834.4315185547, 0, 132, 0);
	SetMovementCoordinationAsOpened(movement,5647.4370117188, 310.12887573242, 1826.3328857422, 0, 38, 0);
	SetMovementKey(movement, "qbduuo_itke_key_14");

	-- Торговый квартал - Дом 15 (площадь правосудия, правый)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,4870.8305664062, 278.87637329102, 2300.3762207031, -0.40000000596046, -111, 2.2000002861023);
	SetMovementCoordinationAsOpened(movement,4897.4008789062, 275.92816162109, 2388.1372070312, 0, 146, 0);
	SetMovementKey(movement, "qbduuo_itke_key_15");

	-- Торговый квартал - Дом 16 (Сара)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_Wooden.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,8966.78125, 354.92391967773, 5855.0239257812, 0, -24, 0);
	SetMovementCoordinationAsOpened(movement,9053.5322265625, 357.14630126953, 5841.0561523438, 0, -127, 0);
	SetMovementKey(movement, "qbduuo_itke_key_16");	

	-- Торговый квартал - Дом 16 (Задний ход)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_Wooden.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,8682.9619140625, 341.06137084961, 6532.7866210938, 0, -207, 0);
	SetMovementCoordinationAsOpened(movement,8584.80859375, 342.0634765625, 6544.173828125, 0, 56, 0);
	SetMovementKey(movement, "qbduuo_itke_key_16");	

	-- Торговый квартал - Дом 17 (Зурис)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,9082.3907502825, 268.2239074707, 3698.8113346591, 0, 65, 0);
	SetMovementCoordinationAsOpened(movement,9174.2755702849, 268.21801757813, 3690.7581489209, 0, 150, 0);
	SetMovementKey(movement, "qbduuo_itke_key_17");	

	-- Портовый квартал - Дом 18 (мясная лавка)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,4686.0693359375, -210.98364257812, -13.995179176331, 0, -34, 0);
	SetMovementCoordinationAsOpened(movement,4778.1513671875, -210.59121704102, -24.177690505981, 0, -139, 0);
	SetMovementKey(movement, "qbduuo_itke_key_18");		

	-- Портовый квартал - Дом 19
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,3506.4074707031, -112.16902160645, -2056.6486816406, 0, 0, 0);
	SetMovementCoordinationAsOpened(movement,3554.7473144531, -140.75180053711, -2112.9077148438, 0, -89, 0);
	SetMovementKey(movement, "qbduuo_itke_key_19");	

	-- Портовый квартал - Дом 20 (штаб боронистов - вход)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,3456.9306640625, -46.380729675293, -1229.8616943359, 0, 181, 0);
	SetMovementCoordinationAsOpened(movement,3385.072265625, -47.380729675293, -1276.5747070312, 0, -81, 0);
	SetMovementKey(movement, "qbduuo_itke_key_20");	

	-- Портовый квартал - Дом 20 (задний ход)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,3459.8962402344, -27.640983581543, -581.35150146484, 0, 181, 0);
	SetMovementCoordinationAsOpened(movement,3394.5532226562, -40.563545227051, -641.77600097656, 0, 270, 0);
	SetMovementKey(movement, "qbduuo_itke_key_20");	

	-- Портовый квартал - Дом 21 (2 этаж боронистов)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_Wooden.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,4141.8510742188, 279.45623779297, -747.26965332031, 0, -270, 0);
	SetMovementCoordinationAsOpened(movement,4066.6340332031, 272.25283813477, -818.58782958984, 0, -5, 0);
	SetMovementKey(movement, "qbduuo_itke_key_21");	

	-- Портовый квартал - Дом 22 (Лемар)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,1897.5152587891, -100.24866485596, -1973.2387695312, 0, 2, 0);
	SetMovementCoordinationAsOpened(movement,1973.9449462891, -101.42742156982, -1906.4249267578, 0, 96, 0);
	SetMovementKey(movement, "qbduuo_itke_key_22");	

	-- Портовый квартал - Дом 23 (напротив Лемара)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Poor_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,1651.5339355469, -163.23818969727, -895.64135742188, 0, 5, 0);
	SetMovementCoordinationAsOpened(movement,1722.8122558594, -163.81704711914, -961.60516357422, 0, -90, 0);
	SetMovementKey(movement, "qbduuo_itke_key_23");	

	-- Портовый квартал - Дом 24 (Феллан)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Poor_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,2128.1022949219, -170.15451049805, 687.34155273438, 0, -7, 0);
	SetMovementCoordinationAsOpened(movement,2211.0134277344, -166.15451049805, 644.41857910156, 0, -107, 0);
	SetMovementKey(movement, "qbduuo_itke_key_24");	

	-- Портовый квартал - Дом 25 (Альвин)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Poor_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,3388.5380859375, -162.78991699219, 577.44128417969, 0, 100, 0);
	SetMovementCoordinationAsOpened(movement,3443.2551269531, -162.90222167969, 485.90380859375, 0, -158, 0);
	SetMovementKey(movement, "qbduuo_itke_key_25");	

	-- Портовый квартал - Дом 26 (дом Блайдена)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Poor_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,1326.4473876953, -165.82012939453, 1878.2795410156, 0, 254, 0);
	SetMovementCoordinationAsOpened(movement,1248.4582519531, -165.82012939453, 1947.8898925781, 0, 4, 0);
	SetMovementKey(movement, "qbduuo_itke_key_26");	

	-- Портовый квартал - Дом 27 (2 этаж склада)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_Wooden.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,195.71098327637, 94.956207275391, 1553.9853515625, 0, 91, 0);
	SetMovementCoordinationAsOpened(movement,268.95153808594, 93.94465637207, 1505.7846679688, 0, 189, 0);
	SetMovementKey(movement, "qbduuo_itke_key_27");	

	-- Портовый квартал - Дом 28
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,-1733.8126220703, -216.82571411133, 1737.3610839844, 0, -88, 0);
	SetMovementCoordinationAsOpened(movement,-1795.5662841797, -217.72027587891, 1806.2127685547, 0, 4, 0);
	SetMovementKey(movement, "qbduuo_itke_key_28");	

	-- Портовый квартал - Дом 29 (у канализации)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_Wooden.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,-1397.4572753906, -183.11386108398, 4061.1245117188, 0, 53, 0);
	SetMovementCoordinationAsOpened(movement,-1403.0930175781, -185.11386108398, 3962.9670410156, 0, -33, 0);
	SetMovementKey(movement, "qbduuo_itke_key_29");	

	-- Портовый квартал - Дом 30 (Халвор)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Poor_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,-1062.0240478516, -166.02624511719, -5232.7778320312, 0, 143, 0);
	SetMovementCoordinationAsOpened(movement,-1160.4450683594, -169.33241271973, -5219.0546875, 0, 51, 0);
	SetMovementKey(movement, "qbduuo_itke_key_30");	

	-- Портовый квартал - Дом 31
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Poor_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,241.67881774902, -167.10055541992, -4680.0693359375, 0, 43, 0);
	SetMovementCoordinationAsOpened(movement,342.66159057617, -167.10055541992, -4687.2534179688, 0, 147, 0);
	SetMovementKey(movement, "qbduuo_itke_key_31");

	-- Портовый квартал - Дом 32
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Poor_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,1375.8968505859, -169.53469848633, -5282.6220703125, 0, 121, 0);
	SetMovementCoordinationAsOpened(movement,1384.486328125, -169.53469848633, -5393.8486328125, 0, -125, 0);
	SetMovementKey(movement, "qbduuo_itke_key_32");

	-- Портовый квартал - Дом 33
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Poor_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,2905.5561523438, -97.97802734375, -4172.2294921875, 0, 30, 0);
	SetMovementCoordinationAsOpened(movement,2961.2463378906, -100.86268615723, -4254.3999023438, 0, -70, 0);
	SetMovementKey(movement, "qbduuo_itke_key_33");

	-- Портовый квартал - Дом 34
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Poor_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,1851.3900146484, -96.659683227539, -3241.982421875, 0, -72, 0);
	SetMovementCoordinationAsOpened(movement,1806.6976318359, -100.65968322754, -3159.8974609375, 0, 14, 0);
	SetMovementKey(movement, "qbduuo_itke_key_34");

	-- Портовый квартал - Дом 35
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Poor_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,3118.6437988281, -98.240097045898, -6223.4697265625, 0, 36, 0);
	SetMovementCoordinationAsOpened(movement,3147.8798828125, -90.240097045898, -6300.548828125, 0, -63, 0);
	SetMovementKey(movement, "qbduuo_itke_key_35");

	-- Портовый квартал - Дом 36
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Poor_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,3960.5612792969, -89.554626464844, -4458.7592773438, 0, -58, 0);
	SetMovementCoordinationAsOpened(movement,3952.5764160156, -87.842643737793, -4350.4370117188, 0, 54, 0);
	SetMovementKey(movement, "qbduuo_itke_key_36");

	-- Портовый квартал - Дом 37 (Игнац)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Poor_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,3986.9685058594, -96.090141296387, -7143.9189453125, 0, -40, 0);
	SetMovementCoordinationAsOpened(movement,4071.1628417969, -96.090141296387, -7147.2299804688, 0, -131, 0);
	SetMovementKey(movement, "qbduuo_itke_key_37");

end

function OnFilterscriptExit()
	print("--------------------------------------");
	print("Closing Movement Gates/Doors script...");
	print("--------------------------------------"); 
	
	KillTimer(movementTimer);
end

function SetMovementKey(movement, key)
	if key ~= nil then
		movement.key = string.upper(key);
	else
		movement.key = nil;
	end
end

function CreateMovement(movementType, movementStatus, vobName, worldName)

	if movementType < 2 then
	
		if movementStatus < 2 then -- STATUS_MOVING_TO_OPEN or STATUS_MOVING_TO_CLOSE can not be set as default
			movement = {};
			movement.type      = movementType;
			movement.status    = movementStatus;
			movement.vobName   = vobName;
			movement.worldName = worldName;
			movement.opened_posX = 0;
			movement.opened_posY = 0;
			movement.opened_posZ = 0;
			movement.opened_rotX = 0;
			movement.opened_rotY = 0;
			movement.opened_rotZ = 0;
			movement.closed_posX = 0;
			movement.closed_posY = 0;
			movement.closed_posZ = 0;
			movement.closed_rotX = 0;
			movement.closed_rotY = 0;
			movement.closed_rotZ = 0;
			movement.key = nil;
			
			if movement.status == MovementStatus.STATUS_OPENED then --Opened
				movement.vobID = Vob.Create(movement.vobName,movement.worldName,movement.opened_posX,movement.opened_posY,movement.opened_posZ);
				movement.vobID:SetRotation(movement.opened_rotX,movement.opened_rotY,movement.opened_rotZ);
				
			elseif movement.status == MovementStatus.STATUS_CLOSED then --Closed
				movement.vobID = Vob.Create(movement.vobName,movement.worldName,movement.closed_posX,movement.closed_posY,movement.closed_posZ);
				movement.vobID:SetRotation(movement.closed_rotX,movement.closed_rotY,movement.closed_rotZ);
			end
	
			table.insert(MovementList,movement);
			return movement;
		else
			LogString("movement_log.txt","Error CreateMovement(): Incorrent movement status. It can be MovementStatus.STATUS_OPENED or MovementStatus.STATUS_CLOSED.");
		end
		
	else
		LogString("movement_log.txt","Error CreateMovement(): Incorrent movement type. It can be MovementType.TYPE_GATE or MovementType.TYPE_DOOR.");
	end
	
	return nil;
end

function DestroyMovement(movement)
	
	for i = 1, #MovementList do
		if MovementList[i] == movement then
			MovementList[i].vobID:Destroy();
			table.remove(MovementList,i);
			return true;
		end
	end
	return false;
end

function SetMovementCoordinationAsOpened(movement, posX, posY, posZ, rotX, rotY, rotZ)

	if movement.status ~= MovementStatus.STATUS_MOVING_TO_OPEN and movement.status ~= MovementStatus.STATUS_MOVING_TO_CLOSE then
		movement.opened_posX = posX;
		movement.opened_posY = posY;
		movement.opened_posZ = posZ;
		movement.opened_rotX = rotX;
		movement.opened_rotY = rotY;
		movement.opened_rotZ = rotZ;
		
		if movement.status == MovementStatus.STATUS_OPENED then
			movement.vobID:SetPosition(movement.opened_posX,movement.opened_posY,movement.opened_posZ);
			movement.vobID:SetRotation(movement.opened_rotX,movement.opened_rotY,movement.opened_rotZ);
		end
		
		return true;
	end
	
	return false;
end

function SetMovementCoordinationAsClosed(movement, posX, posY, posZ, rotX, rotY, rotZ)
	
	if movement.status ~= MovementStatus.STATUS_MOVING_TO_OPEN and movement.status ~= MovementStatus.STATUS_MOVING_TO_CLOSE then
		movement.closed_posX = posX;
		movement.closed_posY = posY;
		movement.closed_posZ = posZ;
		movement.closed_rotX = rotX;
		movement.closed_rotY = rotY;
		movement.closed_rotZ = rotZ;
		
		if movement.status == MovementStatus.STATUS_CLOSED then
			movement.vobID:SetPosition(movement.closed_posX,movement.closed_posY,movement.closed_posZ);
			movement.vobID:SetRotation(movement.closed_rotX,movement.closed_rotY,movement.closed_rotZ);
		end
		
		return true;
	end
	
	return false;
end

function OpenMovement(movement)

	--Gate
	if movement.type == MovementType.TYPE_GATE then
		if movement.status == MovementStatus.STATUS_CLOSED or movement.status == MovementStatus.STATUS_MOVING_TO_CLOSE then
			movement.status = MovementStatus.STATUS_MOVING_TO_OPEN;
			return true;
		end
	
	--Door
	elseif movement.type == MovementType.TYPE_DOOR then
		if movement.status == MovementStatus.STATUS_CLOSED then -- if closed
			movement.vobID:SetPosition(movement.opened_posX,movement.opened_posY,movement.opened_posZ);
			movement.vobID:SetRotation(movement.opened_rotX,movement.opened_rotY,movement.opened_rotZ);
			
			movement.status = MovementStatus.STATUS_OPENED; -- lets open
			return true;
		end
	end
	
	return false;
end

function CloseMovement(movement)

	--Gate
	if movement.type == MovementType.TYPE_GATE then
		if movement.status == MovementStatus.STATUS_OPENED or movement.status == MovementStatus.STATUS_MOVING_TO_OPEN then
			movement.status = MovementStatus.STATUS_MOVING_TO_CLOSE;
			return true;
		end
		
	
	--Door
	elseif movement.type == MovementType.TYPE_DOOR then
		if movement.status == MovementStatus.STATUS_OPENED then -- if opened
			movement.vobID:SetPosition(movement.closed_posX,movement.closed_posY,movement.closed_posZ);
			movement.vobID:SetRotation(movement.closed_rotX,movement.closed_rotY,movement.closed_rotZ);
			
			movement.status = MovementStatus.STATUS_CLOSED; --lets close
			return true;
		end
	end
	
	return false;
end

function GetNearestGate(playerid)
	
	if IsPlayerConnected(playerid) == 1 then
		local playerX,playerY,playerZ = GetPlayerPos(playerid);
		local playerWorld = GetPlayerWorld(playerid);
		local key = nil;
		if #MovementList > 0 then
			local currDistance = GetDistance3D(playerX,playerY,playerZ,MovementList[1].closed_posX,MovementList[1].closed_posY,MovementList[1].closed_posZ);
			if #MovementList > 1 then
				local currMovement = nil;
			
				for i = 1, #MovementList do
					if MovementList[i].type == MovementType.TYPE_GATE then
						if MovementList[i].worldName == playerWorld then
							local distanceToGate = GetDistance3D(playerX,playerY,playerZ,MovementList[i].closed_posX,MovementList[i].closed_posY,MovementList[i].closed_posZ);
							if distanceToGate <= currDistance then
								currDistance = distanceToGate;
								currMovement = MovementList[i];
								key = MovementList[i].key;
							end
						end
					end
				end
				
				if currDistance < MovementDistance.DISTANCE_PLAYER_GATE then
					return currMovement, currDistance, key;
				end
			end
			
			if MovementList[1].type == MovementType.TYPE_GATE and currDistance < MovementDistance.DISTANCE_PLAYER_GATE then
				return MovementList[1], currDistance, MovementList[1].key;
			end
		end
	end
	return nil;
end

function GetNearestDoor(playerid)

	if IsPlayerConnected(playerid) == 1 then
		local playerX,playerY,playerZ = GetPlayerPos(playerid);
		local playerWorld = GetPlayerWorld(playerid);
		local key = nil;
		if #MovementList > 0 then
			local currDistance = GetDistance3D(playerX,playerY,playerZ,MovementList[1].closed_posX,MovementList[1].closed_posY,MovementList[1].closed_posZ);
			if #MovementList > 1 then
				local currMovement = nil;
				
				for i = 1, #MovementList do
					if MovementList[i].type == MovementType.TYPE_DOOR then
						if MovementList[i].worldName == playerWorld then
							local distanceToDoor = GetDistance3D(playerX,playerY,playerZ,MovementList[i].closed_posX,MovementList[i].closed_posY,MovementList[i].closed_posZ);	
							if distanceToDoor <= currDistance then
								currDistance = distanceToDoor;
								currMovement = MovementList[i];
								key = MovementList[i].key;
							end
						end
					end
				end
				
				if currDistance < MovementDistance.DISTANCE_PLAYER_DOOR then
					return currMovement, currDistance, key;
				end
			end
			
			if MovementList[1].type == MovementType.TYPE_DOOR and currDistance < MovementDistance.DISTANCE_PLAYER_DOOR then
				return MovementList[1], currDistance, MovementList[1].key;
			end
		end
	end
	return nil;
end

function GetNearestMovement(playerid)
	
	local gate, distanceGate, keyG = GetNearestGate(playerid);
	local door, distanceDoor, keyD = GetNearestDoor(playerid);
	
	if gate ~= nil and door ~= nil then

		if distanceGate < distanceDoor then
			return gate, distanceGate, keyG;
		else
			return door, distanceDoor, keyD;
		end

	elseif gate == nil and door ~= nil then
		return door, distanceDoor, keyD;

	elseif gate ~= nil and door == nil then
		return gate, distanceGate, keyG;
	end
	
	return nil;
end

function MovementProcess() --Timer

	for i = 1, #MovementList do
		if MovementList[i].type == MovementType.TYPE_GATE then
		
			local x,y,z = MovementList[i].vobID:GetPosition();
		
			if MovementList[i].status == MovementStatus.STATUS_MOVING_TO_OPEN then --gate is moving to open
			
				local distanceMove = GetDistance3D(x,y,z,MovementList[i].opened_posX,MovementList[i].opened_posY,MovementList[i].opened_posZ); --calculate distance for fixing position
				
				if MovementList[i].opened_posY < MovementList[i].closed_posY then --if opened gate is lower than closed gate (default)
					if y > MovementList[i].opened_posY then
						if distanceMove > MovementDistance.DISTANCE_MOVE_GATE then
							MovementList[i].vobID:SetPosition(x,y - MovementDistance.DISTANCE_MOVE_GATE,z); -- destination is far
						else
							MovementList[i].vobID:SetPosition(x,y - distanceMove,z); --fixing position with small distance to destination
						end
					else
						MovementList[i].status = MovementStatus.STATUS_OPENED;
					end
				else --if opened gate is higher than closed gate (default)
					if y < MovementList[i].opened_posY then
						if distanceMove > MovementDistance.DISTANCE_MOVE_GATE then
							MovementList[i].vobID:SetPosition(x,y + MovementDistance.DISTANCE_MOVE_GATE,z);
						else
							MovementList[i].vobID:SetPosition(x,y + distanceMove,z); --fixing position with small distance to destination
						end
					else
						MovementList[i].status = MovementStatus.STATUS_OPENED;
					end
				end
			
			elseif MovementList[i].status == MovementStatus.STATUS_MOVING_TO_CLOSE then --gate is moving to close
				
				local distanceMove = GetDistance3D(x,y,z,MovementList[i].closed_posX,MovementList[i].closed_posY,MovementList[i].closed_posZ); --calculate distance for fixing position
				
				if MovementList[i].opened_posY < MovementList[i].closed_posY then --if opened gate is lower than closed gate (default)
					if y < MovementList[i].closed_posY then
						if distanceMove > MovementDistance.DISTANCE_MOVE_GATE then
							MovementList[i].vobID:SetPosition(x,y + MovementDistance.DISTANCE_MOVE_GATE,z); -- destination is far
						else
							MovementList[i].vobID:SetPosition(x,y + distanceMove,z); --fixing position with small distance to destination
						end
					else
						MovementList[i].status = MovementStatus.STATUS_CLOSED;
					end
				else --if opened gate is higher than closed gate (default)
					if y > MovementList[i].closed_posY then
						if distanceMove > MovementDistance.DISTANCE_MOVE_GATE then
							MovementList[i].vobID:SetPosition(x,y - MovementDistance.DISTANCE_MOVE_GATE,z); -- destination is far
						else
							MovementList[i].vobID:SetPosition(x,y - distanceMove,z); --fixing position with small distance to destination
						end
					else
						MovementList[i].status = MovementStatus.STATUS_CLOSED;
					end
				end
			end
		end
	end
end

function CheckDatabaseGateDoor(id, key)

	local file = io.open("Database/Players/Items/"..GetPlayerName(id)..".db", "r");
	if file then
		for line in file:lines() do
			local result, item, amount = sscanf(line, "sd");
			if result == 1 then
				if string.upper(item) == key then
					if amount > 0 then
						return true;
					end
				end
			end
		end
	file:close();
	end
	return false;

end

function CheckDatabaseAdmin(id)

	local file = io.open("Database/Players/Profiles/"..GetPlayerName(id)..".txt", "r");
	if file then
		line = file:read("*l");
		line = file:read("*l");
		local result, admin = sscanf(line,"d");
		if result == 1 then
			if admin > 0 then
				file:close();
				return true;
			end
		end
	file:close();
	end
	return false;
end

function OnPlayerCommandText(playerid, cmdtext)

	if cmdtext == "/откр" then
	
		local movement = GetNearestMovement(playerid);
		if movement ~= nil then
			if CheckDatabaseGateDoor(playerid, string.upper(movement.key)) == true then
				OpenMovement(movement);
				SendPlayerMessage(playerid, 255, 255, 255, "Открыто.")
			else
				if CheckDatabaseAdmin(playerid) == true then
					OpenMovement(movement);
					SendPlayerMessage(playerid, 255, 255, 255, "Открыто.")
				else
					SendPlayerMessage(playerid, 255, 255, 255, "У вас нет ключа.")
				end
			end
		end
	
	elseif cmdtext == "/закр" then
	
		local movement = GetNearestMovement(playerid);
		if movement ~= nil then
			if CheckDatabaseGateDoor(playerid, string.upper(movement.key)) == true then
				CloseMovement(movement);
				SendPlayerMessage(playerid, 255, 255, 255, "Закрыто.")
			else
				if CheckDatabaseAdmin(playerid) == true then
					CloseMovement(movement);
					SendPlayerMessage(playerid, 255, 255, 255, "Закрыто.")
				else
					SendPlayerMessage(playerid, 255, 255, 255, "У вас нет ключа.")
				end
			end
		end
	end
end