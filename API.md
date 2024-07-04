# API说明

本文档包含Linux版本的WEB Server提供的HTTP服务，只支持**单线程**访问。

## loadJSON

加载从POE获取的JSON数据，包括items和passiveSkills。

请求：

||内容|描述|
|--|--|--|
|方法|POST||
|路径|/loadJSON||
|body|00068924{"items":...}{"character": 2,...}|`items字节长度`+`items`+`passiveSkills`，`items字节长度`为长度为8的十进制表示的字符串，不足8位高位补零|
|content-type|text/plain||

响应：

||内容|描述|
|--|--|--|
|status code|200||

## loadXML

加载XML格式的Build数据。

||内容|描述|
|--|--|--|
|方法|POST||
|路径|/loadXML||
|body|`<?xml...</xml>`|XML Build|
|content-type|text/plain||


响应：

||内容|描述|
|--|--|--|
|status code|200||

## saveXML

保存Build为XML。

请求：

||内容|描述|
|--|--|--|
|方法|GET||
|路径|/saveXML||

响应：

||内容|描述|
|--|--|--|
|status code|200||
|body|`<?xml...</xml>`|xml build数据|

## saveCode

保存Build为可分享的Code。

请求：

||内容|描述|
|--|--|--|
|方法|GET||
|路径|/saveCode||

响应：

||内容|描述|
|--|--|--|
|status code|200||
|body|`eJztfVt3nDi...`|code数据|

## getAllGems

获取Build的所有Gems，去除重复。

请求：

||内容|描述|
|--|--|--|
|方法|GET||
|路径|/getAllGems||

响应：

||内容|描述|
|--|--|--|
|status code|200||

```json
["Enfeeble","Cast when Stunned","Immortal Call","Purifying Flame","Enhance","Enduring Cry","Call to Arms","Vitality","Shield Charge","Awakened Elemental Focus","Awakened Unbound Ailments","Detonate Dead of Chain Reaction","Item Rarity","Awakened Deadly Ailments","Petrified Blood","Flame Dash","Purity of Elements","Eternal Blessing","Spell Cascade","Frost Bomb","Desecrate"]
```

## getAllMainSkills

获取Build的所有主技能，通过连接数量判断，需要指定最小连接数。

瓦尔技能不计入主技能。

请求：

||内容|描述|
|--|--|--|
|方法|GET||
|路径|/getAllMainSkills||
|body|`5`|最小连接数量|
|content-type|text/plain||

响应：

||内容|描述|
|--|--|--|
|status code|200||

```json
[{"supports":["Cast when Stunned","Awakened Elemental Focus","Awakened Unbound Ailments","Item Rarity","Awakened Deadly Ailments"],"skill":"Detonate Dead of Chain Reaction","dps":505269.49214545}]
```