--[[
 Script of Rabbid MultiTool by Harommel Rabbid
]]
dofile("scripts/msg.lua")
function import_media(path)
 local files1 = files.listfiles(path) 
 local media_count = 0
 if files1 and #files1 == 0 then
  none = true
  os.dialog("Failed. Check your files again.")
 else
  none = false
 end
 for i=1, #files1 do 
 local filesres = files.export(files1[i].path) 
if filesres == 1 then
 media_count+=1
 if media_count == 1 then
 if bg == true then back:blit(0,0) end 
 message_wait("Imported Media:\n\n"..media_count.." file imported")
 else
 if bg == true then back:blit(0,0) end 
 message_wait("Imported Media:\n\n"..media_count.." files imported")
 end
else
 if bg == true then back:blit(0,0) end 
 message_wait("Imported Media:\n\nSkipping file...")
end
 if files1 and #files1 > 0 then
  files.delete(files1[i].path)
 end
end
end

function restore_db(path)
 if files.copy("ux0:data/Rabbid MultiTool/Backups/app.db", path) and files.copy("ux0:data/Rabbid MultiTool/Backups/iconlayout.ini", path) == 1 then
  os.dialog("Successfully restored app.db to the last backed up version")
  restart_flag = true
 else
  os.dialog("app.db not detected. You can back it up first")
 end
end
