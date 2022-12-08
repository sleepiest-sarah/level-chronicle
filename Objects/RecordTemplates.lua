local lc = require('Utils.Constants') or LevelingChronicle

lc.RecordTemplates = {}
local rt = lc.RecordTemplates

rt.stats_record_template = {
    total_xp_gained = 0,
    levels_gained = 0,
    pct_levels_gained = 0,
    pet_battle_xp_gained = 0,
    gathering_xp_gained = 0,
    other_xp_gained = 0,
    crafting_xp_gained = 0,
    quest_xp_gained = 0,
    kill_xp_raw_gained = 0,             -- experience gained from kills without rested or group bonus xp
    kill_xp_gained = 0,                  -- raw + rested
    kill_xp_instance_gained = 0,        -- xp with bonuses from kills in a party instance
    kill_xp_raw_instance_gained = 0,    -- xp + group bonus from kills; raw because group bonus is unavoidable
    kill_xp_world_gained = 0,           -- xp with bonuses from kills in the over world
    kill_xp_raw_world_gained = 0,       -- xp from kills in the over world without rested or group bonus xp
    battleground_xp_gained = 0,
    scenario_xp_gained = 0,
    bonus_rested_xp_gained = 0,
    bonus_group_xp_gained = 0,
    bonus_warmode_xp_gained = 0,
    num_quests_completed = 0,
    num_scenarios_completed = 0,
    num_kills = 0,                      -- total kills = instance + world
    num_kills_instance = 0,             -- kills in a party instance
    num_kills_world = 0,                -- kills in the over world
    num_gathers = 0,
    num_pet_battles = 0,
    num_battlegrounds_completed = 0,
    num_first_crafts = 0,
    elapsed_time = 0,
    time_battlegrounds = 0,
    time_scenarios = 0,
    time_pet_battles = 0
  }
  
rt.level_event_template = {
    date_reached = 0
  }
  
rt.character_db_template = {
    metadata = {
        database_version = "0"
      },
    characters = {}
  }
  
rt.character_record_template = {
    unit_data = {
        guid = "",
        name = "",
        realm = "",
        class = "",
        level = 0,
        max_level = 0,
        xp = 0,
        max_xp = 0,
        rested_xp = 0,
        xp_disabled = false,
        last_updated = 0
      },
    stats = {
        total = rt.stats_record_template
      },
    stats_by_level = {
        --list of Recorder.stats_template; keys are character levels
      },
    sessions = {
        --list of Recorder.session
      },
    events = {
        levels = {}
      }
 }
 
 rt.options_db_template = {
    ui = {
        state = {
            session_monitor_visible = true,
            session_monitor_expanded = true,
            rp_mode_on = false
          }
      },
    options = {
        minimap_show = lc.SHOW_MINIMAP_BUTTON_ALWAYS,
        show_monitor_on_login = true,
        continuous_timer = true,
      },
    profile = {
        minimap = {
            hide = false
          }
      }
  }

return rt