dofile("scripts/scroll.lua")
dofile("scripts/stars.lua")
color.loadpalette()
buttons.homepopup(0)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end

local load_callback = function()
 if sfopath then sfopath = osk.init("Path to the .SFO file", sfopath) else sfopath = osk.init("Path to the .SFO file", "") end
end

local view_callback = function()
local y1 = 75
if sfopath == nil then
 os.message("No file loaded.") 
else
sfofile = game.info(sfopath)
if back then back:blit(0,0) end
draw.fillrect(0,0,960,70, color1:a(50))
screen.print(480, 25, ".SFO Viewer", 1, color.white, color.black, __ACENTER)
for k,v in pairs(sfofile) do
screen.print(10, y1, tostring(k)..": "..v)
y1+=20
end
draw.fillrect(5,544-55,950,50, color1) 
screen.print(480, 544-40, "Back")
screen.flip()
buttons.waitforkey(__CIRCLE or __CROSS)
end
end

local edit_callback = function()
 if sfopath == nil then
  os.message("No file loaded.")
 else
  param = osk.init("Specify Parameter", "")
  if param != nil then
  newvalue = osk.init("Specify the new value", "")
  if newvalue != nil then
  game.setsfo(sfopath, param, newvalue)
  end
  end
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
draw.fillrect(0,0,960,70, color1:a(50))
screen.print(480, 25, ".SFO Tools", 1, color.white, color.black, __ACENTER)
	local y = 75
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y,472.5,50, color1) 
draw.fillrect(0,544-30,960,70, color1:a(50)) 
screen.print(480, 544-25, menulst1[i].desc or menulst1[i].text, 1, color.white, color.black, __ACENTER)
end
draw.fillrect(482.5,y,472.5,50, color1:a(30)) 
		if i == scroll.sel then 
		screen.print(161,y+15, menulst1[i].text) 
else
        draw.fillrect(5,y,472.5,50, color1:a(30)) 
		screen.print(161,y+15, menulst1[i].text) 
end
		y+=55
end

showbattery()
if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept then menulst1[scroll.sel].funct() end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.cancel then dofile("menus/misc.lua") end

end
