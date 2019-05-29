--[[ 
creaturescript.xml

<event type="login" name="Anti-Magebomb" script="mctfs1.lua"/>

ATTENTION! This script works in TFS 1.1 and 1.2 to TFS 1.0 change functions:
Code:
onLogin(player) --> onLogin(cid)
player:getIp() --> Player(cid):getIp()

]]--

local AccPorIp = 2

function onLogin(player) 

    local mc = 0
    for _, verificar in ipairs(Game.getPlayers()) do
        if player:getIp() == verificar:getIp() then
            mc = mc + 1
			if mc > AccPorIp then 
			return 
			false 
			end
        end
    end
 
    return true
end


