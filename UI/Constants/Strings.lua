local lc = LevelingChronicle
lc.UI.Strings = {}

lc.UI.Strings.Empty_Journey_Text = "Your journey awaits..."

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
    kill_instance = "Creatures Killed (Dungeon):",
    kill_world = "Creatures Killed (World):",
    gathering = "Nodes Harvested:",
    pet_battle = "Pet Battles Battled:",
    scenario = "Dungeons Run:",
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
    kill_instance = "     Kill",
    scenario_bonus = "     Bonus", 
    kill_world = "Kill",

    gathering = "Gathering",
    battleground = "Battleground",
    scenario = "Dungeon",
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
    scenarios_to_level = "   Dungeons:",
    gathers_to_level = "   Gathers:",
    battlegrounds_to_level = "   Battlegrounds:",
    pet_battles_to_level = "   Pet Battles:",
  }
  
lc.UI.Strings.MiniSessionMonitor_TimerTooltip = "Approximate time to next level (HH:MM:SS)"
lc.UI.Strings.MiniSessionMonitor_TimerTooltip_Running = "Running"
lc.UI.Strings.MiniSessionMonitor_TimerTooltip_Standby = "Waiting for activity"

lc.UI.Strings.Options_MinimapShow = "Show Minimap Button"
lc.UI.Strings.Options_MinimapShow_Always = "Always"
lc.UI.Strings.Options_MinimapShow_Only_Sub_Max = "Only on Characters Below Max Level"
lc.UI.Strings.Options_MinimapShow_Never = "Never"

lc.UI.Strings.Options_ShowOnLogin = "Show Monitor on Login"
lc.UI.Strings.Options_ContinuousTimer = "Display Continuous Timer"

lc.UI.Strings.Options_ContinuousTimer_Tooltip = 
[[
  Checked: the monitor timer will update at regular intervals
  Unchecked: the monitor timer will only update when experience is received
]]

lc.UI.Strings.Options_ShowOnLogin_Tooltip = "Monitor will only automatically show on characters below max level"

lc.UI.Strings.OPTIONS_CATEGORY = "Journey"
lc.UI.Strings.ABOUT_CATEGORY = "About"

lc.UI.Strings.MinimapButton_TooltipHover = 
[[
Journey

|cFFFFFF00Click |cFFFFFFFFto toggle monitor (characters below max level only)
|cFFFFFF00Right Click |cFFFFFFFFto open journal
|cFFFFFF00Shift+Click |cFFFFFFFFto open options
|cFFFFFF00Shift+Right Click |cFFFFFFFFto open the guide
]]

lc.UI.Strings.SlashCommand_Info1 =
[[
Usage: /journey [command] [args]
       /jy [command] [args]
       
  /journey monitor        
    -- toggle the monitor UI
  /journey monitor reset  
    -- reset the position of the monitor
  /journey journal        
    -- toggle the journal UI
  /journey options        
    -- open the options menu
  /journey help           
    -- open the guide
]]

lc.UI.Strings.Information_Full =
[[
<html>
  <body>
    <p>
    All times are in HH:MM:SS format e.g. 12:15:33 is 12 hours, 15 minutes, and 33 seconds.
    </p>
    <br />
    <h1 align="CENTER">Monitor</h1>
    <p>
      A small window to track your leveling progress. Can be minified to show only estimated time to the next level.
      <br /><br />
      Average XP/Hour and Average Approx. Time to Next Level are calculated using the last few leveling sessions<br/> for the current character.<br />
      Current XP/Hour and Current Approx. Time to Next Level are calculated using only activities from the current <br /> login session. <br />
      <br />
      The timer at the bottom tracks your active leveling time for the current session. <br />
      When green, the timer is running and you've been detected as actively leveling.<br />
      When yellow, the timer is paused and waiting for leveling activity.
    </p>
    <br />
    <h1 align="CENTER">Journal</h1>
    <br />
    <h2 align="CENTER">Left Page</h2>
    <p>
      Summary of leveling statistics for all recorded levels. The bottom table gives an overview of the different<br /> sources from which you've obtained experience.
    </p>
    <br/>
    <h2 align="CENTER">Right Page</h2>
    <p>
      Shows summaries for each recorded level.<br /> 
      
      Can be scrolled using the arrow buttons at the bottom, by clicking the bookmarks on the right, or by using<br /> the mouse wheel. 
      Bookmarks will appear every 10 recorded levels and allow navigating directly to specific levels.
    </p>
    <br />
    <h1 align="CENTER">Glossary</h1>
    <br />
    <h3>Active Leveling Time</h3>
    <p>Time you were participating in activities that grant experience. It's a best guess based on how what you're<br /> currently doing and how often experience has been received.</p>
    <br/>
    <h3>% Level or % Level Per</h3>
    <p>On average how much of a level you gain from doing one of these. One kill, one dungeon, one battleground, etc.</p>
    <br/>
    <h3>Saved from Rested XP</h3>
    <p>How much longer it would have taken to reach your current level if you had not had rested experience.</p>  
  </body>
</html>
]]