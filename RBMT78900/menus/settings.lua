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

menulst1 = {
{text="Show icons in app list", funct=iconset_callback},
{text="Back to main menu", funct=exit1_callback}
}

local scroll = newScroll(menulst1,#menulst1)
	buttons.interval(10,6)

while true do
screen.print(10,10,"Rabbid MultiTool Lua") 
screen.print(10,30,"by Harommel Rabbid")
if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "appicon", "default") == "true" then
 screen.print(355,70,"Yes")
else
 screen.print(355,70,"No")
end
 screen.print()
	local y = 70
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y-2,350,21, color.blue:a(125)) 
end
		screen.print(10,y, menulst1[i].text) 
		y+=20 
end

if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept then menulst1[scroll.sel].funct() end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.cancel then dofile("menus/menu.lua") end

end
