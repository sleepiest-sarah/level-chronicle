LevelingChronicle = {}

local lc = LevelingChronicle

lc.ADDON_NAME = "LevelingChronicle"

lc.EVENT_WINDOW_SECONDS = 1
lc.INACTIVITY_PAUSE_AFTER = 300

--Internal Custom Events
lc.Event = {}

lc.Event.PLAYER_LOGIN = "PLAYER_LOGIN"

-- option_key, old_value, new_value
lc.Event.ON_OPTION_CHANGED = "ON_OPTION_CHANGED"

-- new_level
lc.Event.PLAYER_LEVEL_UP = "PLAYER_LEVEL_UP"

lc.Event.SESSION_DATA_CHANGED = "SESSION_DATA_CHANGED"

-- lc.Character
lc.Event.CHARACTER_INITIALIZED = "CHARACTER_INITIALIZED"

return lc