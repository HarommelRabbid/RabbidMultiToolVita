snow = false
if tonumber(os.date("%m")) == 12 or tonumber(os.date("%m")) == 1 or tonumber(os.date("%m")) == 2 then snow = true end
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
local scroll = newScroll(menulst2,23)
	buttons.interval(10,6)

while true do
screen.print(10,30,"by Harommel Rabbid")
screen.print(10,10,"Rabbid MultiTool Lua")
screen.print(730, 525, "SELECT: System Apps")
	local y = 70
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y-2,350,21, color.blue:a(125)) 
draw.fillrect(355,y-2,140,21, color.green:a(125)) 
draw.fillrect(495,y-2,40,21, color.red:a(125)) 
draw.fillrect(832,0, 128, 128, color.white) 
local appicon0 = image.load("ur0:appmeta/"..menulst2[i].id.."/icon0.png")
if appicon0 then appicon0:blit(832,0) end
end
		screen.print(10,y, menulst2[i].title)
		screen.print(355,y, menulst2[i].id)
		screen.print(495,y, menulst2[i].type)
		y+=20 
end

if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept then selgame = menulst2[scroll.sel].id seltitle = menulst2[scroll.sel].title selpath = menulst2[scroll.sel].path dofile("menus/app1.lua") end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.select then dofile("menus/appsys.lua") end
if buttons.cancel then dofile("script.lua") end

end
