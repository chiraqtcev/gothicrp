

Player = {};
for i = 0, GetMaxSlots() - 1 do


	Player[i] = {};

	Player[i].openinv = false;
	Player[i].rpinventory = {};
	Player[i].rpinventory_amount = {};
	Player[i].rpinventory_slot = nil;
	Player[i].rpinventory_final = false;

	Player[i].hunting = false;
	Player[i].huntlevel = 0;
	Player[i].huntexpn = 0;
	Player[i].huntexp = 0;

	Player[i].readscrolls = 0;

	Player[i].inviseforbots = false;
    Player[i].onGUI = false;

	Player[i].masked = false;

	Player[i].invise = false;
	Player[i].zvanie = nil;

	Player[i].mine = 0;
	Player[i].wood = 0;
	Player[i].iron = 0;
	Player[i].SkinCode = "";


	Player[i].energy = 0;
	Player[i].energyblock = 0;
	Player[i].energydate = 0;

	Player[i].openstatspanel = false;

	Player[i].opencraft = false;
	Player[i].craftpage = 0;
	Player[i].selectcraftitem = 0;
	Player[i].craftlevel = {0, 0, 0}; -- [1] - smith, [2] - alchemy, [3] - wood


	Player[i].nickname = "";
	Player[i].password = "";
	Player[i].astatus = 0;
	Player[i].loggedIn = false;
	Player[i].lastplay_data = "";

	Player[i].overlay = "";
	Player[i].skin = {};

	-- res
	Player[i].gold = 0;
	Player[i].oldgold = 0;
	Player[i].rude = 0;
	Player[i].bank = 0;
	Player[i].acrob = 0;

	-- stats
	Player[i].h1 = 0;
	Player[i].h2 = 0;
	Player[i].bow = 0;
	Player[i].cbow = 0;
	Player[i].hp = 0;
	Player[i].chp = 0;
	Player[i].mp = 0;
	Player[i].cmp = 0;
	Player[i].currenthp = 0;
	Player[i].str = 0;
	Player[i].dex = 0;
	Player[i].mag = 0;

	-- other
	Player[i].menuopen = 0;
	Player[i].showchat = true;
	Player[i].vobtimer = nil;
	Player[i].enterreg = false;
	Player[i].enterlog = false;
	Player[i].logconnect = true;
	Player[i].rdy = false;
	Player[i].logconnect = nil;
	Player[i].stepone = false;
	Player[i].steptwo = false;
	Player[i].stepthree = false;
	Player[i].regclass = 0;
	Player[i].animtimer = nil;
	Player[i].exittimer = nil;
	Player[i].defclick = 0;
	Player[i].dlg = false;
	Player[i].campos = 0;


	Player[i].aduty = false; -- Активация админки
	Player[i].ahide = false; -- Скрытие админки

	-- golod
	Player[i].food = 100;
	
end
