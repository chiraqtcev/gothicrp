
function _sit1(id)
	RemovePlayerOverlay(id, GetPlayerWalk(id));
	SetPlayerWalk(id, "HUMANS_G1MAGE.mds");
	PlayAnimation(id,"T_STAND_2_SIT");
	Freeze(id);
	SendPlayerMessage(id, 255, 255, 255, "����� ������ - ������� ������� /������");
end
addCommandHandler({"/�����1"}, _sit1);

function _sit2(id)
	RemovePlayerOverlay(id, GetPlayerWalk(id));
	SetPlayerWalk(id, "HUMANS_G1MILITIA.mds");
	PlayAnimation(id,"T_STAND_2_SIT");
	Freeze(id);
	SendPlayerMessage(id, 255, 255, 255, "����� ������ - ������� ������� /������");
end
addCommandHandler({"/�����2"}, _sit2);

function _sit3(id)
	RemovePlayerOverlay(id, GetPlayerWalk(id));
	SetPlayerWalk(id, "HUMANS_G1RELAXED.mds");
	PlayAnimation(id,"T_STAND_2_SIT");
	Freeze(id);
	SendPlayerMessage(id, 255, 255, 255, "����� ������ - ������� ������� /������");
end
addCommandHandler({"/�����3"}, _sit3);

function _sit4(id)
	RemovePlayerOverlay(id, GetPlayerWalk(id));
	SetPlayerWalk(id, "HUMANS_G1TIRED.mds");
	PlayAnimation(id,"T_STAND_2_SIT");
	Freeze(id);
	SendPlayerMessage(id, 255, 255, 255, "����� ������ - ������� ������� /������");
end
addCommandHandler({"/�����4"}, _sit4);

function _sit_stand(id)
	RemovePlayerOverlay(id, GetPlayerWalk(id));
	PlayAnimation(id,"T_STAND_2_LGUARD");
	UnFreeze(id);
	SetPlayerWalk(id, Player[id].overlay);
end
addCommandHandler({"/������"}, _sit_stand);


function CMD_SIT(playerid)
	if GetPlayerInstance(playerid) == "ORCELITE_ROAM" or GetPlayerInstance(playerid) == "ORCSHAMAN_SIT" or GetPlayerInstance(playerid) == "ORCWARRIOR_ROAM" then
		PlayAnimation(playerid, "S_GUARDSLEEP");
	else
		PlayAnimation(playerid,"T_STAND_2_SIT");
	end
end
addCommandHandler({"/�����", "/sit"}, CMD_SIT);	

addCommandHandler({"/�����5"}, function(playerid, param) 
	PlayAnimation(playerid, "T_SITDOWNEXPERIENCED_STAND_2_S0")
end);

addCommandHandler({"/�����6"}, function(playerid, param) 
	PlayAnimation(playerid, "T_SITDOWNATTENTIVE_STAND_2_S0")
end);

addCommandHandler({"/�����7"}, function(playerid, param) 
	PlayAnimation(playerid, "T_SITDOWNMEDITATE_STAND_2_S0")
end);

addCommandHandler({"/�����8"}, function(playerid, param) 
	PlayAnimation(playerid, "T_SITDOWNCROSSLEGGED_STAND_2_SIT")
end);

addCommandHandler({"/�����","/sleep"}, function(playerid, param)
	if GetPlayerInstance(playerid) == "ORCELITE_ROAM" or GetPlayerInstance(playerid) == "ORCSHAMAN_SIT" or GetPlayerInstance(playerid) == "ORCWARRIOR_ROAM" then
		PlayAnimation(playerid, "T_STAND_2_GUARDSLEEP");
	else
		PlayAnimation(playerid,"T_STAND_2_SLEEPGROUND");
	end
end);

addCommandHandler({"/�����","/pee"}, function(playerid, param)
	PlayAnimation(playerid,"T_STAND_2_PEE");
end);

addCommandHandler({"/������","/hi"}, function(playerid, param)
	PlayAnimation(playerid,"T_GREETRIGHT");
end);

addCommandHandler({"/������2","/hi2"}, function(playerid, param)
	PlayAnimation(playerid,"T_HGUARD_GREET");
end);

addCommandHandler({"/�����3","/guard3"}, function(playerid, param)
	PlayAnimation(playerid,"T_HGUARD_LOOKAROUND");
end);

addCommandHandler({"/�����","/yes"}, function(playerid, param)
	PlayAnimation(playerid,"T_YES");
end);

addCommandHandler({"/��������","/otognat"}, function(playerid, param)
	PlayAnimation(playerid,"T_GETLOST2");
end);

addCommandHandler({"/������������","/see"}, function(playerid, param)
	PlayAnimation(playerid,"T_1HSINSPECT");
end);

addCommandHandler({"/��������","/po4yhat"}, function(playerid, param)
	PlayAnimation(playerid,"R_SCRATCHEGG");
end);

addCommandHandler({"/��������","/4esat"}, function(playerid, param)
	PlayAnimation(playerid,"R_SCRATCHHEAD");
end);

addCommandHandler({"/������������","/peremen"}, function(playerid, param)
	PlayAnimation(playerid,"R_LEGSHAKE");
end);

addCommandHandler({"/������","/knock"}, function(playerid, param)
	PlayAnimation(playerid,"T_BORINGKICK");
end);

addCommandHandler({"/������","/dontknow"}, function(playerid, param)
	PlayAnimation(playerid,"T_DONTKNOW");
end);

addCommandHandler({"/�������","/mah"}, function(playerid, param)
	PlayAnimation(playerid,"T_FORGETIT");
end);

addCommandHandler({"/������","/kovka"}, function(playerid, param)
	PlayAnimation(playerid,"S_BSANVIL_S1");
end);

addCommandHandler({"/������","/to4ka"}, function(playerid, param)
	PlayAnimation(playerid,"S_BSSHARP_S1");
end);

addCommandHandler({"/������","/meshat"}, function(playerid, param)
	PlayAnimation(playerid,"S_CAULDRON_S1");
end);

addCommandHandler({"/�������","/mayta"}, function(playerid, param)
	PlayAnimation(playerid,"T_PAUKE_S1_2_S0");
end);

addCommandHandler({"/�����","/rana"}, function(playerid, param)
	PlayAnimation(playerid,"T_STAND_2_WOUNDED");
end);

addCommandHandler({"/������","/dobit"}, function(playerid, param)
	PlayAnimation(playerid,"T_1HSFINISH");
end);

addCommandHandler({"/������1","/smoke1"}, function(playerid, param)
	PlayAnimation(playerid,"T_JOINT_S0_2_STAND");
end);

addCommandHandler({"/������2","/smoke2"}, function(playerid, param)
	PlayAnimation(playerid,"T_JOINTSTRONG_S0_2_STAND");
end);

addCommandHandler({"/�������","/push"}, function(playerid, param)
	PlayAnimation(playerid,"S_CANONPUSH_S1");
end);

addCommandHandler({"/����","/fear"}, function(playerid, param)
	PlayAnimation(playerid,"T_Q405_MARVIN_ONKNEE");
end);

addCommandHandler({"/��������","/bless"}, function(playerid, param)
	PlayAnimation(playerid,"T_STAND_2_PRAY");
end);

addCommandHandler({"/��������2","/bless2"}, function(playerid, param)
	PlayAnimation(playerid,"S_INNOS_S1");
end);

addCommandHandler({"/�������1","/hammer1"}, function(playerid, param)
	PlayAnimation(playerid,"S_REPAIR_S1");
end);

addCommandHandler({"/�������2","/hammer2"}, function(playerid, param)
	PlayAnimation(playerid,"T_HAMMERGROUND_S0_2_S1");
end);

addCommandHandler({"/����������","/trenya"}, function(playerid, param)
	PlayAnimation(playerid,"T_1HSFREE");
end);

addCommandHandler({"/��","/da"}, function(playerid, param)
	PlayAnimation(playerid,"T_YES");
end);

addCommandHandler({"/���","/net"}, function(playerid, param)
	PlayAnimation(playerid, "T_NO")
end);

addCommandHandler({"/�����","/obisk"}, function(playerid, param)
	PlayAnimation(playerid,"T_PLUNDER");
end);

addCommandHandler({"/����������","/ogl"}, function(playerid, param)
	PlayAnimation(playerid,"T_SEARCH");
end);

addCommandHandler({"/������","/eat"}, function(playerid, param)
	PlayAnimation(playerid, "T_FOOD_S0_2_STAND")
end);

addCommandHandler({"/������","/kopka"}, function(playerid, param)
	PlayAnimation(playerid, "S_TREASURE_S2")
end);

addCommandHandler({"/���","/obl"}, function(playerid, param)
	PlayAnimation(playerid, "S_LEAN")
end);

addCommandHandler({"/���2","/obl2"}, function(playerid, param)
	PlayAnimation(playerid, "S_WALL_S1")
end);

addCommandHandler({"/����","/drink"}, function(playerid, param)
	PlayAnimation(playerid, "T_POTION_S0_2_STAND")
end);

addCommandHandler({"/��������","/prisest"}, function(playerid, param)
	PlayAnimation(playerid, "T_CHESTSMALL_STAND_2_S0")
end);

addCommandHandler({"/����","/idol"}, function(playerid, param)
	PlayAnimation(playerid, "S_IDOL_S1")
end);

addCommandHandler({"/������","/dead"}, function(playerid, param)
	PlayAnimation(playerid, "T_DEAD")
end);

addCommandHandler({"/������2","/dead2"}, function(playerid, param)
	PlayAnimation(playerid, "T_DEADB")
end);

addCommandHandler({"/������3","/dead3"}, function(playerid, param)
	PlayAnimation(playerid, "T_DEAD_TRADER")
end);

addCommandHandler({"/�����1","/guard1"}, function(playerid, param)
	PlayAnimation(playerid,"T_STAND_2_LGUARD");
end);

addCommandHandler({"/�����2","/guard2"}, function(playerid, param)
	PlayAnimation(playerid,"T_STAND_2_HGUARD");
end);

addCommandHandler({"/�����"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_01")
end);

addCommandHandler({"/�����1"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_02")
end);

addCommandHandler({"/�����2"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_03")
end);

addCommandHandler({"/�����3"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_04")
end);

addCommandHandler({"/�����4"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_05")
end);

addCommandHandler({"/�����5"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_06")
end);

addCommandHandler({"/�����6"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_07")
end);

addCommandHandler({"/�����7"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_08")
end);

addCommandHandler({"/�����8"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_09")
end);

addCommandHandler({"/���1"}, function(playerid, param)
	PlayAnimation(playerid, "S_BARRELCONTAINER_S1")
end);

addCommandHandler({"/���2"}, function(playerid, param)
	PlayAnimation(playerid, "R_BARRELCONTAINER_DRINK")
end);

addCommandHandler({"/���3"}, function(playerid, param)
	PlayAnimation(playerid, "T_INN_S0_2_S1")
end);

addCommandHandler({"/�����"}, function(playerid, param) 
	PlayAnimation(playerid, "T_STAND_2_BREATH")
end);

addCommandHandler({"/���"}, function(playerid, param) 
	PlayAnimation(playerid, "T_PET_START")
end);

addCommandHandler({"/�������1"}, function(playerid, param) 
	PlayAnimation(playerid, "R_VOMIT_RANDOM_01")
end);

addCommandHandler({"/�������2"}, function(playerid, param) 
	PlayAnimation(playerid, "R_VOMIT_SUNDER")
end);

addCommandHandler({"/�������"}, function(playerid, param)
	PlayAnimation(playerid, "S_CRY")
end);

addCommandHandler({"/�����"}, function(playerid, param)
	PlayAnimation(playerid, "T_WHISTLE")
end);

addCommandHandler({"/���������"}, function(playerid, param)
	PlayAnimation(playerid, "T_FACEPALM")
end);

addCommandHandler({"/������"}, function(playerid, param) 
	PlayAnimation(playerid, "T_FALLDOWN_QUICK")
end);

addCommandHandler({"/������2"}, function(playerid, param)
	PlayAnimation(playerid, "T_FALLDOWN_LONG")
end);

addCommandHandler({"/�����������"}, function(playerid, param)
	PlayAnimation(playerid, "T_EXPLOSION_SCARED_HERO") 
end);

addCommandHandler({"/������"}, function(playerid, param)
	PlayAnimation(playerid, "T_FINGERSCOUNT_START_GUIDO") 
end);

addCommandHandler({"/���������"}, function(playerid, param)
	PlayAnimation(playerid, "S_FIREPLACE") 
end);

addCommandHandler({"/��"}, function(playerid, param)
	PlayAnimation(playerid, "T_FIREPLACEOAR_S0_2_S1")
end);

--addCommandHandler({"/�������"}, function(playerid, param)
	--PlayAnimation(playerid, "R_HOWLSSIT") 
--end);

addCommandHandler({"/���������"}, function(playerid, param)
	PlayAnimation(playerid, "T_JON_KNEEL") 
end);

addCommandHandler({"/������"}, function(playerid, param)
	PlayAnimation(playerid, "T_THREAT_DEATH") 
end);

addCommandHandler({"/���"}, function(playerid, param)
	PlayAnimation(playerid, "T_SHOCKED_START") 
end);

addCommandHandler({"/������"}, function(playerid, param)
	PlayAnimation(playerid, "S_KICKOBJECT_S1") 
end);

addCommandHandler({"/��������"}, function(playerid, param)
	PlayAnimation(playerid, "T_LAUGH") 
end);

addCommandHandler({"/����"}, function(playerid, param)
	PlayAnimation(playerid, "S_LOOKOUT") 
end);

addCommandHandler({"/����������"}, function(playerid, param)
	PlayAnimation(playerid, "T_STAND_2_MPRISON") 
end);

addCommandHandler({"/�"}, function(playerid, param)
	PlayAnimation(playerid, "S_OCEAN_S1") 
end);


addCommandHandler({"/��������1"}, function(playerid, param)
	PlayAnimation(playerid, "T_STAND_2_DEPRESSIONSIT") 
end);

addCommandHandler({"/��������2"}, function(playerid, param)
	PlayAnimation(playerid, "T_SITTIRED_S0_2_S1") 
end);

addCommandHandler({"/�����"}, function(playerid, param)
	PlayAnimation(playerid, "S_SLAVSQUATDIALOGUE") 
	SendPlayerMessage(playerid, 255, 255, 255, "������ � �������� - /�����_������")
end);

addCommandHandler({"/�����_������"}, function(playerid, param)
	PlayAnimation(playerid, "T_REMOVE_SLAVSQUATDIALOGUE") 
end);

addCommandHandler({"/��������"}, function(playerid, param)
	PlayAnimation(playerid, "S_BLOODFLASK_S1") 
end);

addCommandHandler({"/��������"}, function(playerid, param)
	PlayAnimation(playerid, "S_BOWMAKING_S1") 
end);

addCommandHandler({"/�������"}, function(playerid, param)
	PlayAnimation(playerid, "T_PISSOFF") 
end);

addCommandHandler({"/�������"}, function(playerid, param)
	PlayAnimation(playerid, "T_STAND_2_CLAPHANDS") 
end);

addCommandHandler({"/����1"}, function(playerid, param)
	PlayAnimation(playerid, "T_ANGRYMOB_01") 
end);

addCommandHandler({"/����2"}, function(playerid, param)
	PlayAnimation(playerid, "T_ANGRYMOB_02") 
end);

addCommandHandler({"/����3"}, function(playerid, param)
	PlayAnimation(playerid, "T_ANGRYMOB_03") 
end);

addCommandHandler({"/����4"}, function(playerid, param)
	PlayAnimation(playerid, "T_MARVIN_FLEX") 
end);

addCommandHandler({"/�����"}, function(playerid, param)
	PlayAnimation(playerid, "T_STAND_2_SCAREDDIALOGUE") 
	SendPlayerMessage(playerid, 255, 255, 255, "�������� �������� - /�����_������")
end);

addCommandHandler({"/�����_������"}, function(playerid, param)
	PlayAnimation(playerid, "T_REMOVE_SCAREDDIALOGUE") 
end);

addCommandHandler({"/������"}, function(playerid, param)
	PlayAnimation(playerid, "T_STAND_2_MILSTAND") 
	SendPlayerMessage(playerid, 255, 255, 255, "�������� �������� - /������_������")
end);

addCommandHandler({"/������_������"}, function(playerid, param)
	PlayAnimation(playerid, "T_REMOVE_MILSTAND") 
end);

addCommandHandler({"/�����"}, function(playerid, param)
	PlayAnimation(playerid, "T_MILSTAND_2_MILJOIN") 
end);

addCommandHandler({"/��������"}, function(playerid, param)
	PlayAnimation(playerid, "T_PICKFRUIT") 
end);

addCommandHandler({"/��������"}, function(playerid, param)
	PlayAnimation(playerid, "T_YELL") 
end);

addCommandHandler({"/�������1"}, function(playerid, param)
	PlayAnimation(playerid, "T_LIEDOWNMACHO_STAND_2_S0") 
end);

addCommandHandler({"/�������2"}, function(playerid, param)
	PlayAnimation(playerid, "T_LIEDOWNRELAXED_STAND_2_S0") 
end);
	

addCommandHandler({"/������������"}, function(playerid, param)
	PlayAnimation(playerid, "S_CHECKSWD_S1") 
end);

function GesticKey(playerid, keydown, keyup)
	if keydown == KEY_NUMPAD7 then
		PlayAnimation (playerid, "T_CANNOTTAKE")
	elseif keydown == KEY_NUMPAD8 then
		PlayAnimation (playerid, "T_GREETNOV")
	elseif keydown == KEY_NUMPAD9 then
		PlayAnimation (playerid, "R_SCRATCHHEAD")
	elseif keydown == KEY_NUMPAD4 then
		PlayAnimation (playerid, "T_FORGETIT")
	elseif keydown == KEY_NUMPAD5 then
		PlayAnimation (playerid, "T_GREETGRD")
	elseif keydown == KEY_NUMPAD6 then
		PlayAnimation (playerid, "T_BORINGKICK")
	elseif keydown == KEY_NUMPAD1 then
		PlayAnimation (playerid, "T_FACEPALM")
	elseif keydown == KEY_NUMPAD2 then
		PlayAnimation (playerid, "T_COMEOVERHERE")
	elseif keydown == KEY_NUMPAD3 then
		PlayAnimation (playerid, "T_NO")
	elseif keydown == KEY_NUMPAD0 then
		PlayAnimation (playerid, "R_LEGSHAKE")
	elseif keydown == KEY_NUMPAD0 then
		PlayAnimation (playerid, "R_SCRATCHEGG")
	end
end

	function animlist(playerid)
	SendPlayerMessage(playerid,255,255,255,"��������: /�����/������/������2/�����/��������/������������/��������/��������/������������/������/������/�������"); 
	SendPlayerMessage(playerid,255,255,255,"/������/������/������/�������/�����/������/������/��������/��������2/�������1/�������2/����������/��/���/�����");
	SendPlayerMessage(playerid,255,255,255,"/����������/������/������/���/���2/����/��������/����/������/������2/������3/�����1/�����2/�����3");
	SendPlayerMessage(playerid,255,255,255,"��������� �������� /��������2");
	end
addCommandHandler({"/��������"}, animlist)

	function animlist2(playerid)
 	SendPlayerMessage(playerid,255,255,255,"/������� 1-14 (1 - ��,2 - ����, 3 - ������, 4 - �������������, 5 - ��������, 6 - ������, 7 - �������,8 - ����������,");
 	SendPlayerMessage(playerid,255,255,255,"9 - �������, 10 - ���� �2, 11 - ���� � ��������, 12 - ���� �� ������, 13 - ����� ��������, 14 - ������ ��������");
	SendPlayerMessage(playerid,255,255,255,"/���(1-3)/�������/������/������2/���������/�����������/������/���������/��/�������");
	SendPlayerMessage(playerid,255,255,255,"/���������/������/��������/����/����������");
	SendPlayerMessage(playerid,255,255,255,"��������� �������� /��������3");
	end
	addCommandHandler({"/��������2"}, animlist2)

	function animlist3(playerid)
 	SendPlayerMessage(playerid,255,255,255,"/����(1-4)/�����/������/��������/��������/�������(1-2)/�����/�������/���/������");
 	SendPlayerMessage(playerid,255,255,255,"/����/�������(1-2)/���/�����/�����/�����(2-8)");
 	SendPlayerMessage(playerid,255,255,255,"/�/��������(1-2)/�����/�����_������/��������/��������/������������/�������");
	end
	addCommandHandler({"/��������3"}, animlist3)