//*******************************************************************************************
//  FILE:   Psionics Ex Machina. stuff                                 
//  
//	File created	25/07/20    21:00
//	LAST UPDATED    07/08/20	19:30 
//
//	controls unique pop-ups etc
//
//*******************************************************************************************
class UIAlert_InR extends UIAlert;

var public localized String m_strInterrogationSuccessful;
var public localized String m_strItemReceivedInInventoryInterrogation;

simulated function BuildAlert ()
{
	BindLibraryItem();

	switch (eAlertName)
	{
		case 'eAlert_ItemReceivedInterrogationFacility':
			InterrogationFacilityItemReceivedAlert();
		break;
				
		default:
			AddBG(MakeRect(0, 0, 1000, 500), eUIState_Normal).SetAlpha(0.75f);
		break;
	}

	// Set up the navigation *after* the alert is built, so that the button visibility can be used. 
	RefreshNavigation();
}

simulated function name GetLibraryID ()
{
	switch (eAlertName)
	{
		case 'eAlert_ItemReceivedInterrogationFacility':	return 'Alert_ProvingGroundAvailable';
		
		default:
			return '';
	}
}

simulated function InterrogationFacilityItemReceivedAlert()
{
	local XComGameState_Tech TechState;
	local TAlertAvailableInfo kInfo;
	local string TitleStr;
	local X2ItemTemplate ItemTemplate;
	local X2ItemTemplateManager TemplateManager;
		
	TemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	ItemTemplate = TemplateManager.FindItemTemplate(
		class'X2StrategyGameRulesetDataStructures'.static.GetDynamicNameProperty(DisplayPropertySet, 'ItemTemplate'));

	TechState = XComGameState_Tech(`XCOMHISTORY.GetGameStateForObjectID(
		class'X2StrategyGameRulesetDataStructures'.static.GetDynamicIntProperty(DisplayPropertySet, 'TechRef')));
	TitleStr = Repl(m_strInterrogationSuccessful, "%PROJECTNAME", Caps(TechState.GetDisplayName()));

	kInfo.strTitle = TitleStr;
	kInfo.strName = ItemTemplate.GetItemFriendlyName(, false);
	kInfo.strBody = ItemTemplate.GetItemBriefSummary() $ "\n\n" $ Repl(m_strItemReceivedInInventoryInterrogation, "%ITEMNAME", ItemTemplate.GetItemFriendlyName(, false));
	kInfo.strConfirm = m_strAccept;
	kInfo.strImage = ItemTemplate.strImage;
	kInfo.eColor = eUIState_Good;
	kInfo.clrAlert = MakeLinearColor(0.0, 0.75, 0.0, 1);

	kInfo = FillInShenAlertAvailable(kInfo);

	BuildAvailableAlert(kInfo);
}
