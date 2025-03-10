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
 if fntpath then fntpath = osk.init("Path to font", fntpath) else fntpath = osk.init("Path to font", "") end
end

local preview_callback = function()
 if fntpath == nil then
  os.message("No font loaded.")
 else
  fntpath1 = font.load(fntpath)
if back then back:blit(0,0) end
draw.fillrect(0,0,960,70, color1:a(50))
screen.print(480, 25, "Font Preview", 1, color.white, color.black, __ACENTER)
  screen.print(fntpath1,10, 75, "qwertyuiopasdfghjklzxcvbnm QWERTYUIOPASDFGHJKLZXCVBNM")
  screen.print(fntpath1,10, 95, "1234567890")
  screen.print(fntpath1,10, 115, ".-/:@!?#%()_,;*+=&<>[]{}")
draw.fillrect(5,544-55,950,50, color1) 
screen.print(480, 544-40, "Back")
  screen.flip()
  buttons.waitforkey(__CIRCLE or __CROSS)
 end
end

local exit2_callback = function()
 dofile("menus/misc.lua")
end

menulst1 = {
{text="Load font", funct=load_callback, desc="Load a font from given path"},
{text="Preview font", funct=preview_callback, desc="Preview the loaded font"},
{text="Back", funct=exit2_callback}
}

local scroll = newScroll(menulst1,#menulst1)
	buttons.interval(10,6)

while true do
if back then back:blit(0,0) end
draw.fillrect(0,0,960,70, color1:a(50))
screen.print(480, 25, "Font Previewer", 1, color.white, color.black, __ACENTER)
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
