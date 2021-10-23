//*******************************************************************************************
//  FILE:   Interrogation and Recruitment stuff                  
//  
//	File created	23/10/21    1:15
//	LAST UPDATED    23/10/21    1:15
//
//	This controls the project stuff
//
//*******************************************************************************************
class XComGameStateContext_HeadquartersOrder_InR extends XComGameStateContext_HeadquartersOrder;

private function CompleteResearch(XComGameState AddToGameState, StateObjectReference TechReference)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_FacilityXCom FacilityState;
	local XComGameState_HeadquartersProjectInR ResearchProject;
	local XComGameState_Tech TechState;
	local X2TechTemplate TechTemplate;
	local int idx;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	if(XComHQ != none)
	{
		XComHQ = XComGameState_HeadquartersXCom(AddToGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		XComHQ.TechsResearched.AddItem(TechReference);
		for(idx = 0; idx < XComHQ.Projects.Length; idx++)
		{
			ResearchProject = XComGameState_HeadquartersProjectInR(History.GetGameStateForObjectID(XComHQ.Projects[idx].ObjectID));
			
			if (ResearchProject != None && ResearchProject.ProjectFocus == TechReference)
			{
				XComHQ.Projects.RemoveItem(ResearchProject.GetReference());
				AddToGameState.RemoveStateObject(ResearchProject.GetReference().ObjectID);

				if (ResearchProject.bProvingGroundProject || !ResearchProject.bShadowProject)
				{
					//FacilityState = XComGameState_FacilityXCom(`XCOMHISTORY.GetGameStateForObjectID(ResearchProject.AuxilaryReference.ObjectID));
                    FacilityState = XComHQ.GetFacilityByName('InterrogationFacility');
					if (FacilityState != none)
					{
						FacilityState = XComGameState_FacilityXCom(AddToGameState.ModifyStateObject(class'XComGameState_FacilityXCom', FacilityState.ObjectID));
						FacilityState.BuildQueue.RemoveItem(ResearchProject.GetReference());
					}
				}
				else if (ResearchProject.bShadowProject)
				{
					XComHQ.EmptyShadowChamber(AddToGameState);
				}

				break;
			}
		}
	}

	TechState = XComGameState_Tech(AddToGameState.ModifyStateObject(class'XComGameState_Tech', TechReference.ObjectID));
	TechState.TimesResearched++;
	TechState.TimeReductionScalar = 0;
	TechState.CompletionTime = `GAME.GetGeoscape().m_kDateTime;

	TechState.OnResearchCompleted(AddToGameState);
	
	TechTemplate = TechState.GetMyTemplate(); // Get the template for the completed tech
	if (!TechState.IsInstant() && !TechTemplate.bShadowProject && !TechTemplate.bProvingGround)
	{
		XComHQ.CheckForInstantTechs(AddToGameState);
		
		// Do not allow two breakthrough techs back-to-back, jump straight to inspired check
		if (TechTemplate.bBreakthrough || !XComHQ.CheckForBreakthroughTechs(AddToGameState))
		{
			// If there is no breakthrough activated, check to activate inspired tech
			XComHQ.CheckForInspiredTechs(AddToGameState);
		}
	}
	
	// Do not clear Breakthrough and Inspired references until after checking for instant
	// to avoid game state conflicts when potentially choosing a new breakthrough tech if the tech tree is exhausted
	if (TechState.bBreakthrough && XComHQ.CurrentBreakthroughTech.ObjectID == TechState.ObjectID)
	{
		XComHQ.CurrentBreakthroughTech.ObjectID = 0;
	}
	else if (TechState.bInspired && XComHQ.CurrentInspiredTech.ObjectID == TechState.ObjectID)
	{
		XComHQ.CurrentInspiredTech.ObjectID = 0;
	}
	
	if (TechState.GetMyTemplate().bProvingGround)
		class'XComGameState_HeadquartersResistance'.static.RecordResistanceActivity(AddToGameState, 'ResAct_ProvingGroundProjectsCompleted');
	else
		class'XComGameState_HeadquartersResistance'.static.RecordResistanceActivity(AddToGameState, 'ResAct_TechsCompleted');

	`XEVENTMGR.TriggerEvent('ResearchCompleted', TechState, ResearchProject, AddToGameState);
}

static function CancelProvingGroundProject(XComGameState AddToGameState, StateObjectReference ProjectRef)
{
	local XComGameState_FacilityXCom FacilityState, NewFacilityState;
	local XComGameState_HeadquartersProjectInR ProjectState;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameStateHistory History;
	local XComGameState_Tech TechState;

	History = `XCOMHISTORY;

	ProjectState = XComGameState_HeadquartersProjectInR(History.GetGameStateForObjectID(ProjectRef.ObjectID));

	if (ProjectState != none)
	{
		TechState = XComGameState_Tech(History.GetGameStateForObjectID(ProjectState.ProjectFocus.ObjectID));
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

		//FacilityState = XComGameState_FacilityXCom(History.GetGameStateForObjectID(ProjectState.AuxilaryReference.ObjectID));
        FacilityState = XComHQ.GetFacilityByName('InterrogationFacility');
		if (FacilityState != none)
		{
			NewFacilityState = XComGameState_FacilityXCom(AddToGameState.ModifyStateObject(class'XComGameState_FacilityXCom', FacilityState.ObjectID));
			NewFacilityState.BuildQueue.RemoveItem(ProjectRef);
		}

		if (XComHQ != none)
		{
			XComHQ = XComGameState_HeadquartersXCom(AddToGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
			XComHQ.RefundStrategyCost(AddToGameState, TechState.GetMyTemplate().Cost, XComHQ.ProvingGroundCostScalars, ProjectState.SavedDiscountPercent);
			XComHQ.Projects.RemoveItem(ProjectState.GetReference());
			AddToGameState.RemoveStateObject(ProjectState.ObjectID);
		}
	}

}

////////////////////////////////////////////

/////////////////////////////////////////////

static function IssueHeadquartersOrder_InR(const out HeadquartersOrderInputContext UseInputContext)
{
	local XComGameStateContext_HeadquartersOrder NewOrderContext;

	NewOrderContext = XComGameStateContext_HeadquartersOrder(class'XComGameStateContext_HeadquartersOrder_InR'.static.CreateXComGameStateContext());
	NewOrderContext.InputContext = UseInputContext;

	`GAMERULES.SubmitGameStateContext(NewOrderContext);
}
