dofile("scripts/dbtool.lua")
dofile("scripts/scroll.lua")
dofile("scripts/stars.lua")
color.loadpalette()
buttons.homepopup(0)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end

local backupdb_callback = function()
files.copy("ur0:shell/db/app.db", "ux0:data/Rabbid MultiTool/Backups") 
files.copy("ux0:/iconlayout.ini", "ux0:data/Rabbid MultiTool/Backups") 
os.dialog("Successfully backed up to 'ux0:data/Rabbid MultiTool/Backups'")
end

local importmedia_callback = function()
os.message("Place your media in 'ux0/data/Rabbid MultiTool/Media'") import_media("ux0:data/Rabbid MultiTool/Media") if none == false then os.delay(1000) end
end

local updatedb_callback = function()
if os.dialog("DISCLAIMER: After the process is complete, you'll have to reimport your custom themes using a custom theme manager. \nThis is not the case if you only have official themes","Update database",__DIALOG_MODE_OK_CANCEL) == true then os.updatedb() restart_flag = true os.dialog("Database updated successfully")
end
end

local restoredb_callback = function()
restore_db("ur0:shell/db")
end

local rebuilddb_callback = function()
if os.dialog("DISCLAIMER: After the process is complete, your bubble layout will be lost.","Confirmation",__DIALOG_MODE_OK_CANCEL) == true then os.rebuilddb() restart_flag = true os.dialog("Database rebuilded successfully") end
end

menulst1 = {
{text="Back up icon layout", funct=backupdb_callback},
{text="Restore backed up icon layout", funct=restoredb_callback},
{text="Import Media", funct=importmedia_callback},
{text="Update database", funct=updatedb_callback},
{text="Rebuild database", funct=rebuilddb_callback},
{text="Back to main menu", funct=exit1_callback}
}

local scroll = newScroll(menulst1,#menulst1)
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
if buttons.cancel then dofile("menus/menu.lua") end

end
