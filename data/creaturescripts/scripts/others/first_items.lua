local config = {
[1] = {
--equipment; Soldier Helmet, Wand of Vortex, Brass Armor, Brass Legs, Amulet of Loss, Black Shield, Leather Boots
{{2481, 1}, {2190, 1}, {2465, 1}, {2478, 1}, {2173, 1}, {2529, 1}, {2643, 1}},
--container; Rope, Light Shovel, 30 Platinum Coins, 100 Brown Mushroom
{{8712, 1}, {5710, 1}, {2152, 30}, {2789, 100}}
},
[2] = {
--equipment; Soldier Helmet, Snakebite Rod, Brass Armor, Brass Legs, Amulet of Loss, Black Shield, Leather Boots
{{2481, 1}, {2182, 1}, {2465, 1}, {2478, 1}, {2173, 1}, {2529, 1}, {2643, 1}},
--container; Rope, Light Shovel, 30 Platinum Coins, 100 Brown Mushroom
{{8712, 1}, {5710, 1}, {2152, 30}, {2789, 100}}
},
[3] = {
--equipment; Soldier Helmet, Bow, Brass Armor, Brass Legs, Amulet of Loss, 100 Arrow, Leather Boots
{{2481, 1}, {2456, 1}, {2465, 1}, {2478, 1}, {2173, 1}, {2544, 100}, {2643, 1}},
--container; Rope, Light Shovel, 30 Platinum Coins, 100 Brown Mushroom
{{8712, 1}, {5710, 1}, {2152, 30}, {2789, 100}}
},
[4] = {
--equipment; Soldier Helmet, Steel Axe, Brass Armor, Brass Legs, Amulet of Loss, Black Shield, Leather Boots
{{2481, 1}, {8601, 1}, {2465, 1}, {2478, 1}, {2173, 1}, {2529, 1}, {2643, 1}},
--container; Rope, Light Shovel, 30 Platinum Coins, 100 Brown Mushroom, Banana Staff, Jagged Sword
{{8712, 1}, {5710, 1}, {2152, 30}, {2789, 100}, {3966, 1}, {8602, 1}}
}
}

function onLogin(cid)
local player = Player(cid)
local targetVocation = config[player:getVocation():getId()]
if not targetVocation then
return true
end

if player:getLastLoginSaved() == 0 then
for i = 1, #targetVocation[1] do
player:addItem(targetVocation[1][1], targetVocation[1][2])
end

local backpack = player:addItem(1988)
for i = 1, #targetVocation[2] do
backpack:addItem(targetVocation[2][1], targetVocation[2][2])
end
end
return true
end