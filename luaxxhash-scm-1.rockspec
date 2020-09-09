package = "luaxxhash"
version = "scm-1"
source = {
  url = "git://github.com/szensk/luaxxhash",
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
