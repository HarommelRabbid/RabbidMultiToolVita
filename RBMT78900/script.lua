snow = false
if tonumber(os.date("%m")) == 12 or tonumber(os.date("%m")) == 1 or tonumber(os.date("%m")) == 2 then snow = true end
buttons.homepopup(0)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end

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

if color1 == "default" then
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "color", "blue")
end

color1 = colpallete[color1]

dofile("git/updater.lua")

exit1_callback = function()
 dofile("menus/menu.lua")
end

if files.exists("ux0:data/Rabbid MultiTool/config.ini") == false then
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "appicon", "false")
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "customfont", "false")
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "fontpath", "")
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "custombg", "false")
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "bgpath", "")
 ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "color", "blue")
end

splash.zoom("sce_sys/pic0.png")
dofile("menus/menu.lua")
