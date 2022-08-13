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
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"DOOR_NW_RICH_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,-818.621673798,2395.2214355469,15951.992982639,0,150,0 );
	SetMovementCoordinationAsOpened(movement,-847.88305260646,2393.2482910156,15842.287729541,0,240,0);

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

	-- -- Нижний квартал - Дом 2 (Торбен) - задний ход
	-- movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Normal_01.MDS","RPCORNER_KHORINIS.ZEN");
	-- SetMovementCoordinationAsClosed(movement,8078.734375, 273.79876708984, -2254.0708007812, 0, 58, 0);
	-- SetMovementCoordinationAsOpened(movement,8078.734375, 273.79876708984, -2314.0708007812, 0, -32, 0);
	-- SetMovementKey(movement, "qbduuo_itke_key_2");

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

	-- Верхний квартал - Дом 6 
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,11327.356932179, 888.19622802734, -4568.3477219228, 0, -225, 0);
	SetMovementCoordinationAsOpened(movement,11217.377739747, 888.20141601563, -4571.9135352456, 0, -315, 0);
	SetMovementKey(movement, "qbduuo_itke_key_6");

	-- Верхний квартал - Дом 7 
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,12641.362678611, 888.19873046875, -3955.2529699281, 0, -5, 0);
	SetMovementCoordinationAsOpened(movement,12713.076301034, 888.71356201172, -3872.7161951147, 0, 90, 0);
	SetMovementKey(movement, "qbduuo_itke_key_7");

	-- Верхний квартал - Дом 8 
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,13473.735170589, 888.18566894531, -3516.2946074613, 0, 115, 0);
	SetMovementCoordinationAsOpened(movement,13381.425956536, 888.20147705078, -3544.4382081358, 0, 20, 0);
	SetMovementKey(movement, "qbduuo_itke_key_8");	

	-- Верхний квартал - Дом 9
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,11040.341281912, 888.20178222656, -2929.7419088858, 0, -230, 0);
	SetMovementCoordinationAsOpened(movement,11030.143128442, 888.22271728516, -3045.2563841173, 0, -135, 0);
	SetMovementKey(movement, "qbduuo_itke_key_9");

	-- Верхний квартал - Дом 10 (Судья)
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,16259.132449074, 898.20971679688, -2411.1612547149, 0, 95, 0);
	SetMovementCoordinationAsOpened(movement,16169.953311447, 898.201171875, -2497.8532576416, 0, 5, 0);
	SetMovementKey(movement, "qbduuo_itke_key_10");

	-- Верхний квартал - Дом 11
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,11239.780215407, 886.05883789063, 1721.9895668716, 0, 75, 0);
	SetMovementCoordinationAsOpened(movement,11337.755186669, 882.99853515625, 1660.0874649542, 0, 170, 0);
	SetMovementKey(movement, "qbduuo_itke_key_11");

	-- Верхний квартал - Дом 12
	movement = CreateMovement(MovementType.TYPE_DOOR,MovementStatus.STATUS_CLOSED,"Door_NW_Rich_01.MDS","RPCORNER_KHORINIS.ZEN");
	SetMovementCoordinationAsClosed(movement,11608.753919297, 886.49005126953, 2855.7156376169, 0, 150, 0);
	SetMovementCoordinationAsOpened(movement,11591.958847215, 885.24633789063, 2746.226774319, 0, 240, 0);
	SetMovementKey(movement, "qbduuo_itke_key_12");


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