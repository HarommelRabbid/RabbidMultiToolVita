--Original script from AutoPlugin II, modified for Rabbid MultiTool.
function message_wait(message,noflip)
	local mge = (message or "Please wait...")
	local titlew = string.format(mge)
	local w,h = screen.textwidth(titlew,1) + 30,80
	local x,y = 480 - (w/2), 272 - (h/2)

	draw.fillrect(x,y,w,h, color1)
	draw.rect(x,y,w,h,color.white)
		screen.print(480,y+15, titlew,1,color.white,color.black:a(0),__ACENTER)
		
	if not noflip then
		screen.flip()
	end

end
