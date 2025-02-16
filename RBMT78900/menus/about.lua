dofile("scripts/stars.lua")
dofile("scripts/scroll.lua")
color.loadpalette()
buttons.homepopup(0)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end
	buttons.interval(10,6)
while true do
if bg != true then
if back then back:blit(500,0) end
else
if back then back:blit(0,0) end
end
screen.print(10,30,"by Harommel Rabbid")
screen.print(10,10,"Rabbid MultiTool Lua")
screen.print(10,70,"Rabbid MultiTool is a toolbox for the PS Vita with many features in.\nV0.11 OneLua\nDeveloped by Harommel OddSock")
draw.fillrect(5,150-2,350,21, color1) 
screen.print(10,150,"Back")
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
if buttons.accept or buttons.cancel then dofile("menus/menu.lua") end

end
