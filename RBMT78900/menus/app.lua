dofile("scripts/stars.lua")
dofile("scripts/scroll.lua")
color.loadpalette()
buttons.homepopup(0)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end

menulst2 = game.list(__GAME_LIST_ALL)
local scroll = newScroll(menulst2,8)
	buttons.interval(10,6)

if ini.read("ux0:data/Rabbid MultiTool/config.ini", "settings", "appicon", "default") == "true" then
  iconshow = true
 else
  iconshow = false
end

while true do
if back then back:blit(0,0) end
draw.fillrect(0,0,960,70, color1:a(50))
screen.print(480, 25, "Apps", 1, color.white, color.black, __ACENTER)
draw.fillrect(0,544-30,960,70, color1:a(50)) 
screen.print(charfont, 960-screen.textwidth("010101 App Types", 1)-5, 544-25, "01")
screen.print(960-screen.textwidth(" App Types", 1)-5, 544-25, " App Types")
	local y = 75
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y,950,50, color1) 
--[[
			screen.clip(832+64,0+64, 128/2)
draw.fillrect(832,0, 128, 128, color.white) 
if appicon0 then appicon0:blit(832,0) end
screen.clip()
else]]
--end
end
        draw.fillrect(5,y,950,50, color1:a(30)) 
		screen.print(10,y+15, menulst2[i].title)
		screen.print(355,y+15, menulst2[i].id)
		screen.print(495,y+15, menulst2[i].type)
		screen.print(660,y+15, menulst2[i].path)
		y+=55
end

showbattery()
if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept then selgame = menulst2[scroll.sel].id seltitle = menulst2[scroll.sel].title selpath = menulst2[scroll.sel].path dofile("menus/app/app1.lua") end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.l then dofile("menus/appemu.lua") end
if buttons.r then dofile("menus/appsys.lua") end
if buttons.cancel then dofile("menus/menu.lua") end

end
