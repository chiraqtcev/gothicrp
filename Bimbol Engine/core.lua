version = "0.1a"
data = "06.10.2020"
c_r, c_g, c_b = 205, 50, 135;
_Module = "[module]";
_Require = "[require]";
_Framework = "[framework]";
_Callback = "[callback]";

filename = function()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("^.*/(.*)$") or str
end
require "Bimbol Engine/require"
