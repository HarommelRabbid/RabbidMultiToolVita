snow = false
if tonumber(os.date("%m")) == 12 or tonumber(os.date("%m")) == 1 or tonumber(os.date("%m")) == 2 then snow = true end
dofile("scripts/dbtool.lua")
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
-- Might have to look into OneLua Team's Account Manager for better func
menulst1 = files.list("ux0:data/Rabbid MultiTool/Backups/Account/")

local scroll = newScroll(menulst1,#menulst1)
	buttons.interval(10,6)

while true do
screen.print(10,10,"Rabbid MultiTool Lua") 
screen.print(10,30,"by Harommel Rabbid")
	local y = 70
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y-2,350,21, color.blue:a(125)) 
end
		screen.print(10,y, menulst1[i].name) 
		y+=20 
end

if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept then if os.message("Are you sure you want to restore your account?", 1) == 1 then if os.restoreaccount(menulst1[scroll.sel].path) == 1 then os.dialog("Successfully restored account") restart_flag = true else os.dialog("Failed") end end end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.cancel then dofile("script.lua") end

end