local cfg = {
   top = 5,
   messagetype = MESSAGE_STATUS_CONSOLE_ORANGE
}
 
function table.find(table, value)
   for i, v in pairs(table) do
     if v == value then
       return i
     end
   end
   return nil
end
 
function getHighest(check, values)
   local highest = 0
   local highestVal = nil
   local highestI = nil
   for i = 1, #values do
     if check[values[i]] > highest then
       highest = check[values[i]]
       highestVal = values[i]
       highestI = i
     end
   end
   
   return {highest, highestVal, highestI}
end
 
function getTopFraggers()
   local fraggers = {}
   local resultId = db.storeQuery("SELECT `player_id`, `killed_by` FROM `player_deaths` WHERE `is_player` = 1")
   if resultId then
     repeat
       table.insert(fraggers, result.getDataString(resultId, "killed_by"))      
     until not result.next(resultId)
     result.free(resultId)
   end
 
   local fraggers_names = {}
   for i = 1, #fraggers do
     if not table.find(fraggers_names, fraggers[i]) then
       table.insert(fraggers_names, fraggers[i])
     end
   end
   
   local fraggers_total = {}
   for i = 1, #fraggers do
   for j = 1, #fraggers_names do
     if fraggers_names[j] == fraggers[i] then
       if not fraggers_total[fraggers_names[j]] then fraggers_total[fraggers_names[j]] = 0 end
       fraggers_total[fraggers_names[j]] = fraggers_total[fraggers_names[j]] + 1
     end
   end  
   end
   
   local fraggers_top = {}
   for i = 1, cfg.top do
     local v = getHighest(fraggers_total, fraggers_names)
     table.insert(fraggers_top, {v[1], v[2]})
     table.remove(fraggers_names, v[3])
   end
   
   local msg = "Top fraggers:\n"
   for i = 1, #fraggers_top do
     if fraggers_top[i][2] then
       msg = msg .. "[" .. i .. "]: " .. fraggers_top[i][2] .. ": [" .. fraggers_top[i][1] .. "]" .. ((fraggers_top[i+1][2] and i+1 ~= #fraggers_top) and "\n" or "")
     else
       break
     end
   end
   broadcastMessage(msg, cfg.messagetype)
end
 
function onThink(interval)
   getTopFraggers()
   return true
end