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
screen.print(480, 25, "PSN Account Info", 1, color.white, color.black, __ACENTER)
screen.print(10,75,"Nickname: "..tostring(os.nick())) 
screen.print(10,95,"PSN Email: "..tostring(os.login())) 
screen.print(10,115,"PSN Password: "..tostring(os.password())) 
screen.print(10,135,"PSN Region: "..tostring(os.psnregion())) 
screen.print(10,155,"PSN ID: "..tostring(os.account())) 
draw.fillrect(5,544-55,950,50, color1) 
screen.print(480, 544-40, "Back")
showbattery()
if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept or buttons.cancel then dofile("menus/account.lua") end

end
