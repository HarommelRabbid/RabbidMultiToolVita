dofile("scripts/scroll.lua")
dofile("scripts/stars.lua")
color.loadpalette()
buttons.homepopup(0)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end
menulst1 = {
"Red",
"Green",
"Blue",
"Cyan",
"Magenta",
"Yellow",
"Maroon",
"Grass",
"Navy",
"Turquoise",
"Violet",
"Olive",
"White",
"Gray",
"Black",
"Orange",
"Chocolate",
"Shine",
"Shadow"
}

local color0 = ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "color", "default")

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
draw.fillrect(5,y-2,350,21, colpallete[string.lower(menulst1[scroll.sel])]) 
end
		screen.print(10,y, menulst1[i]) 
		y+=20 
end

if batt.lifepercent() < 50 and batt.lifepercent() >= 20 then
screen.print(880,10,batt.lifepercent().."%",1,color.orange)
elseif batt.lifepercent() < 20 then
screen.print(880,10,batt.lifepercent().."%",1,color.red)
else
screen.print(880,10,batt.lifepercent().."%",1,color.green)
end

if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept then upd = true color1 = colpallete[string.lower(menulst1[scroll.sel])] ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "color", string.lower(menulst1[scroll.sel])) os.message("Color updated") end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.cancel then if upd != true then color1 = colpallete[color0] end dofile("menus/settings.lua") end

end
