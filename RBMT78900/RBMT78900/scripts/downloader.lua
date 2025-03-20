--File downloader functions for Rabbid MultiTool
function download(url)
function onNetGetFile(size, written, speed, step)
if back then back:blit(0, 0) end
screen.print(10,10,"Total file size: "..size.." B")
screen.print(10,30,"Downloaded size: "..written.." B")
screen.print(10,50,"Download speed: "..speed.." KB/sec")
screen.print(10,70,math.floor((written*100)/size).."% downloaded")
downloadwidth = (written*950)/size
draw.fillrect(5,544-55,downloadwidth,50, color1) 
screen.flip()
end
if not http.getfile(url, "ux0:/data/Rabbid MultiTool/Downloads/") then
 os.message("File couldn't be downloaded. Check the URL.")
else
 os.delay(1000)
end
--os.downloader(url:gsub("https","http"),os.VIDEO,"Rabbid MultiTool downloader")
end
