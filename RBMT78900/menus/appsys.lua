dofile("scripts/stars.lua")
dofile("scripts/scroll.lua")
color.loadpalette()
buttons.homepopup(0)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end

menulst2 = game.list(__GAME_LIST_SYS)
local scroll = newScroll(menulst2,23)
	buttons.interval(10,6)

while true do
screen.print(10,30,"by Harommel Rabbid")
screen.print(10,10,"Rabbid MultiTool Lua")
screen.print(805, 525, "L/R: App Types")
	local y = 70
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y-2,350,21, color.blue:a(125)) 
draw.fillrect(355,y-2,140,21, color.green:a(125)) 
draw.fillrect(495,y-2,40,21, color.red:a(125)) 
if iconshow == "true" then
local appicon0 = image.load("vs0:app/"..menulst2[i].id.."/sce_sys/icon0.png")
			screen.clip(832+64,0+64, 128/2)
			draw.fillrect(832,0, 128, 128, color.white) 
if appicon0 then appicon0:blit(832,0) end
screen.clip()
end
end
		screen.print(10,y, menulst2[i].title)
		screen.print(355,y, menulst2[i].id)
		screen.print(495,y, menulst2[i].type)
		y+=20 
end

if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.l then dofile("menus/app.lua") end
if buttons.r then dofile("menus/appemu.lua") end
if buttons.cancel then dofile("menus/menu.lua") end

end
