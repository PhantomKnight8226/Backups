local HttpGet;
HttpGet = hookfunction(game.HttpGet, function(g,l,...)
    if l:find("ObfuscationHTTP") then
        return HttpGet(g, "https://raw.githubusercontent.com/HyperNIt3/Backups/main/ReaperHubCracked/ObfuscationHTTP.lua")
    end
    return HttpGet(g,l,...)
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/HyperNIt3/Backups/main/ReaperHubCracked/Bypass.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/HyperNIt3/Backups/main/ReaperHubCracked/File.lua"))()