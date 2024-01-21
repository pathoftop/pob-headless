# 使用须知

安装luajit和luarocks，并安装以下依赖：

luafilesystem:

```bash
sudo luarocks install luafilesystem
```

lua-http:

```bash
sudo apt update
# cqueues的构建依赖
sudo apt install libssl-dev m4
sudo luarocks install http
```

执行服务：

```bash
export LUA_PATH="./lua/?.lua;./lua/?/init.lua;/usr/local/share/lua/5.1/?.lua;"
luajit HeadlessWrapper.lua
```

**注意，服务没有做任何线程安全处理，仅支持串行访问**。