local lc = LevelingChronicle

lc.UI.Definitions.MAIN_WINDOW_BACKGROUND_TEXTURE = "collections-background-tile"

lc.UI.Definitions.CHARACTER_TREE_SCROLL_BACKGROUND_TEXTURE = "UI-Frame-Neutral-CardParchment"

--lc.UI.Definitions.MAIN_WINDOW_NINE_SLICE = NineSliceLayouts.Dialog
lc.UI.Definitions.MAIN_WINDOW_NINE_SLICE = {
		TopLeftCorner =	{ atlas = "UI-Frame-DiamondMetal-CornerTopLeft", x=-6, y=7 },
		TopRightCorner =	{ atlas = "UI-Frame-DiamondMetal-CornerTopRight", x=6, y=7 },
		BottomLeftCorner =	{ atlas = "UI-Frame-DiamondMetal-CornerBottomLeft", x=-6, y=-7 },
		BottomRightCorner =	{ atlas = "UI-Frame-DiamondMetal-CornerBottomRight", x=6, y=-7 },
		TopEdge = { atlas = "_UI-Frame-DiamondMetal-EdgeTop",},
		BottomEdge = { atlas = "_UI-Frame-DiamondMetal-EdgeBottom",},
		LeftEdge = { atlas = "!UI-Frame-DiamondMetal-EdgeLeft",},
		RightEdge = { atlas = "!UI-Frame-DiamondMetal-EdgeRight",},
	}

lc.UI.Definitions.JOURNAL_BACKGROUNDS = {
    {file = "Interface\\QUESTFRAME\\QuestBackgroundHordeAlliance", coords = {left = 0.0009765625, top = 0.0009765625, right = 0.29296875, bottom = 0.3984375}},
    {file = "Interface\\QUESTFRAME\\QuestBackgroundHordeAlliance", coords = {left = 0.2930, top = 0, right = 0.586, bottom = 0.3984}},
    {file = "Interface\\QUESTFRAME\\QuestBackgroundHordeAlliance", coords = {left = 0.5888671875, top = 0.0009765625, right = 0.880859375, bottom = 0.3984}},
    {file = "Interface\\QUESTFRAME\\QuestBackgroundHordeAlliance", coords = {left = 0.0009765625, top = 0.400390625, right = 0.29296875, bottom = 0.7978515625}},
    {file = "Interface\\QUESTFRAME\\questmaplogatlas", coords = {left = 0.0009765625, top = 0.4560546875, right = 0.28125, bottom = 0.9091796875}},
  }

lc.UI.Definitions.JOURNAL_STAMPS = {
  {file = "Interface\\EncounterJournal\\UI-EJ-BACKGROUND-AhnkahetTheOldKingdom", coords = {left=0, right=0.7383, top=0, bottom=0.8340}},
  {file = "Interface\\ENCOUNTERJOURNAL\\UI-EJ-BACKGROUND-Argus", coords =  {left=0, right=0.7383, top=0, bottom=0.8340}},
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