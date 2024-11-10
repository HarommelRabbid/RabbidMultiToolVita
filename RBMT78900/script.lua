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
end

dofile("menus/menu.lua")
