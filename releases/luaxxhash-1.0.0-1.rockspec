package = "luaxxhash"
version = "1.0.0-1"
source = {
  url = "git://github.com/szensk/luaxxhash",
  tag = "1.0.0",
}
description = {
  summary = "A LuaJIT implementation of xxhash",
  detailed = [[
   A LuaJIT implementation of xxhash.
   Doesn't require bindings. Doesn't implement digest.
  ]],
  homepage = "https://github.com/szensk/luaxxhash",
  license = "MIT"
}
build = {
  type = "builtin",
  modules = {
    luaxxhash = "luaxxhash.lua"
  }
}
