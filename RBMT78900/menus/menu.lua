dofile("scripts/stars.lua")
dofile("scripts/scroll.lua")
dofile("scripts/tai.lua")
color.loadpalette()
buttons.homepopup(0)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end
if bg != true then
back = image.load("imgs/pic0.png")
else
back = image.load(bgpath)
end

tai.load()

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
local repatch_callback = function()
 dofile("menus/repatch.lua")
end
local tai_callback = function()
 dofile("menus/tai.lua")
end
local file_callback = function()
 dofile("menus/file.lua")
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
{text="Database Tools",funct=db_callback, desc="Settings related to the system's database"},
{text="App Tools",funct=app_callback, desc="Manage your apps"},
{text="Account Tools",funct=acc_callback, desc="Manage, switch & delete your PSN account(s)"},
{text="Registry Tools",funct=reg_callback, desc="Manage your system's registry"},
{text="Misc. Tools",funct=misc_callback, desc="Miscellaneous tools"},
{text="rePatch Tools",funct=repatch_callback, desc="Manage rePatch game patches"},
{text="taiHEN Tools",funct=tai_callback, desc="Manage taiHEN plugins"},
{text="File Manager",funct=file_callback, desc="Manage files"},
{text="Settings",funct=settings_callback, desc="Configure Rabbid MultiTool to your likings"},
{text="About", funct=credits_callback, desc="See your system's information as well as the developers of Rabbid MultiTool"},
{text="Exit",funct=exit_callback, desc="Exit to the LiveArea"}
}
if not tai.find("KERNEL", "ur0:tai/repatch.skprx") then
table.remove(menulst, 6)
end
scroll = newScroll(menulst, 16)
	buttons.interval(10,6)

while true do
if back then back:blit(0,0) end
draw.fillrect(0,0,960,70, color1:a(50)) 
screen.print(480, 25, "Welcome to Rabbid MultiTool!", 1, color.white, color.black, __ACENTER)
	local y = 75
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
if scroll.sel > 8 then
draw.fillrect(482.5,y,472.5,50, color1) 
else
draw.fillrect(5,y,472.5,50, color1) 
end
draw.fillrect(0,544-30,960,70, color1:a(50)) 
screen.print(480, 544-25, menulst[i].desc or menulst[i].text, 1, color.white, color.black, __ACENTER)
end
		if i != scroll.sel and scroll.sel < 9 and i<9 then 
        draw.fillrect(5,y,472.5,50, color1:a(30)) 
        draw.fillrect(482.5,y,472.5,50, color1:a(30)) 
end
		if i != scroll.sel and scroll.sel > 8 and i<9 then 
        draw.fillrect(482.5,y,472.5,50, color1:a(30)) 
        draw.fillrect(5,y,472.5,50, color1:a(30)) 
end
		if i == scroll.sel and scroll.sel < 9 and i<9 then 
        draw.fillrect(482.5,y,472.5,50, color1:a(30)) 
end
if i>8 then
		screen.print(161*4,y+15, menulst[i].text) 
else
		screen.print(161,y+15, menulst[i].text) 
end
if i==8 then
		y=75-55 --simple fix for now
end
		y+=55
end

showbattery()
if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept then menulst[scroll.sel].funct() end
if buttons.cancel then scroll.sel = #menulst end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.right or buttons.analoglx > 60 then if scroll.sel+8 <= #menulst then scroll.sel +=8 else if scroll.sel <= 8 then scroll.sel = #menulst end end end
if buttons.left and scroll.sel-8 >= 1 or buttons.analoglx < -60 and scroll.sel-8 >= 1 then scroll.sel -=8 end
if buttons.up or buttons.analogly < -60 then scroll:up() end 

end
