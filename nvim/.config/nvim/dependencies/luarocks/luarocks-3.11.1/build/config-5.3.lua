-- LuaRocks configuration

rocks_trees = {
   { name = "user", root = home .. "/.luarocks" };
   { name = "system", root = "/usr/local" };
}
variables = {
   LUA_DIR = "/usr/local";
   LUA_INCDIR = "/usr/local/include";
   LUA_BINDIR = "/usr/local/bin";
   LUA_VERSION = "5.3";
   LUA = "/usr/local/bin/lua";
}
