local xxh32 = require("luaxxhash")

local str = "Cats are interesting."
local str1 = "a"
local strt = { 
	str1:rep(4),
 	str1:rep(16),
 	str1:rep(32),
 	str1:rep(32) .. str1 .. str1:rep(4)
}
local answer = {
	-631806169,
 	1571609996,
	-1557966914,
	1065833563
}

for i=1, #strt do
	assert(xxh32(strt[i],0) == answer[i], "Hash produces incorrect values")
end

assert(xxh32(str) == 1710037756, "Hash produces incorrect values")
