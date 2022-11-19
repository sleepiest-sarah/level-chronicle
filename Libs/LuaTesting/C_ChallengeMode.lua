C_ChallengeMode = {}

function C_ChallengeMode.GetActiveKeystoneInfo()
  return 15, {1,2,3}, true
end

function C_ChallengeMode.GetAffixInfo(id)
  return "affix", "desc", 1
end

function C_ChallengeMode.GetActiveChallengeMapID()
  return 1
end

function C_ChallengeMode.GetDeathCount()
  return 1, 15
end

function C_ChallengeMode.GetCompletionInfo()
  return 1, 15, 360, true
end