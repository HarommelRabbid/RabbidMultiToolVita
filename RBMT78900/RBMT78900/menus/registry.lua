dofile("scripts/scroll.lua")
dofile("scripts/stars.lua")
color.loadpalette()
buttons.homepopup(0)
SYMBOL_SQUARE	= string.char(0xe2)..string.char(0x96)..string.char(0xa1)
SYMBOL_TRIANGLE = string.char(0xe2)..string.char(0x96)..string.char(0xb3)
SYMBOL_CROSS	= string.char(0xe2)..string.char(0x95)..string.char(0xb3)
SYMBOL_CIRCLE	= string.char(0xe2)..string.char(0x97)..string.char(0x8b)
if os.access() == 0 then os.message("Unsafe mode is required for this homebrew") os.exit() end

local parental_callback = function()
if os.getreg("/CONFIG/SECURITY/PARENTAL/", "passcode", 2) != "" then
 if os.setreg("/CONFIG/SECURITY/PARENTAL/", "passcode", "") == 0 then
  os.message("Reset successfully")
 else
  os.message("Failed")
 end
else
 os.message("Passcode is already reset")
end
end

local lock_callback = function()
if os.getreg("/CONFIG/SECURITY/SCREEN_LOCK/", "passcode", 2) != "" then
 if os.setreg("/CONFIG/SECURITY/SCREEN_LOCK/", "passcode", "") == 0 then
  os.message("Reset successfully")
 else
  os.message("Failed")
 end
else
 os.message("Passcode is already reset")
end
end

local custom_callback = function()
 reg = osk.init("Registry path", "/CONFIG/")
 regkey = osk.init("Registry key", "")
 regkey1 = os.getreg(reg,regkey,1)
 if string.find(regkey1, ": Error") then
  regkey1 = os.getreg(reg,regkey,2)
 num = false
 else
  num = true
 end
 if num == false then
  regval = osk.init("Registry value", regkey1)
 else
  regval = osk.init("Registry value", regkey1, 1, __OSK_TYPE_NUMBER)
 end
 if os.setreg(reg, regkey, regval) == 0 then
  os.message("Successfully modified")
 else
  os.message("Failed")
 end
end

menulst1 = {
{text="Reset parental passcode", funct=parental_callback},
{text="Reset screen lock passcode", funct=lock_callback},
{text="Modify any registry key", funct=custom_callback},
{text="Back to main menu", funct=exit1_callback}
}

local scroll = newScroll(menulst1,#menulst1)
	buttons.interval(10,6)

while true do
if back then back:blit(0,0) end
draw.fillrect(0,0,960,70, color1:a(50))
screen.print(480, 25, "Registry Tools", 1, color.white, color.black, __ACENTER)
	local y = 75
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y,472.5,50, color1) 
draw.fillrect(0,544-30,960,70, color1:a(50)) 
screen.print(480, 544-25, menulst1[i].desc or menulst1[i].text, 1, color.white, color.black, __ACENTER)
end
        draw.fillrect(482.5,y,472.5,50, color1:a(30)) 
		if i == scroll.sel then 
		screen.print(161,y+15, menulst1[i].text) 
else
        draw.fillrect(5,y,472.5,50, color1:a(30)) 
		screen.print(161,y+15, menulst1[i].text) 
end
		y+=55
end

screen.print(161*4,75+15, os.getreg("/CONFIG/SECURITY/PARENTAL/", "passcode", 2)) 
screen.print(161*4,75+55+15, os.getreg("/CONFIG/SECURITY/SCREEN_LOCK/", "passcode", 2))

showbattery()
if snow == true then stars.render() end
screen.flip()

buttons.read()
if buttons.accept then menulst1[scroll.sel].funct() end
if buttons.down or buttons.analogly > 60 then scroll:down() end
if buttons.up or buttons.analogly < -60 then scroll:up() end 
if buttons.cancel then dofile("menus/menu.lua") end

end
