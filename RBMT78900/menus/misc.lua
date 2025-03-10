dofile("scripts/stars.lua")
dofile("scripts/scroll.lua")
color.loadpalette()
buttons.homepopup(0)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end

local font_callback = function()
 dofile("menus/misc/font.lua")
end

local sfo_callback = function()
 dofile("menus/misc/sfo.lua")
end

local ftp_callback = function()
 if ftp.init() == true then
  os.message("FTP is running at: "..wlan.getip()..":1337")
  ftp.term()
 else
  os.message("Error")
 end
end

local usb_callback = function()
 if os.requireusb() == 1 then
  usb.start(2)
  os.message("USB is running at SD2Vita")
  usb.stop()
 else
  os.message("Error")
 end
end

local menulst = {
{text="Font Previewer",funct=font_callback},
{text=".SFO Tools",funct=sfo_callback},
{text="Enable FTP",funct=ftp_callback},
{text="Enable USB",funct=usb_callback, desc="Enables USB on the SD2Vita"},
{text="Back to main menu",funct=exit1_callback}
}
scroll = newScroll(menulst, #menulst)
	buttons.interval(10,6)

while true do
if back then back:blit(0,0) end
draw.fillrect(0,0,960,70, color1:a(50))
screen.print(480, 25, "Miscellaneous Tools", 1, color.white, color.black, __ACENTER)
	local y = 75
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y,472.5,50, color1) 
draw.fillrect(0,544-30,960,70, color1:a(50)) 
screen.print(480, 544-25, menulst[i].desc or menulst[i].text, 1, color.white, color.black, __ACENTER)
end
        draw.fillrect(482.5,y,472.5,50, color1:a(30)) 
		if i == scroll.sel then 
		screen.print(161,y+15, menulst[i].text) 
else
        draw.fillrect(5,y,472.5,50, color1:a(30)) 
		screen.print(161,y+15, menulst[i].text) 
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
if buttons.accept then menulst[scroll.sel].funct() end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.cancel then dofile("menus/menu.lua") end

end
