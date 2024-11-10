dofile("scripts/scroll.lua")
dofile("scripts/stars.lua")
color.loadpalette()
buttons.homepopup(0)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end
if bg == true then
back = image.load(bgpath)
end

local load_callback = function()
 if sfopath then sfopath = osk.init("Path to the .SFO file", sfopath) else sfopath = osk.init("Path to the .SFO file", "") end
end

local view_callback = function()
if sfopath == nil then
 os.message("No file loaded.") 
else
sfofile = game.info(sfopath)
screen.print(10,10,"Rabbid MultiTool Lua") 
screen.print(10,30,"by Harommel Rabbid")
screen.print(10, 70, "TITLE: "..sfofile.TITLE)
screen.print(10, 70, "STITLE: "..sfofile.STITLE)
screen.flip()
buttons.waitforkey(__CIRCLE)
end
end

local edit_callback = function()
 if sfopath == nil then
  os.message("No file loaded.")
 else
  param = osk.init("Specify Parameter", "")
  newvalue = osk.init("Specify the new value", "")
  game.setsfo(sfopath, param, newvalue)
end
end

local exit2_callback = function()
 dofile("menus/misc.lua")
end

menulst1 = {
{text="Load .SFO", funct=load_callback},
{text="View .SFO", funct=view_callback},
{text="Edit .SFO", funct=edit_callback},
{text="Back", funct=exit2_callback}
}

local scroll = newScroll(menulst1,#menulst1)
	buttons.interval(10,6)

while true do
if back then back:blit(0,0) end
screen.print(10,10,"Rabbid MultiTool Lua") 
screen.print(10,30,"by Harommel Rabbid")
	local y = 70
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y-2,350,21, color.blue) 
end
		screen.print(10,y, menulst1[i].text) 
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
if buttons.accept then menulst1[scroll.sel].funct() end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.cancel then dofile("menus/misc.lua") end

end
