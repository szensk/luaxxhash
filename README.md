luaxxhash
========
A LuaJIT implementation of [xxhash](https://code.google.com/p/xxhash/). Doesn't require bindings. Doesn't implement digest.

Usage
=====
```lua
local xxh32 = require("luaxxhash")
local str = "Cats are interesting."
assert(xxh32(str) == 1710037756)
```

Benchmark
=========
Ran on a Intel T6400 @ 2.0GHz.
```
lua-xxhash: 54957.13/s 3959.19MB/s (C binding)
luaxxhash:  12435.24/s 895.854MB/s (pure LuaJIT)
pmurmur3:    5603.67/s 403.697MB/s (pure LuaJIT)
```