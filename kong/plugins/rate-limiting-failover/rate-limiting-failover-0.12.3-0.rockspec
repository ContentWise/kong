package = "rate-limiting-failover"
version = "0.12.3-0"
source = {
  url = "git://github.com/ContentWise/kong",
  tag = "0.12.3-rate-limiting-failover"
}
dependencies = {
  "luasec == 0.6",
  "luasocket == 3.0-rc1",
  "penlight == 1.5.4",
  "lua-resty-http == 0.08",
  "lua-resty-jit-uuid == 0.0.7",
  "multipart == 0.5.1",
  "version == 0.2",
  "kong-lapis == 1.6.0.1",
  "lua-cassandra == 1.2.3",
  "pgmoon == 1.8.0",
  "luatz == 0.3",
  "lua_system_constants == 0.1.2",
  "lua-resty-iputils == 0.3.0",
  "luaossl == 20171028",
  "luasyslog == 1.0.0",
  "lua_pack == 1.0.5",
  "lua-resty-dns-client == 1.0.0",
  "lua-resty-worker-events == 0.3.1",
  "lua-resty-mediador == 0.1.2",
  "lua-resty-healthcheck == 0.3.0",
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.rate-limiting-failover.daos"] = "daos.lua",
    ["kong.plugins.rate-limiting-failover.schema"] = "schema.lua",
    ["kong.plugins.rate-limiting-failover.handler"] = "handler.lua",
    ["kong.plugins.rate-limiting-failover.migrations.cassandra"] = "migrations/cassandra.lua",
    ["kong.plugins.rate-limiting-failover.migrations.postgres"] = "migrations/postgres.lua",
    ["kong.plugins.rate-limiting-failover.policies.cluster"] = "policies/cluster.lua",
    ["kong.plugins.rate-limiting-failover.policies.init"] = "policies/init.lua",
  }
}
