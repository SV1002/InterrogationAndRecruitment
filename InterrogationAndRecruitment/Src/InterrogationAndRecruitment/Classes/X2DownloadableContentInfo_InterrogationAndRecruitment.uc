//---------------------------------------------------------------------------------------
//  FILE:   XComDownloadableContentInfo_InterrogationAndRecruitment.uc                                    
//           
//	Use the X2DownloadableContentInfo class to specify unique mod behavior when the 
//  player creates a new campaign or loads a saved game.
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_InterrogationAndRecruitment extends X2DownloadableContentInfo;

var config array<LootTable> LootTables, LootEntry;

/// <summary>
/// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the 
/// DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
/// create without the content installed. Subsequent saves will record that the content was installed.
/// </summary>
static event OnLoadedSavedGame()
{}

/// <summary>
/// Called when the player starts a new campaign while this DLC / Mod is installed
/// </summary>
static event InstallNewCampaign(XComGameState StartState)
{}

////////////////////////////////////////////////////////////////////////
//	OPTC MASTER
////////////////////////////////////////////////////////////////////////

static event OnPostTemplatesCreated()
{
    AddLootTables();
}

////////////////////////////////////////////////////////////////////////
//	CHL HOOK requires CHL v 1.21 or higher
//	Called from XComGameState_HeadquartersXCom
//	lets mods add their own events to the event queue when the player is at the Avenger or the Geoscape
////////////////////////////////////////////////////////////////////////

static function bool GetDLCEventInfo(out array<HQEvent> arrEvents)
{
	GetInRHQEvents(arrEvents);
	return true; //returning true will tell the game to add the events have been added to the above array
}

static function GetInRHQEvents(out array<HQEvent> arrEvents)
{
	class'XComGameState_HeadquartersProjectInR'.static.GetAllInRProjects(arrEvents);
}


////////////////////////////////////////////////////////////////////////
//	FUNCTION TO ADD INR LOOT TABLES
////////////////////////////////////////////////////////////////////////

static function AddLootTables()
{
	local X2LootTableManager	LootManager;
	local LootTable				LootBag;
	local LootTableEntry		Entry;
	
	LootManager = X2LootTableManager(class'Engine'.static.FindClassDefaultObject("X2LootTableManager"));

	foreach default.LootEntry(LootBag)
	{
		if ( LootManager.default.LootTables.Find('TableName', LootBag.TableName) != INDEX_NONE )
		{
			foreach LootBag.Loots(Entry)
			{
				class'X2LootTableManager'.static.AddEntryStatic(LootBag.TableName, Entry, false);
			}
		}	
	}
}

////////////////////////////////////////////////////////////////////////
//	FUNCTION TO ADD TECHS FOR THE INTERROGATION FACILITY
////////////////////////////////////////////////////////////////////////

static function AddTechGameStates()
{
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local X2TechTemplate TechTemplate;
	local X2StrategyElementTemplateManager	StratMgr;

	//This adds the techs to games that installed the mod in the middle of a campaign.
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	History = `XCOMHISTORY;	

	//Create a pending game state change
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding InR Tech Templates");

	//Find tech templates
	if ( !IsResearchInHistory('Tech_InR_Interrogation_AdventTrooper') )
	{
		TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_InR_Interrogation_AdventTrooper'));
		NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
	}
	
	if ( !IsResearchInHistory('Tech_InR_Interrogation_AdventStunlancer') )
	{
		TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_InR_Interrogation_AdventStunlancer'));
		NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
	}
	
	if ( !IsResearchInHistory('Tech_InR_Interrogation_AdventPurifier') )
	{
		TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_InR_Interrogation_AdventPurifier'));
		NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
	}
	
	if ( !IsResearchInHistory('Tech_InR_Interrogation_AdventShieldbearer') )
	{
		TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_InR_Interrogation_AdventShieldbearer'));
		NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
	}
	
	if ( !IsResearchInHistory('CreateTech_InR_Interrogation_AdventCaptain') )
	{
		TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('CreateTech_InR_Interrogation_AdventCaptain'));
		NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
	}
	
	if ( !IsResearchInHistory('Tech_InR_Interrogation_AdventPriest') )
	{
		TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_InR_Interrogation_AdventPriest'));
		NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
	}
	
	if ( !IsResearchInHistory('Tech_InR_Interrogation_AdventGeneral') )
	{
		TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_InR_Interrogation_AdventGeneral'));
		NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
	}

	if( NewGameState.GetNumGameStateObjects() > 0 )
	{
		//Commit the state change into the history.
		History.AddGameStateToHistory(NewGameState);
	}
	else
	{
		History.CleanupPendingGameState(NewGameState);
	}
}

static function bool IsResearchInHistory(name ResearchName)
{
	// Check if we've already injected the tech templates
	local XComGameState_Tech	TechState;
	
	foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_Tech', TechState)
	{
		if ( TechState.GetMyTemplateName() == ResearchName )
		{
			return true;
		}
	}
	return false;
}

//////////////////////////////////
/// Vanilla DLCInfo misc hooks ///
//////////////////////////////////

static function bool DisplayQueuedDynamicPopup (DynamicPropertySet PropertySet)
{
	if (PropertySet.PrimaryRoutingKey == 'UIAlert_InR')
	{
		CallUIAlert_InR(PropertySet);
		return true;
	}

	return false;
}

static protected function CallUIAlert_InR (const out DynamicPropertySet PropertySet)
{
	local XComHQPresentationLayer HQPres;
	local UIAlert_InR Alert;

	HQPres = `HQPRES;

	Alert = HQPres.Spawn(class'UIAlert_InR', HQPres);
	Alert.DisplayPropertySet = PropertySet;
	Alert.eAlertName = PropertySet.SecondaryRoutingKey;

	HQPres.ScreenStack.Push(Alert);
}
