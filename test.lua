local xxh32 = require("luaxxhash")
local str = "Cat's are interesting."
assert(xxh32(str) == -219447131)