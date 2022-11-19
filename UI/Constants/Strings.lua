local lc = LevelingChronicle
lc.UI.Strings = {}

lc.UI.Strings.JourneyRpStatDisplay = {
    pet_battle_xp_gained = {},
    gathering_xp_gained = {},
    other_xp_gained = {},
    quest_xp_gained = {},
    kill_xp_gained = {},
    rested_xp_time_saved = {"A good night's sleep saved me at least %s"},
    bonus_group_xp_gained = {},
    elapsed_time = {"After %s of hard work, I feel like I've really reached a new level of prowess."},
    num_quests_completed = {"%d local denizens were aided by my selfless and heroic actions."},
    num_player_kills = {"%d creatures were put to the sword.",
                        "Monsters gently put to rest: %d.",
                        "%d creatures with numerous friends and loving families will never return home."},
    num_gathers = {"With pick and sickle, I collected the land's bounty %d times."},
    num_pet_battles = {"My loyal companions fought in %d battles on my behalf."},
    num_scenarios_completed = {}
}

lc.UI.Strings.JourneyStatDisplay = {
    pet_battle_xp_gained = "Pet Battle XP",
    gathering_xp_gained = "Gathering XP",
    other_xp_gained = "Other XP",
    quest_xp_gained = "Quest XP",
    kill_xp_gained = "Kill X",
    rested_xp_time_saved = "Saved from Rested XP",
    bonus_group_xp_gained = "Group XP Time Saved",
    elapsed_time = "Active Leveling Time",
    quest = "Quests Completed:",
    kill = "Creatures Killed:",
    gathering = "Nodes Harvested:",
    pet_battle = "Pet Battles Battled:",
    scenario = "Scenarios Run:",
    battleground = "Battlegrounds Fought:",
    xp_rate = "Average XP / Hour",
    pct_levels_rate = "Average Levels / Hour",
}

lc.UI.Strings.XpSourceTable_Header = "XP Sources"
lc.UI.Strings.XpSourceTable_Headers = {
    source = "XP Sources",
    pct = "% XP",
    rate = "XP/Hour",
    num = "#",
    per = "% Level"
  }
lc.UI.Strings.XpSourceTable = {
    quest = "Quest",
    kill = "Kill",
    gathering = "Gathering",
    battleground = "Battleground",
    scenario = "Scenario",
    pet_battle = "Pet Battle"
  }
  
lc.UI.Strings.SessionMonitorDisplay = {
    xp_rate_header = "XP/Hour",
    xp_rate = "   Current:",
    average_xp_rate = "   Average:",
    time_to_level_header = "Approx. Time To Next Level",
    time_to_level = "   Current:",
    avg_time_to_level = "   Average:",
    to_level_header = "Number to Level",
    kills_to_level = "   Kills:",
    quests_to_level = "   Quests:",
    scenarios_to_level = "   Scenarios:",
    gathers_to_level = "   Gathers:",
    battlegrounds_to_level = "   Battlegrounds:",
    pet_battles_to_level = "   Pet Battles:",
  }
  
lc.UI.Strings.MiniSessionMonitor_TimerTooltip = "Approximate time to next level (HH:MM:SS)"
lc.UI.Strings.MiniSessionMonitor_TimerTooltip_Running = "Running"
lc.UI.Strings.MiniSessionMonitor_TimerTooltip_Standby = "Waiting for activity"

lc.UI.Strings.Options_MinimapShow = "Show Minimap Button"
lc.UI.Strings.Options_ShowOnLogin = "Show Monitor on Login"
lc.UI.Strings.Options_ContinuousTimer = "Display Continuous Timer"

lc.UI.Strings.OPTIONS_CATEGORY = "Leveling Chronicle"
lc.UI.Strings.ABOUT_CATEGORY = "About"

lc.UI.Strings.MinimapButton_TooltipHover = 
[[
LevelingChronicle

|cFFFFFF00Click |cFFFFFFFFto open monitor
|cFFFFFF00Right Click |cFFFFFFFFto open diary
|cFFFFFF00Alt+Click |cFFFFFFFFto open options
|cFFFFFF00Shift+Click |cFFFFFFFFto open the guide
]]

lc.UI.Strings.Information_Full =
[[
<html>
  <body>
    <h2 align="CENTER">Monitor</h2>
    <p>Timer at the bottom is the active leveling time
    for this session. Green means the timer is running
    and Yellow means it's standing by until you start receiving XP
       Average XP/Hour is based on recent experience gains
       Current XP/Hour is for this session
    </p>
    <br />
    <h1 align="CENTER">Journal</h1>
    <br />
    <h2 align="CENTER">XP Sources</h2>
    <p>
      Summary of all experience earned<br /><br />
      % XP - % of total experience earned through this source<br />
      XP/Hour - amount of experience earned per hour from this source<br/>
      # - number of quests completed, number of scenarios completed, number of creatures killed, etc.<br/>
      XP Per - average experience earned per instance e.g. experience per battleground or experience per dungeon run<br/>
    </p>
    <br/>
    <h2 align="CENTER">Glossary</h2>
    <br />
    <h3>Active Leveling Time</h3>
    <p>Time you were participating in activities that<br /> grant experience. It's a best guess based<br /> on how often you're receiving<br /> experience.</p>
  </body>
</html>
]]