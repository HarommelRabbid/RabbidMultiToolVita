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

local db_callback = function()
 dofile("menus/db.lua")
end
local app_callback = function()
 dofile("menus/app.lua")
end
local acc_callback = function()
 dofile("menus/account.lua")
end
local reg_callback = function()
 dofile("menus/registry.lua")
end
local misc_callback = function()
 dofile("menus/misc.lua")
end
local settings_callback = function()
 dofile("menus/settings.lua")
end
local credits_callback = function()
 dofile("menus/about.lua")
end
local exit_callback = function()
 if restart_flag == true then 
  if os.dialog("Your system has to restart in order for the changes you made to take effect. Do you want to do it now?","Confirmation",__DIALOG_MODE_OK_CANCEL) == true then
  power.restart() 
 end
 else
  os.exit()
 end
end

local menulst = {
{text="Database Tools",funct=db_callback},
{text="App Tools",funct=app_callback},
{text="Account Tools",funct=acc_callback},
{text="Registry Tools",funct=reg_callback},
{text="Misc Tools",funct=misc_callback},
{text="Settings",funct=settings_callback},
{text="About", funct=credits_callback},
{text="Exit",funct=exit_callback}
}
scroll = newScroll(menulst, #menulst)
	buttons.interval(10,6)

while true do
if bg == true then
if back then back:blit(0,0) end
else
if back then back:blit(500,0) end
end
screen.print(10,10,"Rabbid MultiTool Lua")
screen.print(10,30,"by Harommel Rabbid")
	local y = 70
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y-2,350,21, color.blue) 
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

end
