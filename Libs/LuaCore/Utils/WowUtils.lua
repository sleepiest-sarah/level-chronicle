LCWowUtils = {}

local wowUtils = LCWowUtils

function wowUtils.getCurrencyString(n)
    local copper,silver, gold,res
    if (math.abs(n) > 10000) then
      gold = math.floor(n/10000)
      silver = math.floor((n % 10000) / 100)
      copper = math.floor(n) % 100
      res = tostring(gold).."g"..tostring(silver).."s"..tostring(copper).."c"
    elseif (math.abs(n) > 1000) then
      silver = math.floor(n/100)
      copper = math.floor(n) % 100
      res = tostring(silver).."s"..tostring(copper).."c"
    else
      res = tostring(math.floor(n)).."c"
    end
    
    return res
end

function wowUtils.getCoppersFromText(text)
  local copper = 0
  for n,currency in string.gmatch(text, "(%d+) (%w+)") do
    if (currency == "Gold") then
      copper = copper + (n * 10000)
    elseif (currency == "Silver") then
      copper = copper + (n * 100)
    else
      copper = copper + n
    end
  end
  
  return copper
end

function wowUtils.getItemId(itemLink)
  local id = string.match(itemLink, "item:(%d+):")
  return tonumber(id)
end

function wowUtils.getJournalIdFromLink(journalLink)
  local id = string.match(journalLink, "HJournal:%d?:(%d+):")
  return tonumber(id)
end

function wowUtils.getBnAccountNameFromChatString(str)
  local id = string.match(str, "|Kq([0-9]+)|k")
  local bn_name

  if (id ~= nil) then
    local _,_,bn_name = C_BattleNet.GetAccountInfoByID(id)
  end

  return bn_name
end

function wowUtils.getUnitGroupPrefix()
  return IsInRaid() and "raid" or "party"
end

function wowUtils.getRoleIcon(role)
  if (role == "TANK") then
    return INLINE_TANK_ICON
  elseif (role == "HEALER") then
    return INLINE_HEALER_ICON
  elseif (role == "DAMAGER") then
    return INLINE_DAMAGER_ICON
  end
  
  return ""
end

function wowUtils.dump(v)
  _G["lc_dump"] = v
  SlashCmdList["DUMP"]("lc_dump")
end

return LCWowUtils