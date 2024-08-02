--[[
 Script of Rabbid MultiTool by Harommel Rabbid
 OneLua by the OneLua Team
]]
dofile("scripts/msg.lua")
function import_media(path)
 local files1 = files.listfiles(path) 
 local media_count = 0
 if files1 and #files1 == 0 then
  os.dialog("Failed. Check your files again.")
 end
 for i=1, #files1 do 
 local filesres = files.export(files1[i].path) 
if filesres == 1 then
 media_count+=1
 message_wait("Imported Media:\n\n"..media_count.." files imported")
else
 message_wait("Imported Media:\n\nSkipping file...")
end
 if files1 and #files1 > 0 then
  files.delete(files1[i].path)
 end
end
end

function restore_db(path)
 if files.copy("ux0:data/Rabbid MultiTool/Backups/app.db",path) == 1 then
  os.dialog("Successfully restored app.db to the last backed up version")
  restart_flag = true
 else
  os.dialog("app.db not detected. You can back it up first")
 end
end
