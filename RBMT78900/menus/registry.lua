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

local avls_callback = function()
if os.getreg("/CONFIG/SOUND/", "avls", 1) != 0 then
 if os.setreg("/CONFIG/SOUND/", "avls", 0) == 0 then
  restart_flag = true os.message("AVLS disabled successfully")
 else
  os.message("Failed")
 end
else
 if os.message("AVLS is already disabled, do you wanna enable it again?", 1) == 1 then
 if os.setreg("/CONFIG/SOUND/", "avls", 1) == 0 then
  restart_flag = true os.message("AVLS enabled successfully")
 else
  os.message("Failed")
 end
end
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
{text="Disable Auto-AVLS", funct=avls_callback},
{text="Modify a registry key", funct=custom_callback},
{text="Back to main menu", funct=exit1_callback}
}

local scroll = newScroll(menulst1,#menulst1)
	buttons.interval(10,6)

while true do
screen.print(10,10,"Rabbid MultiTool Lua") 
screen.print(10,30,"by Harommel Rabbid")
		screen.print(355,70, os.getreg("/CONFIG/SECURITY/PARENTAL/", "passcode", 2)) 
		screen.print(355,90, os.getreg("/CONFIG/SECURITY/SCREEN_LOCK/", "passcode", 2))
	local y = 70
	for i=scroll.ini,scroll.lim do 
		if i == scroll.sel then 
draw.fillrect(5,y-2,350,21, color.blue:a(125)) 
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
if buttons.cancel then dofile("menus/menu.lua") end

end
