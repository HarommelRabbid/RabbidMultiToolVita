dofile("scripts/stars.lua")
dofile("scripts/scroll.lua")
color.loadpalette()
buttons.homepopup(0)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end
if bg != true then
back = image.load("imgs/raving-rabbids-tv-lapin-cretin.png")
else
back = image.load(bgpath)
end

local font_callback = function()
 dofile("menus/misc/font.lua")
end

local sfo_callback = function()
 dofile("menus/misc/sfo.lua")
end

local ftp_callback = function()
 if ftp.init() == true then
  os.message("FTP is running at: "..wlan.getip())
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
{text="SFO Tools",funct=sfo_callback},
{text="Enable FTP",funct=ftp_callback},
{text="Enable USB",funct=usb_callback},
{text="Back to main menu",funct=exit1_callback}
}
scroll = newScroll(menulst, #menulst)
	buttons.interval(10,6)

while true do
if bg != true then
if back then back:blit(500,0) end
else
if back then back:blit(0,0) end
end
screen.print(10,10,"Rabbid MultiTool Lua")
screen.print(10,30,"by Harommel Rabbid")
	local y = 70
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y-2,350,21, color1) 
end
		screen.print(10,y, menulst[i].text) 
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
if buttons.accept then menulst[scroll.sel].funct() end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.cancel then dofile("menus/menu.lua") end

end
