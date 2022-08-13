--[[

	Module: voblist.lua
	Author: Bimbol
	
	World Builder vob list

]]--

local Vobs = {};

function loadVobsFromFile(filename)
	if filename then
		if openFile(filename, "r+") then
			local vobs = readFileLines(filename);
			for i in pairs(vobs) do
				table.insert(Vobs, vobs[i]);
			end
			print("== Successfully loaded vob list ==");
			print("== Vob amount: "..#Vobs.." ==");
			closeFile(filename);
		end
	end
end

function getVobByID(id)
	if id then
		for i, k in ipairs(Vobs) do
			if i == id then
				return k;
			end
		end
	end
end

-- Loaded
print(debug.getinfo(1).source.." has been loaded.");