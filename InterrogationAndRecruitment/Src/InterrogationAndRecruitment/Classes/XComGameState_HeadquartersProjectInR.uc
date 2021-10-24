//*******************************************************************************************
//  FILE:    XComGameState_HeadquartersProjectInR.uc
//  AUTHOR:  Joe Weinhoffer  --  05/19/2015 && RustyDios, Modified by Losu
//  PURPOSE: This object represents the instance data for an XCom HQ proving ground project
//           Will eventually be a component
//           
//*******************************************************************************************
//  FILE:   Interrogation and Recruitment stuff                  
//  
//	File created	23/10/21    1:15
//	LAST UPDATED    23/10/21    1:15
//
//*******************************************************************************************
class XComGameState_HeadquartersProjectInR extends XComGameState_HeadquartersProjectResearch;

static function StateObjectReference GetCurrentInRProject()
{
	local XComGameState_FacilityXCom FacilityState;
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	FacilityState = XComHQ.GetFacilityByName('InterrogationFacility');

	if ( (FacilityState != none) && (FacilityState.BuildQueue.Length > 0) )
	{
		return FacilityState.BuildQueue[0]; //.ObjectID;
	}
}

//re-creation of the UIFacility_InRLab BuildQueue > UpdateBuildQueue
static function GetAllInRProjects(out array<HQEvent> arrEvents)
{
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_FacilityXCom Facility;
	local int i, ProjectHours;
	local StateObjectReference BuildItemRef;
	local XComGameState_HeadquartersProjectInR InRProject;
	local XComGameState_Tech InRTech;
	local HQEvent BuildItem;
	local array<HQEvent> BuildItems;

	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	Facility = XComHQ.GetFacilityByName('InterrogationFacility');

	for (i = 0; i < Facility.BuildQueue.Length; ++i)
	{
		BuildItemRef = Facility.BuildQueue[i];
		InRProject = XComGameState_HeadquartersProjectInR(`XCOMHISTORY.GetGameStateForObjectID(BuildItemRef.ObjectID));
		if (InRProject != none)
		{
			// Calculate the hours based on which type of Headquarters Project this queue item is
			if (i == 0)
			{
				ProjectHours = InRProject.GetCurrentNumHoursRemaining();
			}
			else
			{
				ProjectHours += InRProject.GetProjectedNumHoursRemaining();
			}

			InRTech = XComGameState_Tech(`XCOMHISTORY.GetGameStateForObjectID(InRProject.ProjectFocus.ObjectID));

			BuildItem.Hours = ProjectHours;
			BuildItem.Data = InRTech.GetMyTemplate().DisplayName;
			BuildItem.ImagePath = class'UIUtilities_Image'.const.EventQueue_Alien;
			BuildItems.AddItem(BuildItem);
		}
	}
	
	arrEvents = BuildItems;
}

//---------------------------------------------------------------------------------------
// Call when you start a new project
function SetProjectFocus(StateObjectReference FocusRef, optional XComGameState NewGameState, optional StateObjectReference AuxRef)
{
	local XComGameStateHistory History;
	local XComGameState_Tech Tech;

	History = `XCOMHISTORY;

	ProjectFocus = FocusRef;
	AuxilaryReference = AuxRef;
	Tech = XComGameState_Tech(History.GetGameStateForObjectID(FocusRef.ObjectID));

	if (Tech.GetMyTemplate().bShadowProject)
	{
		bShadowProject = true;
	}
	if (Tech.GetMyTemplate().bProvingGround)
	{
		bProvingGroundProject = true;
	}
	bInstant = Tech.IsInstant();
	
	if (Tech.bBreakthrough) // If this tech is a breakthrough, duration is not modified by science score
	{
		bIgnoreScienceScore = true;
	}

	UpdateWorkPerHour();
	InitialProjectPoints = Tech.GetProjectPoints(WorkPerHour);
	ProjectPointsRemaining = InitialProjectPoints;
	StartDateTime = `STRATEGYRULES.GameTime;
	if(MakingProgress())
	{
		SetProjectedCompletionDateTime(StartDateTime);
	}
	else
	{
		// Set completion time to unreachable future
		CompletionDateTime.m_iYear = 9999;
	}
}

//---------------------------------------------------------------------------------------
function int CalculateWorkPerHour(optional XComGameState StartState = none, optional bool bAssumeActive = false)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local int iTotalWork;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	//iTotalWork = XComHQ.ProvingGroundRate;	//<> HQ.ref
	iTotalWork = XcomHQ.PsiTrainingRate;

	// Can't make progress when paused or instant
	// The only time instant projects should be calculating work per hour is right when an Order that turns them instant activates
	// Keeping work per hour at zero prevents a project in the queue from assuming it is now active and getting stuck
	if (!FrontOfBuildQueue() && !bAssumeActive || bInstant)
	{
		return 0;
	}
	else
	{
		// Check for Higher Learning
		iTotalWork += Round(float(iTotalWork) * (float(XComHQ.EngineeringEffectivenessPercentIncrease) / 100.0));
	}

	return iTotalWork;
}

//       TODO: Find a way to impliment this function to replace 'PsiTrainingRate'
// 
//       Idearly, time should scale 1:1 with one scientist halfing the durnation, and 2 thirding the time. (12 days by default + 2 staffed scientist = 4 days total)
//
//function int InterrogationRate()
//{
//  local int Rate;
//  local XComGameState_FacilityXCom Facility;
//  local XComGameState_StaffSlot StaffSlot;
//  local StateObjectReference LocationRef;
//  Rate = 1;
//
//  Facility = XComGameState_FacilityXCom(`XCOMHISTORY.GetGameStateForObjectID(LocationRef.ObjectID));
//  
//  if (Facility.StaffSlots.Length = 1)
//  {
//    Rate = Rate *2 ;
//  }
//  if (Facility.StaffSlots.Length > 1)
//  {
//    Rate = Rate *3 ;
//  }
//
//  return Rate;
//}

//---------------------------------------------------------------------------------------
// Add the tech to XComs list of completed research, and call any OnResearched methods for the tech
function OnProjectCompleted()
{
	local XComGameState_Tech TechState;
	local HeadquartersOrderInputContext OrderInput;
	local StateObjectReference TechRef;
	local X2ItemTemplate ItemTemplate;

	TechRef = ProjectFocus;

	OrderInput.OrderType = eHeadquartersOrderType_ResearchCompleted;
	OrderInput.AcquireObjectReference = ProjectFocus;

	class'XComGameStateContext_HeadquartersOrder_InR'.static.IssueHeadquartersOrder_InR(OrderInput);

	`GAME.GetGeoscape().Pause();

	if (bProvingGroundProject)
	{
		TechState = XComGameState_Tech(`XCOMHISTORY.GetGameStateForObjectID(TechRef.ObjectID));

		// If the Proving Ground project rewards an item, display all the project popups on the Geoscape
		if (TechState.ItemRewards.Length > 0)
		{
			TechState.DisplayTechCompletePopups();

			foreach TechState.ItemRewards(ItemTemplate)
			{
				UIInterrogationFacilityItemReceived(ItemTemplate, TechRef);
			}
		}
		else // Otherwise give the normal project complete popup
		{
			`HQPRES.UIProvingGroundProjectComplete(TechRef);
		}
	}
	else if(bInstant)
	{
		TechState = XComGameState_Tech(`XCOMHISTORY.GetGameStateForObjectID(TechRef.ObjectID));
		TechState.DisplayTechCompletePopups();

		`HQPRES.ResearchReportPopup(TechRef);
	}
	else
	{
		`HQPRES.UIResearchComplete(TechRef);
	}
}

static function BuildUIAlert_LnR (
	out DynamicPropertySet PropertySet,
	Name AlertName,
	delegate<X2StrategyGameRulesetDataStructures.AlertCallback> CallbackFunction,
	Name EventToTrigger,
	string SoundToPlay,
	bool bImmediateDisplay = true
)
{
	class'X2StrategyGameRulesetDataStructures'.static.BuildDynamicPropertySet(PropertySet, 'UIAlert_LnR', AlertName, CallbackFunction, bImmediateDisplay, true, true, false);
	class'X2StrategyGameRulesetDataStructures'.static.AddDynamicNameProperty(PropertySet, 'EventToTrigger', EventToTrigger);
	class'X2StrategyGameRulesetDataStructures'.static.AddDynamicStringProperty(PropertySet, 'SoundToPlay', SoundToPlay);
}

static function UIInterrogationFacilityItemReceived (X2ItemTemplate ItemTemplate, StateObjectReference TechRef)
{
	local XComHQPresentationLayer HQPres;
	local DynamicPropertySet PropertySet;

	HQPres = `HQPRES;

	BuildUIAlert_LnR(PropertySet, 'eAlert_ItemReceivedInterrogationFacility', none, '', "Geoscape_ItemComplete");
	class'X2StrategyGameRulesetDataStructures'.static.AddDynamicNameProperty(PropertySet, 'ItemTemplate', ItemTemplate.DataName);
	class'X2StrategyGameRulesetDataStructures'.static.AddDynamicIntProperty(PropertySet, 'TechRef', TechRef.ObjectID);
	HQPres.QueueDynamicPopup(PropertySet);
}

//---------------------------------------------------------------------------------------
// Is it currently at the front of the build queue
function bool FrontOfBuildQueue()
{
	local XComGameState_FacilityXCom Facility;

	Facility = XComGameState_FacilityXCom(`XCOMHISTORY.GetGameStateForObjectID(AuxilaryReference.ObjectID));

	if ((Facility != none) && (Facility.BuildQueue.Length > 0))
	{
		if (Facility.BuildQueue[0].ObjectID == self.ObjectID)
		{
			return true;
		}
	}

	return false;
}

//---------------------------------------------------------------------------------------
DefaultProperties
{
}
