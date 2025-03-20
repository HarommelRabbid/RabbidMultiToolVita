dofile("scripts/scroll.lua")
dofile("scripts/stars.lua")
dofile("scripts/filetools.lua")
color.loadpalette()
buttons.homepopup(1)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end
local currdir, selected = {}, {}
local i1 = 1
local contextmenu = false

menulst1 = files.list("ux0:")
local menulst = {
{text="Rename", funct=rename_file},
{text="Delete", funct=delete_file}
}

local scroll = newScroll(menulst1,8)
local scroll1 = newScroll(menulst,#menulst)
	buttons.interval(10,6)

while true do
if back then back:blit(0,0) end
draw.fillrect(0,0,960,70, color1:a(50))
screen.print(480, 15, "File Manager", 1, color.white, color.black, __ACENTER)
if currdir[#currdir] == nil then
screen.print(480, 35, "ux0:", 1, color.white, color.black, __ACENTER)
else
screen.print(480, 35, currdir[#currdir], 1, color.white, color.black, __ACENTER)
end
	local y = 75
	local x = 472.5
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y,950,50, color1) 
draw.fillrect(0,544-30,960,70, color1:a(50)) 
--screen.print(charfont, 485-screen.textwidth("Options", 1), 544-25, ",")
screen.print(480, 544-25, "Options", 1, color.white, color.black, __ACENTER)
else
draw.fillrect(5,y,950,50, color1:a(30)) 
end
if menulst1[i].directory then
		screen.print(10,y+15, menulst1[i].name.."/") 
		screen.print(480,y+15, menulst1[i].mtime) 
		screen.print(720,y+15, menulst1[i].ctime) 
else
		screen.print(10,y+15, menulst1[i].name) 
		screen.print(360,y+15, menulst1[i].size.." B") 
		screen.print(480,y+15, menulst1[i].mtime) 
		screen.print(720,y+15, menulst1[i].ctime) 
end
if inarray(menulst1[i].path, selected) then
if color1 != colpallete["white"] then
draw.fillrect(5,y,950,50, color.shine) 
else
draw.fillrect(5,y,950,50, color.shadow) 
end
end
		y+=55
end

local y1 = 85
if contextmenu then
 draw.gradrect(960-200, 70, 960, 544, color1:mix(color.white, 80, 20), color1, __VERTICAL)
 for i=scroll1.ini,scroll1.lim do 
  if i == scroll1.sel then 
   screen.print(960-180, y1, menulst[i].text, 1, color1)
  else
   screen.print(960-180, y1, menulst[i].text)
  end
  y1+=20
 end
end

showbattery()
if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept then 
if not contextmenu then
selected = {}
if menulst1[scroll.sel].directory then 
table.insert(currdir, i1, menulst1[scroll.sel].path)
i1 += 1
menulst1 = files.list(menulst1[scroll.sel].path) 
scroll:set(menulst1, 8) 
else
if menulst1[scroll.sel].ext == "sfo" then
sfopath = menulst1[scroll.sel].path
dofile("menus/misc/sfo.lua")
elseif inarray(menulst1[scroll.sel].ext, {"png", "jpg", "jpeg", "bmp"}) then
if back then back:blit(0,0) end
local fileimage = image.load(menulst1[scroll.sel].path)
if fileimage then fileimage:blit(480-(image.getw(fileimage)/2), 272-(image.geth(fileimage)/2)) end
screen.flip()
buttons.waitforkey(__CIRCLE)
elseif inarray(menulst1[scroll.sel].ext, {"mp3", "wav", "ogg"}) then
if back then back:blit(0,0) end
local soundfile = sound.load(menulst1[scroll.sel].path)
soundfile:play(1)
screen.print(10, 10, sound.getid3(menulst1[scroll.sel].path).title)
screen.print(10, 30, sound.getid3(menulst1[scroll.sel].path).album)
screen.print(10, 50, sound.getid3(menulst1[scroll.sel].path).artist)
if sound.getid3(menulst1[scroll.sel].path).cover then sound.getid3(menulst1[scroll.sel].path).cover:blit(960-image.getw(sound.getid3(menulst1[scroll.sel].path).cover)-10, 10) end
screen.flip()
buttons.waitforkey(__CIRCLE)
soundfile:stop()
elseif menulst1[scroll.sel].ext == "pbp" then
if os.message("Are you sure you want to extract the PBP?", 1) == 1 then
game.unpack(menulst1[scroll.sel].path, files.nofile(menulst1[scroll.sel].path))
menulst1 = files.list(files.nofile(menulst1[scroll.sel].path)) 
scroll:set(menulst1, 8) 
end
elseif menulst1[scroll.sel].ext == "mp4" then
playvideo(menulst1[scroll.sel].path, menulst1[scroll.sel].name)
end
end
else
if scroll1.sel == 1 then --Rename
local newname = osk.init("Rename "..menulst1[scroll.sel].name, menulst1[scroll.sel].name) or menulst1[scroll.sel].name
if newname != menulst1[scroll.sel].name then
if os.message("Are you sure you want to rename "..menulst1[scroll.sel].name.." to "..newname.."?", 1) == 1 then
files.rename(menulst1[scroll.sel].path, newname)
menulst1 = files.list(files.nofile(menulst1[scroll.sel].path)) 
scroll:set(menulst1, 8) 
contextmenu = false
end
end
elseif scroll1.sel == 2 then --Delete
if #selected <= 1 then
if os.message("Are you sure you want to delete "..menulst1[scroll.sel].name.."?", 1) == 1 then
if files.delete(menulst1[scroll.sel].path) == 0 then
os.dialog("Failed")
else
menulst1 = files.list(files.nofile(menulst1[scroll.sel].path)) 
scroll:set(menulst1, 8) 
contextmenu = false
end
end
else
if os.message("Are you sure you want to delete these files &/or folders?", 1) == 1 then
for i=1, #selected do
 files.delete(selected[i])
 i+=1
end
menulst1 = files.list(files.nofile(menulst1[scroll.sel].path)) 
scroll:set(menulst1, 8) 
contextmenu = false
end
end
end
end
end
if not contextmenu then
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
else
if buttons.down or buttons.analogly > 60 then scroll1:down() end
if buttons.up or buttons.analogly < -60 then scroll1:up() end 
end
if buttons.square and scroll.maxim > 0 and not contextmenu then 
if not inarray(menulst1[scroll.sel].path, selected) then
table.insert(selected, menulst1[scroll.sel].path)
else
removefirst(menulst1[scroll.sel].path, selected)
end
end
--[[local returntime = timer.new()
if buttons.cancel then returntime:start() if returntime:time() >= 1000 then videostate = false returntime:stop() returntime:reset() end end]]
if buttons.cancel then 
if not contextmenu then
selected = {}
if currdir[#currdir] != nil then 
menulst1 = files.list(files.nofile(currdir[#currdir])) 
table.remove(currdir, #currdir) 
i1 -= 1 
scroll:set(menulst1, 8)
else
dofile("menus/menu.lua")
end 
else
if contextmenu then
contextmenu = false
end 
end 
end 
if buttons.triangle then if not contextmenu then scroll1.sel = 1 contextmenu = true else contextmenu = false end end

end
