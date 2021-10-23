//---------------------------------------------------------------------------------------
//  FILE:   X2StrategyElement_InRFacilities.uc                                    
//
//	File created by RustyDios & Modified by Losu
//  
//	File created	23/10/21    1:15
//	LAST UPDATED    23/10/21    1:15
//
//  ADDS Interrogation facility !!
//
//---------------------------------------------------------------------------------------
class X2StrategyElement_InRFacilities extends X2StrategyElement_DefaultFacilities config(InterrogationAndRecruitment);

var config array<name> strInterrogationFacility_COST_TYPE; //175 supplies, 10 edust
var config array<int>  iInterrogationFacility_COST_AMOUNT;

var config int InterrogationFacilityDAYS, InterrogationFacilityPOWER, InterrogationFacilityUPKEEP; //21 , -5, 55

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Facilities;

	Facilities.AddItem(CreateInterrogationFacilityTemplate());

	return Facilities;
}

//---------------------------------------------------------------------------------------
// InR CHAMBER    
//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateInterrogationFacilityTemplate()
{
	local X2FacilityTemplate Template;
	local ArtifactCost Resources;
	local int i;
	local StaffSlotDefinition StaffSlotDef0, StaffSlotDef1;

	//setup
	`CREATE_X2TEMPLATE(class'X2FacilityTemplate', Template, 'InterrogationFacility');
	Template.bIsCoreFacility = false;				//is it one of the big rooms
	Template.bIsUniqueFacility = true;				//can only one be built at a time
	Template.bIsIndestructible = false;				//can it be destroyed
	Template.MapName = "AVG_PsiLab_A";				//to be replaced in future
	Template.AnimMapName = "AVG_PsiLab_A_Anim";		//ditto
	//Template.FlyInMapName = "";					// ??
	Template.FlyInRemoteEvent = '';					//'CIN_Flyin_Infirmary'; //??

	Template.strImage =  "img:///UILibrary_StrategyImages.FacilityIcons.ChooseFacility_PsionicLab";//to be replaced

	//delegates
	Template.SelectFacilityFn = SelectFacility;
	Template.OnFacilityBuiltFn = OnInterrogationFacilityBuilt;
	Template.CanFacilityBeRemovedFn = CanInterrogationFacilityBeRemoved;
	Template.OnFacilityRemovedFn = OnInterrogationFacilityRemoved;
	Template.IsFacilityProjectActiveFn = IsInterrogationFacilityProjectActive;
	Template.GetQueueMessageFn = GetInterrogationFacilityQueueMessage;

	//upgrades
	Template.Upgrades.AddItem('InterrogationFacility_SecondCell');		//back area, more staff, faster projects

	//appearances
	Template.bHideStaffSlotOpenPopup = true;					//does it instantly want to staff

	Template.UIFacilityClass = class'UIFacility_InterrogationFacility';		// UIFacility_PsiLab && UIFacility_ProvingGround

	Template.FacilityEnteredAkEvent = "Play_AvengerPsiChamber_Unoccupied";
	Template.FacilityCompleteNarrative = "X2NarrativeMoments.Strategy.Avenger_PsiLab_Complete";
	Template.FacilityUpgradedNarrative = "X2NarrativeMoments.Strategy.Avenger_PsiLab_Upgraded";
	Template.ConstructionStartedNarrative = "X2NarrativeMoments.Strategy.Avenger_Tutorial_Psy_Lab_Construction";

	//crew
	Template.BaseMinFillerCrew = 1;
    	Template.FillerSlots.AddItem('Engineer');
        Template.FillerSlots.AddItem('Engineer');
		
    	Template.FillerSlots.AddItem('Engineer');
        Template.FillerSlots.AddItem('Engineer');
	Template.MaxFillerCrew = 12;
	
	Template.MatineeSlotsForUpgrades.AddItem('EngineerSlot2');
	
	//staff slots
	StaffSlotDef0.StaffSlotTemplateName = 'InterrogationFacilityStaffSlot_Eng';
	Template.StaffSlotDefs.AddItem(StaffSlotDef0);

	StaffSlotDef1.StaffSlotTemplateName = 'InterrogationFacilityStaffSlot_Eng';
	StaffSlotDef1.bStartsLocked = true;
	Template.StaffSlotDefs.AddItem(StaffSlotDef1);


	// Stats
	Template.PointsToComplete = GetFacilityBuildDays(default.InterrogationFacilityDAYS);
	Template.iPower = default.InterrogationFacilityPOWER;
	Template.UpkeepCost = default.InterrogationFacilityUPKEEP;

	// Costs	Code forloop taken from Iridar, looks for arrays in the config file and cycles through them adding the costs
	// default costs are 1 Elerium Core
	for (i = 0; i < default.strInterrogationFacility_COST_TYPE.Length; i++)
	{
		if (default.iInterrogationFacility_COST_AMOUNT[i] > 0)
		{
			Resources.ItemTemplateName = default.strInterrogationFacility_COST_TYPE[i];
			Resources.Quantity = default.iInterrogationFacility_COST_AMOUNT[i];
			Template.Cost.ResourceCosts.AddItem(Resources);
		}
	}

	return Template;
}

static function OnInterrogationFacilityBuilt(StateObjectReference FacilityRef)
{
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState NewGameState;
	local UIAvengerHUD AvengerHud;

	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("On InterrogationFacility Built");
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));

	//Then add the avenger shortcut ? ... should this be handled by the UISL ?
	AvengerHud = `HQPRES.m_kAvengerHUD; //Movie.Stack.GetScreen(class'UIAvengerHUD');
	class'UISL_AvengerHUD_Shortcuts_InR'.static.AddSubMenuItems(AvengerHud);

	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
}

static function bool CanInterrogationFacilityBeRemoved(StateObjectReference FacilityRef)
{
	return !IsInterrogationFacilityProjectActive(FacilityRef);
}

static function OnInterrogationFacilityRemoved(StateObjectReference FacilityRef)
{
	local XComGameState NewGameState;
	local XComGameState_HeadquartersXCom NewXComHQ;
	local XComGameState_FacilityXCom FacilityState;
	local StateObjectReference BuildItemRef;
	local int idx;

	local UIAvengerHUD AvengerHud;

    //Empty the soldier staff slots
	EmptyFacilityProjectStaffSlots(FacilityRef);

	//Then cancel all of the active proving ground projects
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Cancel All InR Projects");
	FacilityState = XComGameState_FacilityXCom(`XCOMHISTORY.GetGameStateForObjectID(FacilityRef.ObjectID));
	if (FacilityState != none)
	{
		for (idx = 0; idx < FacilityState.BuildQueue.Length; idx++)
		{
			BuildItemRef = FacilityState.BuildQueue[idx];
			class'XComGameStateContext_HeadquartersOrder_InR'.static.CancelProvingGroundProject(NewGameState, BuildItemRef);
		}
	}
	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState); // we need two separate NewGameStates because facility and XComHQ are changed in both

	// Then actually remove the facility
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("On InR Chamber Removed");
	RemoveFacility(NewGameState, FacilityRef, NewXComHQ);

	//Then remove the avenger shortcut ? ... should this be handled by the UISL ?
	AvengerHud = `HQPRES.m_kAvengerHUD; //Movie.Stack.GetScreen(class'UIAvengerHUD');
	class'UISL_AvengerHUD_Shortcuts_InR'.static.ResetSubMenuItems(AvengerHud);

	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
}

static function bool IsInterrogationFacilityProjectActive(StateObjectReference FacilityRef)
{
	local XComGameStateHistory History;
	local XComGameState_FacilityXCom FacilityState;

	History = `XCOMHISTORY;
	FacilityState = XComGameState_FacilityXCom(History.GetGameStateForObjectID(FacilityRef.ObjectID));


    // ... are there things in the build queue
    if (FacilityState.BuildQueue.Length > 0)
    {
        return true;	//we have projects
    }

	return false;		//no projects
}

//THIS IS THE ANTHILL VIEW MESSAGE
static function string GetInterrogationFacilityQueueMessage(StateObjectReference FacilityRef)
{
    local XComGameStateHistory								History;
	local XComGameState_Tech								TechState;
	local XComGameState_FacilityXCom						FacilityState;			
   	local XComGameState_HeadquartersProjectInR				InRProject;		
   	local StateObjectReference								BuildItemRef;

	local string strStatus, Message;

	History = `XCOMHISTORY;
	FacilityState = XComGameState_FacilityXCom(`XCOMHISTORY.GetGameStateForObjectID(FacilityRef.ObjectID));
	
	//Show info about the first item in the build queue.
	if (FacilityState.BuildQueue.length == 0)
	{
		strStatus = class'UIUtilities_Text'.static.GetColoredText(class'UIFacility_InterrogationFacility'.default.m_strEmptyQueue, eUIState_Bad);
	}
	else
	{
		BuildItemRef = FacilityState.BuildQueue[0];
		InRProject = XComGameState_HeadquartersProjectInR(History.GetGameStateForObjectID(BuildItemRef.ObjectID));	
		TechState = XComGameState_Tech(History.GetGameStateForObjectID(InRProject.ProjectFocus.ObjectID));

		if (InRProject.GetCurrentNumHoursRemaining() < 0)
			Message = class'UIUtilities_Text'.static.GetColoredText(class'UIFacility_Powercore'.default.m_strStalledResearch, eUIState_Warning);
		else
			Message = class'UIUtilities_Text'.static.GetTimeRemainingString(InRProject.GetCurrentNumHoursRemaining());

		strStatus = TechState.GetMyTemplate().DisplayName $ ":" @ Message;
	}

	return strStatus;
}
