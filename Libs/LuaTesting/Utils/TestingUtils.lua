local m = {}

function m.sleep(time)
  local start = os.clock()
  while os.clock() - start <= n do end
end

return m