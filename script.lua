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
back = image.load("imgs/raving-rabbids-tv-lapin-cretin.png")

local db_callback = function()
 dofile("menus/db.lua")
end
local app_callback = function()
 dofile("menus/app.lua")
end
local acc_callback = function()
 dofile("menus/account.lua")
end
local credits_callback = function()
 dofile("menus/about.lua")
end
local exit_callback = function()
 if restart_flag == true then 
  os.dialog("Your system will now restart.")
  power.restart() 
 else
  os.exit()
 end
end

local menulst = {
{text="Database Tools",funct=db_callback},
{text="App Tools",funct=app_callback},
{text="Account Tools",funct=acc_callback},
{text="About", funct=credits_callback},
{text="Exit",funct=exit_callback}
}
scroll = newScroll(menulst, #menulst)
	buttons.interval(10,6)
while true do
screen.print(10,30,"by Harommel Rabbid")
screen.print(10,10,"Rabbid MultiTool Lua")
if back then back:blit(500,0) end
	local y = 70
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y-2,350,21, color.blue:a(125)) 
end
		screen.print(10,y, menulst[i].text) 
		y+=20 
end

if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept then menulst[scroll.sel].funct() end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 

end
