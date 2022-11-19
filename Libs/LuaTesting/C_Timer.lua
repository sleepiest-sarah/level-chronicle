local testing_utils = require('Libs.LuaTesting.Utils.TestingUtils')

C_Timer = {}

function C_Timer.After(duration, callback)
  testing_utils.sleep(duration)
  callback()
end

function C_Timer.NewTimer(seconds, callback)
  return {seconds = seconds, callback = callback, Cancel = function () end}
end

return C_Timer