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
if back then back:blit(0,0) end
draw.fillrect(0,0,960,70, color1:a(50))
screen.print(480, 25, "About Rabbid MultiTool", 1, color.white, color.black, __ACENTER)
screen.print(10,75,"Rabbid MultiTool is a toolbox for the PS Vita with many features in.\nV0.12pre OneLua\nDeveloped by Harommel OddSock")
draw.fillrect(5,544-55,950,50, color1) 
screen.print(480, 544-40, "Back")
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
