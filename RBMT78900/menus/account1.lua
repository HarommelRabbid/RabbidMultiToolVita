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
	buttons.interval(10,6)
while true do
screen.print(10,30,"by Harommel Rabbid")
screen.print(10,10,"Rabbid MultiTool Lua")
screen.print(10,70,"Nickname: "..tostring(os.nick())) 
screen.print(10,90,"PSN Email: "..tostring(os.login())) 
screen.print(10,110,"PSN Password: "..tostring(os.password())) 
screen.print(10,130,"PSN Region: "..tostring(os.psnregion())) 
screen.print(10,150,"PSN ID: "..tostring(os.account())) 
draw.fillrect(5,190-2,350,21, color.blue:a(125)) 
screen.print(10,190,"Back")
if back then back:blit(500,0) end
if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept or buttons.cancel then break end

end
