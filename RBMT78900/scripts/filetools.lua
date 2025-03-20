--[[
For Rabbid MultiTool's file manager
by Harommel OddSock
]]

function inarray(value, table) --Checks if an item is in an array
 for i, v in ipairs(table) do
  if v == value then
   return true
  end
 end
 return false
end

function removefirst(value, table1) --Removes the first instance of an item in an array
 for i, v in ipairs(table1) do
  if v == value then
   return table.remove(table1, i)
  end
 end
end

function playvideo(path, title)
 if video.init(path) == 1 then
  local stats = true
  local statstime = timer.new()
   --buttons.read()
  while video.actived() do
   buttons.read()
   touch.read()
   if buttons.square then stats = true if video.playing() then video.pause() else video.play() end end
   if buttons.l then stats = true statstime:reset() video.jump(-10) end
   if buttons.r then stats = true statstime:reset() video.jump(10) end
   if buttons.left then stats = true statstime:reset() video.jump(-5) end
   if buttons.right then stats = true statstime:reset() video.jump(5) end
   if buttons.cancel then video.stop() videostate = false end
   if buttons.accept or touch.front[1].pressed then if not stats then stats = true else stats = false statstime:stop() statstime:reset() end end
   if buttons.triangle then stats = true statstime:reset() if video.looping() then video.looping(0) else video.looping(1) end end
  if buttons.held.cross or touch.front[1].held then statstime:reset() end
  video.render(0,0,960,544)
  if stats then
   statstime:start()
   draw.fillrect(0,0,960,70, color1:a(50)) 
   if video.looping() then
   screen.print(480, 25, title.." on loop" or "Video Player on loop", 1, color.white, color.black, __ACENTER)
   else
   screen.print(480, 25, title or "Video Player", 1, color.white, color.black, __ACENTER)
   end
   draw.fillrect(5,544-55,950,50, color1:a(50)) 
   draw.fillrect(5,544-55,math.map(video.percent(), 0, 100, 0, 950),50, color1) 
   screen.print(480, 544-40, tostring(video.time()).."/"..tostring(video.totaltime()), 1, color.white, color.black:a(0), __ACENTER)
   if statstime:time() >= 2500 then
    statstime:stop()
    statstime:reset()
    stats = false
   end
  end
  screen.flip()
  end
 video.term()
   buttons.read()
 end
end
