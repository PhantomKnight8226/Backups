repeat wait() until game:IsLoaded() wait()
game:GetService("ScriptContext"):SetTimeout(3)
if hookmetamethod then
local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
    local Args = {...}
    local Self = Args[1]
    if getnamecallmethod() == "Kick" and self.Name == game.Players.LocalPlayer  then
            return nil
    end
    if getnamecallmethod() == "Kick" then
            return nil
    end
    return OldNameCall(self, ...)
end)
end 
if setfflag then
setfflag("HumanoidParallelRemoveNoPhysics", "False")
setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
end 
if setfpscap then
setfpscap(100)
end 
if getconnections then
for _,v in next, getconnections(game:GetService("LogService").MessageOut) do
    v:Disable()
end
for _,v in next, getconnections(game:GetService("ScriptContext").Error) do
    v:Disable()
end
for _,v in next, getconnections(game:GetService("Players").LocalPlayer.Idled) do
    v:Disable()
end
end
if hookfunction and gcinfo or collectgarbage then
hookfunction((gcinfo or collectgarbage), function(...)
     return math.random(200,350) 
end)
end 
if not getconnections then
game:GetService("Players").LocalPlayer.Idled:connect(function()
game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end) print("bad exploit") end 