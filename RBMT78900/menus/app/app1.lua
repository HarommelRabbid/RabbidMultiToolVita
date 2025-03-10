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
 if os.message("Are you sure you want to rename "..seltitle.."?", 1) == 1 then
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
 if os.message("Place your custom image files, inside of a folder named after the \nID of your currently selected app in \n'ux0:data/Rabbid MultiTool/Game'", 1) == 1 then
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
end

local exit1_callback = function()
 dofile("menus/app.lua")
end

menulst1 = {
{text="Launch app", funct=launch_callback},
{text="Change bubble & LiveArea images", funct=mimg_callback, desc="Changes bubble and/or LiveArea images of an app to your own custom images."},
{text="Change bubble title", funct=name_callback, desc="Changes the STITLE parameter only, as changing TITLE will require a database update."},
{text="Uninstall app", funct=remove_callback},
{text="Back", funct=exit1_callback}
}

local scroll = newScroll(menulst1,#menulst1)
	buttons.interval(10,6)

while true do
if back then back:blit(0,0) end
draw.fillrect(0,0,960,70, color1:a(50))
screen.print(480, 25, seltitle.." - "..selgame, 1, color.white, color.black, __ACENTER)
			screen.clip(832-5+64,75+64, 128/2)
draw.fillrect(832-5,75, 128, 128, color.white) 
if appicon0 then appicon0:blit(832-5,75) end
screen.clip()
	local y = 75
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y,472.5,50, color1) 
draw.fillrect(0,544-30,960,70, color1:a(50)) 
screen.print(480, 544-25, menulst1[i].desc or menulst1[i].text, 1, color.white, color.black, __ACENTER)
end
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
if buttons.cancel then dofile("menus/app.lua") end

end
