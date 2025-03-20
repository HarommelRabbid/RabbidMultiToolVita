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
  back = image.load("imgs/pic0.png")
 else
  ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "custombg", "true")
  bgpath = ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "bgpath", "default")
  bgpath = osk.init("Path to background", bgpath)
  ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "bgpath", bgpath)
  bg = true
  back = image.load(bgpath)
 end
end

local color_callback = function()
 color1 = colpallete[ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "color", "default")]
 dofile("menus/settings/color.lua")
end

local snow_callback = function()
 if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "snow", "default") == "true" then
  snow = true ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "snow", "auto")
 elseif ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "snow", "default") == "auto" then
  if tonumber(os.date("%m")) == 12 or tonumber(os.date("%m")) == 1 or tonumber(os.date("%m")) == 2 then 
  snow = true
  else snow = false
  end
  ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "snow", "false")
  elseif ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "snow", "default") == "false" then
  snow = false ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "snow", "true")
  end
end

local lang_callback = function()
 
end

local update_callback = function()
 dofile("git/updater.lua")
end

menulst1 = {
{text="Show icons in app list", funct=iconset_callback},
{text="Use a custom font", funct=font_callback},
{text="Use a custom background", funct=bg_callback},
{text="Change highlight color", funct=color_callback},
{text="Language", funct=lang_callback, desc="Coming soon"},
{text="Check for updates", funct=update_callback},
{text="Back to main menu", funct=exit1_callback}
}

local scroll = newScroll(menulst1,#menulst1)
	buttons.interval(10,6)

while true do
if back then back:blit(0,0) end
draw.fillrect(0,0,960,70, color1:a(50))
screen.print(480, 25, "Rabbid MultiTool Settings", 1, color.white, color.black, __ACENTER)
	local y = 75
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y,472.5,50, color1) 
draw.fillrect(0,544-30,960,70, color1:a(50)) 
screen.print(480, 544-25, menulst1[i].desc or menulst1[i].text, 1, color.white, color.black, __ACENTER)
end
        draw.fillrect(482.5,y,472.5,50, color1:a(30)) 
		if i == scroll.sel then 
		screen.print(161,y+15, menulst1[i].text) 
else
        draw.fillrect(5,y,472.5,50, color1:a(30)) 
		screen.print(161,y+15, menulst1[i].text) 
end
		y+=55
end

showbattery()

if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "appicon", "default") == "true" 
then
        draw.fillrect(482.5,75,472.5,50, color.green) 
 screen.print(161*4,75+15,"Yes")
else
        draw.fillrect(482.5,75,472.5,50, color.red) 
 screen.print(161*4,75+15,"No")
end

if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "customfont", "default") == "true" 
then
        draw.fillrect(482.5,75+55,472.5,50, color.green) 
 screen.print(161*4,75+55+15,"Yes")
else
        draw.fillrect(482.5,75+55,472.5,50, color.red) 
 screen.print(161*4,75+55+15,"No")
end

if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "custombg", "default") == "true" then
        draw.fillrect(482.5,75+55*2,472.5,50, color.green) 
 screen.print(161*4,75+55*2+15,"Yes")
else
        draw.fillrect(482.5,75+55*2,472.5,50, color.red) 
 screen.print(161*4,75+55*2+15,"No")
end

if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept then menulst1[scroll.sel].funct() end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.cancel then dofile("menus/menu.lua") end

end
