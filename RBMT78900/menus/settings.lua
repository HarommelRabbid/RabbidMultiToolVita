dofile("scripts/scroll.lua")
dofile("scripts/stars.lua")
color.loadpalette()
buttons.homepopup(0)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end

local iconset_callback = function()
 if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "appicon", "default") == "true" then
  ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "appicon", "false")
 else
  ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "appicon", "true")
 end
end

local font_callback = function()
 if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "customfont", "default") == "true" then
  ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "customfont", "false")
  font.setdefault()
 else
  ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "customfont", "true")
  local fontpath = ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "fontpath", "default")
  local fontpath = osk.init("Path to font", fontpath)
  ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "fontpath", fontpath)
  font.load(fontpath)
  font.setdefault(fontpath)
 end
end

local bg_callback = function()
 if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "custombg", "default") == "true" then
  ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "custombg", "false")
  bg = false
 else
  ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "custombg", "true")
  bgpath = ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "bgpath", "default")
  bgpath = osk.init("Path to background", bgpath)
  ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "bgpath", bgpath)
  bg = true
 end
end

local color_callback = function()

end

local update_callback = function()
 dofile("git/updater.lua")
end

menulst1 = {
{text="Show icons in app list", funct=iconset_callback},
{text="Use a custom font", funct=font_callback},
{text="Use a custom background", funct=bg_callback},
{text="Change highlight color", funct=color_callback},
{text="Check for updates", funct=update_callback},
{text="Back to main menu", funct=exit1_callback}
}

local scroll = newScroll(menulst1,#menulst1)
	buttons.interval(10,6)

while true do
if bg != true then
if back then back:blit(500,0) end
else
if back then back:blit(0,0) end
end
screen.print(10,10,"Rabbid MultiTool Lua") 
screen.print(10,30,"by Harommel Rabbid")
	local y = 70
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y-2,350,21, color.blue) 
if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "appicon", "default") == "true" and i == 1 then
 draw.fillrect(355,y-2,40,21, color.green) 
elseif ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "appicon", "default") == "false" and i == 1 then
 draw.fillrect(355,y-2,40,21, color.red) 
end
if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "customfont", "default") == "true" 
and i == 2 then
 draw.fillrect(355,y-2,40,21, color.green) 
elseif ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "customfont", "default") == "false" and i == 2 then
 draw.fillrect(355,y-2,40,21, color.red) 
end
if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "custombg", "default") == "true" and i == 3 then
 draw.fillrect(355,y-2,40,21, color.green) 
elseif ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "custombg", "default") == "false" and i == 3 then
 draw.fillrect(355,y-2,40,21, color.red) 
end
end
		screen.print(10,y, menulst1[i].text) 
		y+=20 
end

if batt.lifepercent() < 50 and batt.lifepercent() >= 20 then
screen.print(880,10,batt.lifepercent().."%",1,color.orange)
elseif batt.lifepercent() < 20 then
screen.print(880,10,batt.lifepercent().."%",1,color.red)
else
screen.print(880,10,batt.lifepercent().."%",1,color.green)
end

if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "appicon", "default") == "true" 
then
 screen.print(355,70,"Yes")
else
 screen.print(355,70,"No")
end

if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "customfont", "default") == "true" 
then
 screen.print(355,90,"Yes")
else
 screen.print(355,90,"No")
end

if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "custombg", "default") == "true" then
 screen.print(355,110,"Yes")
else
 screen.print(355,110,"No")
end

if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept then menulst1[scroll.sel].funct() end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.cancel then dofile("menus/menu.lua") end

end
