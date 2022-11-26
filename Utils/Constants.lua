LevelingChronicle = {}

local lc = LevelingChronicle

lc.ADDON_NAME = "Journey"

lc.EVENT_WINDOW_SECONDS = 1.5
lc.INACTIVITY_PAUSE_AFTER = 300

lc.SESSIONS_TO_KEEP = 10

lc.ELAPSED_TIME_EASING = 60

lc.SHOW_MINIMAP_BUTTON_ALWAYS = 1
lc.SHOW_MINIMAP_BUTTON_ONLY_SUB_MAX = 2
lc.SHOW_MINIMAP_BUTTON_NEVER = 3

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