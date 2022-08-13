
function _sit1(id)
	RemovePlayerOverlay(id, GetPlayerWalk(id));
	SetPlayerWalk(id, "HUMANS_G1MAGE.mds");
	PlayAnimation(id,"T_STAND_2_SIT");
	Freeze(id);
	SendPlayerMessage(id, 255, 255, 255, "Чтобы встать - введите команду /встать");
end
addCommandHandler({"/сесть1"}, _sit1);

function _sit2(id)
	RemovePlayerOverlay(id, GetPlayerWalk(id));
	SetPlayerWalk(id, "HUMANS_G1MILITIA.mds");
	PlayAnimation(id,"T_STAND_2_SIT");
	Freeze(id);
	SendPlayerMessage(id, 255, 255, 255, "Чтобы встать - введите команду /встать");
end
addCommandHandler({"/сесть2"}, _sit2);

function _sit3(id)
	RemovePlayerOverlay(id, GetPlayerWalk(id));
	SetPlayerWalk(id, "HUMANS_G1RELAXED.mds");
	PlayAnimation(id,"T_STAND_2_SIT");
	Freeze(id);
	SendPlayerMessage(id, 255, 255, 255, "Чтобы встать - введите команду /встать");
end
addCommandHandler({"/сесть3"}, _sit3);

function _sit4(id)
	RemovePlayerOverlay(id, GetPlayerWalk(id));
	SetPlayerWalk(id, "HUMANS_G1TIRED.mds");
	PlayAnimation(id,"T_STAND_2_SIT");
	Freeze(id);
	SendPlayerMessage(id, 255, 255, 255, "Чтобы встать - введите команду /встать");
end
addCommandHandler({"/сесть4"}, _sit4);

function _sit_stand(id)
	RemovePlayerOverlay(id, GetPlayerWalk(id));
	PlayAnimation(id,"T_STAND_2_LGUARD");
	UnFreeze(id);
	SetPlayerWalk(id, Player[id].overlay);
end
addCommandHandler({"/встать"}, _sit_stand);


function CMD_SIT(playerid)
	if GetPlayerInstance(playerid) == "ORCELITE_ROAM" or GetPlayerInstance(playerid) == "ORCSHAMAN_SIT" or GetPlayerInstance(playerid) == "ORCWARRIOR_ROAM" then
		PlayAnimation(playerid, "S_GUARDSLEEP");
	else
		PlayAnimation(playerid,"T_STAND_2_SIT");
	end
end
addCommandHandler({"/сесть", "/sit"}, CMD_SIT);	

addCommandHandler({"/спать","/sleep"}, function(playerid, param)
	if GetPlayerInstance(playerid) == "ORCELITE_ROAM" or GetPlayerInstance(playerid) == "ORCSHAMAN_SIT" or GetPlayerInstance(playerid) == "ORCWARRIOR_ROAM" then
		PlayAnimation(playerid, "T_STAND_2_GUARDSLEEP");
	else
		PlayAnimation(playerid,"T_STAND_2_SLEEPGROUND");
	end
end);

addCommandHandler({"/ссать","/pee"}, function(playerid, param)
	PlayAnimation(playerid,"T_STAND_2_PEE");
end);

addCommandHandler({"/привет","/hi"}, function(playerid, param)
	PlayAnimation(playerid,"T_GREETRIGHT");
end);

addCommandHandler({"/привет2","/hi2"}, function(playerid, param)
	PlayAnimation(playerid,"T_HGUARD_GREET");
end);

addCommandHandler({"/страж3","/guard3"}, function(playerid, param)
	PlayAnimation(playerid,"T_HGUARD_LOOKAROUND");
end);

addCommandHandler({"/кивок","/yes"}, function(playerid, param)
	PlayAnimation(playerid,"T_YES");
end);

addCommandHandler({"/отогнать","/otognat"}, function(playerid, param)
	PlayAnimation(playerid,"T_GETLOST2");
end);

addCommandHandler({"/разглядывать","/see"}, function(playerid, param)
	PlayAnimation(playerid,"T_1HSINSPECT");
end);

addCommandHandler({"/почухать","/po4yhat"}, function(playerid, param)
	PlayAnimation(playerid,"R_SCRATCHEGG");
end);

addCommandHandler({"/почесать","/4esat"}, function(playerid, param)
	PlayAnimation(playerid,"R_SCRATCHHEAD");
end);

addCommandHandler({"/переминаться","/peremen"}, function(playerid, param)
	PlayAnimation(playerid,"R_LEGSHAKE");
end);

addCommandHandler({"/пинать","/knock"}, function(playerid, param)
	PlayAnimation(playerid,"T_BORINGKICK");
end);

addCommandHandler({"/незнаю","/dontknow"}, function(playerid, param)
	PlayAnimation(playerid,"T_DONTKNOW");
end);

addCommandHandler({"/махнуть","/mah"}, function(playerid, param)
	PlayAnimation(playerid,"T_FORGETIT");
end);

addCommandHandler({"/ковать","/kovka"}, function(playerid, param)
	PlayAnimation(playerid,"S_BSANVIL_S1");
end);

addCommandHandler({"/точить","/to4ka"}, function(playerid, param)
	PlayAnimation(playerid,"S_BSSHARP_S1");
end);

addCommandHandler({"/мешать","/meshat"}, function(playerid, param)
	PlayAnimation(playerid,"S_CAULDRON_S1");
end);

addCommandHandler({"/маяться","/mayta"}, function(playerid, param)
	PlayAnimation(playerid,"T_PAUKE_S1_2_S0");
end);

addCommandHandler({"/ранен","/rana"}, function(playerid, param)
	PlayAnimation(playerid,"T_STAND_2_WOUNDED");
end);

addCommandHandler({"/добить","/dobit"}, function(playerid, param)
	PlayAnimation(playerid,"T_1HSFINISH");
end);

addCommandHandler({"/курить","/smoke"}, function(playerid, param)
	PlayAnimation(playerid,"T_JOINT_S0_2_STAND");
end);

addCommandHandler({"/молиться","/bless"}, function(playerid, param)
	PlayAnimation(playerid,"T_STAND_2_PRAY");
end);

addCommandHandler({"/молиться2","/bless2"}, function(playerid, param)
	PlayAnimation(playerid,"S_INNOS_S1");
end);

addCommandHandler({"/молоток","/hammer"}, function(playerid, param)
	PlayAnimation(playerid,"S_REPAIR_S1");
end);

addCommandHandler({"/тренировка","/trenya"}, function(playerid, param)
	PlayAnimation(playerid,"T_1HSFREE");
end);

addCommandHandler({"/да","/da"}, function(playerid, param)
	PlayAnimation(playerid,"T_YES");
end);

addCommandHandler({"/нет","/net"}, function(playerid, param)
	PlayAnimation(playerid, "T_NO")
end);

addCommandHandler({"/обыск","/obisk"}, function(playerid, param)
	PlayAnimation(playerid,"T_PLUNDER");
end);

addCommandHandler({"/оглядеться","/ogl"}, function(playerid, param)
	PlayAnimation(playerid,"T_SEARCH");
end);

addCommandHandler({"/кушать","/eat"}, function(playerid, param)
	PlayAnimation(playerid, "T_FOOD_S0_2_STAND")
end);

addCommandHandler({"/копать","/kopka"}, function(playerid, param)
	PlayAnimation(playerid, "S_TREASURE_S2")
end);

addCommandHandler({"/обл","/obl"}, function(playerid, param)
	PlayAnimation(playerid, "S_LEAN")
end);

addCommandHandler({"/обл2","/obl2"}, function(playerid, param)
	PlayAnimation(playerid, "S_WALL_S1")
end);

addCommandHandler({"/пить","/drink"}, function(playerid, param)
	PlayAnimation(playerid, "T_POTION_S0_2_STAND")
end);

addCommandHandler({"/присесть","/prisest"}, function(playerid, param)
	PlayAnimation(playerid, "T_CHESTSMALL_STAND_2_S0")
end);

addCommandHandler({"/идол","/idol"}, function(playerid, param)
	PlayAnimation(playerid, "S_IDOL_S1")
end);

addCommandHandler({"/присесть","/prisest"}, function(playerid, param)
	PlayAnimation(playerid, "T_CHESTSMALL_STAND_2_S0")
end);

addCommandHandler({"/присесть","/prisest"}, function(playerid, param)
	PlayAnimation(playerid, "T_CHESTSMALL_STAND_2_S0")
end);

addCommandHandler({"/смерть","/dead"}, function(playerid, param)
	PlayAnimation(playerid, "T_DEAD")
end);

addCommandHandler({"/смерть2","/dead2"}, function(playerid, param)
	PlayAnimation(playerid, "T_DEADB")
end);

addCommandHandler({"/страж1","/guard1"}, function(playerid, param)
	PlayAnimation(playerid,"T_STAND_2_LGUARD");
end);

addCommandHandler({"/страж2","/guard2"}, function(playerid, param)
	PlayAnimation(playerid,"T_STAND_2_HGUARD");
end);

addCommandHandler({"/танец"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_01")
end);

addCommandHandler({"/танец1"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_02")
end);

addCommandHandler({"/танец2"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_03")
end);

addCommandHandler({"/танец3"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_04")
end);

addCommandHandler({"/танец4"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_05")
end);

addCommandHandler({"/танец5"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_06")
end);

addCommandHandler({"/танец6"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_07")
end);

addCommandHandler({"/танец7"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_08")
end);

addCommandHandler({"/танец8"}, function(playerid, param)
	PlayAnimation(playerid, "T_DANCE_09")
end);

addCommandHandler({"/бар1"}, function(playerid, param)
	PlayAnimation(playerid, "S_BARRELCONTAINER_S1")
end);

addCommandHandler({"/бар2"}, function(playerid, param)
	PlayAnimation(playerid, "R_BARRELCONTAINER_DRINK")
end);

addCommandHandler({"/блевать"}, function(playerid, param) 
	PlayAnimation(playerid, "S_BREATH")
end);

addCommandHandler({"/плакать"}, function(playerid, param)
	PlayAnimation(playerid, "S_CRY")
end);

addCommandHandler({"/огорчение"}, function(playerid, param)
	PlayAnimation(playerid, "T_FACEPALM")
end);

addCommandHandler({"/упасть"}, function(playerid, param) 
	PlayAnimation(playerid, "T_FALLDOWN_QUICK")
end);

addCommandHandler({"/упасть2"}, function(playerid, param)
	PlayAnimation(playerid, "T_FALLDOWN_LONG")
end);

addCommandHandler({"/осмотреться"}, function(playerid, param)
	PlayAnimation(playerid, "T_EXPLOSION_SCARED_HERO") 
end);

addCommandHandler({"/пальцы"}, function(playerid, param)
	PlayAnimation(playerid, "T_FINGERSCOUNT_START_GUIDO") 
end);

addCommandHandler({"/погреться"}, function(playerid, param)
	PlayAnimation(playerid, "S_FIREPLACE") 
end);

addCommandHandler({"/уу"}, function(playerid, param)
	PlayAnimation(playerid, "S_FIREPLACEOAR_S1")
end);

--addCommandHandler({"/кричать"}, function(playerid, param)
	--PlayAnimation(playerid, "R_HOWLSSIT") 
--end);

addCommandHandler({"/поражение"}, function(playerid, param)
	PlayAnimation(playerid, "T_JON_KNEEL") 
end);

addCommandHandler({"/выбить"}, function(playerid, param)
	PlayAnimation(playerid, "S_KICKOBJECT_S1") 
end);

addCommandHandler({"/обсмеять"}, function(playerid, param)
	PlayAnimation(playerid, "T_LAUGH") 
end);

addCommandHandler({"/взор"}, function(playerid, param)
	PlayAnimation(playerid, "S_LOOKOUT") 
end);

addCommandHandler({"/схваченный"}, function(playerid, param)
	PlayAnimation(playerid, "T_STAND_2_MPRISON") 
end);

addCommandHandler({"/с"}, function(playerid, param)
	PlayAnimation(playerid, "S_OCEAN_S1") 
end);

addCommandHandler({"/отчаяние"}, function(playerid, param)
	PlayAnimation(playerid, "S_SITTIRED_S1") 
end);

addCommandHandler({"/корты"}, function(playerid, param)
	PlayAnimation(playerid, "S_SLAVSQUATDIALOGUE") 
	SendPlayerMessage(playerid, 255, 255, 255, "Встать в корточек - /корты_отмена")
end);

addCommandHandler({"/корты_отмена"}, function(playerid, param)
	PlayAnimation(playerid, "T_REMOVE_SLAVSQUATDIALOGUE") 
end);

addCommandHandler({"/черпнуть"}, function(playerid, param)
	PlayAnimation(playerid, "S_BLOODFLASK_S1") 
end);

addCommandHandler({"/обточить"}, function(playerid, param)
	PlayAnimation(playerid, "S_BOWMAKING_S1") 
end);

addCommandHandler({"/отстань"}, function(playerid, param)
	PlayAnimation(playerid, "T_PISSOFF") 
end);

addCommandHandler({"/гопак"}, function(playerid, param)
	PlayAnimation(playerid, "T_HOPAK") 
end);


addCommandHandler({"/демонстрация"}, function(playerid, param)
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
	SendPlayerMessage(playerid,255,255,255,"Анимации: /ссать/привет/привет2/страж3/кивок/отогнать/разглядывать/почухать/почесать/переминаться/пинать/незнаю/махнуть"); 
	SendPlayerMessage(playerid,255,255,255,"/ковать/точить/мешать/маяться/ранен/добить/курить/молиться/молиться2/молоток/тренировка/да/нет/обыск/оглядеться/кушать");
	SendPlayerMessage(playerid,255,255,255,"копать/обл/обл2/пить/присесть/идол/присесть/присесть/смертьсмерть2/страж1/страж2");
	SendPlayerMessage(playerid,255,255,255,"Следующая страница /анимлист2");
	end
addCommandHandler({"/анимлист"}, animlist)

	function animlist2(playerid)
 SendPlayerMessage(playerid,255,255,255,"/походка1-6(1-мага,2-стража,3-уставшая,4-расслабленная,5-важная,6-разбойника,7-женская)");
	SendPlayerMessage(playerid,255,255,255,"/бар1/бар2/блевать/плакать/упасть/огорчение/упасть2/осмотреться/пальцы/погреться/уу/кричать");
	SendPlayerMessage(playerid,255,255,255,"/поражение/выбить/обсмеять/взор/схваченный");
	SendPlayerMessage(playerid,255,255,255,"/с/отчаяние/корты/корты_отмена/черпнуть/обточить/демонстрация/отстань");
	end
	addCommandHandler({"/анимлист2"}, animlist2)