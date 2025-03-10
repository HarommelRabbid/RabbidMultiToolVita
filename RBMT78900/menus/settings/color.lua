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

local scroll = newScroll(menulst1,8)
	buttons.interval(10,6)

while true do
if back then back:blit(0,0) end
draw.fillrect(0,0,960,70, color1:a(50))
screen.print(480, 25, "Pick Highlight Color", 1, color.white, color.black, __ACENTER)
	local y = 75
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(0,544-30,960,70, colpallete[string.lower(menulst1[scroll.sel])]:a(50))
screen.print(480, 544-25, menulst1[scroll.sel], 1, color.white, color.black, __ACENTER)
draw.fillrect(5,y,950,50, colpallete[string.lower(menulst1[scroll.sel])]) 
end
draw.fillrect(5,y,950,50, colpallete[string.lower(menulst1[i])]:a(30)) 
if colpallete[string.lower(menulst1[i])] == color1 then
screen.print(480, y+15, menulst1[i], 1, color.gray, color.black:a(0), __ACENTER)
else
screen.print(480, y+15, menulst1[i], 1, color.white, color.black:a(0), __ACENTER)
end
		y+=55
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
if buttons.accept then if colpallete[string.lower(menulst1[scroll.sel])] != color1 then upd = true color1 = colpallete[string.lower(menulst1[scroll.sel])] ini.write("ux0:data/Rabbid MultiTool/config.ini", "settings", "color", string.lower(menulst1[scroll.sel])) os.message("Color updated") dofile("menus/settings.lua") end end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.cancel then if upd != true then color1 = colpallete[color0] end dofile("menus/settings.lua") end

end
