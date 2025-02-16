dofile("scripts/scroll.lua")
dofile("scripts/stars.lua")
color.loadpalette()
buttons.homepopup(0)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end

local appicon0 = image.load("ur0:appmeta/"..selgame.."/icon0.png")

local name_callback = function()
 local name = osk.init("Change Bubble Title", seltitle)
 if name != nil then
 if os.message("Are you sure you want to rename the selected bubble?", 1) == 1 then
 if os.stitledb(name, selgame) == 1 then
  restart_flag = true
  os.dialog("Success")
 else
  os.dialog("Failed")
 end
end
end
end

local launch_callback = function()
 if selgame == "RBMT78900" then
  os.message("You're already in Rabbid MultiTool")
 else
  game.launch(selgame)
 end
end

local remove_callback = function()
 if selgame == "RBMT78900" then
  os.message("You can't uninstall Rabbid MultiTool from here")
 else
 if os.message("Are you sure you want to uninstall "..seltitle.."?", 1) == 1 then
 game.delete(selgame)
 os.message("Successfully uninstalled.")
 dofile("menus/app.lua")
 end
 end
end

local mimg_callback = function()
 os.message("Place your custom image files, inside of a folder named after the \nID of your currently selected app in \n'ux0:data/Rabbid MultiTool/Game'")
 local files2 = "ux0:data/Rabbid MultiTool/Game/"..selgame
 local files3 = files.list("ux0:data/Rabbid MultiTool/Game/"..selgame.."/")
 if files.copy(files2, "ur0:appmeta/") == 1 then
 files.copy("ur0:appmeta/"..selgame, "ux0:data/Rabbid MultiTool/Backups/Apps/")
 for c=1, #files3 do
  files.copy(files3[c].path, "ux0:app/"..selgame.."/sce_sys")
 end
 if files.exists("ux0:data/Rabbid MultiTool/Game/"..selgame.."/icon0.png") == true then
 restart_flag = true
 end
 os.dialog("Files replaced successfully")
 else
 os.dialog("Failed. Check if you put your files correctly.")
 end
end

local exit1_callback = function()
 dofile("menus/app.lua")
end

menulst1 = {
{text="Launch app", funct=launch_callback},
{text="Change bubble & LiveArea images", funct=mimg_callback},
{text="Change bubble title", funct=name_callback},
{text="Uninstall app", funct=remove_callback},
{text="Back", funct=exit1_callback}
}

local scroll = newScroll(menulst1,#menulst1)
	buttons.interval(10,6)

while true do
screen.print(10,10,"Rabbid MultiTool Lua") 
screen.print(10,30,"by Harommel Rabbid")
screen.print(10,70,"Selected Game: "..selgame.."")
			screen.clip(832+64,0+64, 128/2)
draw.fillrect(832,0, 128, 128, color.white) 
if appicon0 then appicon0:blit(832,0) end
screen.clip()
	local y = 110
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y-2,350,21, color1) 
end
		screen.print(10,y, menulst1[i].text) 
		y+=20 
end

if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept then menulst1[scroll.sel].funct() end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.cancel then dofile("menus/app.lua") end

end
