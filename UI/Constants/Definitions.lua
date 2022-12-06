local lc = LevelingChronicle

lc.UI.Definitions = {}

local texture_path = "Interface\\AddOns\\"..lc.ADDON_NAME.."\\UI\\Textures"

lc.UI.Definitions.BACKDROP_DEFAULT = {
  bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",
  edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
  tile=true,
  tileSize = 32,
  edgeSize = 16,
  insets = {left=4, right=4, top=4, bottom=4}
}

lc.UI.Definitions.BACKDROP_JOURNEY_WIDGET = {
	edgeFile = "Interface\\AchievementFrame\\UI-Achievement-WoodBorder",
	edgeSize = 64,
	tileEdge = true,
  insets = {left=-4, right=-4, top=-4, bottom=-4}
}

lc.UI.Definitions.BACKDROP_MAIN_WINDOW = {
  bgFile="interface\\framegeneral\\uiframedragonflightbackground",
  tile=true,
  tileSize = 256,
  edgeFile="Interface\\AchievementFrame\\UI-Achievement-WoodBorder",
  edgeSize=64,
  tileEdge = true,
  insets = {left=4, right=4, top=4, bottom=4}    
}

-- this is in retail NineSliceLayouts but not classic
lc.UI.Definitions.MAIN_WINDOW_NINE_SLICE = NineSliceLayouts.WoodenNeutralFrameTemplate

lc.UI.Definitions.MAIN_WINDOW_BACKGROUND_TEXTURE = "UI-Frame-Dragonflight-BackgroundTile"
lc.UI.Definitions.CHARACTER_TREE_SCROLL_BACKGROUND_TEXTURE = "UI-Frame-NightFae-CardParchment"

lc.UI.Definitions.RECORDER_RUNNING_COLOR = {0, 1, 0.3}
lc.UI.Definitions.RECORDER_STANDBY_COLOR = {1, .82, 0}

lc.UI.Definitions.DRAWN_EXPAND_ICON_PATH = "Interface\\AddOns\\Journey\\UI\\Textures\\expand_icon.tga"
lc.UI.Definitions.DRAWN_EXPAND_HIGHLIGHT_PATH = "Interface\\AddOns\\Journey\\UI\\Textures\\expand_icon_highlight.tga"
lc.UI.Definitions.DRAWN_COLLAPSE_ICON_PATH = "Interface\\AddOns\\Journey\\UI\\Textures\\collapse_icon.tga"
lc.UI.Definitions.DRAWN_COLLAPSE_HIGHLIGHT_PATH = "Interface\\AddOns\\Journey\\UI\\Textures\\collapse_icon_highlight.tga"

lc.UI.Definitions.DEFAULT_JOURNAL_BACKGROUND_COORDS = {left = 0, right = .5879, top = 0, bottom = .8008}

lc.UI.Definitions.JOURNAL_BACKGROUNDS = {
    "Interface\\QUESTFRAME\\QuestBackgroundShadowlandsArdenweald",
    "Interface\\QUESTFRAME\\QuestBackgroundShadowlandsBastion",
    "Interface\\QUESTFRAME\\QuestBackgroundShadowlandsCovenantsNightFae",
    "Interface\\QUESTFRAME\\QuestBackgroundShadowlandsCovenantsKyrian",
    "Interface\\QUESTFRAME\\QuestBackgroundShadowlandsCovenantsNecrolords",
    "Interface\\QUESTFRAME\\QuestBackgroundShadowlandsCovenantsVenthyr",
    "Interface\\QUESTFRAME\\QuestBackgroundShadowlandsMaldraxxus",
    "Interface\\QUESTFRAME\\QuestBackgroundShadowlandsOribos",
    "Interface\\QUESTFRAME\\QuestBackgroundShadowlandsRevendreth",
    "Interface\\QUESTFRAME\\QuestBackgroundShadowlandsSecretsoftheFirstOnes",
    "Interface\\QUESTFRAME\\QuestBackgroundShadowlands",
    "Interface\\QUESTFRAME\\QuestBackgroundDragonflightAzureSpan",
    "Interface\\QUESTFRAME\\QuestBackgroundDragonflightDracthyrAwaken",
    "Interface\\QUESTFRAME\\QuestBackgroundDragonflightDragonflight",
    "Interface\\QUESTFRAME\\QuestBackgroundDragonflightOhnplains",
    "Interface\\QUESTFRAME\\QuestBackgroundDragonflightThaldraszus",
    "Interface\\QUESTFRAME\\QuestBackgroundDragonflightWalkingshore",
    "Interface\\QUESTFRAME\\QuestBackgroundProfessionAlchemy",
    "Interface\\QUESTFRAME\\QuestBackgroundProfessionBlacksmithing",
    "Interface\\QUESTFRAME\\QuestBackgroundProfessionCooking",
    "Interface\\QUESTFRAME\\QuestBackgroundProfessionEnchanting",
    "Interface\\QUESTFRAME\\QuestBackgroundProfessionEngineering",
    "Interface\\QUESTFRAME\\QuestBackgroundProfessionFishing",
    "Interface\\QUESTFRAME\\QuestBackgroundProfessionHerbalism",
    "Interface\\QUESTFRAME\\QuestBackgroundProfessionInscription",
    "Interface\\QUESTFRAME\\QuestBackgroundProfessionJewelcrafting",
    "Interface\\QUESTFRAME\\QuestBackgroundProfessionLeatherworking",
    "Interface\\QUESTFRAME\\QuestBackgroundProfessionMining",
    "Interface\\QUESTFRAME\\QuestBackgroundProfessionSkinning",
    "Interface\\QUESTFRAME\\QuestBackgroundProfessionTailoring",
  }


lc.UI.Definitions.JOURNAL_STAMPS = {
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-AhnkahetTheOldKingdom", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\ENCOUNTERJOURNAL\\UI-EJ-BACKGROUND-EternalPalace", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\ENCOUNTERJOURNAL\\UI-EJ-BACKGROUND-TheMotherlode", coords =  {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\ENCOUNTERJOURNAL\\UI-EJ-BACKGROUND-Argus", coords =  {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\ENCOUNTERJOURNAL\\UI-EJ-BACKGROUND-MistsofTirnaScithe", coords =  {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\ENCOUNTERJOURNAL\\UI-EJ-BACKGROUND-Shadowlands", coords =  {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\ENCOUNTERJOURNAL\\UI-EJ-BACKGROUND-SepulcherOfTheFirstOnes", coords =  {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\ENCOUNTERJOURNAL\\UI-EJ-BACKGROUND-HallsofAtonement", coords =  {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\ENCOUNTERJOURNAL\\UI-EJ-BACKGROUND-CastleNathria", coords =  {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\ENCOUNTERJOURNAL\\UI-EJ-BACKGROUND-TheUnderrot", coords =  {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\ENCOUNTERJOURNAL\\UI-EJ-BACKGROUND-WaycrestManor", coords =  {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\ENCOUNTERJOURNAL\\UI-EJ-BACKGROUND-NecroticWake", coords =  {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-AhnkahetTheOldKingdom", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-AssaultonVioletHold", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-Auchindoun", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-HourOfTwilight", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-CourtofStars", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-Firelands1", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-HallsofOrigination", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-Karazhan", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-HourOfTwilight", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-Pandaria", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-GrimrailDepot", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-EndTime", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-TheNighthold", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-TheEmeraldNightmare", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-SkywallRaid", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-MogushanPalace", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-IcecrownCitadel", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-BrokenIsles", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-ClockworkGnome", coords =  {left=0.3301, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-ChaliceMountainKings", coords = {left=0.3301, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-TyrandesFavoriteDoll", coords = {left=0.3301, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-KaldoreiWindChimes", coords = {left=0.2188, right=0.8282, top=0.0312, bottom=.8867}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-TrollGolem", coords = {left=0.3301, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-AncientShamanHeaddress", coords = {left=0.14, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-BonesOfTransformation", coords = {left=0.25, right=0.65, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-CthunsPuzzleBox", coords = {left=0.3301, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-DraeneiRelic", coords = {left=0.3301, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-GenBeauregardsLastStand", coords = {left=0.3301, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-QueenAzsharaGown", coords = {left=0.3301, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-HighborneSoulMirror", coords = {left=0.3301, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-TheInnKeepersDaughter", coords = {left=0.3301, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-ScimitaroftheSirocco", coords = {left=0.3301, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-VrykulDrinkingHorn", coords = {left=0.25, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-WispAmulet", coords = {left=0.25, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-StaffofSorcererThanThaurissan", coords = {left=0.3301, right=0.7012, top=0.0508, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-QuilinStatue", coords = {left=0.3301, right=0.7012, top=0, bottom=.8164}},
  {file = "Interface\\ARCHEOLOGY\\ArchRare-TrollDrum", coords = {left=0.3301, right=0.7012, top=0.0508, bottom=.8164}},
}

lc.UI.Definitions.TEXT_DIVIDERS = {
    {left=0.0376, right=0.2480, top=0.0781, bottom=.2383},
    {left=0.0376, right=0.2480, top=0.3164, bottom=.5078},
    {left=0.0376, right=0.2480, top=0.6348, bottom=.7881},
    {left=0.3013, right=0.6885, top=0.0508, bottom=.2324},
    {left=0.3013, right=0.6885, top=0.3418, bottom=.5352},
    {left=0.3013, right=0.6885, top=0.6152, bottom=.8008},
    {left=0.7373, right=0.9278, top=0.1445, bottom=.2871},
    {left=0.7271, right=0.9385, top=0.3242, bottom=.4434},
    {left=0.7134, right=0.9634, top=0.5820, bottom=.7305},
  }

lc.UI.Definitions.Options = {
    {text = lc.UI.Strings.Options_ContinuousTimer, control="checkbox", key="continuous_timer", tooltip = lc.UI.Strings.Options_ContinuousTimer_Tooltip},
    {text = lc.UI.Strings.Options_ShowOnLogin, control="checkbox", key = "show_monitor_on_login", tooltip = lc.UI.Strings.Options_ShowOnLogin_Tooltip},
    {text = lc.UI.Strings.Options_MinimapShow, control="dropdown", key = "minimap_show",
      selections = {lc.UI.Strings.Options_MinimapShow_Always, lc.UI.Strings.Options_MinimapShow_Only_Sub_Max, lc.UI.Strings.Options_MinimapShow_Never}},
  }