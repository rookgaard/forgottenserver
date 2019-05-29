--[[
Key Information:
unique - If this is true then the chest will block other chests from being used.
uidChests - If the player has used any chests with these uid's then it cannot be opened.
itemRandom - If this is true the player will receive one of the items specified in the items table randomly otherwise he will recieve all of them.
level_req - This level is required to open the chest.
quest - If this is true it will check to see if the players storage is the correct value before giving rewards.
storage - This is the quest storage and value which is required for the chest to give rewards. It is not used if: quest = false
storage - the 3rd value in this can be used to change the players storage value of the quest if required.


chestRewards = {
    [2000] = {unique = true, uidChests = {2001, 2002, 2003}, itemRandom = false, level_req = 10, quest = false, storage = {15000, 5, 5}
            items = {{1111, 1}, {1111, 1}}, --Itemid, amount--
            exp = 20000,
            outfit = {"Citizen", 216, 217, 3, true}, --outfit name/male id/female id/addons/if this is true it will give all addons 1-3 Otherwise it will only give the specific addon--
            mount = {"Black Sheep", 20}
            text = "You cannot open this chest until you do..." --This is only used if the chest is quest required.--
            }
    --[2004] --
}
]]--
chestRewards = {
    [3000] = {unique = true, uidChests = {3000}, itemRandom = true, level_req = 10, quest = false, storage = {15000, 5, 5}
            items = {{2518, 1}, {2149, 5}, {2147, 5}, {2533, 1}}, --Itemid, amount--
            text = "You cannot open this chest until you do..." --This is only used if the chest is quest required.--
            } -- amazon camp
	{
    [3001] = {unique = true, uidChests = {3001}, itemRandom = false, level_req = 10, quest = false, storage = {15001, 5, 5}
            items = {{2392, 1}}, --Itemid, amount--
            text = "You cannot open this chest until you do..." --This is only used if the chest is quest required.--
            } -- dragons
	{
    [3002] = {unique = true, uidChests = {3002}, itemRandom = false, level_req = 10, quest = false, storage = {15002, 5, 5}
            items = {{2414, 1}}, --Itemid, amount--
            text = "You cannot open this chest until you do..." --This is only used if the chest is quest required.--
            } --dragons
    {
    [3003] = {unique = true, uidChests = {3003}, itemRandom = false, level_req = 10, quest = false, storage = {15003, 5, 5}
            items = {{7383, 1}, {2151, 5}, {2155, 1}}, --Itemid, amount--
            text = "You cannot open this chest until you do..." --This is only used if the chest is quest required.--
            }
	{
   
    --[2004] --
}