luaxxhash
========
A LuaJIT implementation of [xxhash](https://code.google.com/p/xxhash/). Doesn't require bindings. Doesn't implement digest.

Usage
=====
```lua
local xxh32 = require("luaxxhash")
local str = "Cat's are interesting."
assert(xxh32(str) == -219447131)
```