# pob-headless

Headless version of [pathofbuilding](https://github.com/PathOfBuildingCommunity/PathOfBuilding).

The main branch works on Windows just for debuging and development.

The linux branch provides http server to support features like [poe.ninja](poe.ninja).

# usage

## linux

install [luajit](https://luajit.org/luajit.html)和[luarocks](https://luarocks.org/).

install luafilesystem:

```bash
sudo luarocks install luafilesystem
```

install lua-http:

```bash
sudo apt update
# cqueues's dependencies
sudo apt install libssl-dev m4
sudo luarocks install http
```

run：

```bash
export LUA_PATH="./lua/?.lua;./lua/?/init.lua;/usr/local/share/lua/5.1/?.lua;"
luajit HeadlessWrapper.lua
```
# dev

## debuging on Windows

Install vscode's extensions [lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) and [Local Lua Debugger](https://marketplace.visualstudio.com/items?itemName=tomblind.local-lua-debugger-vscode). Change `configurations.program.lua` value in `.vscode/launch.json` to the path of luajit exec file. Use vscode to debug it.

Or you can run it manually:

```powershell
$Env:LUA_PATH="./lua/?.lua;./lua/?/init.lua;"
$Env:LUA_CPATH="./lua/?/?.dll;"
D:/AppsInDisk/luajit2.1_x64/luajit .\HeadlessWrapper.lua
```

## update pob

准备一份干净的最新的pob版本：

- 将pob根目录下的所有文件（非文件夹）粘贴到项目根目录，检查文件的增减（通常所有新增文件可以丢弃掉）。
- 将pob根目录下的所有文件夹粘贴到项目根目录，更新clean.sh脚本并使用它来删除不需要的文件，检查文件夹的增减（通常不需要进一步操作）。项目目前只修改了`lua/`的内容，仅需要重点关注该文件夹。
- 将main分区的更新合并到linux分区。