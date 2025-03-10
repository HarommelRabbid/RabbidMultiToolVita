--[[
Rabbid MultiTool OneLua 0.12pre
TODO:
- Add touch support
- Add icons to app list
- Finish the rest of the menus
]]
snow = false
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end

--[[appicons = {}
sysicons = {}

local apps = game.list(__GAME_LIST_ALL)
local sysapps = game.list(__GAME_LIST_SYS)

for i=1, #apps do
table.insert(appicons, i, image.load("ur0:appmeta/"..apps[i].id.."/icon0.png") or image.new(128, 128, color.white))
end
for i=1, #sysapps do
table.insert(sysicons, i, image.load("vs0:app/"..sysapps[i].id.."/sce_sys/icon0.png"))
end
]]

if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "customfont", "default") == "true" then
  local fontpath = ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "fontpath", "default")
 font.load(fontpath)
 font.setdefault(fontpath)
else
 font.setdefault()
end

if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "custombg", "default") == "true" then
  bg = true
  bgpath = ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "bgpath", "default")
else
  bg = false
end

colpallete = {
["red"]=color.red,
["green"]=color.green,
["blue"]=color.blue,
["cyan"]=color.cyan,
["magenta"]=color.magenta,
["yellow"]=color.yellow,
["maroon"]=color.maroon,
["grass"]=color.grass,
["navy"]=color.navy,
["turquoise"]=color.turquoise,
["violet"]=color.violet,
["olive"]=color.olive,
["white"]=color.white,
["gray"]=color.gray,
["black"]=color.black,
["orange"]=color.orange,
["chocolate"]=color.chocolate,
["shine"]=color.shine,
["shadow"]=color.shadow
}

color1 = ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "color", "default")
snow1 = ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "snow", "default")

if color1 == "default" then
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "color", "navy")
end

if snow1 == "default" then
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "snow", "false")
end

color1 = colpallete[color1]

dofile("git/updater.lua")

exit1_callback = function()
 dofile("menus/menu.lua")
end

if files.exists("ux0:data/Rabbid MultiTool/config.ini") == false then
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "appicon", "false")
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "customfont", "true")
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "fontpath", "sa0:data/font/pvf/jpn2.pvf")
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "custombg", "false")
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "bgpath", "")
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "color", "navy")
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "snow", "false")
end

if ((tonumber(os.date("%m")) == 12 or tonumber(os.date("%m")) == 1 or tonumber(os.date("%m")) == 2) and snow1 == "auto") or snow1 == "true" then snow = true end

splash.zoom("sce_sys/pic0.png")
dofile("menus/menu.lua")
