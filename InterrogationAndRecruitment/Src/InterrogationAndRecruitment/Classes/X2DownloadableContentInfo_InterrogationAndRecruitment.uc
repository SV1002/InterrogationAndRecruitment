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