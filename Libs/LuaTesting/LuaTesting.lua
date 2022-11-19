require('Libs.LuaTesting.WowGlobalStubs')
require('Libs.LuaTesting.C_Map')
require('Libs.LuaTesting.C_Timer')
require('Libs.LuaTesting.C_ChallengeMode')
require('Libs.LuaTesting.C_PvP')

local parent_dir = string.match(io.popen("cd"):read(), "(.-)[^%\\]+$")
package.path = package.path .. ";" .. parent_dir .. "?.lua" .. ";" .. parent_dir .. "Libs\\?\\?.lua"

local m = {}

function m.fireEvent(event, ...)
  WowEventFramework.sframe:OnEvent(event, ...)
end

return m