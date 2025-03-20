dofile("scripts/scroll.lua")
dofile("scripts/stars.lua")
color.loadpalette()
buttons.homepopup(0)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end
psn = ((os.login() or "")/"@")[1]
menulst1 = files.list("ux0:data/Rabbid MultiTool/Backups/Account/")

local scroll = newScroll(menulst1,8)
	buttons.interval(10,6)

while true do
if back then back:blit(0,0) end
draw.fillrect(0,0,960,70, color1:a(50))
screen.print(480, 25, "Switch Account", 1, color.white, color.black, __ACENTER)
	local y = 75
	local x = 472.5
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y,950,50, color1) 
else
draw.fillrect(5,y,950,50, color1:a(30)) 
end
		screen.print(480,y+15, menulst1[i].name, 1, color.white, color.black:a(0), __ACENTER) 
		y+=55
end

showbattery()
if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept then if os.message("Are you sure you want to restore your account?", 1) == 1 then if os.restoreaccount(menulst1[scroll.sel].path) == 1 then os.dialog("Successfully restored account") restart_flag = true else os.dialog("Failed") end end end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.cancel then dofile("menus/account.lua") end

end
